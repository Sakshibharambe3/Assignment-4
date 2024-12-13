//
//  SearchCompleter.swift
//  WeatherSearchApp
//
//  Created by SAKSHI BHARAMBE on 12/12/24.
//

import MapKit

class SearchCompleter: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    private var completer = MKLocalSearchCompleter()
    @Published var searchResults: [MKLocalSearchCompletion] = []
    
    override init() {
        super.init()
        completer.delegate = self
        completer.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 10.0, longitudeDelta: 10.0)
        )
    }
    
    var queryFragment: String {
        get { completer.queryFragment }
        set { completer.queryFragment = newValue }
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async {
            self.searchResults = completer.results
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}
