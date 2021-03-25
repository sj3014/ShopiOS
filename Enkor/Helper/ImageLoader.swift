//
//  ImageLoader.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/20.
//

import UIKit
import Kingfisher

class ImageLoader {

    @discardableResult
    static func loadImageInto(string: String?, imageView: UIImageView) -> Bool {
        guard let string = string, string.count > 0 else { return false }
        if let url = URL(string: string) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url)
            return true
        }
        return false
    }
}
