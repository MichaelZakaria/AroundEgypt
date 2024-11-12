//
//  HomeViewModel.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-11.
//

import Foundation
import UIKit

class HomeViewModel {
    private let networkService: NetworkServiceProtocol
    private let fileSevice: LocalFileService
    private let folderName: String
    
    var bindResultToViewController: () -> Void = {}
    
    var recommended: [Experience] = [] {
        didSet {
            bindResultToViewController()
        }
    }
    
    var recent: [Experience] = [] {
        didSet {
            bindResultToViewController()
        }
    }
    
    init () {
        networkService = NetworkSevice.instance
        fileSevice = LocalFileService.instance
        folderName = "experince_images"
        getExperinces()
    }
    
    func getExperinces() {
        getRecommendedExperinces()
        getRecentExperinces()
    }
    
    private func getRecommendedExperinces() {
        networkService.fetchData(url: APIHandler.getExperincesURL(.recommendedExperiences), method: .get, type: ExperiencesResponse.self, decodResult: true) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async { [weak self] in
                    self?.recommended = response.data
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getRecentExperinces() {
        networkService.fetchData(url: APIHandler.getExperincesURL(.recentExperiences), method: .get, type: ExperiencesResponse.self, decodResult: true) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async { [weak self] in
                    self?.recent = response.data
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getCoverPhoto(experince: Experience, completion: @escaping (Data) -> Void) {
        if let savedExperinceImage = fileSevice.getImage(folderName: folderName, imageName: experince.id) {
            completion(savedExperinceImage.pngData()!)
            return
        } else {
            networkService.fetchData(url: experince.coverPhoto, method: .get, type: Data.self, decodResult: false) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async { [weak self] in
                        completion(data)
                        guard let self = self, let image = UIImage(data: data)  else {return}
                        self.fileSevice.saveImage(image: image, folderName: self.folderName, imageName: experince.id)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
