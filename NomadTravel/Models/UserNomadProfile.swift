import Foundation

public struct UserNomadProfile: Identifiable, Codable {
    public let id: String
    public var email: String
    public var displayName: String
    public var avatarUrl: String?
    public var currentCity: String
    public var nationalityCountryCode: String
    public var isGhostMode: Bool
    public var primarySkill: String
    
    public init(
        id: String,
        email: String,
        displayName: String,
        avatarUrl: String? = nil,
        currentCity: String,
        nationalityCountryCode: String,
        isGhostMode: Bool = false,
        primarySkill: String
    ) {
        self.id = id
        self.email = email
        self.displayName = displayName
        self.avatarUrl = avatarUrl
        self.currentCity = currentCity
        self.nationalityCountryCode = nationalityCountryCode
        self.isGhostMode = isGhostMode
        self.primarySkill = primarySkill
    }
}
