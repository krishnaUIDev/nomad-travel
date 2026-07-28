import SwiftUI

public enum NomadColors {
    public static let background = Color(red: 10/255, green: 12/255, blue: 16/255)
    public static let cardBackground = Color(red: 20/255, green: 24/255, blue: 33/255)
    public static let glassBorder = Color.white.opacity(0.12)
    public static let primaryCoral = Color(red: 255/255, green: 90/255, blue: 95/255) // Vibrant Airbnb-style coral
    public static let nomadCyan = Color(red: 0/255, green: 212/255, blue: 255/255)
    public static let wifiGreen = Color(red: 46/255, green: 213/255, blue: 115/255)
    public static let textPrimary = Color.white
    public static let textSecondary = Color.white.opacity(0.65)
    public static let textMuted = Color.white.opacity(0.40)
    
    public static let glassLinearGradient = LinearGradient(
        colors: [Color.white.opacity(0.15), Color.white.opacity(0.03)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
