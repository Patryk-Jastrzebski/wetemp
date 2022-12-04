//
//  Station.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 04/12/2022.
//

import Foundation

struct Station {
    static let base = Station(name: "Nazwa", localization: "Poland, Katowice", temperature: "8°")
    
    let id = UUID()
    let name: String
    let localization: String
    let temperature: String
}
