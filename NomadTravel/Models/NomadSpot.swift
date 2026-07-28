import Foundation

public enum SpotCategory: String, Codable, CaseIterable {
    case cafe = "Cafe"
    case coworking = "Co-Working"
    case library = "Library"
    case hotelLobby = "Hotel Lobby"
    
    public var iconName: String {
        switch self {
        case .cafe: return "cup.and.saucer.fill"
        case .coworking: return "laptopcomputer"
        case .library: return "books.vertical.fill"
        case .hotelLobby: return "building.2.fill"
        }
    }
}

public struct NomadSpot: Identifiable, Codable {
    public let id: String
    public let name: String
    public let category: SpotCategory
    public let latitude: Double
    public let longitude: Double
    public let avgWifiDownloadMbps: Double
    public let hasPowerOutlets: Bool
    public let isSilentCallFriendly: Bool
    public let rating: Double
    public let imageUrl: String
    
    public static let mockSpots: [NomadSpot] = [
        NomadSpot(
            id: "spot-1",
            name: "Zest Work & Artisanal Coffee",
            category: .cafe,
            latitude: -8.6480,
            longitude: 115.1390,
            avgWifiDownloadMbps: 180.0,
            hasPowerOutlets: true,
            isSilentCallFriendly: false,
            rating: 4.85,
            imageUrl: "https://images.unsplash.com/photo-1554118811-1e0d58224f24?auto=format&fit=crop&w=800&q=80"
        ),
        NomadSpot(
            id: "spot-2",
            name: "B2B Co-Working & Soundproof Pods",
            category: .coworking,
            latitude: 38.7120,
            longitude: -9.1410,
            avgWifiDownloadMbps: 650.0,
            hasPowerOutlets: true,
            isSilentCallFriendly: true,
            rating: 4.95,
            imageUrl: "https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&w=800&q=80"
        )
    ]
}
