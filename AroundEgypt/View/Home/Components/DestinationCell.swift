//
//  CollectionViewCell.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-10.
//

import Foundation
import UIKit

protocol GetExperincesProtocol {
    func getExperinces()
}

class DestinationCell: UICollectionViewCell {
    
    var destinationImageView: DestinationImageView!
    var destinationName: UILabel!
    var favouriteButton: UIButton!
    var favouriteCount: UILabel!
    var experinceID: String?
    var conroller: GetExperincesProtocol?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        destinationImageView = DestinationImageView()
        destinationName = UILabel.create(text: "Destination name", font: .boldSystemFont(ofSize: 14), maxLines: 1)
        favouriteButton = UIButton.create(image: UIImage(systemName: "heart"), tintColor: .myTeal)
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
            //destinationName.trailingAnchor.constraint(equalTo: favouriteCount.leadingAnchor, constant: -5),
            destinationName.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            
            favouriteButton.bottomAnchor.constraint(equalTo: destinationName.bottomAnchor),
            favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            favouriteButton.heightAnchor.constraint(equalToConstant: 18),
            favouriteButton.widthAnchor.constraint(equalToConstant: 20),
            
            favouriteCount.bottomAnchor.constraint(equalTo: favouriteButton.bottomAnchor),
            favouriteCount.trailingAnchor.constraint(equalTo: favouriteButton.leadingAnchor, constant: -8),
            //favouriteCount.widthAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    @objc func toggleFavouriteButton() {
        guard let id = experinceID else {return}
        
        if UserDefaults.standard.value(forKey: id) != nil {
            favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            return
        }
        
        favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        self.favouriteCount.text = (Int(self.favouriteCount.text!)! + 1).description
        
        NetworkSevice.instance.fetchData(url: APIHandler.getExperincesURL(.likeExperince(id: id)), method: .post, type: Data.self, decodResult: false) { result in
            switch result {
            case .success(_):
                UserDefaults.standard.setValue(true, forKey: id)
                self.conroller?.getExperinces()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
