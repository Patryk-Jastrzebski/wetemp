//
//  HorizontalTemperature.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 09/11/2022.
//

import SwiftUI

struct HorizontalTemperature: View {
    
    let temps: [BottomTemperatureModel]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(temps, id: \.id) { model in
                    VStack(spacing: 15) {
                        Text(model.hour.description)
                            .font(.system(size: 14))
                        Image("Cloudy")
                            .foregroundColor(.black)
                        Text("\(model.temperature)°")
                            .font(.system(size: 20))
                    }
                    .fontWeight(.semibold)
                }
            }
        }
        .padding()
    }
}

struct BottomTemperatureModel: Identifiable {
    var id = UUID()
    let temperature: Int
    let hour: Int
}
