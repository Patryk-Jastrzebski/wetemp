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
    var detents: [CustomHeightDetent] = [.smallHome, .medium]
    
    private let networkService: DashboardNetworkService
    
    init(networkService: DashboardNetworkService = DashboardNetworkServiceImpl.shared) {
        self.networkService = networkService
    }
    
    func fetch() async {
        // TODO: Implement fetch methods
        do {
            _ = try await networkService.fetchTemperatureData()
        } catch {
            print(error.localizedDescription)
        }
    }
}
