//
//  CircularProgress.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 05/11/2022.
//

import SwiftUI

struct CircularProgress: View {
    let progressValue: Float?
    var specifier: Int = 0
    let minValue: Float
    let maxValue: Float
    let image: Image
    let unit: String
    
    var body: some View {
        if let progressValue = progressValue {
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .trim(from: Constants.minValue, to: Constants.maxValue)
                        .stroke(style: StrokeStyle(lineWidth: Constants.circleWidth, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Colors.backgroundProgress)
                        .rotationEffect(Angle(degrees: Constants.rotationValue))
                    if getProgress(progressValue) < Constants.maxValue {
                        Circle()
                            .trim(from: Constants.minValue, to: getProgress(progressValue))
                            .stroke(style: StrokeStyle(lineWidth: Constants.circleWidth, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Colors.foregroundProgress)
                            .rotationEffect(Angle(degrees: Constants.rotationValue))
                    }
                    VStack {
                        Text("\(progressValue, specifier: "%.\(specifier)f")")
                            .font(.system(size: Constants.fontSize))
                            .fontWeight(.bold)
                            .foregroundColor(Colors.foregroundProgress)
                        Text(unit)
                            .font(.system(size: Constants.fontSize))
                            .fontWeight(.bold)
                            .foregroundColor(Colors.foregroundProgress)
                    }
                }
                .frame(width: Constants.viewWidth)
                ZStack(alignment: .center) {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: Constants.imageSize)
                    valuesView
                }
                .font(.system(size: Constants.fontSize))
                .fontWeight(.bold)
                .padding(.top, Constants.fixTopSpacing)
                .foregroundColor(Colors.foregroundProgress)
            }
            .frame(width: 100)
            .padding(.horizontal, -15)
        }
    }
}

extension CircularProgress {
    private var valuesView: some View {
        HStack(alignment: .center) {
            Text("\(minValue, specifier: "%.\(specifier)f")")
            Spacer()
                .frame(width: Constants.textSpacing)
            Text("\(maxValue, specifier: "%.\(specifier)f")")
        }
    }
    private func getProgress(_ progress: Float) -> CGFloat {
        let interval = maxValue - minValue
        let currentValue = progress - minValue
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
    static let textSpacing: CGFloat = 40
    static let fontSize: CGFloat = 10
    static let imageSize: CGFloat = 15
}
