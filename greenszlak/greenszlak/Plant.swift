//
//  Plant.swift
//  zielnik
//
//  Created by student on 07/05/2025.
//

//import SwiftUI

import Foundation
import MapKit

struct Plant: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let imageName: String
}



func convertToCoreDataPlant(plant: Plant, context: NSManagedObjectContext) -> Plant? {
    // Create a new Core Data plant object
    let coreDataPlant = Plant(context: context)
    
    // Map properties from the struct to the Core Data entity
    coreDataPlant.id = plant.id
    coreDataPlant.name = plant.name
    coreDataPlant.latitude = plant.coordinate.latitude
    coreDataPlant.longitude = plant.coordinate.longitude
    coreDataPlant.imageName = plant.imageName
    
    // Save context
    do {
        try context.save()
        return coreDataPlant
    } catch {
        print("Failed to save Plant to Core Data: \(error)")
        return nil
    }
}


