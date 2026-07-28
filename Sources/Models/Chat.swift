import Foundation

public enum ChatType: String, Codable {
    case directMessage = "DirectMessage"
    case cityGroup = "CityGroup"
    case meetupGroup = "MeetupGroup"
}

public struct ChatMessage: Identifiable, Codable, Hashable {
    public let id: String
    public let chatRoomId: String
    public let senderId: String
    public let senderName: String
    public let senderAvatarUrl: String?
    public let text: String
    public let imageUrl: String?
    public let createdAt: Date
    
    public init(
        id: String = UUID().uuidString,
        chatRoomId: String,
        senderId: String,
        senderName: String,
        senderAvatarUrl: String? = nil,
        text: String,
        imageUrl: String? = nil,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.chatRoomId = chatRoomId
        self.senderId = senderId
        self.senderName = senderName
        self.senderAvatarUrl = senderAvatarUrl
        self.text = text
        self.imageUrl = imageUrl
        self.createdAt = createdAt
    }
}

public struct ChatRoom: Identifiable, Codable, Hashable {
    public let id: String
    public let type: ChatType
    public let title: String
    public let participantIds: [String]
    public let city: String?
    public let lastMessageText: String?
    public let lastMessageTimestamp: Date?
    public let unreadCount: Int
    
    public init(
        id: String = UUID().uuidString,
        type: ChatType,
        title: String,
        participantIds: [String],
        city: String? = nil,
        lastMessageText: String? = nil,
        lastMessageTimestamp: Date? = nil,
        unreadCount: Int = 0
    ) {
        self.id = id
        self.type = type
        self.title = title
        self.participantIds = participantIds
        self.city = city
        self.lastMessageText = lastMessageText
        self.lastMessageTimestamp = lastMessageTimestamp
        self.unreadCount = unreadCount
    }
}

// Sample Mock Chat Rooms & Messages
public extension ChatRoom {
    static let mockRooms: [ChatRoom] = [
        ChatRoom(
            id: "room-1",
            type: .directMessage,
            title: "Sophia Lin",
            participantIds: ["current-user", "user-1"],
            lastMessageText: "Hey! Are you working from Zin Cafe today?",
            lastMessageTimestamp: Date().addingTimeInterval(-300),
            unreadCount: 1
        ),
        ChatRoom(
            id: "room-2",
            type: .cityGroup,
            title: "🇵🇹 Lisbon Nomads 2026",
            participantIds: ["user-1", "user-2", "current-user"],
            city: "Lisbon",
            lastMessageText: "Marcus: Anyone up for Sintra weekend hike?",
            lastMessageTimestamp: Date().addingTimeInterval(-3600),
            unreadCount: 3
        )
    ]
}
