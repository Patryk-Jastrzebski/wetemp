//
//  SpinnerCircle.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 06/01/2023.
//

import SwiftUI

struct SpinnerCircle: View {
    var start: CGFloat
    var end: CGFloat
    var rotation: Angle
    var color: Color
    
    var body: some View {
        Circle()
            .trim(from: start, to: end)
            .stroke(style: StrokeStyle(lineWidth: Constants.circleWidth, lineCap: .round))
            .fill(color)
            .rotationEffect(rotation)
    }
}

private extension Constants {
    static let circleWidth: CGFloat = 3
}
