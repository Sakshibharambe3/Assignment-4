//
//  SearchBar.swift
//  WeatherSearchApp
//
//  Created by SAKSHI BHARAMBE on 12/12/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var showSuggestions: Bool
    @ObservedObject var viewModel: WeatherViewModel
    var onSelectCity: ((String) -> Void)?
    
    // Hardcoded suggestions
    let allSuggestions = ["Bonner Springs", "Bonsall", "Bonita", "Lake Wood", "Las Vegas", "La Mirada", "Los Angeles", "New York", "Chicago", "Houston"]

    var filteredSuggestions: [String] {
        allSuggestions.filter {
            $0.lowercased().contains(searchText.lowercased())
        }
    }

    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)

                    TextField("Enter a City Name", text: $searchText, onEditingChanged: { isEditing in
                        showSuggestions = isEditing && !searchText.isEmpty
                    })
                    .onChange(of: searchText) { _ in
                        showSuggestions = !searchText.isEmpty
                    }
                    .autocapitalization(.words)
                    .disableAutocorrection(true)

                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                            showSuggestions = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(20)
                .shadow(color: .gray.opacity(0.3), radius: 5)
            }
            .zIndex(1)
            .padding()
            .background(Color.white)
            .shadow(color: .gray.opacity(0.3), radius: 5)
            
            // Suggestions List
            if showSuggestions && !filteredSuggestions.isEmpty {
                            SuggestionsList(suggestions: filteredSuggestions) { suggestion in
                                searchText = suggestion
                                showSuggestions = false
                                onSelectCity?(suggestion)
                            }
                            .offset(y: 80) // Adjust this value to position the suggestions list exactly under the search bar
                                            
                        }
            

        }
    }
}
