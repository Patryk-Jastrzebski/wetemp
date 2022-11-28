//
//  ChartView.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 09/11/2022.
//

import SwiftUI
import SwiftUICharts

struct ChartView: View {
    var body: some View {
        VStack(spacing: 30) {
            LineView(data: [8,7,9,4,2,5,4], title: "Temperature", legend: "last 7 days in Celsius", style: Styles.barChartStyleNeonBlueLight)
                .frame(height: 350)
            Description(title: "Summary of the day", description: "Temperatura odczuwalna w tej chwili to 8°, ale rzeczywista to 9°. Temperatura dziś wahała się pomiędzy 5° a 13°")
            LineView(data: [87,88,100,95,100,100,92], title: "Humidity", legend: "last 7 days %, (today: 98%)", style: Styles.barChartStyleOrangeLight)
                .frame(height: 350)
            Description(title: "Summary of the week", description: "Wilgotność powietrza dziś to 98%. Dzisiejsze wahania to między 90% a 98%.")
            LineView(data: [1000,998,985,1015,1014,1012,1004], title: "Pressure", legend: "last 7 days %", style: Styles.barChartStyleOrangeLight)
                .frame(height: 350)
            Description(title: "Summary of the week", description: "Dzisiejsze ciśnienie to 1004 hPa. Wahanie na przestrzeni tygodnia jest między 985 a 1014 hPa.")
        }
        .preferredColorScheme(.light)
        .padding()
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}

