//
//  DashboardNetworkService.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 06/11/2022.
//

import Foundation

protocol DashboardNetworkService {
    func fetchTemperatureData() async throws
}

final class DashboardNetworkServiceImpl: DashboardNetworkService {
    static let shared = DashboardNetworkServiceImpl()
    
    private let httpClient: HttpClient

    init(httpClient: HttpClient = HttpClientImpl.shared) {
        self.httpClient = httpClient
    }

    func fetchTemperatureData() async throws {
        let url = BaseUrl(featurePath: .temperature)
        let request = HttpRequest(url: url, method: .get)
        // TODO: Implement if api model will be ready
    }
}
