//
//  BaseUrl.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 06/11/2022.
//

import Foundation

enum UrlFeaturePath: String {
    case temperature = "/temperature"
    case humidity = "/humidity"
    case preassure = "/preassure"
}

struct BaseUrl {
    private let baseUrl = "todo api url"
    private let featurePath: UrlFeaturePath
    private let url: String

    init(featurePath: UrlFeaturePath, url: String = "") {
        self.featurePath = featurePath
        self.url = url
    }

    func getUrl() -> String {
        return baseUrl + featurePath.rawValue + url
    }
}
