//
//  HomeViewController.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/20.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (AppConfigure.shared.buildPhase?.rawValue == "Debug") {
            self.navigationItem.title = "Enkor Development"
        } else {
            self.navigationItem.title = "Enkor"
        }
    }
    
    
    @IBAction func tapFoodDelivery(_ sender: Any) {
        let vc = Storyboard.Market.create(withIdentifier: "Market")
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
