//
//  ProductDetailViewModel.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/24.
//

import Foundation
import RxSwift
import RxCocoa

class ProductDetailViewModel: ErrorHandling {
    var errorMessage = PublishSubject<String>()
    var authError = PublishSubject<Void>()
    var fetchedProductDetail = BehaviorRelay<Product>(value: Product.empty())

    let disposeBag = DisposeBag()
    let apiClient: ProductAPI
    
    var productDetail: Product {
        return fetchedProductDetail.value
    }
    
    
    init(apiClient: ProductAPI) {
        self.apiClient = apiClient
    }
    
    func fetchProductDetail(productID: Int) {
        apiClient
            .getProductDetail(productID: productID)
            .subscribe(onNext: { [weak self] json in
                guard let self = self else { return }
                do {
                    let productDetail = try ProductAPIParser(json: json).parseProductDetail()
                    self.fetchedProductDetail.accept(productDetail)
                } catch {
                    self.handleAsUnknownError(error)
                }
            }, onError: { [weak self] error in
                self?.handleServerError(error)
            })
            .disposed(by: disposeBag)
    }
    
}
