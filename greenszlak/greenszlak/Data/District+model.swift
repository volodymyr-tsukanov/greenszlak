import Foundation
import MapKit
import CoreData

struct DistrictModel: Identifiable, Hashable {
    let id: UUID
    let name: String
    let timestamp: Date
    let center: CLLocationCoordinate2D
    let plants: [PlantModel]

    static func == (lhs: DistrictModel, rhs: DistrictModel) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension District {
    // Właściwość pomocnicza do konwersji plants NSSet? na Set<Plant>
    var plantsSet: Set<Plant> {
        plants as? Set<Plant> ?? []
    }

    static func from(_ model: DistrictModel, context: NSManagedObjectContext) -> District {
        let district = District(context: context)
        district.id = model.id
        district.name = model.name
        district.timestamp = model.timestamp
        district.latitude = model.center.latitude
        district.longitude = model.center.longitude
        return district
    }

    var toModel: DistrictModel {
        DistrictModel(
            id: self.id ?? UUID(),  // Jeśli id nil, użyj nowego UUID, ale raczej id powinno istnieć
            name: self.name ?? "Unknown",
            timestamp: self.timestamp ?? Date(),
            center: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude),
            plants: plantsSet.map { $0.toModel }  // Używamy plantsSet zamiast rzutowania inline
        )
    }
}
