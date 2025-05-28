import SwiftUI


struct MenuBoczne: View {
    @Binding var pokazMenu: Bool
    @Binding var nazwaKoloruTla: String


    let opcjeKolorow: [(nazwa: String, kolor: Color)] = [
        ("bialy", .white),
        ("zolty", .yellow),
        ("niebieski", .blue),
        ("zielony", .green),
        ("szary", .gray),
        ("czarny", .black)
    ]


    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Wybierz kolor tła")
                .font(.headline)
                .padding(.top, 40)


            ForEach(opcjeKolorow, id: \.nazwa) { opcja in
                Button(action: {
                    nazwaKoloruTla = opcja.nazwa
                }) {
                    HStack {
                        Circle()
                            .fill(opcja.kolor)
                            .frame(width: 30, height: 30)
                        Text(opcja.nazwa.capitalized)
                            .foregroundColor(.black)
                    }
                }
            }


            Spacer()


            Button("Zamknij") {
                withAnimation {
                    pokazMenu = false
                }
            }
            .padding(.bottom, 40)
        }
        .padding()
        .frame(maxWidth: 300)
        .background(Color(.systemGray6))
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(.leading)
    }
}





