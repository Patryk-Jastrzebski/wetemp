//
//  MapView.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 28/11/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Binding var lat: CGFloat
    @Binding var lon: CGFloat
    
    @State var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 1, longitude: 1), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: getAnnotationPoint()) {
                MapMarker(coordinate: $0.coordinate, tint: .blue)
            }
            mapCenter
                .padding()
        }
        
        .task {
            setRegion()
        }
        .frame(height: 300)
        .frame(maxWidth: .infinity)
    }
    
    private func setRegion() {
        withAnimation {
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }
    }
    
    private func getAnnotationPoint() -> [Place] {
        return [Place(name: "", coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))]
    }
}

extension MapView {
    private var mapCenter: some View {
        Button {
            setRegion()
        } label: {
            Image(systemName: "mappin.square")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .semibold))
                .padding(5)
                .background(.blue)
                .cornerRadius(25)
        }
    }
}
