//
//  ChartView.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 09/11/2022.
//

import SwiftUI
import SwiftUICharts

struct ChartView: View {
    @AppStorage(AppStorageVariables.chartDays) var chartDays = "7"
    @AppStorage(AppStorageVariables.temperatureUnit) var temperatureUnit = "c"
    let historical: [Historical]
    var body: some View {
        VStack(spacing: 30) {
            LineView(data: getTemperature(), title: "Temperature", legend: "last \(chartDays) days in \(getTemperatureUnit())", style: Styles.barChartStyleNeonBlueLight)
                .frame(height: 350)
            LineView(data: getHumidity(), title: "Humidity", legend: "last \(chartDays) days %", style: Styles.barChartStyleOrangeLight)
                .frame(height: 350)
            LineView(data: getPressure(), title: "Pressure", legend: "last \(chartDays) days %", style: Styles.barChartStyleOrangeLight)
                .frame(height: 350)
            LineView(data: getIsRaining(), title: "Last \(chartDays) days Raining", legend: "0 - clear, 1 - rain", style: Styles.barChartStyleOrangeLight)
                .frame(height: 350)
            LineView(data: getInsolation(), title: "Insolation", legend: "last \(chartDays) days %", style: Styles.barChartStyleOrangeLight)
                .frame(height: 350)
        }
        .preferredColorScheme(.light)
        .padding()
    }
    
    private func getTemperatureUnit() -> String {
        switch temperatureUnit {
        case "c":
            return "Celsius"
        case "f":
            return "Fahrenheit"
        case "k":
            return "Kelvin"
        default:
            return "-"
        }
    }
    
    private func getTemperature() -> [Double] {
        var temperatures: [Double] = []
        for history in historical {
            temperatures.append(Double(history.temperature ?? 0))
        }
        return temperatures.reversed()
    }
    
    private func getHumidity() -> [Double] {
        var humidities: [Double] = []
        for history in historical {
            humidities.append(Double(history.humidity ?? 0))
        }
        return humidities.reversed()
    }
    
    private func getPressure() -> [Double] {
        var pressures: [Double] = []
        for history in historical {
            pressures.append(Double(history.pressure ?? 0))
        }
        return pressures.reversed()
    }
    
    private func getIsRaining() -> [Double] {
        var rainHistory: [Double] = []
        for history in historical {
            rainHistory.append(Double(history.isRaining ?? 0))
        }
        return rainHistory.reversed()
    }
    
    private func getInsolation() -> [Double] {
        var insolation: [Double] = []
        for history in historical {
            insolation.append(Double(history.insolation ?? 0))
        }
        return insolation.reversed()
    }
}
