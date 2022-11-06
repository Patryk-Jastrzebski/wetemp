//
//  HttpRequest.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 06/11/2022.
//

import Foundation

typealias Parameters = [String: Any]

class HttpRequest {
    var url: BaseUrl
    var method: HttpMethod
    var parameters: Parameters

    init(url: BaseUrl, method: HttpMethod, parameters: Parameters = [:]) {
        self.url = url
        self.method = method
        self.parameters = parameters
    }

    init<K: Encodable>(url: BaseUrl, method: HttpMethod, parameters: K) {
        self.url = url
        self.method = method
        do {
            let data = try JSONEncoder().encode(parameters)
            guard let params = try JSONSerialization.jsonObject(with: data) as? Parameters else {
                self.parameters = [:]
                return
            }
            self.parameters = params
        } catch {
            self.parameters = [:]
        }
    }
}
