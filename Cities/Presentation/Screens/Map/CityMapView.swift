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
    @State private var cameraPosition: MapCameraPosition
    
    init(city: CityRenderModel, selectedCity: CityRenderModel? = nil) {
        self.city = city
        self.selectedCity = selectedCity
        _cameraPosition = State(initialValue: MapCameraPosition.region(
            MKCoordinateRegion(
                center: city.coordinates,
                span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
        ))
    }
    
    var body: some View {
        Map(position: $cameraPosition) {
            Annotation(city.name, coordinate: city.coordinates) {
                Button(action: {
                    selectedCity = city
                }) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title)
                        .foregroundStyle(.red)
                        .shadow(radius: 2)
                }
                .buttonStyle(.plain)
                .accessibilityIdentifier("city_map_button")
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    withAnimation {
                        cameraPosition = MapCameraPosition.region(
                            MKCoordinateRegion(
                                center: city.coordinates,
                                span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
                        )
                        selectedCity = city
                    }
                } label: {
                    Image(systemName: "location.fill")
                }
            }
        }
        .sheet(item: $selectedCity) { city in
            CityDetailView(city: city)
        }
    }
}

#Preview {
    CityMapView(city: .dummy)
}
