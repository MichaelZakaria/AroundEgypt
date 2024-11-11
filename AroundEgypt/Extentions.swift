//
//  Extentions.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-11.
//

import Foundation
import UIKit

// UIImageView extension for reusable creation
extension UIImageView {
    static func create(image: UIImage?, contentMode: UIView.ContentMode = .scaleAspectFit, cornerRaduis: CGFloat = 0) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.contentMode = contentMode
        imageView.tintColor = .white
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = cornerRaduis
        
        return imageView
    }
}

// UIButton extension for reusable creation
extension UIButton {
    static func create(image: UIImage?, title: String? = nil, tintColor: UIColor = .white) -> UIButton {
        let button = UIButton()
        if let title = title {
            button.setTitle(title, for: .normal)
        }
        if let image = image {
            button.setImage(image, for: .normal)
        }
        button.tintColor = tintColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

// UILabel extension for reusable creation
extension UILabel {
    static func create(text: String, font: UIFont = .systemFont(ofSize: 14), color: UIColor = .black, maxLines: Int = 0) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = color
        label.numberOfLines = maxLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
