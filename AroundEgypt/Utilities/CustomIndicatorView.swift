//
//  CustomIndicatorView.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-11.
//

import Foundation
import UIKit

class CustomIndicatorView: UIView {
    
    // MARK: - Properties
    private var activityIndicator: UIActivityIndicatorView!
    private var backgroundView: UIView!
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        // Create a semi-transparent background view
        backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        backgroundView.layer.cornerRadius = 10
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundView)
        
        // Create the activity indicator
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(activityIndicator)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints for backgroundView
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundView.widthAnchor.constraint(equalToConstant: 100),
            backgroundView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Constraints for activityIndicator
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
        ])
    }
    
    // MARK: - Public Methods
    
    // Show the indicator
    func show(in view: UIView) {
        self.frame = view.bounds
        view.addSubview(self)
        activityIndicator.startAnimating()
    }
    
    // Hide the indicator
    func hide() {
        activityIndicator.stopAnimating()
        self.removeFromSuperview()
    }
}
