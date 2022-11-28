//
//  BottomTemperatureModel.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 28/11/2022.
//

import Foundation

struct BottomTemperatureModel: Identifiable {
    var id = UUID()
    let temperature: Int
    let hour: Int
}

