//
//  HomeViewModel.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-11.
//

import Foundation
import UIKit

class HomeViewModel {
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
        getExperinces()
    }
    
    func getExperinces() {
        getRecommendedExperinces()
        getRecentExperinces()
    }
    
    private func getRecommendedExperinces() {
        NetworkSevice.instance.request(url: APIHandler.requestURL(.recommendedExperiences), method: .get, type: ExperiencesResponse.self, decodResult: true) { result in
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
        NetworkSevice.instance.request(url: APIHandler.requestURL(.recentExperiences), method: .get, type: ExperiencesResponse.self, decodResult: true) { result in
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

}
