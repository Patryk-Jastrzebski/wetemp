//
//  LoadingIndicator.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 06/01/2023.
//

import SwiftUI

struct LoadingIndicator: View {
    let oneRotationTime: Double = 0.5
    let animationDuration: Double = 2
    var color: Color = .white
    
    @State var spinnerStartValue: CGFloat = Constants.startValue
    @State var spinnderEndValue: CGFloat = Constants.startValue
    @State var rotationDegree: Angle = .degrees(270)
    @State var timer: Timer?
    
    var body: some View {
        SpinnerCircle(start: spinnerStartValue, end: spinnderEndValue, rotation: rotationDegree, color: color)
            .frame(width: Constants.frameSize, height: Constants.frameSize)
            .onAppear {
                self.animate()
                self.timer = Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { _ in
                    self.animate()
                }
            }
            .onDisappear {
                timer?.invalidate()
                timer = nil
            }
    }
    
    func animateSpinner(with duration: Double, completion: @escaping (() -> Void)) {
        self.timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { _ in
            withAnimation(.easeInOut(duration: self.oneRotationTime)) {
                completion()
            }
        }
    }

    func animate() {
        animateSpinner(with: oneRotationTime) {
            self.spinnderEndValue = Constants.endValue
        }
        
        animateSpinner(with: (oneRotationTime * 2)) {
            self.spinnerStartValue = Constants.endValue
        }
        
        animateSpinner(with: (oneRotationTime * 3)) {
            self.spinnerStartValue = Constants.startValue
            self.spinnderEndValue = Constants.startValue
        }
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator()
            .preferredColorScheme(.dark)
    }
}

private extension Constants {
    static let circleWidth: CGFloat = 3
    static let frameSize: CGFloat = 25
    static let startValue: CGFloat = 0.0
    static let endValue: CGFloat = 1.0
}
