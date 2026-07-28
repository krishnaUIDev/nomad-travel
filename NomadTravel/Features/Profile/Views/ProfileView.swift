import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            NomadColors.background.ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("NOMAD ID")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(NomadColors.nomadCyan)
                            .tracking(2)
                        Text("Profile & Settings")
                            .font(.system(size: 26, weight: .heavy))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 54)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        // User Identity Header Card
                        VStack(spacing: 14) {
                            AsyncImage(url: URL(string: authManager.currentUser?.avatarUrl ?? "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80")) { phase in
                                switch phase {
                                case .success(let img):
                                    img.resizable().aspectRatio(contentMode: .fill)
                                default:
                                    Circle().fill(NomadColors.cardBackground)
                                }
                            }
                            .frame(width: 86, height: 86)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(NomadColors.primaryCoral, lineWidth: 2))
                            .shadow(color: NomadColors.primaryCoral.opacity(0.3), radius: 12, x: 0, y: 6)
                            
                            VStack(spacing: 4) {
                                Text(authManager.currentUser?.displayName ?? "Alex Rivera")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text(authManager.currentUser?.primarySkill ?? "iOS / Swift Developer")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(NomadColors.nomadCyan)
                            }
                            
                            HStack(spacing: 8) {
                                Label(authManager.currentUser?.currentCity ?? "Canggu, Bali", systemImage: "mappin.and.ellipse")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(NomadColors.textSecondary)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.white.opacity(0.06))
                            .cornerRadius(12)
                        }
                        .padding(24)
                        .frame(maxWidth: .infinity)
                        .glassmorphicCard(cornerRadius: 28)
                        
                        // Settings & Controls Section
                        VStack(spacing: 12) {
                            // Ghost Mode Toggle
                            Toggle(isOn: $appState.isGhostModeActive) {
                                HStack(spacing: 12) {
                                    Image(systemName: "eye.slash.fill")
                                        .foregroundColor(NomadColors.nomadCyan)
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("Ghost Mode")
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundColor(.white)
                                        Text("Hide exact coordinates on Nomad Radar")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(NomadColors.textMuted)
                                    }
                                }
                            }
                            .tint(NomadColors.primaryCoral)
                            .padding(16)
                            .glassmorphicCard(cornerRadius: 18)
                            
                            // Logout Button
                            Button {
                                authManager.logout()
                            } label: {
                                HStack {
                                    Image(systemName: "arrow.right.square.fill")
                                    Text("Sign Out")
                                        .font(.system(size: 15, weight: .bold))
                                }
                                .foregroundColor(NomadColors.primaryCoral)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .glassmorphicCard(cornerRadius: 18)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 120)
                }
            }
        }
    }
}
