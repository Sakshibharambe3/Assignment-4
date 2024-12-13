//
//  LaunchScreen.swift
//  WeatherSearchApp
//
//  Created by SAKSHI BHARAMBE on 12/10/24.
//

import SwiftUI
import SwiftData

struct LaunchScreenView: View {
    @State private var isAnimating = false
    @State private var isLaunchScreenVisible = true
    @State private var isLoading = false
    @StateObject private var weatherViewModel = WeatherViewModel()

    var body: some View {
        ZStack {
            // Background Image
            Image("App_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()

                // Center Icon
                Image("Mostly Clear")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)

                Spacer()

                // Credit Text
                Image("Powered_by_Tomorrow-Black")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            }
        }
        .onAppear {
            isAnimating = true

            // Dispatch the view model initialization on the main queue
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            isLaunchScreenVisible = false
                            isLoading = true

                            // Simulate data loading, then transition to WeatherView
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                isLoading = false
                                weatherViewModel.showWeatherView = true
                            }
                        }

                        // Initialize the view model
                        weatherViewModel.initialize()
        }
        .fullScreenCover(isPresented: $weatherViewModel.showWeatherView) {
            WeatherView()
        }
    }
}
