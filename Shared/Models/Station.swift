//
//  Station.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 04/12/2022.
//

import Foundation

struct Station: Decodable {
    static let base = Station(id: 1, name: "", localization: "")
    
    let uuid = UUID()
    let id: Int
    let name: String
    let localization: String
}
