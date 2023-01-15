//
//  DashboardNetworkService.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 06/11/2022.
//

import SwiftUI

protocol DashboardNetworkService {
    func fetchTemperatureData() async throws -> Temperature
    func fetchHistorical() async throws -> [Historical]
    func fetchPredictions() async throws -> [Prediction]
}

final class DashboardNetworkServiceImpl: DashboardNetworkService {
    static let shared = DashboardNetworkServiceImpl()
    
    @AppStorage(AppStorageVariables.temperatureUnit) var temperatureUnit = "c"
    @AppStorage(AppStorageVariables.pressureUnit) var pressureUnit = "h"
    @AppStorage(AppStorageVariables.stationId) var stationId = 1
    @AppStorage(AppStorageVariables.chartDays) var chartDays = "7"

    
    private let httpClient: HttpClient

    init(httpClient: HttpClient = HttpClientImpl.shared) {
        self.httpClient = httpClient
    }

    func fetchTemperatureData() async throws -> Temperature {
        let parameters: Parameters = [
            "station": stationId,
            "t_unit": temperatureUnit,
            "p_unit": pressureUnit
        ]
        let url = BaseUrl(featurePath: .recent)
        let request = HttpRequest(url: url,
                                  method: .get,
                                  parameters: parameters)
        let requestResponse: Temperature = try await httpClient.perform(httpRequest: request)
        return requestResponse
    }
    
    func fetchPredictions() async throws -> [Prediction] {
        let parameters: Parameters = [
            "station": stationId,
            "t_unit": temperatureUnit
        ]
        let url = BaseUrl(featurePath: .prediction)
        let request = HttpRequest(url: url,
                                  method: .get,
                                  parameters: parameters)
        let requestResponse: [Prediction] = try await httpClient.perform(httpRequest: request)
        return requestResponse
    }
    
    func fetchHistorical() async throws -> [Historical] {
        let parameters: Parameters = [
            "station": stationId,
            "t_unit": temperatureUnit,
            "p_unit": pressureUnit,
            "n": chartDays
        ]
        let url = BaseUrl(featurePath: .historical)
        let request = HttpRequest(url: url,
                                  method: .get,
                                  parameters: parameters)
        let requestResponse: [Historical] = try await httpClient.perform(httpRequest: request)
        return requestResponse
    }
}
