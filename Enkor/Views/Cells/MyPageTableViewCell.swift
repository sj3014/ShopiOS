//
//  MyPageTableViewCell.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/16.
//

import UIKit

class MyPageTableViewCell: UITableViewCell {
    
    @IBOutlet var title: UILabel!

    static let identifier = "MyPageTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MyPageTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {

        
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
