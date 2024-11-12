//
//  MideaView.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-12.
//

import SwiftUI

struct MideaView: View {
    var experience: Experience
    var conroller: UpdateFavouriteCountProtocol?
    
    @State private var isFavourite: Bool
    @State private var likesNumber: Int
    
    init(experience: Experience, conroller: UpdateFavouriteCountProtocol?) {
        self.experience = experience
        self.isFavourite = UserDefaults.standard.value(forKey: experience.id) == nil ? false : true
        self.likesNumber = experience.likesNumber
        self.conroller = conroller
    }
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text("\(experience.title)")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.bottom, 2)
                
                Text("\(experience.city.name), Egypt.")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.gray)
                    
            }
    
            Spacer()
            
            HStack {
                Button(action: {}, label: {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundStyle(.myTeal)
                    
                }).padding(.horizontal, 2)
                
                Button(action: {
                    if UserDefaults.standard.value(forKey: experience.id) == nil {
                        isFavourite = true
                        
                        NetworkSevice.instance.fetchData(url: APIHandler.getExperincesURL(.likeExperince(id: experience.id)), method: .post, type: Data.self, decodResult: false) { result in
                            switch result {
                            case .success(_):
                                UserDefaults.standard.setValue(true, forKey: experience.id)
                                conroller?.updateFavouriteCount(experienceID: experience.id)
                                likesNumber = likesNumber + 1
                            case .failure(let error):
                                print(error.localizedDescription)
                                
                            }
                        }
                    }
                }, label: {
                    Image(systemName: isFavourite ? "heart.fill" : "heart")
                        .foregroundStyle(.myTeal)
                }).padding(.horizontal, 2)
                
                Text("\(likesNumber)")
                    .font(.system(size: 14, weight: .semibold))
            }
            .font(.system(size: 24))
                
        }
    }
}

#Preview (traits: .sizeThatFitsLayout) {
    MideaView(experience: Experience.previewExperience, conroller: nil)
        .padding()
}


