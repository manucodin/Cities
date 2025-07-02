//
//  CityMapView.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

import SwiftUI
import MapKit

struct CityMapView: View {
    let city: CityRenderModel
    
    @State private var selectedCity: CityRenderModel?
    
    var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: city.coordinates.latitude, longitude: city.coordinates.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
        )
    }
    
    var body: some View {
        Map(coordinateRegion: .constant(region), annotationItems: [AnnotationItem(coordinate: region.center)]) { item in
            MapAnnotation(coordinate: city.coordinates) {
                Button(action: {
                    selectedCity = city
                }) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title)
                        .foregroundStyle(.red)
                        .shadow(radius: 2)
                }
                .buttonStyle(.plain)
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $selectedCity) { city in
            CityDetailView(city: city)
        }
    }
    
    struct AnnotationItem: Identifiable {
        let id = UUID()
        let coordinate: CLLocationCoordinate2D
    }
}


#Preview {
    CityMapView(city: .dummy)
}
