//
//  Dashboard.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 01/11/2022.
//

import SwiftUI

struct Dashboard: View {
    @StateObject var viewModel = DashboardViewModelImpl()
    
    @State var sheet: Bool = true
    @State var offset: CGFloat = 0
    var body: some View {
        ZStack {
            backgroundColor
            VStack(spacing: 5) {
                temperature
                temperatureDescription
                circularViews
                Spacer()
            }
        }
        .customSheet(isPresented: $viewModel.isBottomSheetEnabled, detents: $viewModel.detents, backgroundColor: .white, header: {
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 50, height: 5)
                .padding(.top)
                .padding(.bottom, 5)
        }, scrollViewContent: {
            VStack {
                HStack {
                    Spacer()
                }
                Spacer()
            }
        }, staticContent: {})
        .foregroundColor(.white)
    }
}

extension Dashboard {
    // TODO: Remove mocks with API
    private var temperature: some View {
        VStack {
            Image("sun")
                .resizable()
                .scaledToFit()
                .frame(width: 220)
            Text("8°")
                .font(.system(size: 88))
                .fontWeight(.medium)
                .padding(.top, -60)
        }
        .padding(.top, -10)
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
    
    private var circularViews: some View {
        HStack(spacing: 30) {
            CircularProgress(progressValue: 1015, minValue: 950, maxValue: 1050)
            CircularProgress(progressValue: 87, minValue: 0, maxValue: 100)
            CircularProgress(progressValue: 18, minValue: 0, maxValue: 24)
        }
        .padding()
    }
    
    private var backgroundColor: some View {
        Gradients.dayBackgroundGradient
            .ignoresSafeArea()
    }
}
