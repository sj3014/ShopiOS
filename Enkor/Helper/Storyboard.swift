//
//  Storyboard.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/15.
//

import UIKit

enum Storyboard: String {
    case MyPage = "MyPage"
    case Home = "Home"
    case Cart = "Cart"
    case Auth = "Auth"
    case Market = "Market"
    case Order = "Order"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func create() -> UIViewController {
        return self.instance.instantiateViewController(withIdentifier: self.rawValue)
    }
    
    func create(withIdentifier: String) -> UIViewController {
        return self.instance.instantiateViewController(withIdentifier: withIdentifier)
    }
}
