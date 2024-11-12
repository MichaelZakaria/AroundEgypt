//
//  TopBarView.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-10.
//

import Foundation
import UIKit

class TopBarView: UIView{

    var leftButton: UIButton!
    var rightButton: UIButton!
    var searchBar: UISearchBar!

    var leftButtonAction: (() -> Void)?
    var rightButtonAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        leftButton = UIButton.create(image: UIImage(systemName: "line.3.horizontal"), tintColor: .black)
        addSubview(leftButton)

        rightButton = UIButton.create(image: UIImage(systemName: "slider.horizontal.3"), tintColor: .black)
        addSubview(rightButton)

        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Try \"Luxor\" "
        searchBar.searchBarStyle = .minimal
        addSubview(searchBar)
        
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            leftButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            leftButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            rightButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            rightButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            searchBar.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: rightButton.leadingAnchor, constant: -10),
            searchBar.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
