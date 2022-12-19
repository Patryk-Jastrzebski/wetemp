//
//  ChartView.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 09/11/2022.
//

import SwiftUI
import SwiftUICharts

struct ChartView: View {
    let historical: [Historical]
    var body: some View {
        VStack(spacing: 30) {
            LineView(data: getTemperature(), title: "Temperature", legend: "last 7 days in Celsius", style: Styles.barChartStyleNeonBlueLight)
                .frame(height: 350)
            
//            Description(title: "Summary of the day", description: "Temperatura odczuwalna w tej chwili to 8°, ale rzeczywista to 9°. Temperatura dziś wahała się pomiędzy 5° a 13°")
            LineView(data: getHumidity(), title: "Humidity", legend: "last 7 days %, (today: 98%)", style: Styles.barChartStyleOrangeLight)
                .frame(height: 350)
//            Description(title: "Summary of the week", description: "Wilgotność powietrza dziś to 98%. Dzisiejsze wahania to między 90% a 98%.")
            LineView(data: getPressure(), title: "Pressure", legend: "last 7 days %", style: Styles.barChartStyleOrangeLight)
                .frame(height: 350)
//            Description(title: "Summary of the week", description: "Dzisiejsze ciśnienie to 1004 hPa. Wahanie na przestrzeni tygodnia jest między 985 a 1014 hPa.")
        }
        .preferredColorScheme(.light)
        .padding()
    }
    
    private func getTemperature() -> [Double] {
        var temperatures: [Double] = []
        for history in historical {
            temperatures.append(Double(history.temperature ?? 0))
        }
        return temperatures
    }
    
    private func getHumidity() -> [Double] {
        var humidities: [Double] = []
        for history in historical {
            humidities.append(Double(history.humidity ?? 0))
        }
        return humidities
    }
    
    private func getPressure() -> [Double] {
        var pressures: [Double] = []
        for history in historical {
            pressures.append(Double(history.pressure ?? 0))
        }
        return pressures
    }
}
