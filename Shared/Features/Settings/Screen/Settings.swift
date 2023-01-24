//
//  Settings.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 19/12/2022.
//

import SwiftUI

typealias SimpleAction = () -> Void

struct Settings: View {
    enum UnitAction {
        case temperature, pressure, days
    }
    @Environment(\.dismiss) var dismiss
    @AppStorage(AppStorageVariables.temperatureUnit) var temperatureUnit = "c"
    @AppStorage(AppStorageVariables.pressureUnit) var pressureUnit = "h"
    @AppStorage(AppStorageVariables.chartDays) var chartDays = "7"
    
    var body: some View {
        ZStack {
            backgroundColor
            content
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("settings")
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .semibold))
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}

extension Settings {
    private var backgroundColor: some View {
        Gradients.dayBackgroundGradient
            .ignoresSafeArea()
    }
    
    private var content: some View {
        VStack {
            subtitle
            tempSettings
            pressureSettings
            daysSettings
            Spacer()
            submitButton
            Spacer()
        }
    }
    
    private var subtitle: some View {
        HStack {
            Text("Unit")
                .foregroundColor(.white)
                .font(.system(size: 22, weight: .semibold))
            Spacer()
        }
        .padding()
    }
    
    private var tempSettings: some View {
        VStack(alignment: .leading) {
            Text("Temperature")
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .semibold))
            HStack(spacing: 25) {
                settingsButton(action: .temperature,
                               buttonLabel: "C",
                               unit: TemperatureUnit.celsius.apiValue,
                               storedValue: temperatureUnit)
                settingsButton(action: .temperature,
                               buttonLabel: "F",
                               unit: TemperatureUnit.fahrenheit.apiValue,
                               storedValue: temperatureUnit)
                settingsButton(action: .temperature,
                               buttonLabel: "K",
                               unit: TemperatureUnit.kelvin.apiValue,
                               storedValue: temperatureUnit)
                Spacer()
            }
        }
        .padding()
    }
    
    private var pressureSettings: some View {
        VStack(alignment: .leading) {
            Text("Pressure")
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .semibold))
            HStack(spacing: 25) {
                settingsButton(action: .pressure,
                               buttonLabel: "mBar",
                               unit: PressureUnit.mBar.apiValue,
                               storedValue: pressureUnit)
                settingsButton(action: .pressure,
                               buttonLabel: "bar",
                               unit: PressureUnit.bar.apiValue,
                               storedValue: pressureUnit)
                settingsButton(action: .pressure,
                               buttonLabel: "psi",
                               unit: PressureUnit.psi.apiValue,
                               storedValue: pressureUnit)
                Spacer()
            }
        }
        .padding()
    }
    
    private var daysSettings: some View {
        VStack(alignment: .leading) {
            Text("Chart length")
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .semibold))
            HStack(spacing: 25) {
                settingsButton(action: .days,
                               buttonLabel: "7 days",
                               unit: "7",
                               storedValue: chartDays)
                settingsButton(action: .days,
                               buttonLabel: "30 days",
                               unit: "30",
                               storedValue: chartDays)
                Spacer()
            }
        }
        .padding()
    }
    
    private var submitButton: some View {
        Button {
            dismiss()
        } label: {
            Text("submit")
                .foregroundColor(.black)
                .font(.system(size: 18, weight: .bold))
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background(.white)
                .cornerRadius(10)
        }
    }
    
    @ViewBuilder func settingsButton(action: UnitAction,
                                     buttonLabel: String,
                                     unit: String,
                                     storedValue: String) -> some View {
        HStack {
            Button {
                switch action {
                case .temperature:
                    temperatureUnit = unit
                case .pressure:
                    pressureUnit = unit
                case .days:
                    chartDays = unit
                }
            } label: {
                HStack {
                    Group {
                        if unit == storedValue {
                            Icons.circleFill
                        } else {
                            Icons.circle
                        }
                    }
                    .font(.system(size: 14, weight: .semibold))
                    Text(buttonLabel)
                        .font(.system(size: 24, weight: .semibold))
                }
                .foregroundColor(.white)
            }
        }
    }
}
