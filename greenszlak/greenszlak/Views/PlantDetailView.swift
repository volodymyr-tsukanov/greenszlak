import SwiftUI


struct PlantDetailView: View {
    let plant: PlantModel
    let kolorTla: Color
    let onEdit: () -> Void
    @Environment(\.dismiss) private var dismiss


    var body: some View {
        ZStack {
            kolorTla.opacity(0.3).edgesIgnoringSafeArea(.all)
            VisualEffectBlur(effect: .systemMaterial)
                .edgesIgnoringSafeArea(.all)


            VStack(spacing: 16) {
                Text(plant.name)
                    .font(.largeTitle)
                    .bold()
                    .padding()


                if let uiImage = UIImage(named: plant.imageID) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(12)
                        .padding()
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .foregroundColor(.gray)
                        .padding()
                }


                ScrollView {
                    Text(plant.info)
                        .font(.body)
                        .padding()
                }


                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Close")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }


                    Button(action: {
                        dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            onEdit()
                        }
                    }) {
                        Text("Edit")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(kolorTla.opacity(0.4))
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
            }
            .padding()
            .background(Color.white.opacity(0.9))
            .cornerRadius(16)
            .padding()
        }
    }
}






