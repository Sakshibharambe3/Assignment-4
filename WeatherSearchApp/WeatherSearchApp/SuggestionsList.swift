//
//  SuggestionsList.swift
//  WeatherSearchApp
//
//  Created by SAKSHI BHARAMBE on 12/12/24.
//



import SwiftUI

struct SuggestionsList: View {
    let suggestions: [String]
    let onSelect: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(suggestions, id: \.self) { suggestion in
                Button(action: {
                    onSelect(suggestion)
                }) {
                    HStack {
                        Image(systemName: "location")
                        Text(suggestion)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white.opacity(0.4))
                    .cornerRadius(5)
                }
                .buttonStyle(PlainButtonStyle())
                
                Divider()
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.3), radius: 5)
    }
}
