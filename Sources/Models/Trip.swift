import Foundation

public enum TripVisibility: String, Codable, CaseIterable {
    case publicTrip = "Public"
    case friendsOnly = "Friends Only"
    case privateTrip = "Private"
}

public struct Trip: Identifiable, Codable, Hashable {
    public let id: String
    public let userId: String
    public let city: String
    public let country: String
    public let countryCode: String
    public let countryFlag: String
    public let startDate: Date
    public let endDate: Date
    public let notes: String?
    public let visibility: TripVisibility
    public let createdAt: Date
    
    public init(
        id: String = UUID().uuidString,
        userId: String,
        city: String,
        country: String,
        countryCode: String,
        countryFlag: String,
        startDate: Date,
        endDate: Date,
        notes: String? = nil,
        visibility: TripVisibility = .publicTrip,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.userId = userId
        self.city = city
        self.country = country
        self.countryCode = countryCode
        self.countryFlag = countryFlag
        self.startDate = startDate
        self.endDate = endDate
        self.notes = notes
        self.visibility = visibility
        self.createdAt = createdAt
    }
    
    /// Calculates whether two trips overlap in destination city and date range
    public func overlaps(with other: Trip) -> Bool {
        guard self.city.lowercased() == other.city.lowercased() else { return false }
        return (self.startDate <= other.endDate) && (self.endDate >= other.startDate)
    }
    
    /// Returns the number of overlapping days between two trips
    public func overlappingDays(with other: Trip) -> Int {
        guard overlaps(with: other) else { return 0 }
        let overlapStart = max(self.startDate, other.startDate)
        let overlapEnd = min(self.endDate, other.endDate)
        let components = Calendar.current.dateComponents([.day], from: overlapStart, to: overlapEnd)
        return max(1, (components.day ?? 0) + 1)
    }
}

// Sample Mock Trips for Overlap Testing
public extension Trip {
    static let mockTrips: [Trip] = [
        Trip(
            id: "trip-1",
            userId: "user-1",
            city: "Lisbon",
            country: "Portugal",
            countryCode: "PT",
            countryFlag: "🇵🇹",
            startDate: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
            endDate: Calendar.current.date(byAdding: .day, value: 25, to: Date())!,
            notes: "Staying in Chiado district. Looking for co-working buddies!"
        ),
        Trip(
            id: "trip-2",
            userId: "user-2",
            city: "Lisbon",
            country: "Portugal",
            countryCode: "PT",
            countryFlag: "🇵🇹",
            startDate: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
            endDate: Calendar.current.date(byAdding: .day, value: 18, to: Date())!,
            notes: "Exploring Sintra & surf spots in Ericeira on weekends."
        ),
        Trip(
            id: "trip-3",
            userId: "user-3",
            city: "Canggu",
            country: "Indonesia",
            countryCode: "ID",
            countryFlag: "🇮🇩",
            startDate: Calendar.current.date(byAdding: .day, value: -10, to: Date())!,
            endDate: Calendar.current.date(byAdding: .day, value: 40, to: Date())!,
            notes: "Working from Zin Cafe & B2B Coworking."
        )
    ]
}
