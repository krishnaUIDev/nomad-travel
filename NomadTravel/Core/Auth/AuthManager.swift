import Foundation
import LocalAuthentication
import SwiftUI

final class AuthManager: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: UserNomadProfile? = nil
    @Published var authError: String? = nil
    @Published var isBiometricsAvailable: Bool = false
    
    init() {
        checkBiometricsAvailability()
    }
    
    func checkBiometricsAvailability() {
        let context = LAContext()
        var error: NSError?
        self.isBiometricsAvailable = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }
    
    func authenticateWithBiometrics() {
        let context = LAContext()
        let reason = "Unlock Nomad Travel to access your saved spots and stays."
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
            DispatchQueue.main.async {
                if success {
                    self?.completeLogin(email: "nomad.developer@example.com", name: "Alex Rivera")
                    NomadHaptics.notification(.success)
                } else {
                    self?.authError = error?.localizedDescription ?? "Biometric authentication failed."
                    NomadHaptics.notification(.error)
                }
            }
        }
    }
    
    func loginWithEmail(email: String, pass: String) {
        guard !email.isEmpty, pass.count >= 6 else {
            self.authError = "Please enter a valid email and password (min 6 chars)."
            NomadHaptics.notification(.warning)
            return
        }
        
        // Simulating authentication completion
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.completeLogin(email: email, name: email.components(separatedBy: "@").first?.capitalized ?? "Nomad Explorer")
            NomadHaptics.notification(.success)
        }
    }
    
    func loginWithGoogleOAuth() {
        // OAuth completion simulation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.completeLogin(email: "alex.nomad@gmail.com", name: "Alex Rivera")
            NomadHaptics.notification(.success)
        }
    }
    
    private func completeLogin(email: String, name: String) {
        self.currentUser = UserNomadProfile(
            id: UUID().uuidString,
            email: email,
            displayName: name,
            avatarUrl: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80",
            currentCity: "Canggu, Bali",
            nationalityCountryCode: "US",
            isGhostMode: false,
            primarySkill: "iOS / Swift Developer"
        )
        withAnimation(NomadSprings.fluidSpring) {
            self.isAuthenticated = true
        }
    }
    
    func logout() {
        withAnimation(NomadSprings.fluidSpring) {
            self.isAuthenticated = false
            self.currentUser = nil
        }
        NomadHaptics.impact(.medium)
    }
}
