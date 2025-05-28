import SwiftUI
import MapKit

struct ContentView: View {
    @State private var wybranaDzielnica = districts.first!
    @State private var region: MKCoordinateRegion
    @State private var wybranaRoslina: Plant? = nil
    @State private var pokazujOknoRosliny = false
    @State private var pokazMenu = false
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
        let poczatkowyRegion = MKCoordinateRegion(
            center: districts.first!.center,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        _region = State(initialValue: poczatkowyRegion)
    }

    var body: some View {
        ZStack {
            kolorTla
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            pokazMenu.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .padding()
                    }
                    Spacer()
                }
                Picker("Wybierz dzielnicę", selection: $wybranaDzielnica) {
                    ForEach(districts) { dzielnica in
                        Text(dzielnica.name).tag(dzielnica)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: wybranaDzielnica) { nowaDzielnica in
                    region.center = nowaDzielnica.center
                }
                Map(coordinateRegion: $region, annotationItems: wybranaDzielnica.plants) { roslina in
                    MapAnnotation(coordinate: roslina.coordinate) {
                        VStack(spacing: 2) {
                            Image(systemName: "leaf.fill")
                                .foregroundColor(.green)
                                .padding(6)
                                .background(Circle().fill(Color.white))
                                .shadow(radius: 3)
                            Text(roslina.name)
                                .font(.caption2)
                                .padding(2)
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(4)
                        }
                        .onTapGesture {
                            wybranaRoslina = roslina
                            pokazujOknoRosliny = true
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
            .padding(.top)
            if pokazMenu {
                MenuBoczne(pokazMenu: $pokazMenu, nazwaKoloruTla: $nazwaKoloruTla)
                    .transition(.move(edge: .leading))
                    .zIndex(1)
            }
        }
        .sheet(isPresented: $pokazujOknoRosliny) {
            if let roslina = wybranaRoslina {
                VStack {
                    Image(roslina.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding()
                    Text(roslina.name)
                        .font(.title)
                        .foregroundColor(kolorTla)
                        .padding()
                    Text("To jest roślina: \(roslina.name)")
                        .padding()
                    Button("Wyjdz") {
                        pokazujOknoRosliny = false
                    }
                    .padding()
                }
                .padding()
            }
        }
    }
}


