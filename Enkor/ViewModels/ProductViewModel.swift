//
//  ProductViewModel.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/20.
//

import Foundation
import RxSwift
import RxCocoa

class ProductViewModel: ErrorHandling {
    var errorMessage = PublishSubject<String>()
    var authError = PublishSubject<Void>()
    var fetchedProducts = BehaviorRelay<[String: [Product]]>(value:[:])
    var isPaginating = false
    
    let disposeBag = DisposeBag()
    let apiClient: ProductAPI
    
    func getProducts(with category: String) -> [Product] {
        return fetchedProducts.value[category] ?? []
    }
    
    init(apiClient: ProductAPI) {
        self.apiClient = apiClient
    }
    
    func fetchProductList(pageNum: Int, category: String) {
        isPaginating = true
        apiClient
            .getProductList(pageSize: 10, pageNum: pageNum, category: category)
            .subscribe(onNext: { [weak self] json in
                guard let self = self else { return }
                do {
                    let fetched = try ProductAPIParser(json: json).parseProductList()
                    if fetched.count == 0 {
                        return
                    }
                    let current = self.fetchedProducts.value[category] ?? []
                    let merged = current + fetched
                    var prev = self.fetchedProducts.value
                    prev[category] = merged
                    self.fetchedProducts.accept(prev)
                } catch {
                    self.handleAsUnknownError(error)
                }
            }, onError: { [weak self] error in
                self?.handleServerError(error)
            })
            .disposed(by: disposeBag)
    }
}
