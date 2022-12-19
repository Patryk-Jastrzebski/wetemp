//
//  MapView.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 28/11/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State var lat: CGFloat
    @State var lon: CGFloat
    @State var region: MKCoordinateRegion
    
    init(lat: CGFloat, lon: CGFloat) {
        self.lat = lat
        self.lon = lon
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    }
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: getAnnotationPoint()) {
            MapMarker(coordinate: $0.coordinate, tint: .blue)
        }
        .frame(height: 300)
        .frame(maxWidth: .infinity)
    }
    
    private func getAnnotationPoint() -> [Place] {
        return [Place(name: "", coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))]
    }
}
