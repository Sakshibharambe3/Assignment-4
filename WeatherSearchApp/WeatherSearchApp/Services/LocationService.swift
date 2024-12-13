//
//  LocationService.swift
//  WeatherSearchApp
//
//  Created by SAKSHI BHARAMBE on 12/9/24.
//

//import Foundation
//import CoreLocation
//
//class LocationService: NSObject, CLLocationManagerDelegate {
//    private let manager = CLLocationManager()
//    private var completion: ((Double, Double) -> Void)?
//
//    func getCurrentLocation(completion: @escaping (Double, Double) -> Void) {
//        self.completion = completion
//        manager.delegate = self
//        manager.requestWhenInUseAuthorization()
//        manager.startUpdatingLocation()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            completion?(location.coordinate.latitude, location.coordinate.longitude)
//            manager.stopUpdatingLocation()
//        }
//    }
//}

//import CoreLocation
//
//class LocationService: NSObject, CLLocationManagerDelegate {
//    static let shared = LocationService()
//    private let locationManager = CLLocationManager()
//    
//    var locationUpdateHandler: ((CLLocation) -> Void)?
//    var authorizationHandler: ((Bool) -> Void)?
//    
//    override init() {
//        super.init()
//        setupLocationManager()
//    }
//    
//    private func setupLocationManager() {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    }
//    
//    func requestLocation() {
//        switch locationManager.authorizationStatus {
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        case .authorizedWhenInUse, .authorizedAlways:
//            locationManager.startUpdatingLocation()
//        default:
//            authorizationHandler?(false)
//        }
//    }
//    
//    // MARK: - CLLocationManagerDelegate
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        locationManager.stopUpdatingLocation()
//        locationUpdateHandler?(location)
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        switch status {
//        case .authorizedWhenInUse, .authorizedAlways:
//            locationManager.startUpdatingLocation()
//            authorizationHandler?(true)
//        default:
//            authorizationHandler?(false)
//        }
//    }
//}

//import CoreLocation
//
//class LocationService: NSObject, CLLocationManagerDelegate {
//    static let shared = LocationService()
//    private let locationManager = CLLocationManager()
//    
//    var locationUpdateHandler: ((CLLocation) -> Void)?
//    var authorizationHandler: ((CLAuthorizationStatus) -> Void)?
//    
//    override init() {
//        super.init()
//        setupLocationManager()
//    }
//    
//    private func setupLocationManager() {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    }
//    
//    func requestLocation() {
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation() // This will trigger didUpdateLocations or didFailWithError
//    }
//    
//    // MARK: - CLLocationManagerDelegate
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        locationUpdateHandler?(location)
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Location manager failed with error: \(error.localizedDescription)")
//        authorizationHandler?(.denied)
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        authorizationHandler?(status)
//        
//        switch status {
//        case .authorizedWhenInUse, .authorizedAlways:
//            locationManager.requestLocation()
//        default:
//            break
//        }
//    }
//}
import Foundation
import CoreLocation

class LocationService {
    static let shared = LocationService()
    private init() {}
    
    private let ipinfoBaseURL = "https://ipinfo.io"
    
    var locationUpdateHandler: ((CLLocationCoordinate2D) -> Void)?
    var authorizationHandler: ((CLAuthorizationStatus) -> Void)?
    
    func fetchLocation() {
        guard let url = URL(string: "\(ipinfoBaseURL)/json") else {
            authorizationHandler?(.denied)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Location fetch error: \(error.localizedDescription)")
                self.authorizationHandler?(.denied)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode),
                  let data = data else {
                print("Location fetch error: Invalid response")
                self.authorizationHandler?(.denied)
                return
            }
            
            do {
                let ipinfoResponse = try JSONDecoder().decode(IPInfoResponse.self, from: data)
                let coordinate = self.parseCoordinates(from: ipinfoResponse)
                DispatchQueue.main.async {
                    self.locationUpdateHandler?(coordinate)
                }
            } catch {
                print("Location fetch error: \(error.localizedDescription)")
                self.authorizationHandler?(.denied)
            }
        }.resume()
    }
    
    private func parseCoordinates(from response: IPInfoResponse) -> CLLocationCoordinate2D {
        let latitude = (response.loc?.components(separatedBy: ",").first).flatMap(Double.init) ?? 0.0
        let longitude = (response.loc?.components(separatedBy: ",").last).flatMap(Double.init) ?? 0.0
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct IPInfoResponse: Codable {
    let ip, city, region, country, loc, org, postal, timezone: String?
}
