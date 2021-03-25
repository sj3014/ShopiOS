//
//  ErrorHandling.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/18.
//

import Foundation
import Moya
import RxSwift

protocol ErrorHandling {
    var errorMessage: PublishSubject<String> { get }
    var authError: PublishSubject<Void> { get }
    //var resetError: PublishSubject<Void> { get }
}


extension ErrorHandling {
    func handleAsUnknownError(_ error: Error) {
        //Logger.error(error.localizedDescription)
        let msg = ServerErrorMessageParser.parse(error: error)
        errorMessage.onNext(msg)
        print(#function, msg, error.localizedDescription, error)
    }
    
    func handleServerError(_ error: Error) {
        let msg = ServerErrorMessageParser.parse(error: error)
        
        let responseCode = (error as? MoyaError)?.response?.statusCode ?? 0
        
        let resetMsg = "Failed to send password reset email, please check your account email"
        
        if responseCode == 404 && resetMsg == msg {
            //resetError.onNext(())
        }
        
        if responseCode == 401 {
            authError.onNext(())
        } else {
            errorMessage.onNext(msg)
        }
    }
}
