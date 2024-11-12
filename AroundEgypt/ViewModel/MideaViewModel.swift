//
//  MideaViewModel.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-12.
//

import Foundation

class MideaViewModel: ObservableObject {
    
    private var experience: Experience
    private var conroller: UpdateFavouriteCountProtocol?
    
    @Published var isFavourite: Bool
    @Published var likesNumber: Int
    
    init(experience: Experience, conroller: UpdateFavouriteCountProtocol?) {
        self.experience = experience
        self.conroller = conroller
        
        self.isFavourite = UserDefaults.standard.value(forKey: experience.id) == nil ? false : true
        self.likesNumber = experience.likesNumber
    }
    
    func toggleFavourite() {
        if isFavourite {
            return
        }
        
        isFavourite = true
        likesNumber += 1
        
        NetworkSevice.instance.request(url: APIHandler.requestURL(.likeExperince(id: experience.id)), method: .post, type: Data.self, decodResult: false) { result in
            switch result {
            case .success(_):
                UserDefaults.standard.setValue(true, forKey: self.experience.id)
                self.conroller?.updateFavouriteCount(experienceID: self.experience.id)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
