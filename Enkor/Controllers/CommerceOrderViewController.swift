//
//  CommerceOrderViewController.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/25.
//

import UIKit

class CommerceOrderViewController: UIViewController {

    
    @IBOutlet weak var productOptionImage: UIImageView!
    @IBOutlet weak var productOptionName: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var productOptionTotalPrice: UILabel!
    @IBOutlet weak var shippingFee: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var kakaoID: UITextField!
    @IBOutlet weak var email: UITextField!
    
    var orderDetail: OrderDetail?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let orderDetail = self.orderDetail else { return }
        setupUI(orderDetail: orderDetail)
    }
    
    func setupUI(orderDetail: OrderDetail) {
        _ = ImageLoader.loadImageInto(string: orderDetail.productImageURL, imageView: self.productOptionImage)
        self.productOptionName.text = orderDetail.productOptionName
        self.quantity.text = "Qty: \(orderDetail.productQuantity)"
        self.productOptionTotalPrice.text = "$ \(orderDetail.productOptionTotalPrice)"
        self.shippingFee.text = "$ \(orderDetail.shippingFee)"
        self.totalPrice.text = "$ \(orderDetail.totalPrice)"
    }
    
    @IBAction func tapAddNewAddress(_ sender: Any) {
    }
    
    
    @IBAction func tapProceedToPay(_ sender: Any) {
    }
    
}
