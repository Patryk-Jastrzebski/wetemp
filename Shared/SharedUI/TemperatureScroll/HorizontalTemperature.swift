//
//  HorizontalTemperature.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 09/11/2022.
//

import SwiftUI

struct HorizontalTemperature: View {
    
    @Binding var temps: [Prediction]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(temps, id: \.date) { model in
                    VStack(spacing: 15) {
                        date(date: model.date)
                        image(image: model.imageName)
                        temperature(temperature: model.temperature)
                    }
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                }
            }
        }
        .padding()
    }
}

extension HorizontalTemperature {
    @ViewBuilder private func date(date: String?) -> some View {
        Group {
            if let date = date {
                Text(date)
            } else {
                Text("---")
            }
        }
        .font(.system(size: 14))
    }
    
    @ViewBuilder private func image(image: String?) -> some View {
        Group {
            if let image = image {
                Image(image)
            } else {
                Text("---")
            }
        }
        .font(.system(size: 14))
    }
    
    @ViewBuilder private func temperature(temperature: String?) -> some View {
        Group {
            if let temperature = temperature {
                Text(temperature)
            } else {
                Text("---")
            }
        }
        .font(.system(size: 20))
    }
}
