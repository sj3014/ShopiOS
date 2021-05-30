//
//  CarouselCollectionViewCell.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/28.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    static let identifier = "CarouselCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CarouselCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    func configure(image: UIImage, width: CGFloat, height: CGFloat) {
        imageViewWidthConstraint.constant = width
        imageViewHeightConstraint.constant = height
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}
