////
////  ContentView.swift
////  WeatherSearchApp
////
////  Created by SAKSHI BHARAMBE on 12/9/24.
////
//
//import SwiftUI
//import SwiftData
//
//struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
//
//    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
//}

// import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        Text("Welcome to Weather Search App!")
//            .padding()
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

//class ContentView: UIView {
//    private let searchBarView = SearchBarView()
//    private let weatherOverview: UIView = {
//        let view = UIView()
//        view.backgroundColor = .systemBackground
//        return view
//    }()
//    
//    private let pageControl: UIPageControl = {
//        let pc = UIPageControl()
//        pc.currentPageIndicatorTintColor = .systemBlue
//        pc.pageIndicatorTintColor = .systemGray
//        return pc
//    }()
//    
//    private let scrollView: UIScrollView = {
//        let sv = UIScrollView()
//        sv.isPagingEnabled = true
//        sv.showsHorizontalScrollIndicator = false
//        return sv
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupViews()
//    }
//    
//    private func setupViews() {
//        backgroundColor = .systemBackground
//        
//        addSubview(searchBarView)
//        addSubview(scrollView)
//        addSubview(pageControl)
//        
//        setupConstraints()
//    }
//    
//    private func setupConstraints() {
//        [searchBarView, scrollView, pageControl].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//        }
//        
//        NSLayoutConstraint.activate([
//            searchBarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            searchBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            searchBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            searchBarView.heightAnchor.constraint(equalToConstant: 56),
//            
//            scrollView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: pageControl.topAnchor),
//            
//            pageControl.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
//            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
//            pageControl.heightAnchor.constraint(equalToConstant: 30)
//        ])
//    }
//}

//import SwiftUI
//import UIKit
//
//struct ContentView: View {
//    @StateObject private var viewModel = WeatherViewModel()
//    @State private var searchText = ""
//    @State private var searchResults: [String] = []
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                // Search bar with autocomplete
//                SearchBar(text: $searchText, suggestions: searchResults) { suggestion in
//                    viewModel.fetchWeather(for: suggestion)
//                }
//                .onChange(of: searchText) { newValue in
//                    // Implement autocomplete logic here
//                    if !newValue.isEmpty {
//                        searchResults = getCitySuggestions(for: newValue)
//                    } else {
//                        searchResults = []
//                    }
//                }
//                
//                ScrollView {
//                    // Current location weather
//                    if let currentWeather = viewModel.currentLocationWeather {
//                        WeatherOverviewView(weatherData: currentWeather)
//                    }
//                    
//                    // Searched city weather
//                    if let weatherData = viewModel.weatherData {
//                        NavigationLink(
//                            destination: WeatherDetailsViewRepresentable(weatherData: weatherData)
//                        ) {
//                            WeatherOverviewView(weatherData: weatherData)
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Weather Search")
//            .onAppear {
//                viewModel.requestLocationPermission()
//                viewModel.fetchCurrentLocationWeather()
//            }
//        }
//    }
//    
//    // Autocomplete function from Assignment 3
//    private func getCitySuggestions(for query: String) -> [String] {
//        // Implement your autocomplete logic here
//        // Return filtered city suggestions based on query
//        return [] // Replace with actual implementation
//    }
//}
//
//struct SearchBar: View {
//    @Binding var text: String
//    let suggestions: [String]
//    let onSuggestionTapped: (String) -> Void
//    
//    var body: some View {
//        VStack {
//            // Search TextField
//            HStack {
//                TextField("Search city", text: $text)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .autocapitalization(.none)
//                
//                if !text.isEmpty {
//                    Button(action: {
//                        text = ""
//                    }) {
//                        Image(systemName: "xmark.circle.fill")
//                            .foregroundColor(.gray)
//                    }
//                }
//            }
//            .padding()
//            
//            // Suggestions List
//            if !suggestions.isEmpty {
//                ScrollView {
//                    VStack(alignment: .leading, spacing: 8) {
//                        ForEach(suggestions, id: \.self) { suggestion in
//                            Button(action: {
//                                text = suggestion
//                                onSuggestionTapped(suggestion)
//                            }) {
//                                Text(suggestion)
//                                    .foregroundColor(.primary)
//                                    .padding(.horizontal)
//                                    .padding(.vertical, 4)
//                            }
//                            Divider()
//                        }
//                    }
//                }
//                .frame(maxHeight: 200)
//            }
//        }
//    }
//}
//
//
