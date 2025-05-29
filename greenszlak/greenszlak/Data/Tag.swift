import Foundation


enum TagType: String, CaseIterable, Identifiable, Codable, Hashable {
    case tree
    case flower
    case shrub
    case grass
    case herb
    case moss
    case whoyou

    var id: String { self.rawValue }

    var displayName: String {
        switch self {
        case .tree: return "Tree"
        case .flower: return "Flower"
        case .shrub: return "Shrub"
        case .grass: return "Grass"
        case .herb: return "Herb"
        case .moss: return "Moss"
        case .whoyou: return "?"
        }
    }

    var emoji: String {
        switch self {
        case .tree: return "🌳"
        case .flower: return "🌸"
        case .shrub: return "🌿"
        case .grass: return "🍃"
        case .herb: return "🌱"
        case .moss: return "🪴"
        case .whoyou: return "🤨"
        }
    }
}
