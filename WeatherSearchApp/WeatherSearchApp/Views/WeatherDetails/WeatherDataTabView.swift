//
//  WeatherDataTabView.swift
//  WeatherSearchApp
//
//  Created by SAKSHI BHARAMBE on 12/10/24.
//

//import SwiftUI
//
//class WeatherDataTabView: UIView {
//    private let weatherData: WeatherData
//    
//    private let summaryView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .systemBackground
//        return view
//    }()
//    
//    private let chartView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .systemBackground
//        return view
//    }()
//    
//    init(weatherData: WeatherData) {
//        self.weatherData = weatherData
//        super.init(frame: .zero)
//        setupViews()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupViews() {
//        addSubview(summaryView)
//        addSubview(chartView)
//        
//        // Setup constraints and configure views
//        setupSummaryView()
//        setupChartView()
//    }
//    
//    private func setupSummaryView() {
//        // Configure summary view with precipitation, humidity, and cloud cover
//        let weather: WeatherData
//
//        var body: some View {
//            VStack {
//                PropertyItem(title: "Humidity", value: "\(weather.humidity)%")
//                PropertyItem(title: "Pressure", value: "\(weather.pressureSurfaceLevel) hPa")
//                PropertyItem(title: "Visibility", value: "\(weather.visibility) km")
//                PropertyItem(title: "Wind Speed", value: "\(weather.windSpeed) m/s")
//            }
//            .padding()
//        }
//    }
//    
//    private func setupChartView() {
//        // Configure Highcharts gauge chart
//    }
//}
//
//
