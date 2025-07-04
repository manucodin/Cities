//
//  CityMapView.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

import SwiftUI
import MapKit

struct CityMapView: View {
    @Binding var selectedCity: CityRenderModel?
    @State private var showDetails: Bool = false
    @State private var cameraPosition: MapCameraPosition
    
    init(selectedCity: Binding<CityRenderModel?>) {
        _selectedCity = selectedCity
        _cameraPosition = State(initialValue: .region(.init(
            center: selectedCity.wrappedValue?.coordinates ?? .init(latitude: .zero, longitude: .zero),
            span: .init(latitudeDelta: 0.3, longitudeDelta: 0.3))
        ))
    }
    
    var body: some View {
        ZStack {
            mapView
            userLayerView
            if let selectedCity {
                FloatingOverlay(isPresented: showDetails) {
                    CityDetailView(isPresented: $showDetails, city: selectedCity)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selectedCity, { oldValue, newValue in
            if let newValue {
                cameraPosition = MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: newValue.coordinates,
                        span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
                )
            }
        })
    }
}

private extension CityMapView {
    @ViewBuilder
    var mapView: some View {
        Map(position: $cameraPosition) {
            if let selectedCity {
                Annotation(selectedCity.name, coordinate: selectedCity.coordinates) {
                    Button(action: {
                        showDetails.toggle()
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
        }
        .ignoresSafeArea(edges: .bottom)
    }
    
    @ViewBuilder
    var userLayerView: some View {
        VStack (alignment: .leading){
            Spacer()
            HStack {
                Spacer()
                locationButton
            }
        }.padding()
    }
    
    @ViewBuilder
    var locationButton: some View {
        Button {
            if let selectedCity {
                withAnimation {
                    cameraPosition = MapCameraPosition.region(
                        MKCoordinateRegion(
                            center: selectedCity.coordinates,
                            span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
                    )
                }
            }
        } label: {
            Image(systemName: "location.fill")
        }
        .frame(width: 15, height: 15)
        .disabled(selectedCity == nil)
        .roundButtonStyle()
    }
}

#Preview {
    CityMapView(selectedCity: .constant(.dummy))
}
