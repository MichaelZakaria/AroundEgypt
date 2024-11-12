//
//  CollectionViewCell.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-10.
//

import Foundation
import UIKit

protocol UpdateFavouriteCountProtocol {
    func updateFavouriteCount(experienceID: String)
}

class DestinationCell: UICollectionViewCell {
    
    var destinationImageView: DestinationImageView!
    var destinationName: UILabel!
    var favouriteButton: UIButton!
    var favouriteCount: UILabel!
    var experince: Experience? {
        didSet {
            configureCell(with: experince)
        }
    }
    var vm: DestinationCellViewModel
    var conroller: UpdateFavouriteCountProtocol?
    
    override init(frame: CGRect) {
        vm = DestinationCellViewModel()
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        destinationImageView = DestinationImageView()
        destinationName = UILabel.create(text: "Destination name", font: .boldSystemFont(ofSize: 14), maxLines: 1)
        favouriteButton = UIButton.create(image: UIImage(systemName: "heart.fill"), tintColor: .myTeal)
        favouriteButton.addTarget(self, action: #selector(toggleFavouriteButton), for: .touchUpInside)
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
            destinationName.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            
            favouriteButton.bottomAnchor.constraint(equalTo: destinationName.bottomAnchor),
            favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            favouriteButton.heightAnchor.constraint(equalToConstant: 18),
            favouriteButton.widthAnchor.constraint(equalToConstant: 20),
            
            favouriteCount.bottomAnchor.constraint(equalTo: favouriteButton.bottomAnchor),
            favouriteCount.trailingAnchor.constraint(equalTo: favouriteButton.leadingAnchor, constant: -8),
        ])
    }
    
    func configureCell(with experience: Experience?) {
        guard let experience = experience else { return }
        
        destinationName.text = experience.title
        favouriteCount.text = experience.likesNumber.description
        destinationImageView.viewsCountLabel.text = experience.viewsNumber.description
        
        vm.getCoverPhoto(experince: experience) { data in
            self.destinationImageView.destinationImageView.image = UIImage(data: data)
        }
        
        if UserDefaults.standard.value(forKey: experience.id) != nil {
            favouriteButton.imageView?.image = UIImage(systemName: "heart.fill")
        } else {
            favouriteButton.imageView?.image = UIImage(systemName: "heart")
        }
        
        destinationImageView.recommenedBanner.isHidden = experience.recommended != 1
    }
    
    @objc func toggleFavouriteButton() {
        guard let id = experince?.id, UserDefaults.standard.value(forKey: id) == nil  else { return }
        
        favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        self.favouriteCount.text = (Int(self.favouriteCount.text!)! + 1).description
        
        vm.postLike(id: id) {
            self.conroller?.updateFavouriteCount(experienceID: id)
        }
    }
    
}
