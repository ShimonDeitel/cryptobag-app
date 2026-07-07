import Foundation

struct CryptobagItem: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var createdAt: Date = Date()
    var coin: String
    var amount: Double
    var pricePaid: Double
}
