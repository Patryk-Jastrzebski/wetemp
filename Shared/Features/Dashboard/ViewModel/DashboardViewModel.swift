//
//  DashboardViewModel.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 06/11/2022.
//

import SwiftUI
import MapKit

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
    @Published var predictionState: ViewState = .error
    @Published var predictionData: [Prediction] = []
    @Published var searchPresented: Bool = false
    
    @AppStorage(AppStorageVariables.pressureUnit) var pressureUnit = "h"
    
    var detents: [CustomHeightDetent] = [.smallHome, .medium]
    var mapDetents: [CustomHeightDetent] = [.zero, .mapDashboard]
    
    private let networkService: DashboardNetworkService
    
    init(networkService: DashboardNetworkService = DashboardNetworkServiceImpl.shared) {
        self.networkService = networkService
    }
    
    @MainActor func fetch() async {
        async let pred: () = fetchPrediction()
        async let data: () = fetchData()
        
        await _ = (pred, data)
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
    
    @MainActor
    func fetchPrediction() async {
        do {
            withAnimation {
                predictionState = .loading
            }
            let prediction = try await networkService.fetchPredictions()
            predictionState = .loaded
            withAnimation(.interpolatingSpring(stiffness: 100, damping: 30)) {
                predictionData = prediction
            }
        } catch {
            predictionState = .error
        }
    }
    
    func getMinPressureValue() -> Float {
        switch pressureUnit {
        case PressureUnit.mBar.apiValue:
            return 900
        case PressureUnit.bar.apiValue:
            return 0.900
        case PressureUnit.psi.apiValue:
            return 13.7785
        default:
            print("error!!!")
            return 112
        }
    }
    
    func getMaxPressureValue() -> Float {
        switch pressureUnit {
        case PressureUnit.mBar.apiValue:
            return 1100
        case PressureUnit.bar.apiValue:
            return 1.100
        case PressureUnit.psi.apiValue:
            return 15.2289
        default:
            print("error!!!")
            return 112
        }
    }
    
    func getSpecifierForPressure() -> Int {
        switch pressureUnit {
        case PressureUnit.mBar.apiValue:
            return 0
        case PressureUnit.bar.apiValue:
            return 3
        case PressureUnit.psi.apiValue:
            return 2
        default:
            print("error!!!")
            return 0
        }
    }
    
    func getPressureUnitString() -> String {
        switch pressureUnit {
        case "h":
            return "hPa"
        case "b":
            return "bar"
        case "p":
            return "psi"
        default:
            return ""
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
