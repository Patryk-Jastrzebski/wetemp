//
//  CircularProgress.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 05/11/2022.
//

import SwiftUI

struct CircularProgress: View {
    let progressValue: Float
    let minValue: Float
    let maxValue: Float
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Circle()
                    .trim(from: Constants.minValue, to: Constants.maxValue)
                    .stroke(style: StrokeStyle(lineWidth: Constants.circleWidth, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Colors.backgroundProgress)
                    .rotationEffect(Angle(degrees: Constants.rotationValue))
                Circle()
                    .trim(from: Constants.minValue, to: getProgress())
                    .stroke(style: StrokeStyle(lineWidth: Constants.circleWidth, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Colors.foregroundProgress)
                    .rotationEffect(Angle(degrees: Constants.rotationValue))
                Text("\(progressValue, specifier: "%.0f")")
                    .font(.system(size: Constants.fontSize))
                    .fontWeight(.bold)
                    .foregroundColor(Colors.foregroundProgress)
            }
            .frame(width: Constants.viewWidth)
            HStack {
                Text("\(minValue, specifier: "%.0f")")
                Spacer()
                    .frame(width: Constants.textSpacing)
                Text("\(maxValue, specifier: "%.0f")")
            }
            .font(.system(size: Constants.fontSize))
            .fontWeight(.bold)
            .padding(.top, Constants.fixTopSpacing)
            .foregroundColor(Colors.foregroundProgress)
        }
    }
}

extension CircularProgress {
    private func getProgress() -> CGFloat {
        let interval = maxValue - minValue
        let currentValue = progressValue - minValue
        let percentageValue = (currentValue * 100) / interval
        let result = (Float(Constants.maxValue) * percentageValue) / 100
        return CGFloat(result)
    }
}

private extension Constants {
    static let circleWidth: CGFloat = 10
    static let rotationValue = 153.5
    static let viewWidth: CGFloat = 60
    static let maxValue: CGFloat = 0.65
    static let minValue: CGFloat = 0.0
    static let fixTopSpacing: CGFloat = -8
    static let textSpacing: CGFloat = 20
    static let fontSize: CGFloat = 10
}
