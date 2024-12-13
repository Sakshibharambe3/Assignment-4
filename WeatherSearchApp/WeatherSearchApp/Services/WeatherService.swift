//
//  WeatherService.swift
//  WeatherSearchApp
//
//  Created by SAKSHI BHARAMBE on 12/9/24.
//

//import Foundation
//import Alamofire
//import SwiftyJSON
//
//class WeatherService {
//    static let shared = WeatherService()
//
//    func fetchWeather(lat: Double, lon: Double, completion: @escaping (Weather?) -> Void) {
//        let url = "https://your-backend-url.com/weather?lat=\(lat)&lon=\(lon)"
//        AF.request(url).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                let weather = Weather(
//                    cityName: json["city"].stringValue,
//                    temperature: json["temp"].doubleValue,
//                    description: json["description"].stringValue,
//                    icon: json["icon"].stringValue,
//                    humidity: json["humidity"].intValue,
//                    windSpeed: json["wind_speed"].doubleValue,
//                    visibility: json["visibility"].doubleValue,
//                    pressure: json["pressure"].intValue
//                )
//                completion(weather)
//            case .failure:
//                completion(nil)
//            }
//        }
//    }
//}
//
//func fetchCoordinates(for city: String, completion: @escaping (Result<(Double, Double), Error>) -> Void) {
//        let url = "https://your-backend-url.com/gecode?address=\(city)"
//        let parameters: [String: Any] = [
//            "q": city,
//            "appid": "",
//            "limit": 1
//        ]
//
//        AF.request(url, parameters: parameters).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                if let firstResult = json.arrayValue.first {
//                    let lat = firstResult["lat"].doubleValue
//                    let lon = firstResult["lon"].doubleValue
//                    completion(.success((lat, lon)))
//                } else {
//                    completion(.failure(NSError(domain: "GeocodeError", code: 404, userInfo: [NSLocalizedDescriptionKey: "City not found."])))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//

//import Foundation
//import Alamofire
//import SwiftyJSON
//
//class WeatherService {
//    static let shared = WeatherService()
//    private let baseURL = "https://assignment3-backend-441722.wl.r.appspot.com/"
//    
//    func fetchWeatherForLocation(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherData, Error>) -> Void) {
//        let urlString = "\(baseURL)/weather?lat=\(latitude)&lon=\(longitude)"
//        performRequest(urlString: urlString, completion: completion)
//    }
//    
//    func fetchWeatherForCity(city: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
//        // First get coordinates from geocoding
//        let geocodeURL = "\(baseURL)/geocode?address=\(city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
//        
//        URLSession.shared.dataTask(with: URL(string: geocodeURL)!) { [weak self] data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let data = data else { return }
//            
//            do {
//                let geocodeResult = try JSONDecoder().decode(GeocodeResult.self, from: data)
//                // Now fetch weather with coordinates
//                self?.fetchWeatherForLocation(
//                    latitude: geocodeResult.latitude,
//                    longitude: geocodeResult.longitude,
//                    completion: completion
//                )
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
//    
//    private func performRequest(urlString: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
//        guard let url = URL(string: urlString) else { return }
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let data = data else { return }
//            
//            do {
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(WeatherResponse.self, from: data)
//                let weatherData = try WeatherData(from: response as! Decoder)
//                DispatchQueue.main.async {
//                    completion(.success(weatherData))
//                }
//            } catch {
//                print("Decoding error: \(error)")
//                completion(.failure(error))
//            }
//        }.resume()
//    }
//
//
//}

import Foundation

class WeatherService {
    static let shared = WeatherService()
    private init() {}
    
    private let baseURL = "https://assignment3-backend-441722.wl.r.appspot.com/"
    
    func fetchLocationCoordinates(
        for address: String,
        completion: @escaping (Result<LocationResponse, Error>) -> Void
    ) {
        guard let url = URL(string: "https://assignment3-backend-441722.wl.r.appspot.com/location?city=\(address.urlEncoded())") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        NetworkManager.shared.request(url: url, completion: completion)
    }
    
    func fetchWeather(
        lat: Double,
        lon: Double,
        completion: @escaping (Result<WeatherResponse, Error>) -> Void
    ) {
        guard let url = URL(string: "https://assignment3-backend-441722.wl.r.appspot.com/weather?lat=\(lat)&lng=\(lon)") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        NetworkManager.shared.request(url: url, completion: completion)
    }
}

extension String {
    func urlEncoded() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }
}
