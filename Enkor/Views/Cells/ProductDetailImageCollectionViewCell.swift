//
//  ProductDetailImageCollectionViewCell.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/24.
//

import UIKit

class ProductDetailImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    static let identifier = "ProductDetailImageCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ProductDetailImageCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(imageLocation: String, width: CGFloat, height: CGFloat) {
        imageWidthConstraint.constant = width
        imageHeightConstraint.constant = height
        DispatchQueue.main.async {
            _ = ImageLoader.loadImageInto(string: imageLocation, imageView: self.imageView)
        }
    }
}
