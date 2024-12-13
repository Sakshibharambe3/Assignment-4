//
//  TodayDayView.swift
//  WeatherSearchApp
//
//  Created by SAKSHI BHARAMBE on 12/10/24.
//

//import SwiftUI
//
//struct TodayTabView: View {
//    let hourlyData: WeatherData.hourlyWeather
//
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack {
//                ForEach(hourlyData) { hour in
//                    VStack {
//                        Text(hour.time)
//                            .font(.caption)
//                            .foregroundColor(.gray)
//
//                        Image(systemName: hour.icon)
//                            .resizable()
//                            .frame(width: 50, height: 50)
//
//                        Text("\(Int(hour.temperature))°")
//                            .font(.subheadline)
//                            .fontWeight(.medium)
//                    }
//                    .frame(width: 80)
//                }
//            }
//            .padding()
//        }
//    }
//}

//import UIKit
//
//class TodayDayView: UIView {
//    private let collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumInteritemSpacing = 10
//        layout.minimumLineSpacing = 10
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.backgroundColor = .clear
//        cv.register(WeatherPropertyCell.self, forCellWithReuseIdentifier: "WeatherPropertyCell")
//        return cv
//    }()
//    
//    private var weatherData: WeatherData?
//    private let properties = [
//        ("humidity", "Humidity", "%"),
//        ("windSpeed", "Wind Speed", "mph"),
//        ("visibility", "Visibility", "mi"),
//        ("pressureSeaLevel", "Pressure", "inHg"),
//        ("precipitationProbability", "Precipitation", "%"),
//        ("cloudCover", "Cloud Cover", "%"),
//        ("temperature", "Temperature", "°F"),
//        ("sunriseTime", "Sunrise", ""),
//        ("sunsetTime", "Sunset", "")
//    ]
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupView()
//    }
//    
//    private func setupView() {
//        addSubview(collectionView)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: topAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//        
//        collectionView.delegate = self
//        collectionView.dataSource = self
//    }
//    
//    func configure(with weatherData: WeatherData) {
//        self.weatherData = weatherData
//        collectionView.reloadData()
//    }
//}
//
//extension TodayDayView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return properties.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherPropertyCell", for: indexPath) as! WeatherPropertyCell
//        
//        let property = properties[indexPath.item]
//        let value = getValue(for: property.0)
//        cell.configure(
//            icon: UIImage(named: property.0) ?? UIImage(),
//            title: property.1,
//            value: "\(value)\(property.2)"
//        )
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (collectionView.frame.width - 20) / 3
//        return CGSize(width: width, height: width)
//    }
//    
//    private func getValue(for property: String) -> String {
//        guard let weatherData = weatherData else { return "N/A" }
//        
//        switch property {
//        case "humidity":
//            return String(format: "%.0f", weatherData.humidity)
//        case "windSpeed":
//            return String(format: "%.1f", weatherData.windSpeed)
//        case "visibility":
//            return String(format: "%.1f", weatherData.visibility)
//        case "pressureSeaLevel":
//            return String(format: "%.1f", weatherData.pressureSurfaceLevel)
//        case "precipitationProbability":
//            return String(format: "%.0f", weatherData.precipitationProbability)
//        case "cloudCover":
//            return String(format: "%.0f", weatherData.cloudCover)
//        case "temperature":
//            return String(format: "%.0f", weatherData.temperature)
//        case "sunriseTime":
//            return formatTime(weatherData.sunriseTime)
//        case "sunsetTime":
//            return formatTime(weatherData.sunsetTime)
//        default:
//            return "N/A"
//        }
//    }
//    
//    private func formatTime(_ timeString: String) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        guard let date = dateFormatter.date(from: timeString) else { return timeString }
//        
//        dateFormatter.dateFormat = "h:mm a"
//        dateFormatter.timeZone = TimeZone(identifier: "America/Los_Angeles")
//        return dateFormatter.string(from: date)
//    }
//}
//
//class WeatherPropertyCell: UICollectionViewCell {
//    private let iconImageView: UIImageView = {
//        let iv = UIImageView()
//        iv.contentMode = .scaleAspectFit
//        return iv
//    }()
//    
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.font = .systemFont(ofSize: 14)
//        return label
//    }()
//    
//    private let valueLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.font = .systemFont(ofSize: 16, weight: .bold)
//        return label
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupView()
//    }
//    
//    private func setupView() {
//        backgroundColor = .systemBackground
//        layer.cornerRadius = 10
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOffset = CGSize(width: 0, height: 2)
//        layer.shadowRadius = 4
//        layer.shadowOpacity = 0.1
//        
//        let stackView = UIStackView(arrangedSubviews: [iconImageView, titleLabel, valueLabel])
//        stackView.axis = .vertical
//        stackView.spacing = 8
//        stackView.alignment = .center
//        
//        addSubview(stackView)
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
//            iconImageView.heightAnchor.constraint(equalToConstant: 30),
//            iconImageView.widthAnchor.constraint(equalToConstant: 30)
//        ])
//    }
//    
//    func configure(icon: UIImage, title: String, value: String) {
//        iconImageView.image = icon
//        titleLabel.text = title
//        valueLabel.text = value
//    }
//}
