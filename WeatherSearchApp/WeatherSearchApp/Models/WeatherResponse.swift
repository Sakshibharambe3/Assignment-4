//
//  WeatherResponse.swift
//  WeatherSearchApp
//
//  Created by SAKSHI BHARAMBE on 12/12/24.
//


import Foundation

struct WeatherResponse: Codable {
    let data: WeatherData
    
    struct WeatherData: Codable {
        let timelines: [Timeline]
        let latitude: Double
        let longitude: Double
        
        struct Timeline: Codable {
            let intervals: [Interval]
        }
        
        struct Interval: Codable {
            let startTime: String
            let values: WeatherValues
        }
        
        struct WeatherValues: Codable {
            let cloudCover: Double
            let humidity: Double
            let precipitationProbability: Double
            let pressureSurfaceLevel: Double
            let sunriseTime: String
            let sunsetTime: String
            let temperature: Double
            let temperatureApparent: Double
            let temperatureMax: Double
            let temperatureMin: Double
            let visibility: Double
            let weatherCode: Int
            let windDirection: Double
            let windSpeed: Double
        }
    }
}
