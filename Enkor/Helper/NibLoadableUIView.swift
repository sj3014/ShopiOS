//
//  NibLoadableUIView.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/17.
//

import UIKit

class NibLoadableUIView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.load()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.load()
    }
    
    func load() {
        // XIB file name should be the same as class name
        Bundle(for: NibLoadableUIView.self).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
    }
}

protocol NibAutoLayout {
    var contentView: UIView! { get set }
    func setupAutoLayout()
}

extension NibAutoLayout where Self: NibLoadableUIView {
    func setupAutoLayout() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ])
    }
}
