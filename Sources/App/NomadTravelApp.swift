import SwiftUI

struct NomadTravelApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var authManager = AuthManager()
    @StateObject private var locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environmentObject(authManager)
                .environmentObject(locationManager)
                .preferredColorScheme(.dark)
        }
    }
}



struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        Group {
            if authManager.isAuthenticated {
                StaysMainView()
                    .transition(.asymmetric(
                        insertion: .opacity.combined(with: .scale(scale: 0.95)),
                        removal: .opacity
                    ))
            } else {
                LoginView()
                    .transition(.opacity)
            }
        }
        .animation(NomadSprings.fluidSpring, value: authManager.isAuthenticated)
    }
}
