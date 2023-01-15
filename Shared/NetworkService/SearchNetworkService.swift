//
//  SearchNetworkService.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 06/01/2023.
//

import Foundation

protocol SearchNetworkService {
    func fetchTemperatureData() async throws -> [Station]
}

final class SearchNetworkServiceImpl: SearchNetworkService {
    static let shared = SearchNetworkServiceImpl()
    
    private let httpClient: HttpClient

    init(httpClient: HttpClient = HttpClientImpl.shared) {
        self.httpClient = httpClient
    }

    func fetchTemperatureData() async throws -> [Station] {
        let url = BaseUrl(featurePath: .list)
        let request = HttpRequest(url: url,
                                  method: .get)
        let requestResponse: [Station] = try await httpClient.perform(httpRequest: request)
        return requestResponse
    }
}
