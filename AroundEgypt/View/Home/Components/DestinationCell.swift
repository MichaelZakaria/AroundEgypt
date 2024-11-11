//
//  CollectionViewCell.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-10.
//

import Foundation
import UIKit

class DestinationCell: UICollectionViewCell {
    
    var destinationImageView: DestinationImageView!
    var destinationName: UILabel!
    var favouriteButton: UIButton!
    var favouriteCount: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        destinationImageView = DestinationImageView()
        destinationName = UILabel.create(text: "Destination name", font: .boldSystemFont(ofSize: 14))
        favouriteButton = UIButton.create(image: UIImage(systemName: "heart.fill"), tintColor: .myTeal)
        favouriteCount = UILabel.create(text: "200", font: .boldSystemFont(ofSize: 14))
        
        contentView.addSubview(destinationImageView)
        contentView.addSubview(destinationName)
        contentView.addSubview(favouriteButton)
        contentView.addSubview(favouriteCount)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            destinationImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            destinationImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28),
            destinationImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            destinationImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            destinationName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            destinationName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            destinationName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            favouriteButton.bottomAnchor.constraint(equalTo: destinationName.bottomAnchor),
            favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            favouriteButton.heightAnchor.constraint(equalToConstant: 18),
            favouriteButton.widthAnchor.constraint(equalToConstant: 20),
            
            favouriteCount.bottomAnchor.constraint(equalTo: favouriteButton.bottomAnchor),
            favouriteCount.trailingAnchor.constraint(equalTo: favouriteButton.leadingAnchor, constant: -8)
        ])
    }
    
}
