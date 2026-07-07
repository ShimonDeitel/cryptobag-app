import SwiftUI

enum Theme {
    static let accent = Color(hex: "#F7931A")
    static let accent2 = Color(hex: "#0B1F3A")
    static let background = Color(hex: "#0A0D14")
    static let cardBackground = Color(hex: "#0A0D14").opacity(0.6)
    static let titleFont: Font = .system(.largeTitle, design: .rounded).weight(.bold)
    static let bodyFont: Font = .system(.body, design: .rounded)
    static let cornerRadius: CGFloat = 16
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255.0
        let g = Double((int >> 8) & 0xFF) / 255.0
        let b = Double(int & 0xFF) / 255.0
        self.init(.sRGB, red: r, green: g, blue: b, opacity: 1.0)
    }
}
