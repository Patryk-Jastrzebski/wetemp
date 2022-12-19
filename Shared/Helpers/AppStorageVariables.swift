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
}

enum TemperatureUnit: String {
    case celsius, fahrenheit, kelvin
}

enum PressureUnit: String {
    case mBar, bar, psi
}

enum SpeedUnit: String {
    case meter, kilometer, mile
}

enum PrecipationUnit: String {
    case milimeter, inch
}
