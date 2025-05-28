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
                Plant(name: "Klon", coordinate: CLLocationCoordinate2D(latitude: 51.2485, longitude: 22.5650), imageName: "klon", description: "Klon to drzewo liściaste o charakterystycznych dłoniastych, klapowanych liściach. Jego drewno jest twarde i cenione w stolarstwie."),
                Plant(name: "Jesion", coordinate: CLLocationCoordinate2D(latitude: 51.2490, longitude: 22.5660), imageName: "jesion", description: "Drzewo liściaste o silnym, prostym pniu i jasnozielonych liściach. Często używany do produkcji mebli i narzędzi ze względu na wytrzymałe drewno.")
             ]),
    District(name: "Sławinek",
             center: CLLocationCoordinate2D(latitude: 51.2645, longitude: 22.5350),
             plants: [
                Plant(name: "Lipa", coordinate: CLLocationCoordinate2D(latitude: 51.2647, longitude: 22.5355), imageName: "lipa", description: "Drzewo o sercowatych liściach i pachnących kwiatach, ważne dla pszczół. Drewno lipowe jest miękkie i łatwe do rzeźbienia."),
                Plant(name: "Wiśnia", coordinate: CLLocationCoordinate2D(latitude: 51.2635, longitude: 22.5340), imageName: "wisnia", description: "Drzewo owocowe o pięknych, różowych kwiatach i smacznych owocach. Drewno wiśniowe jest cenione za ciepły, czerwony kolor i trwałość.")
             ]),
    District(name: "Czechów",
             center: CLLocationCoordinate2D(latitude: 51.2700, longitude: 22.5600),
             plants: [
                Plant(name: "Sosna", coordinate: CLLocationCoordinate2D(latitude: 51.2710, longitude: 22.5610), imageName: "sosna", description: "Drzewo iglaste o długich igłach i charakterystycznym zapachu żywicy. Drewno sosnowe jest lekkie, łatwe w obróbce i szeroko stosowane w budownictwie."),
                Plant(name: "Dąb", coordinate: CLLocationCoordinate2D(latitude: 51.2690, longitude: 22.5590), imageName: "dab", description: "Drzewo o mocnym, twardym drewnie i charakterystycznych klapowanych liściach. Drewno dębowe jest trwałe i odporne na wilgoć, często używane do produkcji beczek i mebli.")
             ]),
    District(name: "Wieniawa",
             center: CLLocationCoordinate2D(latitude: 51.2470, longitude: 22.5550),
             plants: [
                Plant(name: "Grab", coordinate: CLLocationCoordinate2D(latitude: 51.2475, longitude: 22.5555), imageName: "grab", description: "Drzewo liściaste o drobnych liściach i twardym drewnie. Grab jest często wykorzystywany jako drewno opałowe oraz do wyrobu narzędzi."),
                Plant(name: "Buk", coordinate: CLLocationCoordinate2D(latitude: 51.2465, longitude: 22.5540), imageName: "buk", description: "Drzewo o gładkiej korze i dużych liściach. Drewno bukowe jest twarde, elastyczne i popularne w meblarstwie oraz produkcji podłóg.")
             ]),
    District(name: "Rury",
             center: CLLocationCoordinate2D(latitude: 51.2350, longitude: 22.5600),
             plants: [
                Plant(name: "Jodła", coordinate: CLLocationCoordinate2D(latitude: 51.2340, longitude: 22.5610), imageName: "jodla", description: "Drzewo iglaste o stożkowatym kształcie i miękkich igłach. Drewno jodłowe jest lekkie i stosowane w budownictwie oraz do produkcji papieru."),
                Plant(name: "Olcha", coordinate: CLLocationCoordinate2D(latitude: 51.2355, longitude: 22.5595), imageName: "olcha", description: "Drzewo rosnące często nad wodą, o lekko czerwonym drewnie. Drewno olchowe jest miękkie i używane do wyrobu mebli oraz instrumentów muzycznych.")
             ])
]
