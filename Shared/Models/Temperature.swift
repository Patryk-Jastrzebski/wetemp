//
//  Temperature.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 28/11/2022.
//

import Foundation

struct Temperature: Decodable {
    static let base = Temperature(stationId: 0, stationName: "", time: "", date: "", isRaining: "", temperature: "", pressure: 0.0, humidity: 0, localization: "", lat: 0.0, lon: 0.0, description: "")
    
    let stationId: Int
    let stationName: String
    let time: String
    let date: String
    let isRaining: String
    let temperature: String
    let pressure: Double
    let humidity: Int
    let localization: String
    let lat: Float
    let lon: Float
    let description: String
    
    private enum CodingKeys: String, CodingKey {
        case stationId = "station_id"
        case stationName = "station_name"
        case time
        case date
        case isRaining = "is_raining"
        case temperature
        case pressure
        case humidity
        case localization
        case lat
        case lon
        case description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        stationId = try container.decode(Int.self, forKey: .stationId)
        stationName = try container.decode(String.self, forKey: .stationName)
        time = try container.decode(String.self, forKey: .time)
        date = try container.decode(String.self, forKey: .date)
        isRaining = try container.decode(String.self, forKey: .isRaining)
        temperature = try container.decode(String.self, forKey: .temperature)
        pressure = try container.decode(Double.self, forKey: .pressure)
        humidity = try container.decode(Int.self, forKey: .humidity)
        localization = try container.decode(String.self, forKey: .localization)
        lat = try container.decode(Float.self, forKey: .lat)
        lon = try container.decode(Float.self, forKey: .lon)
        description = try container.decode(String.self, forKey: .description)
    }
    
    init(stationId: Int,
         stationName: String,
         time: String,
         date: String,
         isRaining: String,
         temperature: String,
         pressure: Double,
         humidity: Int,
         localization: String,
         lat: Float,
         lon: Float,
         description: String) {
        
        self.stationName = stationName
        self.stationId = stationId
        self.time = time
        self.date = date
        self.isRaining = isRaining
        self.temperature = temperature
        self.pressure = pressure
        self.humidity = humidity
        self.localization = localization
        self.lat = lat
        self.lon = lon
        self.description = description
    }
}
