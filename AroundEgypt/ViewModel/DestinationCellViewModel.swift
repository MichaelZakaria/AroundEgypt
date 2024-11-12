//
//  DestinationCellViewModel.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-12.
//

import Foundation
import UIKit

class DestinationCellViewModel {
    private let networkService: NetworkServiceProtocol
    private let fileSevice: LocalFileService
    private let folderName: String
    
    init () {
        networkService = NetworkSevice.instance
        fileSevice = LocalFileService.instance
        folderName = "experince_images"
    }
    
    func getCoverPhoto(experince: Experience, completion: @escaping (Data) -> Void) {
        if let savedExperinceImage = fileSevice.getImage(folderName: folderName, imageName: experince.id) {
            completion(savedExperinceImage.pngData()!)
            return
        } else {
            networkService.request(url: experince.coverPhoto, method: .get, type: Data.self, decodResult: false) { result in
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
    
    func postLike(id: String, completion: @escaping () -> Void) {
        NetworkSevice.instance.request(url: APIHandler.requestURL(.likeExperince(id: id)), method: .post, type: Data.self, decodResult: false) { result in
            switch result {
            case .success(_):
                UserDefaults.standard.setValue(true, forKey: id)
                completion()
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
}
