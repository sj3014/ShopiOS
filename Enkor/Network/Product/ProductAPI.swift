//
//  ProductAPI.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/20.
//

import Foundation
import Moya
import RxSwift
import SwiftyJSON

class ProductAPI: BaseServerAPI {
    var provider: MoyaProvider<ProductService>
    
    init(provider: MoyaProvider<ProductService>?) {
        if let provider = provider {
            self.provider = provider
        } else {
            self.provider = MoyaProvider<ProductService>(plugins: BaseServerAPI.defaultPlugins)
        }
    }
    
    func getProductList(pageSize: Int, pageNum: Int, category: String) -> Observable<JSON> {
        return provider.rx
            .request(.getProductList(pageSize: pageSize, pageNum: pageNum, category: category))
            .asObservable()
            .map { response -> JSON in
                return JSON(response.data)
            }
    }
    
    func getProductDetail(productID: Int) -> Observable<JSON> {
        return provider.rx
            .request(.getProductDetail(productID: productID))
            .asObservable()
            .map { response -> JSON in
                return JSON(response.data)
            }
    }
}
