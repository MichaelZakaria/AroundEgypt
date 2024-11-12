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
    
    @StateObject private var vm: MideaViewModel
    
    init(experience: Experience, conroller: UpdateFavouriteCountProtocol?) {
        self.experience = experience
        self.conroller = conroller
        _vm = StateObject(wrappedValue: MideaViewModel(experience: experience, conroller: conroller))
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(experience.title)
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
                    vm.toggleFavourite()
                }, label: {
                    Image(systemName: vm.isFavourite ? "heart.fill" : "heart")
                        .foregroundStyle(.myTeal)
                }).padding(.horizontal, 2)
                
                Text("\(vm.likesNumber)")
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


