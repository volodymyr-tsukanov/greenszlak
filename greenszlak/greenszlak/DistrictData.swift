//
//  DistrictData.swift
//  zielnik
//
//  Created by student on 07/05/2025.
//

import SwiftUI

import Foundation
import MapKit

struct District: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let center: CLLocationCoordinate2D
    let plants: [Plant]

    static func == (lhs: District, rhs: District) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

let districts: [District] = [
    District(name: "Śródmieście",
             center: CLLocationCoordinate2D(latitude: 51.2485, longitude: 22.5655),
             plants: [
                Plant(name: "Klon", coordinate: CLLocationCoordinate2D(latitude: 51.2485, longitude: 22.5650), imageName: "klon"),
                Plant(name: "Jesion", coordinate: CLLocationCoordinate2D(latitude: 51.2490, longitude: 22.5660), imageName: "jesion")
             ]),
    District(name: "Sławinek",
             center: CLLocationCoordinate2D(latitude: 51.2645, longitude: 22.5350),
             plants: [
                Plant(name: "Lipa", coordinate: CLLocationCoordinate2D(latitude: 51.2647, longitude: 22.5355), imageName: "lipa"),
                Plant(name: "Wiśnia", coordinate: CLLocationCoordinate2D(latitude: 51.2635, longitude: 22.5340), imageName: "wisnia")
             ]),
    District(name: "Czechów",
             center: CLLocationCoordinate2D(latitude: 51.2700, longitude: 22.5600),
             plants: [
                Plant(name: "Sosna", coordinate: CLLocationCoordinate2D(latitude: 51.2710, longitude: 22.5610), imageName: "sosna"),
                Plant(name: "Dąb", coordinate: CLLocationCoordinate2D(latitude: 51.2690, longitude: 22.5590), imageName: "dab")
             ]),
    District(name: "Wieniawa",
             center: CLLocationCoordinate2D(latitude: 51.2470, longitude: 22.5550),
             plants: [
                Plant(name: "Grab", coordinate: CLLocationCoordinate2D(latitude: 51.2475, longitude: 22.5555), imageName: "grab"),
                Plant(name: "Buk", coordinate: CLLocationCoordinate2D(latitude: 51.2465, longitude: 22.5540), imageName: "buk")
             ]),
    District(name: "Rury",
             center: CLLocationCoordinate2D(latitude: 51.2350, longitude: 22.5600),
             plants: [
                Plant(name: "Jodła", coordinate: CLLocationCoordinate2D(latitude: 51.2340, longitude: 22.5610), imageName: "jodla"),
                Plant(name: "Olcha", coordinate: CLLocationCoordinate2D(latitude: 51.2355, longitude: 22.5595), imageName: "olcha")
             ])
]
