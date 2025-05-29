import SwiftUI
import MapKit
import CoreData


struct AddPlantView: View {
    @Environment(\.managedObjectContext) private var viewContext

    let coordinate: CLLocationCoordinate2D
    let district: DistrictModel?

    // Add @State properties for form inputs here

    var body: some View {
        // TODO: Implement UI to enter plant details, select image, tags, etc.
        EmptyView()
    }

    private func savePlant() {
        guard let district = district else { return }

        let newPlantModel = PlantModel(
            id: UUID(),
            name: "", // fill in from user input
            info: "",
            timestamp: Date(),
            coordinate: coordinate,
            imageID: "", // fill in from selected image
            tags: [] // fill in from selected tags
        )

        let plant = Plant.from(newPlantModel, context: viewContext)

        // Link plant to district if needed
        let districtFetchRequest: NSFetchRequest<District> = District.fetchRequest()
        districtFetchRequest.predicate = NSPredicate(format: "id == %@", district.id as CVarArg)

        if let coreDataDistrict = try? viewContext.fetch(districtFetchRequest).first {
            plant.district = coreDataDistrict
            coreDataDistrict.addToPlants(plant)
        }

        try? viewContext.save()
    }
}
