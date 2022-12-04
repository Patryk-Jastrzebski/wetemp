//
//  SearchViewModel.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 04/12/2022.
//

import SwiftUI

final class SearchViewModel: ObservableObject {
    @Published var searchPhrase = ""
    @Published var stations = [Station]()
    
    func fetch() {
        withAnimation {
            stations = [.base, .base, .base, .base, .base]
        }
    }
}
