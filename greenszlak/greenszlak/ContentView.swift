//
//  ContentView.swift
//  greenszlak
//
//  Created by student on 28/05/2025.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var selectedDistrict = districts.first!
    @State private var region: MKCoordinateRegion
    @State private var selectedPlant: Plant? = nil
    @State private var showPlantSheet = false

    init() {
        let initialRegion = MKCoordinateRegion(
            center: districts.first!.center,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        _region = State(initialValue: initialRegion)
    }

    var body: some View {
        VStack {
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
            }
            .edgesIgnoringSafeArea(.all)
        }
        // z obrazkiem
        .sheet(isPresented: $showPlantSheet) {
            if let plant = selectedPlant {
                VStack {
                    
                    Image(plant.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding()

                    Text(plant.name)
                        .font(.title)
                        .padding()

                    Text("To jest roślina: \(plant.name)")
                        .padding()

                    Button("Wyjdz") {
                        showPlantSheet = false
                    }
                    .padding()
                }
                .padding()
            }
        }
    }
}
