//
//  SearchViewModel.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 04/12/2022.
//

import SwiftUI

final class SearchViewModel: ObservableObject {
    enum State {
        case loading, loaded, error
    }
    
    @Published var searchPhrase = ""
    @Published var stations = [Station]()
    @Published var state: State = .loading
    
    let networkService: SearchNetworkService
    
    init(networkService: SearchNetworkService = SearchNetworkServiceImpl.shared) {
        self.networkService = networkService
        
    }
    
    @MainActor
    func fetch() async {
        do {
            state = .loading
            stations = try await networkService.fetchTemperatureData()
            state = .loaded
        } catch {
            state = .error
        }
    }
}
