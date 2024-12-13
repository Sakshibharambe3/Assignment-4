//
//  LasVegasDetailsView.swift
//  WeatherSearchApp
//
//  Created by SAKSHI BHARAMBE on 12/12/24.
//

import SwiftUI

struct LasVegasDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedTab = 0
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
                                    
                                    Text("Las Vegas")
                                        .font(.title3)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        // Handle Twitter share action
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
                                            WeatherDetailCard(icon: "Pressure", label: "Pressure", value: "27.94 inHg")
                                            WeatherDetailCard(icon: "Precipitation", label: "Precipitation", value: "0%")
                                            WeatherDetailCard(icon: "Temperature", label: "Temperature", value: "46°F")
                                            WeatherDetailCard(icon: "Cloudy", label: "Condition", value: "Cloudy")
                                            WeatherDetailCard(icon: "Humidity", label: "Humidity", value: "57%")
                                            WeatherDetailCard(icon: "Visibility", label: "Visibility", value: "10.00 mi")
                                            WeatherDetailCard(icon: "CloudCover", label: "Cloud Cover", value: "100%")
                                            WeatherDetailCard(icon: "UVIndex", label: "UV Index", value: "0")
                                        }
                                        .padding()
                                } else if selectedTab == 1 {
                                    // Weekly Tab - Single card with temperature
                                    VStack(spacing: 20) {
                                        WeatherDetailTempChartCard(icon: "Cloudy", label: "Cloudy", value: "46°F")
                                        
                                        Text("Temperature Chart")
                                            .font(.headline)
                                            .foregroundColor(.black)
                                    }
                                } else {
                                    // Weather Data Tab - Pressure, Humidity, Precipitation
                                    VStack(spacing: 20) {
                                        VStack(spacing: 10) {
                                            WeatherDetailGaugeChartCard(value1: "0%", value2: "57%:", value3: "100%")
                                            
                                        }
                                        
                                        Text("Gauge Chart")
                                            .font(.headline)
                                            .foregroundColor(.black)
                                    }
                                }
                
                
                Spacer()
                
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
}
