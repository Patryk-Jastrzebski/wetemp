//
//  Dashboard.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 01/11/2022.
//

import SwiftUI

struct Dashboard: View {
    @State var sheet: Bool = true
    @State var offset: CGFloat = 0
    var body: some View {
        ZStack {
            Gradients.dayBackgroundGradient
                .ignoresSafeArea()
            VStack(spacing: 5) {
                temperature
                temperatureDescription
                Spacer()
            }
        }
        .foregroundColor(.white)
    }
}

extension Dashboard {
    // TODO: Remove mocks with API
    private var temperature: some View {
        VStack(spacing: 0) {
            Image("sun")
            Text("8°")
                .font(.system(size: 88))
                .fontWeight(.medium)
            
                .padding(.top, -80)
        }
    }
    
    private var temperatureDescription: some View {
        VStack(spacing: 5) {
            Text("Katowice")
                .font(.system(size: 24))
                .fontWeight(.bold)
            Text("tue., 1.11")
                .font(.system(size: 20))
                .fontWeight(.bold)
            Text("little windy today, dress warmly")
                .font(.system(size: 18))
                .fontWeight(.semibold)
        }
    }
}
