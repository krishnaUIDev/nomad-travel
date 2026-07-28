import SwiftUI

struct StaysMainView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        ZStack(alignment: .bottom) {
            NomadColors.background
                .ignoresSafeArea()
            
            // Tab Content Switcher
            Group {
                switch appState.selectedTab {
                case .discovery:
                    DiscoveryMainView()
                case .trips:
                    ItineraryListView()
                case .chat:
                    ChatListView()
                case .meetups:
                    MeetupListView()
                case .profile:
                    ProfileView()
                }
            }
            .transition(.opacity)
        }
        .onAppear {
            locationManager.requestLocationPermission()
        }
    }
}
