//
//  TemperatureAreaChartView.swift
//  WeatherSearchApp
//
//  Created by SAKSHI BHARAMBE on 12/12/24.
//


import SwiftUI
import Charts

struct TemperatureAreaChartView: View {
    // Hardcoded data for Max and Min temperatures
    let maxTemperature: [Double] = [80, 82, 79, 85, 83, 84, 81]
    let minTemperature: [Double] = [75, 76, 74, 77, 76, 75, 74]

    var body: some View {
        VStack {
            // Chart title
            Text("Temperature Variation by Day")
                .font(.headline)
                .foregroundColor(.black)

            // Chart area
            GeometryReader { geometry in
                Chart {
                    // Plot Area between Max and Min Temperature with gradient fill
                    ForEach(maxTemperature.indices, id: \.self) { index in
                        AreaMark(
                            x: .value("Day", index),
                            yStart: .value("Min Temperature", minTemperature[index]),
                            yEnd: .value("Max Temperature", maxTemperature[index])
                        )
                        .foregroundStyle(
                            Gradient(colors: [Color.blue.opacity(0.4), Color.orange.opacity(0.4)])
                        ) // Gradient color for the area between max and min temperatures
                    }
                }
                .chartXAxis {
                    AxisMarks(position: .bottom) { value in
                        if let index = value.as(Int.self) {
                            AxisValueLabel("\(index + 1)")
                        }
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading) { value in
                        if let temp = value.as(Double.self) {
                            AxisValueLabel("\(temp, specifier: "%.0f")")
                        }
                    }
                }
                .chartYScale(domain: [70, 90]) // Adjusted for both max and min temperature
                .chartXScale(domain: [0, maxTemperature.count - 1])
                .frame(height: geometry.size.height * 0.8)
                .background(Color.white) // Chart background
                .cornerRadius(10)
            }
            .frame(height: 250)

            // Footer text aligned to the right
            HStack {
                Spacer()
                Text("Highcharts iOS")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white) // Entire chart container background
        .cornerRadius(12)
    }
}
