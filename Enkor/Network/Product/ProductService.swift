//
//  ProductService.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/20.
//

import Foundation
import Moya

enum ProductService {
    case getProductList(pageSize: Int, pageNum: Int, category: String)
    case getProductDetail(productID: Int)
}

extension ProductService: TargetType, AccessTokenAuthorizable {
    var path: String {
        switch self {
        case .getProductList:
            return "/commerce/product"
        case .getProductDetail(let productID):
            return "/commerce/product/\(productID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getProductList, .getProductDetail:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getProductList(let pageSize, let pageNum, let category):
            var params = [String:Any]()
            params["pageSize"] = pageSize
            params["pageNum"] = pageNum
            params["category"] = category
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case .getProductDetail:
            return .requestPlain
        }
    }
    
    var headers: [String:String]? {
        switch self {
        default:
            return ["Content-type": "application/json"]
        }
    }
    
    var authorizationType: AuthorizationType? {
        switch self {
        default:
            return .bearer
        }
    }
    
    var baseURL: URL {
        let baseURL = "\(AppConfigure.shared.baseURL)/api"
        guard let url = URL(string: baseURL) else { fatalError("baseURL could not be configured") }
        return url
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
