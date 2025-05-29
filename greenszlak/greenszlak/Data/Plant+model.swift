import Foundation
import MapKit


struct PlantModel: Identifiable {
    let id : UUID
    let name: String
    let info: String
    let timestamp: Date
    let coordinate: CLLocationCoordinate2D
    let imageID: String
    let tags: [TagType]
}

extension Plant {
    static func from(_ model: PlantModel, context: NSManagedObjectContext) -> Plant {
        let entity = Plant(context: context)
        entity.id = model.id
        entity.name = model.name
        entity.info = model.info
        entity.timestamp = model.timestamp
        entity.latitude = model.coordinate.latitude
        entity.longitude = model.coordinate.longitude
        entity.imageID = model.imageID
        entity.tagsRaw = model.tags.map { $0.rawValue }
        return entity
    }

    var toModel: PlantModel {
        PlantModel(
            id: self.id,
            name: self.name ?? "Unknown",
            info: self.info ?? "",
            timestamp: self.timestamp ?? Date(),
            coordinate: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude),
            imageID: self.imageID ?? "placeholder",
            tags: (self.tagsRaw as? [String] ?? []).compactMap { raw in
                TagType(rawValue: raw) ?? .whoyou
            }
        )
    }
}
