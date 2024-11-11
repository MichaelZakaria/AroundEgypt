//
//  ViewController.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-10.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var topBar: TopBarView!
    
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    
    var homeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewUI()
    }
    
    func setupViewUI() {
        let layout = UICollectionViewCompositionalLayout{ indexPath, enviroment in
            
            switch indexPath {
            case 0:
                return self.drawSection(groupWidth: 1, groupHeight: 181, isScrollingHorizontally: true)
            case 1:
                return self.drawSection(groupWidth: 1, groupHeight: 181, isScrollingHorizontally: false)
            default:
                return self.drawSection(groupWidth: 0, groupHeight: 0, isScrollingHorizontally: false)
            }
            
        }
        
        // Initialize UICollectionView
        homeCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        homeCollectionView.backgroundColor = .white
        
        // Register the cell and header view
        homeCollectionView.register(DestinationCell.self, forCellWithReuseIdentifier: "Cell")
        homeCollectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        
        // Set the data source and delegate
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self
        
        // Setup the title and subtitle labels
        titleLabel = UILabel.create(text: "Welcome!", font: .boldSystemFont(ofSize: 22))
        subtitleLabel = UILabel.create(text: "Now you can explore any experience in 360 degrees and get all the details about it all in one place.", font: .systemFont(ofSize: 14))
        
        // Setup topbar
        topBar = TopBarView()
        
        // Add the views to the view hierarchy
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(homeCollectionView)
        view.addSubview(topBar)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        homeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        topBar.translatesAutoresizingMaskIntoConstraints = false
        
        // Apply Auto Layout constraints
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            topBar.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            homeCollectionView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            homeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            homeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            homeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            ])
    }
    
    func drawSection(groupWidth: CGFloat, groupHeight: CGFloat, isScrollingHorizontally: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(view.frame.width - 20), heightDimension: .absolute(groupHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10 , bottom: 20, trailing: 10)
        section.boundarySupplementaryItems = [drawHeader()]
        
        if isScrollingHorizontally {
            section.orthogonalScrollingBehavior = .groupPaging
        }
        
        
        return section
    }

    func drawHeader() -> NSCollectionLayoutBoundarySupplementaryItem{
        let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .absolute(40))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerHeaderSize,
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeaderView = homeCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as! SectionHeaderView
        
        switch indexPath.section {
        case 0:
            sectionHeaderView.configure(with: "Recommended Experiences")
            return sectionHeaderView
        case 1:
            sectionHeaderView.configure(with: "Most Recent")
            return sectionHeaderView
        default:
            return sectionHeaderView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50) // header height
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DestinationCell
        
        return cell
    }
}
