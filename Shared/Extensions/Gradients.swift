//
//  Gradients.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 01/11/2022.
//

import SwiftUI

struct Gradients {
    static var dayBackgroundGradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Constants.topBlue,
                                                   Constants.bottomBlue]),
                       startPoint: .top,
                       endPoint: .bottom)
    }
}

private extension Constants {
    static let topBlue = Color.hex("#0A4DD0")
    static let bottomBlue = Color.hex("#148EFF")
}
