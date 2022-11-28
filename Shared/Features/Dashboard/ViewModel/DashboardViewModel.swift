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
    @Published var isBottomSheetEnabled = true
    @Published var isBottomSheedMapEnabled = false
    @Published var temperautreData: Temperature = .base
    @Published var temperatureIcon: Image = Icons.rainSun
    @Published var temperaturesBottomSheet: [BottomTemperatureModel] = []
    @Published var mapSheet: Bool = false
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
            let data = try await networkService.fetchTemperatureData()
            withAnimation(.interpolatingSpring(stiffness: 100, damping: 15)) {
                temperautreData = data
                temperatureIcon = getTemperatureImage()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func getTemperatureImage() -> Image {
        switch temperautreData.isRaining {
        case .yes:
            if temperautreData.temperature >= "10" {
                return Icons.rainSun
            } else {
                return Icons.rain
            }
        case .no:
            if temperautreData.temperature >= "10" {
                return Icons.sun
            } else {
                return Icons.cloudy
            }
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
