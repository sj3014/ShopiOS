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

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tapFoodDelivery(_ sender: Any) {
        let vc = Storyboard.Market.create(withIdentifier: "Market")
//        vc.modalPresentationStyle = .fullScreen
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.type = CATransitionType
//        self.show(vc, sender: self)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
