import SwiftUI
import MapKit
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: District.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \District.timestamp, ascending: false)]
    )
    private var fetchedDistricts: FetchedResults<District>
    
    // Track selected district by ID (UUID)
    @State private var selectedDistrictID: UUID?
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion()
    @State private var selectedPlant: PlantModel? = nil
    @State private var showPlantSheet = false
    @State private var showPlantEditor = false
    @State private var showMenu = false
    @State private var showAddPlantView = false
    @State private var newPlantCoordinate: CLLocationCoordinate2D? = nil
    
    @AppStorage("nazwaKoloruTla") private var nazwaKoloruTla: String = "bialy"
    
    var kolorTla: Color {
        switch nazwaKoloruTla {
        case "zolty": return .yellow
        case "niebieski": return .blue
        case "zielony": return .green
        case "szary": return .gray
        default: return .white
        }
    }
    
    // Convert Core Data objects to models
    private var districts: [DistrictModel] {
        fetchedDistricts.map { $0.toModel }
    }
    
    // Get the currently selected district model from selectedDistrictID
    private var selectedDistrictModel: DistrictModel? {
        guard let id = selectedDistrictID else { return nil }
        return districts.first(where: { $0.id == id })
    }
    
    var body: some View {
        ZStack {
            kolorTla.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .padding()
                    }
                    Spacer()
                }
                
                if !districts.isEmpty {
                    Picker("Wybierz dzielnicę", selection: $selectedDistrictID) {
                        ForEach(districts, id: \.id) { district in
                            Text(district.name).tag(Optional(district.id))
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .onChange(of: selectedDistrictID) { newID in
                        if let district = districts.first(where: { $0.id == newID }) {
                            region.center = district.center
                        }
                    }
                    
                    Map(coordinateRegion: $region, annotationItems: selectedDistrictModel?.plants ?? []) { plant in
                        MapAnnotation(coordinate: plant.coordinate) {
                            VStack(spacing: 2) {
                                Image(systemName: "leaf.fill")
                                    .foregroundColor(.green)
                                    .padding(6)
                                    .background(Circle().fill(Color.white))
                                    .shadow(radius: 3)
                                Text(plant.name)
                                    .font(.caption2)
                                    .padding(2)
                                    .background(Color.white.opacity(0.8))
                                    .cornerRadius(4)
                            }
                            .onTapGesture {
                                selectedPlant = plant
                                showPlantSheet = true
                            }
                        }
                    }
                    .gesture(
                        LongPressGesture(minimumDuration: 1.3)
                            .onEnded { _ in
                                newPlantCoordinate = region.center
                                showAddPlantView = true
                            }
                    )
                    .edgesIgnoringSafeArea(.all)
                } else {
                    Text("No district data available")
                        .font(.headline)
                        .padding()
                }
            }
            
            if showMenu {
                MenuBoczne(pokazMenu: $showMenu, nazwaKoloruTla: $nazwaKoloruTla)
                    .transition(.move(edge: .leading))
            }
        }
        .onAppear {
            if let firstDistrict = districts.first {
                selectedDistrictID = firstDistrict.id
                region = MKCoordinateRegion(
                    center: firstDistrict.center,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            }
        }
        .sheet(isPresented: $showPlantSheet) {
            if let plant = selectedPlant {
                PlantDetailView(
                    plant: plant,
                    kolorTla: kolorTla,
                    onEdit: {
                        showPlantSheet = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            showPlantEditor = true
                        }
                    }
                )
            }
        }
        .sheet(isPresented: $showPlantEditor) {
            if let plant = selectedPlant {
                PlantEditorView(
                    plant: plant,
                    district: selectedDistrictModel,
                    kolorTla: kolorTla
                )
                .environment(\.managedObjectContext, viewContext)
            }
        }
        .sheet(isPresented: $showAddPlantView) {
            if let coordinate = newPlantCoordinate {
                AddPlantView(coordinate: coordinate, district: selectedDistrictModel)
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }
}



