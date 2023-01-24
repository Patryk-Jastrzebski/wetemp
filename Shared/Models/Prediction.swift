//
//  Prediction.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 06/01/2023.
//

import Foundation

struct Prediction: Decodable {
    let temperature: String?
    let image: Int?
    let date: String?
    
    var imageName: String? {
        switch image {
        case 0:
            return "sunSheet"
        case 1:
            return "sunSheet"
        case 2:
            return "sunAndCloudySheet"
        case 3:
            return "sunAndCloudySheet"
        case 4:
            return "cloudySheet"
        case 5:
            return "cloudySheet"
        default:
            return "cloudySheet"
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case temperature
        case image = "img_code"
        case date
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temperature = try container.decodeIfPresent(String.self, forKey: .temperature)
        image = try container.decodeIfPresent(Int.self, forKey: .image)
        date = try container.decodeIfPresent(String.self, forKey: .date)
    }
    
    init(temperature: String?, image: Int?, date: String?) {
        self.temperature = temperature
        self.image = image
        self.date = date
    }
}
