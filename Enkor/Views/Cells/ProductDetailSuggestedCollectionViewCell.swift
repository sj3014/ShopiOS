//
//  ProductDetailSuggestedCollectionViewCell.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/24.
//

import UIKit

class ProductDetailSuggestedCollectionViewCell: UICollectionViewCell {

    static let identifier = "ProductDetailSuggestedCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ProductDetailSuggestedCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
