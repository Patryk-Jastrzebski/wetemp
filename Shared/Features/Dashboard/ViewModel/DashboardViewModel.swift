//
//  DashboardViewModel.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 06/11/2022.
//

import SwiftUI

protocol DashboardViewModel {
    
}

final class DashboardViewModelImpl: ObservableObject, DashboardViewModel {
    enum ViewState {
        case loading, loaded, error
    }
    
    @Published var isBottomSheetEnabled = true
    @Published var isBottomSheedMapEnabled = false
    @Published var temperautreData: Temperature = .base
    @Published var historicalData: [Historical] = [.base]
    @Published var temperatureIcon: Image = Icons.rainSun
    @Published var temperaturesBottomSheet: [BottomTemperatureModel] = []
    @Published var mapSheet: Bool = false
    @Published var viewState: ViewState = .loading
    var detents: [CustomHeightDetent] = [.smallHome, .medium]
    var mapDetents: [CustomHeightDetent] = [.zero, .mapDashboard]
    
    private let networkService: DashboardNetworkService
    
    init(networkService: DashboardNetworkService = DashboardNetworkServiceImpl.shared) {
        self.networkService = networkService
        setTemps()
    }
    
    @MainActor
    func fetchData() async {
        do {
            viewState = .loading
            let data = try await networkService.fetchTemperatureData()
            let historical = try await networkService.fetchHistorical()
            viewState = .loaded
            withAnimation(.interpolatingSpring(stiffness: 100, damping: 30)) {
                temperautreData = data
                historicalData = historical
            }
        } catch {
            viewState = .error
            print(error.localizedDescription)
        }
    }
    
    func setTemps() {
        let temperature: [Int] = [7, 9, 8, 7, 5, 6, 7, 7, 5, 4, 3, 4, 3, 5, 6, 7, 3, 2, 1]
        let hours: [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]
        var a = 0
        for i in temperature {
            temperaturesBottomSheet.append(BottomTemperatureModel(temperature: i, hour: hours[a]))
            a += 1
        }
    }
}
