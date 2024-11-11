//
//  DestinationImageView.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-11.
//

import Foundation
import UIKit

class DestinationImageView: UIView {
    var destinationImageView: UIImageView!
    var infoButton: UIButton!
    var imagesButton: UIButton!
    var viewsImageView: UIImageView!
    var viewsCountLabel: UILabel!
    var vrButton: UIButton!
    var recommenedBanner: RecommendedBannerView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        destinationImageView = UIImageView.create(image: .gratisographyCyberKitty800X525, contentMode: .scaleAspectFill)
        destinationImageView.layer.cornerRadius = min(destinationImageView.frame.width, destinationImageView.frame.height) / 32
        infoButton = UIButton.create(image: UIImage(systemName: "info.circle"))
        imagesButton = UIButton.create(image: UIImage(systemName: "photo.on.rectangle"))
        viewsImageView = UIImageView.create(image: UIImage(systemName: "eye.fill"))
        viewsCountLabel = UILabel.create(text: "156", font: .boldSystemFont(ofSize: 14), color: .white)
        vrButton = UIButton.create(image: UIImage(systemName: "globe"))
        recommenedBanner = RecommendedBannerView()
        
        
        addSubview(destinationImageView)
        addSubview(infoButton)
        addSubview(imagesButton)
        addSubview(viewsImageView)
        addSubview(viewsCountLabel)
        addSubview(vrButton)
        addSubview(recommenedBanner)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            destinationImageView.topAnchor.constraint(equalTo: self.topAnchor),
            destinationImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            destinationImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            destinationImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            infoButton.topAnchor.constraint(equalTo: destinationImageView.topAnchor, constant: 10),
            infoButton.trailingAnchor.constraint(equalTo: destinationImageView.trailingAnchor, constant: -10),
            infoButton.heightAnchor.constraint(equalToConstant: 20),
            infoButton.widthAnchor.constraint(equalToConstant: 20),
            
            imagesButton.bottomAnchor.constraint(equalTo: destinationImageView.bottomAnchor, constant: -10),
            imagesButton.trailingAnchor.constraint(equalTo: destinationImageView.trailingAnchor, constant: -10),
            imagesButton.heightAnchor.constraint(equalToConstant: 16.7),
            imagesButton.widthAnchor.constraint(equalToConstant: 20.87),
            
            viewsImageView.bottomAnchor.constraint(equalTo: destinationImageView.bottomAnchor, constant: -10),
            viewsImageView.leadingAnchor.constraint(equalTo: destinationImageView.leadingAnchor, constant: 10),
            viewsImageView.heightAnchor.constraint(equalToConstant: 14),
            viewsImageView.widthAnchor.constraint(equalToConstant: 18),
            
            viewsCountLabel.bottomAnchor.constraint(equalTo: viewsImageView.bottomAnchor),
            viewsCountLabel.leadingAnchor.constraint(equalTo: viewsImageView.trailingAnchor, constant: 5),
            viewsCountLabel.heightAnchor.constraint(equalToConstant: 14),
            
            vrButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            vrButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            vrButton.heightAnchor.constraint(equalToConstant: 60),
            vrButton.widthAnchor.constraint(equalToConstant: 60),
            
            recommenedBanner.topAnchor.constraint(equalTo: infoButton.topAnchor),
            recommenedBanner.leadingAnchor.constraint(equalTo: viewsImageView.leadingAnchor),
            recommenedBanner.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.14)
        ])
    }
}
