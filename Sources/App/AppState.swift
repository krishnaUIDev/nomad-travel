import SwiftUI

public enum NomadTab: String, CaseIterable, Identifiable {
    case discovery = "Discover"
    case trips = "Trips"
    case chat = "Chat"
    case meetups = "Meetups"
    case profile = "Profile"
    
    public var id: String { rawValue }
    
    public var iconName: String {
        switch self {
        case .discovery: return "sparkles.rectangle.stack.fill"
        case .trips: return "airplane.departure"
        case .chat: return "bubble.left.and.bubble.right.fill"
        case .meetups: return "person.3.fill"
        case .profile: return "person.crop.circle.fill"
        }
    }
}

final class AppState: ObservableObject {
    @Published var selectedTab: NomadTab = .discovery
    @Published var selectedUserForDetail: NomadUser? = nil
    @Published var isProfileDetailExpanded: Bool = false
    @Published var isGhostModeActive: Bool = false
    
    func selectUserDetail(_ user: NomadUser) {
        withAnimation(NomadSprings.sharedElementSpring) {
            self.selectedUserForDetail = user
            self.isProfileDetailExpanded = true
        }
        NomadHaptics.impact(.medium)
    }
    
    func dismissUserDetail() {
        withAnimation(NomadSprings.fluidSpring) {
            self.isProfileDetailExpanded = false
            self.selectedUserForDetail = nil
        }
        NomadHaptics.impact(.light)
    }
}
