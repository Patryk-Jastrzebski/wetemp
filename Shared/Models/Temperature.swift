//
//  Temperature.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 28/11/2022.
//

import Foundation

struct Temperature: Decodable {
    static let base = Temperature(stationId: 0,
                                  stationName: "",
                                  time: "",
                                  date: "", isRaining: nil,
                                  temperature: "",
                                  pressure: nil,
                                  humidity: nil,
                                  insolation: nil,
                                  localization: nil,
                                  lat: 0.0,
                                  lon: 0.0,
                                  description: nil,
                                  image: 100)
    
    let stationId: Int
    let stationName: String
    let time: String
    let date: String
    let isRaining: Raining?
    let temperature: String?
    let pressure: Float?
    let humidity: Float?
    let insolation: Float?
    let localization: String?
    var lat: CGFloat
    var lon: CGFloat
    let description: String?
    let image: Int?
    
    var imageName: String? {
        switch image {
        case 0:
            return "sun"
        case 1:
            return "sunAndCloudy"
        case 2:
            return "cloudy"
        case 3:
            return "rainSun"
        case 4:
            return "rainSun"
        case 5:
            return "rain"
        case .none:
            return nil
        case .some(_):
            return ""
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case stationId = "station_id"
        case stationName = "station_name"
        case time
        case date
        case isRaining = "is_raining"
        case temperature
        case pressure
        case humidity
        case insolation
        case localization
        case lat
        case lon
        case description
        case image = "img_code"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        stationId = try container.decode(Int.self, forKey: .stationId)
        stationName = try container.decode(String.self, forKey: .stationName)
        time = try container.decode(String.self, forKey: .time)
        date = try container.decode(String.self, forKey: .date)
        isRaining = try container.decodeIfPresent(Raining.self, forKey: .isRaining)
        temperature = try container.decodeIfPresent(String.self, forKey: .temperature)
        pressure = try container.decodeIfPresent(Float.self, forKey: .pressure)
        humidity = try container.decodeIfPresent(Float.self, forKey: .humidity)
        insolation = try container.decodeIfPresent(Float.self, forKey: .insolation)
        localization = try container.decodeIfPresent(String.self, forKey: .localization)
        lat = try container.decode(CGFloat.self, forKey: .lat)
        lon = try container.decode(CGFloat.self, forKey: .lon)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        image = try container.decodeIfPresent(Int.self, forKey: .image)
    }
    
    init(stationId: Int,
         stationName: String,
         time: String,
         date: String,
         isRaining: Raining?,
         temperature: String?,
         pressure: Float?,
         humidity: Float?,
         insolation: Float?,
         localization: String?,
         lat: CGFloat,
         lon: CGFloat,
         description: String?,
         image: Int?) {
        
        self.stationName = stationName
        self.stationId = stationId
        self.time = time
        self.date = date
        self.isRaining = isRaining
        self.temperature = temperature
        self.pressure = pressure
        self.humidity = humidity
        self.insolation = insolation
        self.localization = localization
        self.lat = lat
        self.lon = lon
        self.description = description
        self.image = image
    }
}

enum Raining: String, Decodable {
    case yes = "Yes"
    case no = "No"
}
