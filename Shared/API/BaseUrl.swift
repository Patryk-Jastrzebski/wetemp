//
//  BaseUrl.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 06/11/2022.
//

import Foundation

enum UrlFeaturePath: String {
    case recent = "/recent"
    case historical = "/historical"
    case list = "/stations"
    case prediction = "/predictions"
}

struct BaseUrl {
    private let baseUrl = "https://wthstation.bieda.it/api/v1"
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
