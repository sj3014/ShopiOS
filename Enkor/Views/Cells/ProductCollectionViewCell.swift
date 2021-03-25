//
//  ProductCollectionViewCell.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/20.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var banner: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    static let identifier = "ProductCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ProductCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(product: Product) {
        DispatchQueue.main.async {
            self.price.text = "$ \(product.productOptions?[0].price ?? "0.00")"
            self.name.text = product.name
            self.banner.text = product.promoBannerText
            _ = ImageLoader.loadImageInto(string: product.productImages?[0].location, imageView: self.imageView)
        }
    }
}
