//
//  GaugeChartView.swift
//  WeatherSearchApp
//
//  Created by SAKSHI BHARAMBE on 12/12/24.
//


import SwiftUI

struct GaugeChartView: View {
    var precipitation: Double // Value between 0 to 1
    var humidity: Double      // Value between 0 to 1
    var cloudCover: Double    // Value between 0 to 1
    
    var body: some View {
        VStack {
            // Heading
            
            
            // Gauge Chart
            ZStack {
//                Text("Weather Data")
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .foregroundColor(.black)
//                    .padding(.top, 10)
//                    .zIndex(1)
                // White Square Background
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 450, height: 300)
                    .shadow(radius: 10)
                
                
                
                // Cloud Cover Ring
                Circle()
                    .stroke(
                        Color.green.opacity(0.5),
                        lineWidth: 40
                    )
                    .overlay(
                        Circle()
                            .trim(from: 0, to: cloudCover)
                            .stroke(
                                Color.green,
                                style: StrokeStyle(lineWidth: 40, lineCap: .round)
                            )
                            .rotationEffect(.degrees(-90))
                    )
                    .padding(20)
                
                // Humidity Ring
                Circle()
                    .stroke(
                        Color.blue.opacity(0.3),
                        lineWidth: 30
                    )
                    .overlay(
                        Circle()
                            .trim(from: 0, to: humidity)
                            .stroke(
                                Color.blue,
                                style: StrokeStyle(lineWidth: 30, lineCap: .round)
                            )
                            .rotationEffect(.degrees(-90))
                    )
                    .padding(40)
                
                // Precipitation Ring
                Circle()
                    .stroke(
                        Color.red.opacity(0.3),
                        lineWidth: 20
                    )
                    .overlay(
                        Circle()
                            .trim(from: 0, to: precipitation)
                            .stroke(
                                Color.red,
                                style: StrokeStyle(lineWidth: 20, lineCap: .round)
                            )
                            .rotationEffect(.degrees(-90))
                    )
                    .padding(60)
            }
            .frame(width: 250, height: 250)
            
            // Highcharts iOS Text at the bottom-right
            HStack {
                Spacer()
                Text("Highcharts iOS")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                    .padding(.trailing, 10)
            }
        }
        .padding()
    }
}

struct GaugeChartView_Previews: PreviewProvider {
    static var previews: some View {
        GaugeChartView(precipitation: 0.4, humidity: 0.7, cloudCover: 0.5)
            .frame(width: 250, height: 350)
    }
}
