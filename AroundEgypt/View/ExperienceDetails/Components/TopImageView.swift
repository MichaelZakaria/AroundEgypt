//
//  TopImageView.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-12.
//

import SwiftUI

struct TopImageView: View {
    var experience: Experience
    
    var body: some View {
        VStack {
            ZStack {
                Image(uiImage: LocalFileService.instance.getImage(folderName: "experince_images", imageName: experience.id)
                      ?? .background)
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.clear,     Color.black.opacity(0.5)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 50), alignment: .bottom
                    )
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("EXPLORE NOW")
                        .font(.system(size: 14,weight: .bold))
                })
                .padding()
                .background(.white)
                .foregroundColor(.myTeal)
                .cornerRadius(10)
            }
            .frame(height: 285)
            .clipped()
            
            HStack {
                Image(systemName: "eye.fill")
                Text("\(experience.viewsNumber) views")
                    .font(.system(size: 14, weight: .bold))
                
                Spacer()
                
                Image(systemName: "photo.on.rectangle")
            }
            .foregroundStyle(.white)
            .padding(.horizontal)
            .position(x: 192, y: -30)
        }
    }
}

#Preview  {
    TopImageView(experience: Experience.previewExperience)
}
