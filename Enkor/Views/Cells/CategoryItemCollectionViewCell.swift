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
    
    override var isHighlighted: Bool {
        didSet {
            categoryName.textColor = isHighlighted ? UIColor.black : UIColor.lightGray
        }
    }
    
    override var isSelected: Bool {
        didSet {
            categoryName.textColor = isSelected ? UIColor.black : UIColor.lightGray
        }
    }
    
    func configure(categoryName: String) {
        self.categoryName.text = categoryName
    }

}
