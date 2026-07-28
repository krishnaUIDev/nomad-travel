import SwiftUI

struct NomadRadarUser: Identifiable {
    let id = UUID()
    let name: String
    let skill: String
    let spotName: String
    let distanceKm: Double
    let avatarUrl: String
    let isAvailableForCoffee: Bool
}

struct NomadRadarView: View {
    @EnvironmentObject var appState: AppState
    @State private var isPulsing: Bool = false
    @State private var nearbyNomads: [NomadRadarUser] = [
        NomadRadarUser(name: "Elena Rostova", skill: "Product Designer", spotName: "Zest Work Cafe", distanceKm: 0.3, avatarUrl: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=80", isAvailableForCoffee: true),
        NomadRadarUser(name: "Marcus Vance", skill: "iOS / Swift Dev", spotName: "B2B Co-Working", distanceKm: 0.7, avatarUrl: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80", isAvailableForCoffee: true),
        NomadRadarUser(name: "Sophia Chen", skill: "AI Researcher", spotName: "Tropical Hub", distanceKm: 1.2, avatarUrl: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80", isAvailableForCoffee: false)
    ]
    
    var body: some View {
        ZStack {
            NomadColors.background.ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("NOMAD RADAR")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(NomadColors.nomadCyan)
                            .tracking(2)
                        Text("Nearby Nomads")
                            .font(.system(size: 26, weight: .heavy))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    
                    // Ghost Mode Toggle Button
                    Button {
                        withAnimation(NomadSprings.snappySpring) {
                            appState.isGhostModeActive.toggle()
                        }
                        NomadHaptics.selection()
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: appState.isGhostModeActive ? "eye.slash.fill" : "location.fill")
                            Text(appState.isGhostModeActive ? "Ghost" : "Visible")
                                .font(.system(size: 13, weight: .bold))
                        }
                        .foregroundColor(appState.isGhostModeActive ? NomadColors.textMuted : NomadColors.wifiGreen)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(appState.isGhostModeActive ? Color.white.opacity(0.1) : NomadColors.wifiGreen.opacity(0.15))
                        .cornerRadius(16)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(appState.isGhostModeActive ? NomadColors.glassBorder : NomadColors.wifiGreen.opacity(0.3), lineWidth: 1))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 54)
                
                // Animated Pulsing Radar Scanner
                ZStack {
                    Circle()
                        .stroke(NomadColors.nomadCyan.opacity(0.2), lineWidth: 1)
                        .frame(width: 220, height: 220)
                        .scaleEffect(isPulsing ? 1.25 : 0.95)
                        .opacity(isPulsing ? 0.0 : 0.8)
                    
                    Circle()
                        .stroke(NomadColors.nomadCyan.opacity(0.4), lineWidth: 1)
                        .frame(width: 150, height: 150)
                    
                    ZStack {
                        Circle()
                            .fill(NomadColors.nomadCyan.opacity(0.2))
                            .frame(width: 70, height: 70)
                        
                        Image(systemName: "antenna.radiowaves.left.and.right")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(NomadColors.nomadCyan)
                    }
                }
                .frame(height: 180)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 2.2).repeatForever(autoreverses: false)) {
                        isPulsing = true
                    }
                }
                
                // Active Nearby Nomads Feed
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 14) {
                        ForEach(nearbyNomads) { nomad in
                            HStack(spacing: 14) {
                                AsyncImage(url: URL(string: nomad.avatarUrl)) { phase in
                                    switch phase {
                                    case .success(let img):
                                        img.resizable().aspectRatio(contentMode: .fill)
                                    default:
                                        Circle().fill(Color.gray)
                                    }
                                }
                                .frame(width: 52, height: 52)
                                .clipShape(Circle())
                                
                                VStack(alignment: .leading, spacing: 3) {
                                    HStack {
                                        Text(nomad.name)
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(.white)
                                        Spacer()
                                        Text(String(format: "%.1f km", nomad.distanceKm))
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundColor(NomadColors.textMuted)
                                    }
                                    
                                    Text("\(nomad.skill) • \(nomad.spotName)")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(NomadColors.textSecondary)
                                }
                                
                                Button {
                                    NomadHaptics.notification(.success)
                                } label: {
                                    Image(systemName: "cup.and.saucer.fill")
                                        .font(.system(size: 14))
                                        .foregroundColor(.black)
                                        .padding(10)
                                        .background(NomadColors.nomadCyan)
                                        .clipShape(Circle())
                                }
                            }
                            .padding(16)
                            .glassmorphicCard(cornerRadius: 20)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 120)
                }
            }
        }
    }
}
