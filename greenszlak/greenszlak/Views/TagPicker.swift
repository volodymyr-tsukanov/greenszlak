import SwiftUI


struct TagSelectionView: View {
    @Binding var selectedTags: Set<TagType>

    var body: some View {
        VStack {
            Text("Choose Tags").font(.headline)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(TagType.allCases) { tag in
                    Button {
                        toggle(tag)
                    } label: {
                        VStack {
                            Text(tag.emoji).font(.largeTitle)
                            Text(tag.displayName)
                                .font(.caption)
                        }
                        .padding()
                        .background(selectedTags.contains(tag) ? Color.green.opacity(0.3) : Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
        }
    }

    private func toggle(_ tag: TagType) {
        if selectedTags.contains(tag) {
            selectedTags.remove(tag)
        } else {
            selectedTags.insert(tag)
        }
    }
}
