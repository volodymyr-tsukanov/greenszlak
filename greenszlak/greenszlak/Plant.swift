//
//  Plant.swift
//  zielnik
//
//  Created by student on 07/05/2025.
//

//import SwiftUI

import Foundation
import MapKit
//TUTAJ ZMIENIONE dodane let description
struct Plant: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let imageName: String
    let description: String
}


