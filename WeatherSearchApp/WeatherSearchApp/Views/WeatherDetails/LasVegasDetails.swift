//
//  LasVegasDetails.swift
//  WeatherSearchApp
//
//  Created by SAKSHI BHARAMBE on 12/12/24.
//

import SwiftUI
import CoreLocation
import MapKit
import UIKit

struct LasVegasDetails: View {
    @State private var searchText = ""
    @ObservedObject var viewModel = WeatherViewModel()
    @State private var searchResults: [MKLocalSearchCompletion] = []
    @StateObject private var searchCompleter = SearchCompleter()
    @Environment(\.presentationMode) var presentationMode
    @State private var isSaved = false
        @State private var showToast = false


    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                Image("App_background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                if viewModel.isLoading {
                    ZStack (alignment: .center) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(5)
                        
                        Text("Fetching Weather Details for Las Vegas...")
                                            .foregroundColor(.white)
                                            .font(.system(size: 16, weight: .medium))

                    }
                    
                } else {
                    VStack(alignment: .center, spacing: 20) {
                        // Search Bar
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
                                                let twitterShareText = "The current temperature at Las Vegas is 46°F. The weather conditions are Cloudy #CSCI571WeatherSearch"
                                                    
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
                        
                        HStack {
                                                Spacer()
                                                Button(action: {
                                                    withAnimation {
                                                        isSaved.toggle()
                                                        showToast = true
                                                        
                                                        // Automatically hide toast after 2 seconds
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                            showToast = false
                                                        }
                                                    }
                                                }) {
                                                    Image(isSaved ? "removeFav" : "addFav")
                                                        .imageScale(.small)
                                                                                                                .padding()
                                                        .foregroundColor(.gray)
                                                }
                                            }
                                            .padding(.horizontal)
                        
                        // Existing Weather Content
                        if viewModel.isLoading {
                            ProgressView("Fetching Weather Data...")
                                .progressViewStyle(DefaultProgressViewStyle())
                        } else {
                            NavigationLink(destination: LasVegasDetailsView()) {
                                HStack(alignment: .center, spacing: 20) {
                                    Image("Cloudy")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 140, height: 140)
                                        .foregroundColor(.white)
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("46°F")
                                            .font(.system(size: 40, weight: .bold))
                                            .foregroundColor(.black)
                                        
                                        Text("Cloudy")
                                            .font(.system(size: 24))
                                            .foregroundColor(.black)
                                        
                                        Text("Las Vegas")
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
                            WeatherInfoRow(label: "Humidity", value: "27%")
                            WeatherInfoRow(label: "Wind Speed", value: "2.0 mph")
                            WeatherInfoRow(label: "Visibility", value: "10.0 mi")
                            WeatherInfoRow(label: "Pressure", value: "29.9 inHg")
                        }
                        
                        Spacer()
                        
                        // Weather Table
                        WeatherTable()
                            .padding(.horizontal, 16)
                        
                        Spacer()
                    }
                    if showToast {
                                            VStack {
                                                Spacer()
                                                Text(isSaved ? "Las Vegas was Added to the Favorites List" : "Las Vegas was Removed from the Favorites List")
                                                    .foregroundColor(.white)
                                                    .padding()
                                                    .background(Color.black.opacity(0.7))
                                                    .cornerRadius(10)
                                                    .transition(.move(edge: .bottom))
                                                    .animation(.easeInOut)
                                                    .padding(.bottom)
                                            }
                                        }

                }
                
            }
            .onAppear {
                viewModel.initialize()
                    }
        }
    }
}