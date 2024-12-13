//
//  WeatherView.swift
//  WeatherSearchApp
//
//  Created by SAKSHI BHARAMBE on 12/12/24.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    @State private var searchText = ""
    @ObservedObject var viewModel = WeatherViewModel()
    @State private var showSuggestions = false
    @State private var selectedCity: String?
    @State private var navigateToLasVegas = false
    @State private var navigateToKansas = false

    var body: some View {
        NavigationView {
            ZStack {
                Image("App_background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(5)
                    
                    Text("Fetching Weather Details...")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .medium))
                    

                } else {
                    VStack(alignment: .center, spacing: 20) {
                        // Search Bar
                        SearchBar(searchText: $searchText, showSuggestions: $showSuggestions, viewModel: viewModel, onSelectCity: { city in
                            if city == "Las Vegas" {
                                navigateToLasVegas = true
                            } else if city == "Bonner Springs" {
                                navigateToKansas = true
                            }
                        })
                                            
                                            // Navigation based on selected city
                        NavigationLink(
                                                destination: LasVegasDetails()
                                                    .navigationBarHidden(true),
                                                isActive: $navigateToLasVegas
                                            ) {
                                                EmptyView()
                                            }
                        
                        NavigationLink(
                            destination: BonnerKansasDetails()
                                                    .navigationBarHidden(true),
                                                isActive: $navigateToKansas
                                            ) {
                                                EmptyView()
                                            }
                        
                        

//                                if showSuggestions && !viewModel.suggestions.isEmpty {
//                                    SuggestionsList(suggestions: viewModel.suggestions) { suggestion in
//                                        searchText = suggestion
//                                        showSuggestions = false
//                                        viewModel.suggestions = []
//                                        viewModel.fetchWeather(for: suggestion)
//                                    }
//                                }
//                        HStack {
//                            
//                            
//                        }
//                        .zIndex(1)
//                        .padding()
//                        .background(Color.white)
//                        .shadow(color: .gray.opacity(0.3), radius: 5)
                        
                        // Existing Weather Content
                        if viewModel.isLoading {
                            ProgressView("Fetching Weather Data...")
                                .progressViewStyle(DefaultProgressViewStyle())
                        } else {
                            NavigationLink(destination: WeatherDetailsView()) {
                                HStack(alignment: .center, spacing: 20) {
                                    Image("Cloudy")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 140, height: 140)
                                        .foregroundColor(.white)
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("62°F")
                                            .font(.system(size: 40, weight: .bold))
                                            .foregroundColor(.black)
                                        
                                        Text("Cloudy")
                                            .font(.system(size: 24))
                                            .foregroundColor(.black)
                                        
                                        Text("Los Angeles")
                                            .font(.title)
                                            .bold()
                                            .foregroundColor(.black)
                                    }
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .background(Color.white.opacity(0.4))
                                .border(Color.white)
                                .cornerRadius(15)
                                .frame(maxWidth: .infinity, alignment: .center)
                                
                                Spacer()
                                
                                
                            }
                        }
                        
                        
                        HStack(alignment: .center, spacing: 8) {
                            WeatherInfoRow(label: "Humidity", value: "90%")
                            WeatherInfoRow(label: "Wind Speed", value: "11.00 mph")
                            WeatherInfoRow(label: "Visibility", value: "10.00 mi")
                            WeatherInfoRow(label: "Pressure", value: "29.92 inHg")
                        }
                        
                        Spacer()
                        
                        // Weather Table
                        WeatherTable()
                            .padding(.horizontal, 16)
                        
                        Spacer()
                    }

                }
                
            }
            .onAppear {
                viewModel.initialize()
                    }
        }
    }
}



struct WeatherInfoRow: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(label)
            Image(label)
            Text(value)
        }
    }
}

struct WeatherData: Identifiable {
    let id = UUID()
    let date: String
    let weatherIcon: String
    let sunriseIcon: String
    let sunsetIcon: String
}

struct WeatherTable: View {
    let data = [
        WeatherData(date: "12/12/2024", weatherIcon: "Partly Cloudy", sunriseIcon: "sun-rise", sunsetIcon: "sun-set"),
        WeatherData(date: "12/13/2024", weatherIcon: "Cloudy", sunriseIcon: "sun-rise", sunsetIcon: "sun-set"),
        WeatherData(date: "12/14/2024", weatherIcon: "Partly Cloudy", sunriseIcon: "sun-rise", sunsetIcon: "sun-set"),
        WeatherData(date: "12/15/2024", weatherIcon: "Partly Cloudy", sunriseIcon: "sun-rise", sunsetIcon: "sun-set"),
        WeatherData(date: "12/16/2024", weatherIcon: "Cloudy", sunriseIcon: "sun-rise", sunsetIcon: "sun-set"),
        WeatherData(date: "12/17/2024", weatherIcon: "Cloudy", sunriseIcon: "sun-rise", sunsetIcon: "sun-set")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
                    ForEach(data) { item in
                        HStack {
                            Text(item.date)
                                .font(.system(size: 16))
                                .frame(width: 100, alignment: .leading)
                                .padding(.horizontal, 5)

                            Image(item.weatherIcon)
                                .resizable()
                                .frame(width: 40, height: 40)
                                .padding(.horizontal, 5)

                            Image(item.sunriseIcon)
                                .resizable()
                                .frame(width: 40, height: 40)
                                .padding(.horizontal, 5)

                            Image(item.sunsetIcon)
                                .resizable()
                                .frame(width: 40, height: 40)
                                .padding(.horizontal, 5)
                        }
                    }
                }
        .frame(width: 300)
            .background(Color.white.opacity(0.5))
            .cornerRadius(8)
            .shadow(color: .gray.opacity(0.3), radius: 5)
        }
}

#Preview {
    WeatherView()
}
