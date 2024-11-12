//
//  ViewController.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-10.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UISearchResultsUpdating, GetExperincesProtocol {
    
    private var topBar: TopBarView!
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    private var homeCollectionView: UICollectionView!
    
    var vm: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewUI()
        vm = HomeViewModel()
        vm?.bindResultToViewController = { [weak self] in
            self?.homeCollectionView.reloadData()
        }
        
    }
    
    func getExperinces() {
        vm?.getExperinces()
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
        homeCollectionView.register(LoadingCell.self, forCellWithReuseIdentifier: "LoadingCell")
        homeCollectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        
        // Set the data source and delegate
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self
        
        // Setup the title and subtitle labels
        titleLabel = UILabel.create(text: "Welcome!", font: .boldSystemFont(ofSize: 22))
        subtitleLabel = UILabel.create(text: "Now you can explore any experience in 360 degrees and get all the details about it all in one place.", font: .systemFont(ofSize: 14))
        
        // Setup topbar
        topBar = TopBarView()
        topBar.searchBar.delegate = self
        
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
            if searchFlag {
                return 0
            }
            return vm?.recommended.count == 0 ? 1 :  (vm?.recommended.count ?? 0)
        case 1:
            if searchFlag {
                return filteredExperinces.count
            }
            return vm?.recent.count == 0 ? 1 :  (vm?.recent.count ?? 0)
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let loadingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DestinationCell
        
        cell.conroller = self
        
        switch indexPath.section {
        case 0:
            if !(vm?.recommended ?? []).isEmpty {
                cell.destinationName.text = vm?.recommended[indexPath.row].title
                cell.favouriteCount.text = vm?.recommended[indexPath.row].likesNumber.description
                cell.destinationImageView.viewsCountLabel.text = vm?.recommended[indexPath.row].viewsNumber.description
                
                vm?.getCoverPhoto(experince: (vm?.recommended[indexPath.row])!, completion: { data in
                    cell.destinationImageView.destinationImageView.image = UIImage(data: data)
                })
                
                cell.experinceID = vm?.recommended[indexPath.row].id
                
                if UserDefaults.standard.value(forKey: (vm?.recommended[indexPath.row].id)!) != nil {
                    cell.favouriteButton.imageView?.image = UIImage(systemName: "heart.fill")
                } else {
                    cell.favouriteButton.imageView?.image = UIImage(systemName: "heart")
                }
                
                cell.destinationImageView.recommenedBanner.isHidden = false
            } else {
                return loadingCell
            }
        case 1:
            if searchFlag {
                 if !filteredExperinces.isEmpty {
                    cell.destinationName.text = filteredExperinces[indexPath.row].title
                    cell.favouriteCount.text = filteredExperinces[indexPath.row].likesNumber.description
                    cell.destinationImageView.viewsCountLabel.text = filteredExperinces[indexPath.row].viewsNumber.description
                    
                    vm?.getCoverPhoto(experince: filteredExperinces[indexPath.row], completion: { data in
                        cell.destinationImageView.destinationImageView.image = UIImage(data: data)
                    })
                    
                     if filteredExperinces[indexPath.row].recommended == 1 {
                         cell.destinationImageView.recommenedBanner.isHidden = false
                     } else {
                         cell.destinationImageView.recommenedBanner.isHidden = true
                     }
                     
                     if UserDefaults.standard.value(forKey: filteredExperinces[indexPath.row].id) != nil {
                         cell.favouriteButton.imageView?.image = UIImage(systemName: "heart.fill")
                     } else {
                         cell.favouriteButton.imageView?.image = UIImage(systemName: "heart")
                     }
                     
                     cell.experinceID = filteredExperinces[indexPath.row].id
                     
                     return cell
                } else {
                    return loadingCell
                }
            }
            
            if !(vm?.recent ?? []).isEmpty {
            cell.destinationName.text = vm?.recent[indexPath.row].title
            cell.favouriteCount.text = vm?.recent[indexPath.row].likesNumber.description
            cell.destinationImageView.viewsCountLabel.text = vm?.recent[indexPath.row].viewsNumber.description
            
            vm?.getCoverPhoto(experince: (vm?.recent[indexPath.row])!, completion: { data in
                cell.destinationImageView.destinationImageView.image = UIImage(data: data)
            })
            
            if vm?.recent[indexPath.row].recommended == 1 {
                cell.destinationImageView.recommenedBanner.isHidden = false
            } else {
                cell.destinationImageView.recommenedBanner.isHidden = true
            }
                
            if UserDefaults.standard.value(forKey: (vm?.recent[indexPath.row].id)!) != nil {
                cell.favouriteButton.imageView?.image = UIImage(systemName: "heart.fill")
            } else {
                cell.favouriteButton.imageView?.image = UIImage(systemName: "heart")
            }
                
                cell.experinceID = vm?.recent[indexPath.row].id
        } else {
            return loadingCell
        }
        default:
            break
        }
        
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        homeCollectionView.reloadData()
    }
    
    var filteredExperinces: [Experience] = []
    var searchFlag: Bool = false
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredExperinces = vm?.recent ?? []
            titleLabel.isHidden = false
            subtitleLabel.isHidden = false
            searchFlag = false
            } else {
                searchFlag = true
                filteredExperinces = (vm?.recent ?? [])!.filter { $0.title.lowercased().contains(searchText.lowercased())
                }
            }
        
        homeCollectionView.reloadData()
    }
}
