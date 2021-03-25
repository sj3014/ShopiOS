//
//  CategoryCollectionViewCell.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/23.
//

import UIKit

class CategoryItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var backView: UIView!
    
    
    static let identifier = "CategoryItemCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CategoryItemCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(categoryName: String, color: UIColor) {
        self.categoryName.text = categoryName
        self.backView.backgroundColor = color
    }

}
