//
//  WeatherViewModel.swift
//  WeatherSearchApp
//
//  Created by SAKSHI BHARAMBE on 12/9/24.
//

//import Foundation
//import Combine
//import CoreLocation
//
//class WeatherViewModel: ObservableObject {
//    @Published var weather: Weather?
//    @Published var isLoading: Bool = false
//
//    private var cancellables = Set<AnyCancellable>()
//
////    func fetchSearchResults(for cityName: String) {
////        isLoading = true
////        WeatherService.shared.fetchWeather(for: cityName)
////            .receive(on: DispatchQueue.main)
////            .sink { completion in
////                self.isLoading = false
////                if case .failure(let error) = completion {
////                    print("Error fetching weather: \(error)")
////                }
////            } receiveValue: { weather in
////                self.weather = weather
////            }
////            .store(in: &cancellables)
////    }
//    
//    func fetchWeather(for city: String) {
//          isLoading = true
//          WeatherService.shared.fetchCoordinates(for: city) { [weak self] result in
//              switch result {
//              case .success(let (lat, lon)):
//                  self?.fetchCurrentLocationWeather(lat: lat, lon: lon)
//              case .failure(let error):
//                  DispatchQueue.main.async {
//                      self?.isLoading = false
//                      print("Error fetching coordinates: \(error.localizedDescription)")
//                  }
//              }
//          }
//      }
//
//    func fetchCurrentLocationWeather(lat: Double, lon: Double) {
//            isLoading = true
//            WeatherService.shared.fetchWeather(lat: lat, lon: lon) { [weak self] result in
//                DispatchQueue.main.async {
//                    self?.isLoading = false
//                    switch result {
//                    case .success(let weather):
//                        self?.weather = weather
//                    case .failure(let error):
//                        print("Error fetching current location weather: \(error.localizedDescription)")
//                    }
//                }
//            }
//        }
//}

//import CoreLocation
//import SwiftUI
//
//class WeatherViewModel: NSObject, ObservableObject {
//    @Published var weatherData: WeatherData?
//    @Published var currentLocationWeather: WeatherData?
//    private let locationManager = CLLocationManager()
//    
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//
//    }
//    
//    func requestLocationPermission() {
//        locationManager.requestWhenInUseAuthorization()
//    }
//    
//    func fetchCurrentLocationWeather() {
//        locationManager.requestLocation()
//    }
//    
//    func fetchWeather(for city: String) {
//        guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
//        let urlString = "https://assignment3-backend-441722.wl.r.appspot.com/geocode?address=\(encodedCity)"
//        
//        guard let url = URL(string: urlString) else { return }
//        
//        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//            if let error = error {
//                print("Error fetching weather: \(error)")
//                return
//            }
//            
//            guard let data = data else { return }
//            
//            do {
//                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
//                DispatchQueue.main.async {
//                    self?.weatherData = weatherData
//                }
//            } catch {
//                print("Error decoding weather data: \(error)")
//            }
//        }.resume()
//    }
//    
//    private func fetchWeatherForLocation(latitude: Double, longitude: Double) {
//        let urlString = "https://assignment3-backend-441722.wl.r.appspot.com/weather?lat=\(latitude)&lon=\(longitude)"
//        
//        guard let url = URL(string: urlString) else { return }
//        
//        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//            if let error = error {
//                print("Error fetching weather: \(error)")
//                return
//            }
//            
//            guard let data = data else { return }
//            
//            do {
//                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
//                DispatchQueue.main.async {
//                    self?.currentLocationWeather = weatherData
//                }
//            } catch {
//                print("Error decoding weather data: \(error)")
//            }
//        }.resume()
//    }
//}
//
//extension WeatherViewModel: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.first else { return }
//        fetchWeatherForLocation(latitude: location.coordinate.latitude,
//                              longitude: location.coordinate.longitude)
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Location error: \(error)")
//    }
//    
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        switch manager.authorizationStatus {
//        case .authorizedWhenInUse, .authorizedAlways:
//            fetchCurrentLocationWeather()
//        case .denied, .restricted:
//            print("Location access denied")
//        case .notDetermined:
//            requestLocationPermission()
//        @unknown default:
//            break
//        }
//    }
//}


import SwiftUI
import CoreLocation
import MapKit
import Foundation
import Combine
//
//class WeatherViewModel: ObservableObject {
//    @Published var weatherData: WeatherResponse.WeatherData.WeatherValues?
//    @Published var isLoading = false
//    @Published var error: Error?
//    @Published var locationStatus: CLAuthorizationStatus = .notDetermined
//    @Published var showWeatherView = true
//    
//    init() {
//            setupLocationTracking()
//        }
//        
//    private func setupLocationTracking() {
//            LocationService.shared.locationUpdateHandler = { [weak self] coordinate in
//                self?.fetchWeatherForLocation(
//                    lat: coordinate.latitude,
//                    lon: coordinate.longitude
//                                    )
//            }
//
//            LocationService.shared.authorizationHandler = { [weak self] status in
//                self?.locationStatus = status
//            }
//
//            LocationService.shared.fetchLocation()
//        }
//
//        func fetchWeather(for cityName: String) {
//            isLoading = true
//            WeatherService.shared.fetchLocationCoordinates(for: cityName) { [weak self] result in
//                switch result {
//                case .success(let locationResponse):
//                    self?.fetchWeatherForLocation(
//                        lat: locationResponse.lat,
//                        lon: locationResponse.lng
//                    )
//                case .failure(let error):
//                    self?.handleError(error)
//                }
//            }
//        }
//
//        private func fetchWeatherForLocation(lat: Double, lon: Double) {
//            WeatherService.shared.fetchWeather(lat: lat, lon: lon) { [weak self] result in
//                DispatchQueue.main.async {
//                    self?.isLoading = false
//                    switch result {
//                    case .success(let weatherResponse):
//                        self?.weatherData = weatherResponse.data.timelines.first?.intervals.first?.values
//                    case .failure(let error):
//                        self?.handleError(error)
//                    }
//                }
//            }
//        }
//
//        private func handleError(_ error: Error) {
//            self.error = error
//            print("Weather fetch error: \(error.localizedDescription)")
//            isLoading = false
//        }
//    
//    // Convenience methods for view formatting
//    var temperatureString: String {
//        guard let temp = weatherData?.temperature else { return "N/A" }
//        return "\(Int(temp))°F"
//    }
//    
//    var weatherCondition: String {
//        guard let code = weatherData?.weatherCode else { return "Unknown" }
//        switch code {
//        case 1000: return "Clear"
//        case 1001: return "Cloudy"
//        case 1100: return "Partly Cloudy"
//        default: return "Unknown"
//        }
//    }
//    
//    var weatherIcon: String {
//        guard let code = weatherData?.weatherCode else { return "Cloudy" }
//        switch code {
//        case 1000: return "Sunny"
//        case 1001: return "Cloudy"
//        case 1100: return "Partly Cloudy"
//        default: return "Cloudy"
//        }
//    }
//    
//    public func initialize() {
//        // Simulate some delay to show the launch screen
//        DispatchQueue.main.async {
//                self.showWeatherView = true
//            }
//    }
//    // Add more computed properties for other weather details
//}

//public class WeatherViewModel: ObservableObject {
//    @Published var showWeatherView = true
//    @Published var isLoading = true
//    @Published var suggestions: [String] = []
//        private var cancellable: AnyCancellable?
//    private let apiKey = "AIzaSyCKyqcq4fpx5KCNTYVbMTc9LMpdmmh-WYg"
//
//    func fetchSuggestions(for query: String) {
//            guard !query.isEmpty else {
//                suggestions = []
//                return
//            }
//
//            let baseURL = "https://maps.googleapis.com/maps/api/place/autocomplete/json"
//            let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//            let urlString = "\(baseURL)?input=\(query)&key=\(apiKey)"
//            
//            guard let url = URL(string: urlString) else {
//                print("Invalid URL")
//                return
//            }
//
//            cancellable = URLSession.shared.dataTaskPublisher(for: url)
//                .map { $0.data }
//                .decode(type: GooglePlacesResponse.self, decoder: JSONDecoder())
//                .map { response in
//                    response.predictions.map { $0.description }
//                }
//                .replaceError(with: [])
//                .receive(on: DispatchQueue.main)
//                .sink { [weak self] places in
//                    self?.suggestions = places
//                }
//        }
//
//    public init() {
//        // Intentionally left empty
//    }
//
//    public func initialize() {
//        // Simulate some delay to show the launch screen
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                self.showWeatherView = true
//            self.isLoading = false
//            }
//    }
//}
//
//struct GooglePlacesResponse: Decodable {
//    let predictions: [PlacePrediction]
//}
//
//struct PlacePrediction: Decodable {
//    let description: String
//}

public class WeatherViewModel: ObservableObject {
    @Published var showWeatherView = true
    @Published var isLoading = true
    @Published var suggestions: [String] = []
    private var cancellable: AnyCancellable?
    
    private var cancellables = Set<AnyCancellable>()
    private let apiKey = "AIzaSyCKyqcq4fpx5KCNTYVbMTc9LMpdmmh-WYg"
    
    public init() {}
    
    func fetchSuggestions(for query: String) {
        // Debounce the search to avoid too many API calls
        cancellable?.cancel()
                
                // Clear suggestions if query is too short
                guard query.count >= 3 else {
                    suggestions = []
                    return
                }

                let baseURL = "https://maps.googleapis.com/maps/api/place/autocomplete/json"
                guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                      let url = URL(string: "\(baseURL)?input=\(encodedQuery)&types=(cities)&key=\(apiKey)") else {
                    print("Invalid URL")
                    return
                }

                // Use URLSession directly for more straightforward debugging
                cancellable = URLSession.shared.dataTaskPublisher(for: url)
                    .map { $0.data }
                    .tryMap { data -> [String] in
                        // Print raw response for debugging
                        if let jsonString = String(data: data, encoding: .utf8) {
                            print("Raw JSON Response: \(jsonString)")
                        }
                        
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(GooglePlacesResponse.self, from: data)
                        return response.predictions.map { $0.description }
                    }
                    .replaceError(with: [])
                    .receive(on: DispatchQueue.main)
                    .sink(receiveValue: { [weak self] places in
                        print("Fetched Suggestions: \(places)")
                        self?.suggestions = places
                    })
    }
    
    private func performAutocompleteSuggestions(for query: String) {
        guard !query.isEmpty else { return }
        
        let baseURL = "https://maps.googleapis.com/maps/api/place/autocomplete/json"
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)?input=\(encodedQuery)&types=(cities)&key=\(apiKey)") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: GooglePlacesResponse.self, decoder: JSONDecoder())
            .map { response in
                response.predictions.map { $0.description }
            }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] places in
                self?.suggestions = places
            }
            .store(in: &cancellables)
    }
    
    
    
    public func initialize() {
        // Simulate some delay to show the launch screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showWeatherView = true
            self.isLoading = false
        }
    }
}

struct GooglePlacesResponse: Decodable {
    let predictions: [PlacePrediction]
}

struct PlacePrediction: Decodable {
    let description: String
}
