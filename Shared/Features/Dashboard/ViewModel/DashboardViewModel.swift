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
    @Published var temperautreData: Temperature = .base
    @Published var temperaturesBottomSheet: [BottomTemperatureModel] = []
    var detents: [CustomHeightDetent] = [.smallHome, .medium]
    
    private let networkService: DashboardNetworkService
    
    init(networkService: DashboardNetworkService = DashboardNetworkServiceImpl.shared) {
        self.networkService = networkService
        setTemps()
    }
    
    func fetch() async {
        // TODO: Implement fetch methods
        do {
            _ = try await networkService.fetchTemperatureData()
        } catch {
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
