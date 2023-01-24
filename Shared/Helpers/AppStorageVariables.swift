//
//  AppStorageVariables.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 19/12/2022.
//

import Foundation

struct AppStorageVariables {
    static let temperatureUnit = "temperatureUnit"
    static let pressureUnit = "pressureUnit"
    static let speedUnit = "speedUnit"
    static let precipationUnit = "precipationUnit"
    static let stationId = "stationId"
    static let chartDays = "chartDays"
}

enum TemperatureUnit: String {
    case celsius, fahrenheit, kelvin
    
    var apiValue: String {
        switch self {
        case .celsius:
            return "c"
        case .fahrenheit:
            return "f"
        case .kelvin:
            return "k"
        }
    }
}

enum PressureUnit: String {
    case mBar, bar, psi
    
    var apiValue: String {
        switch self {
        case .mBar:
            return "h"
        case .bar:
            return "b"
        case .psi:
            return "p"
        }
    }
}
