import Foundation

struct Note: Identifiable, Codable {
    var id = UUID()
    var content: String
}
