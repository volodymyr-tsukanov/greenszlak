//
//  core.swift
//  greenszlak
//
//  Created by student on 28/05/2025.
//

import Foundation
import CoreData


func addNewPlant(name: String, description: String, photo: Data?, latitude: Double, longitude: Double, tags: [Tag]) {
    let context = persistentContainer.viewContext
    let newPlant = Plant(context: context)
    newPlant.name = name
    newPlant.descriptionText = description
    newPlant.photo = photo
    newPlant.createdAt = Date()

    // Add location
    let newLocation = Location(context: context)
    newLocation.latitude = latitude
    newLocation.longitude = longitude
    newLocation.plants = NSSet(object: newPlant)
    newPlant.location = newLocation

    // Add tags
    newPlant.tags = Set(tags)

    // Save context
    do {
        try context.save()
    } catch {
        print("Failed to save plant: \(error)")
    }
}


func fetchPlantsByLocation(latitude: Double, longitude: Double) -> [PlantD]? {
    let context = persistentContainer.viewContext
    let request: NSFetchRequest<PlantD> = Plant.fetchRequest()
    
    let predicate = NSPredicate(format: "location.latitude == %lf AND location.longitude == %lf", latitude, longitude)
    request.predicate = predicate
    
    do {
        let plants = try context.fetch(request)
        return plants
    } catch {
        print("Failed to fetch plants: \(error)")
        return nil
    }
}
