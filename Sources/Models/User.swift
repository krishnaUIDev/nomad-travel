import Foundation

public enum TravelStyle: String, Codable, CaseIterable, Identifiable {
    case digitalNomad = "Digital Nomad"
    case backpacker = "Backpacker"
    case slowTravel = "Slow Travel"
    case vanLife = "Van Life"
    case luxuryNomad = "Luxury Nomad"
    
    public var id: String { rawValue }
    
    public var iconName: String {
        switch self {
        case .digitalNomad: return "laptopcomputer"
        case .backpacker: return "figure.walk.backpack"
        case .slowTravel: return "tortoise.fill"
        case .vanLife: return "car.side.fill"
        case .luxuryNomad: return "sparkles"
        }
    }
}

public struct NomadUser: Identifiable, Codable, Hashable {
    public let id: String
    public var email: String
    public var displayName: String
    public var bio: String
    public var profilePhotos: [String]
    public var homeCountry: String
    public var homeCountryFlag: String
    public var languagesSpoken: [String]
    public var travelStyles: [TravelStyle]
    public var profession: String
    public var currentCity: String
    public var currentCountry: String
    public var latitude: Double
    public var longitude: Double
    public var instagramHandle: String?
    public var linkedinUrl: String?
    public var twitterHandle: String?
    public var trustScore: Int // 0-100 social verification score
    public var isVerified: Bool
    public var isGhostMode: Bool
    public var createdAt: Date
    
    public init(
        id: String,
        email: String,
        displayName: String,
        bio: String,
        profilePhotos: [String],
        homeCountry: String,
        homeCountryFlag: String,
        languagesSpoken: [String],
        travelStyles: [TravelStyle],
        profession: String,
        currentCity: String,
        currentCountry: String,
        latitude: Double,
        longitude: Double,
        instagramHandle: String? = nil,
        linkedinUrl: String? = nil,
        twitterHandle: String? = nil,
        trustScore: Int = 85,
        isVerified: Bool = true,
        isGhostMode: Bool = false,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.email = email
        self.displayName = displayName
        self.bio = bio
        self.profilePhotos = profilePhotos
        self.homeCountry = homeCountry
        self.homeCountryFlag = homeCountryFlag
        self.languagesSpoken = languagesSpoken
        self.travelStyles = travelStyles
        self.profession = profession
        self.currentCity = currentCity
        self.currentCountry = currentCountry
        self.latitude = latitude
        self.longitude = longitude
        self.instagramHandle = instagramHandle
        self.linkedinUrl = linkedinUrl
        self.twitterHandle = twitterHandle
        self.trustScore = trustScore
        self.isVerified = isVerified
        self.isGhostMode = isGhostMode
        self.createdAt = createdAt
    }
}

// Sample Mock Users for Social Discovery Engine
public extension NomadUser {
    static let mockUsers: [NomadUser] = [
        NomadUser(
            id: "user-1",
            email: "sophia@nomad.io",
            displayName: "Sophia Lin",
            bio: "Building AI agents by day, surfing Canggu breaks at sunset. Always down for coffee & co-working!",
            profilePhotos: [
                "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=800&q=80",
                "https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=800&q=80"
            ],
            homeCountry: "Canada",
            homeCountryFlag: "🇨🇦",
            languagesSpoken: ["English", "Mandarin", "Spanish"],
            travelStyles: [.digitalNomad, .slowTravel],
            profession: "AI Software Engineer",
            currentCity: "Lisbon",
            currentCountry: "Portugal",
            latitude: 38.7167,
            longitude: -9.1333,
            instagramHandle: "@sophialin_travels",
            trustScore: 92,
            isVerified: true
        ),
        NomadUser(
            id: "user-2",
            email: "marcus@nomad.io",
            displayName: "Marcus Vance",
            bio: "UI/UX Designer exploring Europe. Looking for travel buddies for weekend hikes in Sintra & Algarve!",
            profilePhotos: [
                "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=800&q=80",
                "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=800&q=80"
            ],
            homeCountry: "United Kingdom",
            homeCountryFlag: "🇬🇧",
            languagesSpoken: ["English", "French"],
            travelStyles: [.digitalNomad, .backpacker],
            profession: "Lead Product Designer",
            currentCity: "Lisbon",
            currentCountry: "Portugal",
            latitude: 38.7120,
            longitude: -9.1410,
            instagramHandle: "@marcusvance",
            trustScore: 88,
            isVerified: true
        ),
        NomadUser(
            id: "user-3",
            email: "elena@nomad.io",
            displayName: "Elena Rostova",
            bio: "Slow traveling across SE Asia & Mediterranean. Love specialty coffee, pilates, and sunset dinners.",
            profilePhotos: [
                "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=800&q=80"
            ],
            homeCountry: "Germany",
            homeCountryFlag: "🇩🇪",
            languagesSpoken: ["German", "English", "Italian"],
            travelStyles: [.slowTravel, .luxuryNomad],
            profession: "Growth Marketer",
            currentCity: "Canggu",
            currentCountry: "Indonesia",
            latitude: -8.6478,
            longitude: 115.1385,
            trustScore: 95,
            isVerified: true
        )
    ]
}
