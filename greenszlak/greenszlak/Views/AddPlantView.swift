import SwiftUI
import MapKit
import CoreData

struct AddPlantView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode

    let coordinate: CLLocationCoordinate2D
    let district: DistrictModel?

    @State private var name: String = ""
    @State private var info: String = ""
    @State private var photoId: String = ""
    @State private var selectedTags: Set<TagType> = []

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Plant Details")) {
                    TextField("Name", text: $name)
                    TextField("Description", text: $info)
                    TextField("Photo ID", text: $photoId)
                }

                Section(header: Text("Tags")) {
                    ForEach(TagType.allCases) { tag in
                        MultipleSelectionRow(title: tag.displayName, emoji: tag.emoji, isSelected: selectedTags.contains(tag)) {
                            if selectedTags.contains(tag) {
                                selectedTags.remove(tag)
                            } else {
                                selectedTags.insert(tag)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add Plant")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    savePlant()
                    presentationMode.wrappedValue.dismiss()
                }.disabled(name.isEmpty)
            )
        }
    }

    private func savePlant() {
        guard let district = district else { return }

        let newPlantModel = PlantModel(
            id: UUID(),
            name: name,
            info: info,
            timestamp: Date(),
            coordinate: coordinate,
            imageID: photoId,
            tags: Array(selectedTags)
        )

        let plant = Plant.from(newPlantModel, context: viewContext)

        let districtFetchRequest: NSFetchRequest<District> = District.fetchRequest()
        districtFetchRequest.predicate = NSPredicate(format: "id == %@", district.id as CVarArg)

        if let coreDataDistrict = try? viewContext.fetch(districtFetchRequest).first {
            plant.district = coreDataDistrict
            coreDataDistrict.addToPlants(plant)
        }

        try? viewContext.save()
    }
}

struct MultipleSelectionRow: View {
    let title: String
    let emoji: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text("\(emoji) \(title)")
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.accentColor)
                }
            }
        }
        .foregroundColor(.primary)
    }
}


