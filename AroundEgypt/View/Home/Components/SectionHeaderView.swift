//
//  SectionHeaderView.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-10.
//

import Foundation
import UIKit

class SectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeaderView"
    
    private let label: UILabel!

    override init(frame: CGRect) {
        label = UILabel(frame: .zero)
        super.init(frame: frame)
        setupHeader()
    }

    required init?(coder: NSCoder) {
        label = UILabel(frame: .zero)
        super.init(coder: coder)
        setupHeader()
    }

    private func setupHeader() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
    
    func configure(with title: String) {
        label.text = title
    }
}
