//
//  RecommendedBannerView.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-11.
//

import Foundation
import UIKit

class RecommendedBannerView: UIView {
            
    // UI Elements
    private var starIconImageView: UIImageView!
    private var infoLabel: UILabel!
    
    // Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // UI Setup
    private func setupUI() {
        // Background with rounded corners
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Light transparent grey color
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        // Star Icon (Yellow)
        starIconImageView = UIImageView(image: UIImage(systemName: "star.fill"))
        starIconImageView.tintColor = .myTeal
        starIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Label
        infoLabel = UILabel()
        infoLabel.text = "RECOMMENDED"
        infoLabel.font =  .boldSystemFont(ofSize: 10)
        infoLabel.textColor = .white
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews
        addSubview(starIconImageView)
        addSubview(infoLabel)
        
        // Set up constraints
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints for the starIconImageView and infoLabel
        NSLayoutConstraint.activate([
            // Star icon constraints
            starIconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            starIconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            starIconImageView.widthAnchor.constraint(equalToConstant: 9.11),
            starIconImageView.heightAnchor.constraint(equalToConstant: 9.12),
            
            // Label constraints
            infoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: starIconImageView.trailingAnchor, constant: 2),
            infoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }

}
