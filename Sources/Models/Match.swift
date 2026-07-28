import Foundation

public enum MatchAction: String, Codable {
    case pass = "Pass"
    case like = "Like"
    case superLike = "SuperLike"
}

public struct Match: Identifiable, Codable, Hashable {
    public let id: String
    public let fromUserId: String
    public let toUserId: String
    public let action: MatchAction
    public let isMutual: Bool
    public let overlappingCity: String?
    public let overlapDays: Int
    public let createdAt: Date
    
    public init(
        id: String = UUID().uuidString,
        fromUserId: String,
        toUserId: String,
        action: MatchAction,
        isMutual: Bool = false,
        overlappingCity: String? = nil,
        overlapDays: Int = 0,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.fromUserId = fromUserId
        self.toUserId = toUserId
        self.action = action
        self.isMutual = isMutual
        self.overlappingCity = overlappingCity
        self.overlapDays = overlapDays
        self.createdAt = createdAt
    }
}
