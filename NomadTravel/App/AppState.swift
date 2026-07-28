import SwiftUI
import Combine

enum NomadTab: String, CaseIterable, Identifiable {
    case explore = "Explore"
    case radar = "Nomad Radar"
    case visa = "Visa & Tax"
    case profile = "Profile"
    
    var id: String { rawValue }
    
    var iconName: String {
        switch self {
        case .explore: return "map.fill"
        case .radar: return "antenna.radiowaves.left.and.right"
        case .visa: return "globe.europe.africa.fill"
        case .profile: return "person.crop.circle.fill"
        }
    }
}

final class AppState: ObservableObject {
    @Published var selectedTab: NomadTab = .explore
    @Published var selectedStay: Stay? = nil
    @Published var isDetailExpanded: Bool = false
    @Published var minWifiMbpsFilter: Double = 50.0
    @Published var isGhostModeActive: Bool = false
    
    func selectStay(_ stay: Stay) {
        withAnimation(NomadSprings.sharedElementSpring) {
            self.selectedStay = stay
            self.isDetailExpanded = true
        }
        NomadHaptics.impact(.medium)
    }
    
    func dismissStayDetail() {
        withAnimation(NomadSprings.fluidSpring) {
            self.isDetailExpanded = false
            self.selectedStay = nil
        }
        NomadHaptics.impact(.light)
    }
}
