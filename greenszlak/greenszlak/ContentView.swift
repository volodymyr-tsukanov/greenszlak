import SwiftUI
import MapKit


struct ContentView: View {
    @State private var selectedDistrict = districts.first!
    @State private var region: MKCoordinateRegion
    @State private var selectedPlant: Plant? = nil
    @State private var showPlantSheet = false
    @State private var showMenu = false
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

    init() {
        let initialRegion = MKCoordinateRegion(
            center: districts.first!.center,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        _region = State(initialValue: initialRegion)
    }

    var body: some View {
        ZStack {
            kolorTla
                .edgesIgnoringSafeArea(.all)
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
                Picker("Wybierz dzielnicę", selection: $selectedDistrict) {
                ForEach(districts) { district in
                    Text(district.name).tag(district)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: selectedDistrict) { newDistrict in
                region.center = newDistrict.center
            }

            Map(coordinateRegion: $region, annotationItems: selectedDistrict.plants) { plant in
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
                .edgesIgnoringSafeArea(.all)	//why?
            }
            .edgesIgnoringSafeArea(.all)
        }
        .sheet(isPresented: $showPlantSheet) {
            if let plant = selectedPlant {
                VStack (spacing: 15){

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

                    Text(plant.description)
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
            }
        }
    }
}
