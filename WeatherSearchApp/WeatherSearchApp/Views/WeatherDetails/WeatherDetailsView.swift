//
//  WeatherDetailsView.swift
//  WeatherSearchApp
//
//  Created by SAKSHI BHARAMBE on 12/10/24.
//

//import UIKit
//
//class WeatherDetailsView: UIViewController {
//    private let todayView = TodayDayView()
//    private let weeklyView = WeeklyTabView()
//    private let weatherDataView: WeatherDataTabView
//    private let weatherData: WeatherData
//    
//    init(weatherData: WeatherData) {
//        self.weatherData = weatherData
//        self.weatherDataView = WeatherDataTabView(weatherData: weatherData)
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        configureViews()
//    }
//    
//    private func setupUI() {
//        view.addSubview(todayView)
//        view.addSubview(weeklyView)
//        view.addSubview(weatherDataView)
//        
//        todayView.translatesAutoresizingMaskIntoConstraints = false
//        weeklyView.translatesAutoresizingMaskIntoConstraints = false
//        weatherDataView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            todayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            todayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            todayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            
//            weeklyView.topAnchor.constraint(equalTo: todayView.bottomAnchor),
//            weeklyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            weeklyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            
//            weatherDataView.topAnchor.constraint(equalTo: weeklyView.bottomAnchor),
//            weatherDataView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            weatherDataView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            weatherDataView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//    
//    private func configureViews() {
//        todayView.configure(with: weatherData)
//        weeklyView.configure(with: weatherData.dailyWeather)
//    }
//}































//class WeatherDetailsView: UIViewController {
//    private let segmentedControl: UISegmentedControl = {
//        let items = ["Today", "Weekly", "Weather Data"]
//        let sc = UISegmentedControl(items: items)
//        sc.selectedSegmentIndex = 0
//        return sc
//    }()
//    
//    private let todayView = TodayDayView()
//    private let weeklyView = WeeklyTabView()
//    private let weatherDataView: WeatherDataTabView
//    private var weatherData: WeatherData?
//    private var cityName: String = ""
//    
//    init(weatherData: WeatherData, cityName: String) {
//        self.weatherDataView = WeatherDataTabView(weatherData: weatherData)
//        super.init(nibName: nil, bundle: nil)
//        self.weatherData = weatherData
//        self.cityName = cityName
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        setupNavigationBar()
//    }
//    
//    private func setupUI() {
//        view.backgroundColor = .systemBackground
//        
//        // Add segmented control
//        view.addSubview(segmentedControl)
//        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
//            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
//        ])
//        
//        // Add container views
//        let views = [todayView, weeklyView, weatherDataView]
//        views.forEach { contentView in
//            view.addSubview(contentView)
//            contentView.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                contentView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
//                contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//            ])
//        }
//        
//        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
//        updateVisibleView()
//    }
//    
//    private func setupNavigationBar() {
//        navigationItem.title = cityName
//        
//        // Add Twitter button
//        let twitterButton = UIBarButtonItem(
//            image: UIImage(named: "twitter"),
//            style: .plain,
//            target: self,
//            action: #selector(twitterButtonTapped)
//        )
//        navigationItem.rightBarButtonItem = twitterButton
//    }
//    
//    @objc private func segmentChanged() {
//        updateVisibleView()
//    }
//    
//    private func updateVisibleView() {
//        todayView.isHidden = segmentedControl.selectedSegmentIndex != 0
//        weeklyView.isHidden = segmentedControl.selectedSegmentIndex != 1
//        weatherDataView.isHidden = segmentedControl.selectedSegmentIndex != 2
//    }
//    
//    @objc private func twitterButtonTapped() {
//        guard let weatherData = weatherData else { return }
//        
//        let tweetText = "Check out the weather in \(cityName): \(Int(weatherData.temperature))°F"
//        let encodedText = tweetText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//        let twitterURL = URL(string: "https://twitter.com/intent/tweet?text=\(encodedText)")!
//        
//        UIApplication.shared.open(twitterURL)
//    }
//    
//    func configure(with weatherData: WeatherData, cityName: String) {
//        self.weatherData = weatherData
//        self.cityName = cityName
//        
//        navigationItem.title = cityName
//        todayView.configure(with: weatherData)
//        weeklyView.configure(with: weatherData)
//        weatherDataView.configure(with: weatherData)
//    }
//}

import SwiftUI

struct WeatherDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedTab = 0
    let temperatureData: [(date: Date, temperature: Double)] = (0..<15).map { day in
        let date = Calendar.current.date(byAdding: .day, value: day, to: Date())!
        return (date: date, temperature: Double.random(in: 10...35))
    }



    // Hardcoded gauge chart values
    let currentPressure = 1012.0 // hPa
    let currentHumidity = 72.0 // %
    let currentPrecipitation = 12.0 // mm

//    let weatherData: WeatherResponse.WeatherData.WeatherValues?
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack {
                                    Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }) {
                                        Image(systemName: "chevron.left")
                                            .foregroundColor(.blue)
                                            .imageScale(.large)
                                        
                                        Text("Weather")
                                            .foregroundColor(.blue)
                                    }
                                    
                                    Spacer()
                                    
                                    Text("Los Angeles")
                                        .font(.title3)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        let twitterShareText = "The current temperature at Los Angeles, California is 62°F. The weather conditions are Cloudy #CSCI571WeatherSearch"
                                            
                                            // URL encode the text
                                            let encodedText = twitterShareText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                                            
                                            // Construct the Twitter web intent URL
                                            if let twitterURL = URL(string: "https://twitter.com/intent/tweet?text=\(encodedText)") {
                                                UIApplication.shared.open(twitterURL)
                                            }
                                    }) {
                                        Image("twitter-x")
                                            .foregroundColor(.blue)
                                            .imageScale(.large)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .background(Color.white)

                Spacer()
                
                
                if selectedTab == 0 {
                                    // Today Tab - Original multiple detail cards
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 30) {
                                            WeatherDetailCard(icon: "Wind Speed", label: "Wind Speed", value: "11.00 mph")
                                            WeatherDetailCard(icon: "Pressure", label: "Pressure", value: "29.92 inHg")
                                            WeatherDetailCard(icon: "Precipitation", label: "Precipitation", value: "0%")
                                            WeatherDetailCard(icon: "Temperature", label: "Temperature", value: "62°F")
                                            WeatherDetailCard(icon: "Cloudy", label: "Condition", value: "Cloudy")
                                            WeatherDetailCard(icon: "Humidity", label: "Humidity", value: "90%")
                                            WeatherDetailCard(icon: "Visibility", label: "Visibility", value: "10.00 mi")
                                            WeatherDetailCard(icon: "CloudCover", label: "Cloud Cover", value: "100%")
                                            WeatherDetailCard(icon: "UVIndex", label: "UV Index", value: "0")
                                        }
                                        .padding()
                    
                    Spacer()
                    
                                } else if selectedTab == 1 {
                                    // Weekly Tab - Single card with temperature
                                    VStack(spacing: 20) {
                                        WeatherDetailTempChartCard(icon: "Cloudy", label: "Cloudy", value: "80°F")
                                        
                                        
                                        
                                                TemperatureAreaChartView()
                                                    .frame(height: 300)
                                                    .padding()
                                    }
                                    Spacer()
                                    Spacer()
                                } else {
                                    // Weather Data Tab - Pressure, Humidity, Precipitation
                                    VStack(spacing: 10) {
                                        VStack(spacing: 10) {
                                            WeatherDetailGaugeChartCard(value1: "0%", value2: "90%", value3: "100%")
                                        }
                                        Text("Weather Data")
                                            .font(.system(size: 24))
                                            .padding()
                                                HStack(spacing: 20) {
                                                    GaugeChartView(
                                                                precipitation: 0.0, // 30%
                                                                humidity: 0.9,      // 80%
                                                                cloudCover: 1.0     // 60%
                                                            )


                                                }
                                                .padding()

                                    }
                                }
                
                
                
                
                HStack (alignment: .center, spacing: 0) {
                    TabBarButton(title: "Today", icon: "Today_Tab", selectedTab: $selectedTab, index: 0)
                        .frame(maxWidth: .infinity)
                    TabBarButton(title: "Weekly", icon: "Weekly_Tab", selectedTab: $selectedTab, index: 1)
                        .frame(maxWidth: .infinity)
                    TabBarButton(title: "Chart", icon: "Weather_Data_Tab", selectedTab: $selectedTab, index: 2)
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity, minHeight: 20, idealHeight: 40)
                .padding(.top, 10)
                .background(Color.white)
            }
            .background(Image("App_background").resizable().edgesIgnoringSafeArea(.all))
        }
        .navigationBarHidden(true)
    }
    
//    // Computed properties for formatting weather data
//        private var windSpeedString: String {
//            guard let wind = weatherData?.windSpeed else { return "N/A" }
//            return "\(String(format: "%.2f", wind)) mph"
//        }
//
//        private var pressureString: String {
//            guard let pressure = weatherData?.pressureSurfaceLevel else { return "N/A" }
//            return "\(String(format: "%.2f", pressure)) inHg"
//        }
//
//        private var precipitationString: String {
//            guard let precipitation = weatherData?.precipitationProbability else { return "N/A" }
//            return "\(Int(precipitation))%"
//        }
//
//        private var temperatureString: String {
//            guard let temp = weatherData?.temperature else { return "N/A" }
//            return "\(Int(temp))°F"
//        }
//
//        private var weatherCondition: String {
//            guard let code = weatherData?.weatherCode else { return "Unknown" }
//            switch code {
//            case 1000: return "Clear"
//            case 1001: return "Cloudy"
//            case 1100: return "Partly Cloudy"
//            default: return "Unknown"
//            }
//        }
//
//        private var humidityString: String {
//            guard let humidity = weatherData?.humidity else { return "N/A" }
//            return "\(Int(humidity))%"
//        }
//
//        private var visibilityString: String {
//            guard let visibility = weatherData?.visibility else { return "N/A" }
//            return "\(String(format: "%.2f", visibility)) mi"
//        }
//
//        private var cloudCoverString: String {
//            guard let cloudCover = weatherData?.cloudCover else { return "N/A" }
//            return "\(Int(cloudCover))%"
//        }
}

struct TabBarButton: View {
    var title: String
    var icon: String
    @Binding var selectedTab: Int
    var index: Int

    var body: some View {
        Button(action: {
            selectedTab = index
        }) {
            VStack {
                Image(icon)
                    .imageScale(.large)
                    .foregroundColor(selectedTab == index ? .blue : .gray)
                Text(title)
                    .foregroundColor(selectedTab == index ? .blue : .gray)
                    .font(.system(size: 12))
            }
            .padding()
        }
    }
}

struct WeatherDetailCard: View {
    let icon: String
    let label: String
    let value: String

    var body: some View {
        VStack(spacing: 10) {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.black)

            Text(value)
                .font(.system(size: 14))
                .foregroundColor(.black)

            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.black)
        }
        .frame(width: 120, height: 150)
        .background(Color.white.opacity(0.5))
        .border(Color.white)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.3), radius: 5)
    }
}

struct WeatherDetailTempChartCard: View {
    let icon: String
    let label: String
    let value: String

    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 140, height: 140)
                .foregroundColor(.white)
            
            VStack(alignment: .leading, spacing: 5) {
                
                Text(label)
                    .font(.system(size: 24))
                    .foregroundColor(.black)
                
                Text(value)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .background(Color.white.opacity(0.4))
        .border(Color.white)
        .cornerRadius(15)
        .frame(maxWidth: .infinity, alignment: .center)
      
    }
}

struct WeatherDetailGaugeChartCard: View {
    let value1: String
    let value2: String
    let value3: String

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            HStack {
                Image("Precipitation")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.black)

                Text("Precipitation: ")
                    .font(.system(size: 20))
                    .foregroundColor(.black)

                Text(value1)
                    .font(.system(size: 20))
                    .foregroundColor(.black)
            }
            HStack {
                Image("Humidity")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.black)

                Text("Humidity: ")
                    .font(.system(size: 20))
                    .foregroundColor(.black)

                Text(value2)
                    .font(.system(size: 20))
                    .foregroundColor(.black)
            }
            HStack {
                Image("CloudCover")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.black)

                Text("Cloud Cover: ")
                    .font(.system(size: 20))
                    .foregroundColor(.black)

                Text(value3)
                    .font(.system(size: 20))
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(Color.white.opacity(0.4))
        .border(Color.white)
        .cornerRadius(15)
        .frame(maxWidth: .infinity, alignment: .center)
      
    }
}
