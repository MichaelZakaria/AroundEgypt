//
//  ExperienceDetailsView.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-12.
//

import SwiftUI

struct ExperienceDetailsView: View {
    var experience: Experience
    var conroller: UpdateFavouriteCountProtocol?
    
    var body: some View {
        VStack {
            TopImageView(experience: experience)
                .frame(height: 285)
                .padding(.bottom)
            MideaView(experience: experience, conroller: conroller!)
                .padding(.horizontal)
            Divider()
                .padding()
            
            VStack(alignment: .leading) {
                Text("Description")
                    .font(.system(size: 22, weight: .bold))
                    .padding(.bottom, 2)
                
                ScrollView {
                    Text("\(experience.description)")
                        .font(.system(size: 14, weight: .semibold))
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

#Preview {
    ExperienceDetailsView(experience: Experience.previewExperience, conroller: nil)
}
