//
//  DashboardNetworkService.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 06/11/2022.
//

import Foundation

protocol DashboardNetworkService {
    func fetchTemperatureData() async throws -> Temperature
    func fetchHistorical() async throws -> [Historical]
}

final class DashboardNetworkServiceImpl: DashboardNetworkService {
    static let shared = DashboardNetworkServiceImpl()
    
    private let httpClient: HttpClient

    init(httpClient: HttpClient = HttpClientImpl.shared) {
        self.httpClient = httpClient
    }

    func fetchTemperatureData() async throws -> Temperature {
        let parameters: Parameters = [
            "station": 1,
            "t_unit": "c",
            "p_unit": "p"
        ]
        let url = BaseUrl(featurePath: .recent)
        let request = HttpRequest(url: url,
                                  method: .get,
                                  parameters: parameters)
        let requestResponse: Temperature = try await httpClient.perform(httpRequest: request)
        return requestResponse
    }
    
//    func fetchPredictions() async throws -> Temperature {
//
//    }
    func fetchHistorical() async throws -> [Historical] {
        let parameters: Parameters = [
            "station": 1,
            "t_unit": "c",
            "p_unit": "p",
            "n": 30
        ]
        let url = BaseUrl(featurePath: .historical)
        let request = HttpRequest(url: url,
                                  method: .get,
                                  parameters: parameters)
        let requestResponse: [Historical] = try await httpClient.perform(httpRequest: request)
        print(requestResponse)
        return requestResponse
    }
}
