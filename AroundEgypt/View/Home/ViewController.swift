//
//  ViewController.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-10.
//

import UIKit
import SwiftUI

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UISearchResultsUpdating, UpdateFavouriteCountProtocol {
    
    private var topBar: TopBarView!
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    private var homeCollectionView: UICollectionView!
    
    var vm: HomeViewModel?
    
    var filteredExperinces: [Experience] = []
    var searchFlag: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewUI()
        vm = HomeViewModel()
        vm?.bindResultToViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.homeCollectionView.reloadData()
            }
        }
        
        self.hideKeyboardWhenTappedAround()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //view.endEditing(true)
        searchBar.resignFirstResponder()
    }

    func updateFavouriteCount(experienceID: String) {
        guard let vm = vm else {return}
        if let index = vm.recommended.firstIndex(where: { $0.id == experienceID }) {
            vm.recommended[index].likesNumber = vm.recommended[index].likesNumber + 1
        }
        if let index = vm.recent.firstIndex(where: { $0.id == experienceID }) {
            vm.recent[index].likesNumber = vm.recent[index].likesNumber + 1
        }
    }
    
    func setupViewUI() {
        //view.backgroundColor = .white
        
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
        
        homeCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        //homeCollectionView.backgroundColor = .white
        
        homeCollectionView.register(DestinationCell.self, forCellWithReuseIdentifier: "Cell")
        homeCollectionView.register(LoadingCell.self, forCellWithReuseIdentifier: "LoadingCell")
        homeCollectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self
        
        titleLabel = UILabel.create(text: "Welcome!", font: .boldSystemFont(ofSize: 22))
        subtitleLabel = UILabel.create(text: "Now you can explore any experience in 360 degrees and get all the details about it all in one place.", font: .systemFont(ofSize: 14))
        
        topBar = TopBarView()
        topBar.searchBar.delegate = self
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(homeCollectionView)
        view.addSubview(topBar)
        
        homeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
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
        let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .absolute(searchFlag ? 0 : 40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerHeaderSize,
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeaderView = homeCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as! SectionHeaderView
        
        if searchFlag {
            sectionHeaderView.configure(with: "")
            return sectionHeaderView
        }
        
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            if searchFlag { return 0 }
            return vm?.recommended.count == 0 ? 1 :  (vm?.recommended.count ?? 0)
        case 1:
            if searchFlag { return filteredExperinces.count }
            return vm?.recent.count == 0 ? 1 :  (vm?.recent.count ?? 0)
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let loadingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DestinationCell
        
        cell.conroller = self
        
        let experience: Experience?
        
        switch indexPath.section {
        case 0:
            guard !(vm?.recommended ?? []).isEmpty else { return loadingCell }
            experience = vm?.recommended[indexPath.row]
        case 1:
            if searchFlag {
                guard !filteredExperinces.isEmpty else { return loadingCell }
                experience = filteredExperinces[indexPath.row]
            } else {
                guard !(vm?.recent ?? []).isEmpty else { return loadingCell }
                experience = vm?.recent[indexPath.row]
            }
        default:
            return loadingCell
        }
        
        cell.experince = experience
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let experience: Experience?
        
        switch indexPath.section {
        case 0:
            experience = vm?.recommended[indexPath.row]
        case 1:
            if searchFlag {
                experience = filteredExperinces[indexPath.row]
            } else {
                experience = vm?.recent[indexPath.row]
            }
        default:
            experience = Experience(id: "", title: "", coverPhoto: "", description: "", viewsNumber: 0, likesNumber: 0, recommended: 0, isLiked: 0, city: City(name: ""))
        }
        
        let experienceDetails = ExperienceDetailsView(experience: experience!, conroller: self)
        let hostingController = UIHostingController(rootView: experienceDetails)
        
        present(hostingController, animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        homeCollectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredExperinces = vm?.recent ?? []
            searchFlag = false
            } else {
                searchFlag = true
                filteredExperinces = (vm?.recent ?? [])!.filter { $0.title.lowercased().contains(searchText.lowercased())
                }
            }
        
        homeCollectionView.reloadData()
    }
}
