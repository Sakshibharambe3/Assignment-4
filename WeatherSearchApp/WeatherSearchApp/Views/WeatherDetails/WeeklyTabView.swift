//
//  WeeeklyTabView.swift
//  WeatherSearchApp
//
//  Created by SAKSHI BHARAMBE on 12/10/24.
//

import SwiftUI
import Charts
//
//struct WeeklyTabView: View {
//    let weeklyData: [DailyWeather]
//
//    var body: some View {
//        VStack {
//            Chart(weeklyData) { day in
//                LineMark(
//                    x: .value("Day", day.day),
//                    y: .value("Temperature", (day.minTemp + day.maxTemp) / 2)
//                )
//            }
//            .frame(height: 200)
//            .padding()
//        }
//    }
//}

//class WeeklyTabView: UIView {
//    private let summaryView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .systemBackground
//        view.layer.cornerRadius = 10
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOffset = CGSize(width: 0, height: 2)
//        view.layer.shadowRadius = 4
//        view.layer.shadowOpacity = 0.1
//        return view
//    }()
//    
//    private let weatherIcon: UIImageView = {
//        let iv = UIImageView()
//        iv.contentMode = .scaleAspectFit
//        return iv
//    }()
//    
//    private let temperatureLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 36, weight: .bold)
//        label.textAlignment = .center
//        return label
//    }()
//    
//    private let weatherTextLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 18)
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        return label
//    }()
//    
//    private var chartData: [(String, Double)] = []
//        
//    func configure(with forecast: [WeatherData.DailyWeather]) {
//            let dates = forecast.map { $0.date }
//            let temperatures = forecast.map { $0.temperatureMax }
//            chartData = Array(zip(dates, temperatures))
//        setupChart(with: forecast)
//        }
//
//    
//    private let chartView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .systemBackground
//        return view
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupViews()
//    }
//    
//    private func setupViews() {
//        // Setup Summary View
//        addSubview(summaryView)
//        summaryView.addSubview(weatherIcon)
//        summaryView.addSubview(temperatureLabel)
//        summaryView.addSubview(weatherTextLabel)
//        
//        // Setup Chart View
//        addSubview(chartView)
//        
//        setupConstraints()
//    }
//    
//    private func setupConstraints() {
//        [summaryView, weatherIcon, temperatureLabel, weatherTextLabel, chartView].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//        }
//        
//        NSLayoutConstraint.activate([
//            summaryView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
//            summaryView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            summaryView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            summaryView.heightAnchor.constraint(equalToConstant: 200),
//            
//            weatherIcon.centerXAnchor.constraint(equalTo: summaryView.centerXAnchor),
//            weatherIcon.topAnchor.constraint(equalTo: summaryView.topAnchor, constant: 20),
//            weatherIcon.heightAnchor.constraint(equalToConstant: 80),
//            weatherIcon.widthAnchor.constraint(equalToConstant: 80),
//            
//            temperatureLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 8),
//            temperatureLabel.centerXAnchor.constraint(equalTo: summaryView.centerXAnchor),
//            
//            weatherTextLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 8),
//            weatherTextLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 16),
//            weatherTextLabel.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -16),
//            
//            chartView.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 16),
//            chartView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            chartView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            chartView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
//    
//    func configure(with weatherData: WeatherData) {
//        // Configure weather icon based on weather code
//        weatherIcon.image = UIImage(named: "weather_\(weatherData.weatherCode)")
//        temperatureLabel.text = "\(Int(weatherData.temperature))°F"
//        weatherTextLabel.text = getWeatherText(for: weatherData.weatherCode)
//        
//        setupChart(with: weatherData.dailyWeather)
//    }
//    
//    private func setupChart(with forecast: [WeatherData.DailyWeather]) {
//        let chartOptions :[String : Any] = [
//            "chart" : ["type": "area"],
//            "title": ["text": "Temperature Trend (15 Days)"],
//            "xAxis": ["categories": forecast.map { $0.date }],
//            "yAxis": ["title": ["text": "Temperature (°F)"]],
//            "series": [
//                ["name": "Max Temperature",
//                 "data": forecast.map { $0.temperatureMax }],
//                ["name": "Min Temperature",
//                 "data": forecast.map { $0.temperatureMin }]
//            ]
//        ]
//        
//        // Initialize and configure Highcharts view here
//        // Note: Actual Highcharts implementation will depend on the specific version and setup
//    }
//    
//    private func getWeatherText(for code: Int) -> String {
//        // Implement weather code to text conversion
//        // Return appropriate weather description based on the code
//        return "Weather description"
//    }
//}
