//
//  Place.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 02/01/2023.
//

import MapKit

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
