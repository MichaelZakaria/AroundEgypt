//
//  EmptyCell.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-12.
//

import UIKit

class EmptyCell: UICollectionViewCell {
    private var emptyLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        emptyLabel = UILabel.create(text: "No data found !", font: .boldSystemFont(ofSize: 24), color: .lightGray)
        contentView.addSubview(emptyLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
