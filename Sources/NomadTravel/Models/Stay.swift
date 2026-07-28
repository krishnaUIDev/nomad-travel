import Foundation

public struct Stay: Identifiable, Hashable, Codable {
    public let id: String
    public let title: String
    public let locationName: String
    public let countryCode: String
    public let pricePerNightUSD: Double
    public let pricePerMonthUSD: Double
    public let wifiSpeedMbps: Int
    public let hasErgonomicDesk: Bool
    public let rating: Double
    public let reviewCount: Int
    public let latitude: Double
    public let longitude: Double
    public let heroImageUrl: String
    public let galleryImageUrls: [String]
    public let hostName: String
    public let isSuperhost: Bool
    
    public init(
        id: String,
        title: String,
        locationName: String,
        countryCode: String,
        pricePerNightUSD: Double,
        pricePerMonthUSD: Double,
        wifiSpeedMbps: Int,
        hasErgonomicDesk: Bool,
        rating: Double,
        reviewCount: Int,
        latitude: Double,
        longitude: Double,
        heroImageUrl: String,
        galleryImageUrls: [String],
        hostName: String,
        isSuperhost: Bool
    ) {
        self.id = id
        self.title = title
        self.locationName = locationName
        self.countryCode = countryCode
        self.pricePerNightUSD = pricePerNightUSD
        self.pricePerMonthUSD = pricePerMonthUSD
        self.wifiSpeedMbps = wifiSpeedMbps
        self.hasErgonomicDesk = hasErgonomicDesk
        self.rating = rating
        self.reviewCount = reviewCount
        self.latitude = latitude
        self.longitude = longitude
        self.heroImageUrl = heroImageUrl
        self.galleryImageUrls = galleryImageUrls
        self.hostName = hostName
        self.isSuperhost = isSuperhost
    }
}

// Sample Mock Data for Stays
public extension Stay {
    static let mockStays: [Stay] = [
        Stay(
            id: "stay-1",
            title: "Oceanfront Glass Villa & Work Studio",
            locationName: "Canggu, Bali",
            countryCode: "ID",
            pricePerNightUSD: 110.0,
            pricePerMonthUSD: 2400.0,
            wifiSpeedMbps: 250,
            hasErgonomicDesk: true,
            rating: 4.96,
            reviewCount: 128,
            latitude: -8.6478,
            longitude: 115.1385,
            heroImageUrl: "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1000&q=80",
            galleryImageUrls: [
                "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1000&q=80",
                "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1000&q=80",
                "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=1000&q=80"
            ],
            hostName: "Maya & Wayan",
            isSuperhost: true
        ),
        Stay(
            id: "stay-2",
            title: "Modern Loft in Historic Chiado",
            locationName: "Lisbon, Portugal",
            countryCode: "PT",
            pricePerNightUSD: 95.0,
            pricePerMonthUSD: 2100.0,
            wifiSpeedMbps: 500,
            hasErgonomicDesk: true,
            rating: 4.92,
            reviewCount: 94,
            latitude: 38.7107,
            longitude: -9.1424,
            heroImageUrl: "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=1000&q=80",
            galleryImageUrls: [
                "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=1000&q=80",
                "https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?auto=format&fit=crop&w=1000&q=80"
            ],
            hostName: "Tiago Silva",
            isSuperhost: true
        ),
        Stay(
            id: "stay-3",
            title: "Minimalist Alpine Penthouse",
            locationName: "Bansko, Bulgaria",
            countryCode: "BG",
            pricePerNightUSD: 45.0,
            pricePerMonthUSD: 850.0,
            wifiSpeedMbps: 300,
            hasErgonomicDesk: true,
            rating: 4.88,
            reviewCount: 67,
            latitude: 41.8383,
            longitude: 23.4885,
            heroImageUrl: "https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=1000&q=80",
            galleryImageUrls: [
                "https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=1000&q=80"
            ],
            hostName: "Elena Kostova",
            isSuperhost: false
        )
    ]
}
