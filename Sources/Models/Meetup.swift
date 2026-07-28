import Foundation

public enum MeetupCategory: String, Codable, CaseIterable {
    case coworking = "Co-Working"
    case coffee = "Coffee Run"
    case dinner = "Dinner & Drinks"
    case outdoor = "Outdoor / Hike"
    case workshop = "Skill Share"
    
    public var iconName: String {
        switch self {
        case .coworking: return "laptopcomputer"
        case .coffee: return "cup.and.saucer.fill"
        case .dinner: return "wineglass.fill"
        case .outdoor: return "figure.hiking"
        case .workshop: return "lightbulb.fill"
        }
    }
}

public struct Meetup: Identifiable, Codable, Hashable {
    public let id: String
    public let hostUserId: String
    public let hostName: String
    public let hostAvatarUrl: String?
    public let title: String
    public let description: String
    public let category: MeetupCategory
    public let city: String
    public let locationName: String
    public let latitude: Double
    public let longitude: Double
    public let eventDate: Date
    public var rsvpUserIds: [String]
    public let maxAttendees: Int
    public let icebreakerPrompt: String
    public let createdAt: Date
    
    public init(
        id: String = UUID().uuidString,
        hostUserId: String,
        hostName: String,
        hostAvatarUrl: String? = nil,
        title: String,
        description: String,
        category: MeetupCategory,
        city: String,
        locationName: String,
        latitude: Double,
        longitude: Double,
        eventDate: Date,
        rsvpUserIds: [String] = [],
        maxAttendees: Int = 10,
        icebreakerPrompt: String = "What was the most unexpected place you've ever worked from?",
        createdAt: Date = Date()
    ) {
        self.id = id
        self.hostUserId = hostUserId
        self.hostName = hostName
        self.hostAvatarUrl = hostAvatarUrl
        self.title = title
        self.description = description
        self.category = category
        self.city = city
        self.locationName = locationName
        self.latitude = latitude
        self.longitude = longitude
        self.eventDate = eventDate
        self.rsvpUserIds = rsvpUserIds
        self.maxAttendees = maxAttendees
        self.icebreakerPrompt = icebreakerPrompt
        self.createdAt = createdAt
    }
}

// Sample Mock Meetups
public extension Meetup {
    static let mockMeetups: [Meetup] = [
        Meetup(
            id: "meetup-1",
            hostUserId: "user-1",
            hostName: "Sophia Lin",
            hostAvatarUrl: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80",
            title: "Focused Deep-Work & Coffee Session",
            description: "2 hours Pomodoro deep work followed by sunset drinks on the terrace.",
            category: .coworking,
            city: "Lisbon",
            locationName: "Zest Work & Artisanal Cafe",
            latitude: 38.7120,
            longitude: -9.1410,
            eventDate: Date().addingTimeInterval(7200),
            rsvpUserIds: ["user-1", "user-2"],
            maxAttendees: 8,
            icebreakerPrompt: "What is your #1 favorite digital nomad hack?"
        ),
        Meetup(
            id: "meetup-2",
            hostUserId: "user-2",
            hostName: "Marcus Vance",
            hostAvatarUrl: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80",
            title: "Sintra Castle Weekend Day Hike",
            description: "Taking the morning train to Sintra. Hiking up to Pena Palace!",
            category: .outdoor,
            city: "Lisbon",
            locationName: "Rossio Station Meeting Point",
            latitude: 38.7140,
            longitude: -9.1400,
            eventDate: Date().addingTimeInterval(86400 * 2),
            rsvpUserIds: ["user-2"],
            maxAttendees: 6,
            icebreakerPrompt: "Which country has been your favorite hike so far?"
        )
    ]
}
