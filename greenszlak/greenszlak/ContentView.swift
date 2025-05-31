import SwiftUI
import MapKit
import CoreData


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: District.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \District.timestamp, ascending: false)])
    private var fetchedDistricts: FetchedResults<District>

    @State private var selectedDistrict: DistrictModel?
    @State private var region: MKCoordinateRegion = MKCoordinateRegion()
    @State private var selectedPlant: PlantModel? = nil
    @State private var showPlantSheet = false
    @State private var showMenu = false
    // add Plant
    @State private var showAddPlantView = false
    @State private var newPlantCoordinate: CLLocationCoordinate2D? = nil

    //TODO change all namings to English (for consistency reasons)
    @AppStorage("nazwaKoloruTla") private var nazwaKoloruTla: String = "bialy"

    var kolorTla: Color {
        switch nazwaKoloruTla {
        case "zolty": return .yellow
        case "niebieski": return .blue
        case "zielony": return .green
        case "szary": return .gray
        case "czarny": return .black
        default: return .white
        }
    }

    private var districts: [DistrictModel] {
        fetchedDistricts.map { $0.toModel }
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
                    Picker("Wybierz dzielnicę", selection: $selectedDistrict) {
                        ForEach(districts, id: \.id) { district in
                            Text(district.name).tag(Optional(district))
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .onChange(of: selectedDistrict) { newDistrict in
                        if let center = newDistrict?.center {
                            region.center = center
                        }
                    }

                    Map(coordinateRegion: $region, annotationItems: selectedDistrict?.plants ?? []) { plant in
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
                                let center = region.center  //approx. let it be, it's not commercial
                                newPlantCoordinate = center
                                showAddPlantView = true
                            }
                    )
                    .edgesIgnoringSafeArea(.all)
                } else {
                    Text("Brak danych o dzielnicach")
                        .font(.headline)
                        .padding()
                }
            }
        }
        .onAppear {
            if let firstDistrict = districts.first {
                selectedDistrict = firstDistrict
                region = MKCoordinateRegion(
                    center: firstDistrict.center,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            }
        }
        .sheet(isPresented: $showPlantSheet) {
            if let plant = selectedPlant {
                PlantEditorView(plant: plant, district: selectedDistrict)
                    .environment(\.managedObjectContext, viewContext)
            }
            /*if let plant = selectedPlant {
                VStack(spacing: 15) {
                    Image(plant.imageID)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 10)
                        .padding()

                    Text(plant.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                        .multilineTextAlignment(.center)

                    Text("Opis:")
                        .font(.headline)
                        .padding(.vertical, 5)

                    Text(plant.info)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)

                    Spacer()

                    Button("Wyjdz") {
                        showPlantSheet = false
                    }
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                .padding()
            }*/
        }
        .sheet(isPresented: $showAddPlantView) {
            if let coordinate = newPlantCoordinate {
                AddPlantView(coordinate: coordinate, district: selectedDistrict)
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }
}
