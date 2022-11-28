//
//  DashboardNetworkService.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 06/11/2022.
//

import Foundation

protocol DashboardNetworkService {
    func fetchTemperatureData() async throws -> Temperature
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
            "t_unit": "f",
            "p_unit": "p"
        ]
        let url = BaseUrl(featurePath: .recent)
        let request = HttpRequest(url: url,
                                  method: .get,
                                  parameters: parameters)
        let requestResponse: Temperature = try await httpClient.perform(httpRequest: request)
        return requestResponse
        
    }
}
