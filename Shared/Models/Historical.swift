//
//  Historical.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 02/01/2023.
//

import Foundation

struct Historical: Decodable {
    static let base = Historical(isRaining: nil, temperature: nil, pressure: nil, humidity: nil, insolation: nil, date: nil)
    
    let isRaining: Int?
    let temperature: Int?
    let pressure: Float?
    let humidity: Int?
    let insolation: Int?
    let date: Int?
    
    private enum CodingKeys: String, CodingKey {
        case isRaining = "is_raining"
        case temperature
        case pressure
        case humidity
        case insolation
        case date
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isRaining = try container.decodeIfPresent(Int.self, forKey: .isRaining)
        temperature = try container.decodeIfPresent(Int.self, forKey: .temperature)
        pressure = try container.decodeIfPresent(Float.self, forKey: .pressure)
        humidity = try container.decodeIfPresent(Int.self, forKey: .humidity)
        insolation = try container.decodeIfPresent(Int.self, forKey: .insolation)
        date = try container.decodeIfPresent(Int.self, forKey: .date)
    }
    
    init(isRaining: Int?,
         temperature: Int?,
         pressure: Float?,
         humidity: Int?,
         insolation: Int?,
         date: Int?) {
        self.isRaining = isRaining
        self.temperature = temperature
        self.pressure = pressure
        self.humidity = humidity
        self.insolation = insolation
        self.date = date
    }
}
