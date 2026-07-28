import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var email: String = ""
    @State private var pass: String = ""
    @State private var isAnimatingIn: Bool = false
    
    var body: some View {
        ZStack {
            NomadColors.background
                .ignoresSafeArea()
            
            // Background Animated Gradient Orbs
            Circle()
                .fill(NomadColors.primaryCoral.opacity(0.25))
                .blur(radius: 90)
                .offset(x: isAnimatingIn ? -100 : -150, y: isAnimatingIn ? -200 : -250)
            
            Circle()
                .fill(NomadColors.nomadCyan.opacity(0.20))
                .blur(radius: 100)
                .offset(x: isAnimatingIn ? 120 : 180, y: isAnimatingIn ? 250 : 300)
            
            VStack(spacing: 28) {
                Spacer()
                
                // Header Logo & Branding
                VStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(NomadColors.glassLinearGradient)
                            .frame(width: 84, height: 84)
                            .overlay(Circle().stroke(NomadColors.glassBorder, lineWidth: 1))
                        
                        Image(systemName: "airplane.circle.fill")
                            .font(.system(size: 48, weight: .bold))
                            .foregroundStyle(
                                LinearGradient(colors: [NomadColors.primaryCoral, NomadColors.nomadCyan], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                    }
                    .shadow(color: NomadColors.primaryCoral.opacity(0.3), radius: 16, x: 0, y: 8)
                    
                    Text("NOMAD TRAVEL")
                        .font(.system(size: 28, weight: .black, design: .rounded))
                        .foregroundColor(NomadColors.textPrimary)
                        .tracking(3)
                    
                    Text("Work & explore anywhere with 120Hz fluidity")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(NomadColors.textSecondary)
                }
                .scaleEffect(isAnimatingIn ? 1.0 : 0.9)
                .opacity(isAnimatingIn ? 1.0 : 0.0)
                
                Spacer()
                
                // Glassmorphic Card Login Form
                VStack(spacing: 18) {
                    if let errorMsg = authManager.authError {
                        Text(errorMsg)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(NomadColors.primaryCoral)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    
                    // Input Fields
                    VStack(spacing: 14) {
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(NomadColors.textMuted)
                            #if os(iOS)
                            TextField("Email address", text: $email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .foregroundColor(NomadColors.textPrimary)
                            #else
                            TextField("Email address", text: $email)
                                .foregroundColor(NomadColors.textPrimary)
                            #endif
                        }

                        .padding()
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(14)
                        .overlay(RoundedRectangle(cornerRadius: 14).stroke(NomadColors.glassBorder, lineWidth: 1))
                        
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(NomadColors.textMuted)
                            SecureField("Password", text: $pass)
                                .foregroundColor(NomadColors.textPrimary)
                        }
                        .padding()
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(14)
                        .overlay(RoundedRectangle(cornerRadius: 14).stroke(NomadColors.glassBorder, lineWidth: 1))
                    }
                    
                    // Email Login Action Button
                    Button {
                        authManager.loginWithEmail(email: email, pass: pass)
                    } label: {
                        Text("Sign In")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(NomadColors.primaryCoral)
                            .cornerRadius(14)
                            .shadow(color: NomadColors.primaryCoral.opacity(0.4), radius: 12, x: 0, y: 6)
                    }
                    
                    // Biometric Unlock Button (Face ID / Touch ID)
                    if authManager.isBiometricsAvailable {
                        Button {
                            authManager.authenticateWithBiometrics()
                        } label: {
                            HStack(spacing: 10) {
                                Image(systemName: "faceid")
                                    .font(.system(size: 20))
                                Text("Quick Unlock with Face ID")
                                    .font(.system(size: 15, weight: .semibold))
                            }
                            .foregroundColor(NomadColors.nomadCyan)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(NomadColors.nomadCyan.opacity(0.12))
                            .cornerRadius(14)
                            .overlay(RoundedRectangle(cornerRadius: 14).stroke(NomadColors.nomadCyan.opacity(0.3), lineWidth: 1))
                        }
                    }
                    
                    // Divider
                    HStack {
                        Rectangle().frame(height: 1).foregroundColor(NomadColors.glassBorder)
                        Text("OR")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(NomadColors.textMuted)
                        Rectangle().frame(height: 1).foregroundColor(NomadColors.glassBorder)
                    }
                    .padding(.vertical, 4)
                    
                    // Social OAuth Button
                    Button {
                        authManager.loginWithGoogleOAuth()
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "g.circle.fill")
                                .font(.system(size: 20))
                            Text("Continue with Google")
                                .font(.system(size: 15, weight: .semibold))
                        }
                        .foregroundColor(NomadColors.textPrimary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.white.opacity(0.08))
                        .cornerRadius(14)
                        .overlay(RoundedRectangle(cornerRadius: 14).stroke(NomadColors.glassBorder, lineWidth: 1))
                    }
                }
                .padding(24)
                .background(NomadColors.cardBackground.opacity(0.85))
                .cornerRadius(28)
                .overlay(RoundedRectangle(cornerRadius: 28).stroke(NomadColors.glassBorder, lineWidth: 1.5))
                .padding(.horizontal, 20)
                .offset(y: isAnimatingIn ? 0 : 40)
                .opacity(isAnimatingIn ? 1.0 : 0.0)
                
                Spacer()
            }
        }
        .onAppear {
            withAnimation(NomadSprings.fluidSpring) {
                isAnimatingIn = true
            }
        }
    }
}
