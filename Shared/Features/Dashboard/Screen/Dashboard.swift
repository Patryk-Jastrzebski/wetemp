//
//  Dashboard.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 01/11/2022.
//

import SwiftUI
import SwiftUICharts
import MapKit

struct Dashboard: View {
    @StateObject var viewModel = DashboardViewModelImpl()
    
    @State var sheet: Bool = true
    @State var offset: CGFloat = 0
    var body: some View {
        ZStack {
            backgroundColor
            dashBoardContent
            navigation
        }
        .onLoad {
            Task { await viewModel.fetchData() }
        }
        .foregroundColor(.white)
        .customSheet(isPresented: $viewModel.isBottomSheedMapEnabled, detents: $viewModel.mapDetents, backgroundColor: .white, header: {
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 50, height: 5)
                .padding(.top)
                .padding(.bottom, 5)
        }, scrollViewContent: {}, staticContent: { MapView()
                .cornerRadius(10)
                .padding()
        })
        .customSheet(isPresented: $viewModel.isBottomSheetEnabled, detents: $viewModel.detents, backgroundColor: .white, header: {
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 50, height: 5)
                .padding(.top)
                .padding(.bottom, 5)
        }, scrollViewContent: {
            HorizontalTemperature(temps: viewModel.temperaturesBottomSheet)
                .padding(.leading, 5)
            ChartView()
        }, staticContent: {})
    }
}

extension Dashboard {
    private var dashBoardContent: some View {
        VStack(spacing: 5) {
            switch viewModel.viewState {
            case .loading:
                EmptyView()
            case .loaded:
                temperature
                mapButton
                circularViews
                Spacer()
            case .error:
                EmptyView()
            }
        }
    }
    
    private var navigation: some View {
        VStack {
            HStack {
                settings
                Spacer()
                search
            }
            .padding(20)
            .font(.system(size: 22))
            Spacer()
        }
    }
    
    private var temperature: some View {
        VStack {
            viewModel.temperatureIcon
                .resizable()
                .scaledToFit()
                .frame(width: 220)
                .padding()
            Text(viewModel.temperautreData.temperature ?? "")
                .font(.system(size: 88))
                .fontWeight(.medium)
                .padding(.top, -60)
        }
        .padding(.top)
    }
    
    private var mapButton: some View {
        Button {
            viewModel.isBottomSheedMapEnabled.toggle()
        } label: {
            temperatureDescription
        }
    }
    
    private var temperatureDescription: some View {
        VStack(spacing: 5) {
            Text(viewModel.temperautreData.localization ?? "")
                .font(.system(size: 24))
                .fontWeight(.bold)
            Text(viewModel.temperautreData.date)
                .font(.system(size: 20))
                .fontWeight(.bold)
            Text(viewModel.temperautreData.description ?? "")
                .font(.system(size: 18))
                .fontWeight(.semibold)
        }
    }
    
    private var circularViews: some View {
        HStack(spacing: 30) {
                CircularProgress(progressValue: viewModel.temperautreData.pressure, minValue: 900, maxValue: 1100)
                CircularProgress(progressValue: viewModel.temperautreData.humidity, minValue: 0, maxValue: 100)
                CircularProgress(progressValue: 18, minValue: 0, maxValue: 24)
        }
        .padding()
    }
    
    private var backgroundColor: some View {
        Gradients.dayBackgroundGradient
            .ignoresSafeArea()
    }
    
    private var settings: some View {
        NavigationLink {
            Settings()
        } label: {
            Image(systemName: "gear")
        }
    }
    
    private var search: some View {
        NavigationLink {
            Search()
        } label: {
            Image(systemName: "magnifyingglass")
        }
        
    }
}
