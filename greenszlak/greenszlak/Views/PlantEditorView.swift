import SwiftUI

struct PlantEditorView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    var originalPlant: PlantModel
    var district: DistrictModel?
    var kolorTla: Color
    
    @State private var name: String
    @State private var info: String
    @State private var imageID: String
    @State private var selectedTags: Set<TagType>
    
    init(plant: PlantModel, district: DistrictModel?, kolorTla: Color) {
        self.originalPlant = plant
        self.district = district
        self.kolorTla = kolorTla
        _name = State(initialValue: plant.name)
        _info = State(initialValue: plant.info)
        _imageID = State(initialValue: plant.imageID)
        _selectedTags = State(initialValue: Set(plant.tags))
    }
    
    var body: some View {
        ZStack {
            Color(kolorTla)
                .opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VisualEffectBlur(effect: .systemMaterial)
                .edgesIgnoringSafeArea(.all)
            
            NavigationView {
                Form {
                    Section(header: Text("Plant Details")) {
                        TextField("Name", text: $name)
                        
                        // Многострочный TextEditor для info
                        TextEditor(text: $info)
                            .frame(minHeight: 80)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        
                        TextField("Image ID", text: $imageID)
                            .textInputAutocapitalization(.never)   // Отключаем автокапитализацию
                            .disableAutocorrection(true)
                            .onChange(of: imageID) { newValue in
                                imageID = newValue.lowercased()
                            }
                    }
                    
                    Section(header: Text("Tags")) {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                            ForEach(TagType.allCases) { tag in
                                Button(action: {
                                    toggleTag(tag)
                                }) {
                                    VStack {
                                        Text(tag.emoji)
                                            .font(.largeTitle)
                                        Text(tag.displayName)
                                            .font(.caption)
                                    }
                                    .padding(8)
                                    .background(selectedTags.contains(tag) ? kolorTla.opacity(0.3) : Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Edit Plant")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            saveChanges()
                            dismiss()
                        }
                    }
                }
            }
        }
    }
    
    private func toggleTag(_ tag: TagType) {
        if selectedTags.contains(tag) {
            selectedTags.remove(tag)
        } else {
            selectedTags.insert(tag)
        }
    }
    
    private func saveChanges() {
        let request = Plant.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", originalPlant.id as CVarArg)
        if let results = try? viewContext.fetch(request),
           let existing = results.first {
            existing.name = name
            existing.info = info
            existing.imageID = imageID
            existing.tagsRaw = NSArray(array: selectedTags.map { $0.rawValue })
            try? viewContext.save()
        }
    }
}



