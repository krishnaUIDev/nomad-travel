import Foundation

public struct GuideSpot: Identifiable, Codable, Hashable {
    public let id: String
    public let name: String
    public let category: String // Cafe, Coworking, SIM Shop, Emergency
    public let address: String
    public let rating: Double
    public let wifiSpeedMbps: Int
    public let hasPowerOutlets: Bool
    public let nomadNotes: String
    
    public init(
        id: String = UUID().uuidString,
        name: String,
        category: String,
        address: String,
        rating: Double,
        wifiSpeedMbps: Int,
        hasPowerOutlets: Bool,
        nomadNotes: String
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.address = address
        self.rating = rating
        self.wifiSpeedMbps = wifiSpeedMbps
        self.hasPowerOutlets = hasPowerOutlets
        self.nomadNotes = nomadNotes
    }
}

public struct CityGuide: Identifiable, Codable, Hashable {
    public let id: String
    public let cityName: String
    public let countryName: String
    public let countryFlag: String
    public let avgMonthlyCostUSD: Double
    public let avgInternetSpeedMbps: Int
    public let safetyScore: Double // 1.0 to 5.0
    public let bestSimCardProvider: String
    public let spots: [GuideSpot]
    public let nomadTipOfDay: String
    
    public init(
        id: String = UUID().uuidString,
        cityName: String,
        countryName: String,
        countryFlag: String,
        avgMonthlyCostUSD: Double,
        avgInternetSpeedMbps: Int,
        safetyScore: Double,
        bestSimCardProvider: String,
        spots: [GuideSpot] = [],
        nomadTipOfDay: String
    ) {
        self.id = id
        self.cityName = cityName
        self.countryName = countryName
        self.countryFlag = countryFlag
        self.avgMonthlyCostUSD = avgMonthlyCostUSD
        self.avgInternetSpeedMbps = avgInternetSpeedMbps
        self.safetyScore = safetyScore
        self.bestSimCardProvider = bestSimCardProvider
        self.spots = spots
        self.nomadTipOfDay = nomadTipOfDay
    }
}

// Sample Mock City Guides
public extension CityGuide {
    static let mockGuides: [CityGuide] = [
        CityGuide(
            id: "guide-lisbon",
            cityName: "Lisbon",
            countryName: "Portugal",
            countryFlag: "🇵🇹",
            avgMonthlyCostUSD: 2100.0,
            avgInternetSpeedMbps: 350,
            safetyScore: 4.8,
            bestSimCardProvider: "Vodafone Portugal (20GB for €15 at airport)",
            spots: [
                GuideSpot(name: "Zin Work Cafe", category: "Cafe", address: "Rua do Alecrim 12", rating: 4.9, wifiSpeedMbps: 400, hasPowerOutlets: true, nomadNotes: "Ergonomic chairs on 2nd floor."),
                GuideSpot(name: "LACS Co-Working", category: "Co-Working", address: "Cais do Sodré", rating: 4.8, wifiSpeedMbps: 650, hasPowerOutlets: true, nomadNotes: "24/7 access with day pass.")
            ],
            nomadTipOfDay: "Use the Viva Viagem card for 24h metro/tram access for only €6.80!"
        )
    ]
}
