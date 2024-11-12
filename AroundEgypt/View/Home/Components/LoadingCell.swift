//
//  LoadingCell.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-11.
//

import Foundation
import UIKit

class LoadingCell: UICollectionViewCell {
    // Loading Indicator View (covers the entire cell)
    private var loadingIndicatorView: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Initialize the activity indicator (loading indicator)
        loadingIndicatorView = UIActivityIndicatorView(style: .large)
        loadingIndicatorView.color = .gray
        loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicatorView.startAnimating()
        contentView.addSubview(loadingIndicatorView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loadingIndicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
