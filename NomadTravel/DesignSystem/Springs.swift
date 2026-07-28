import SwiftUI

/// Physics-based spring presets tailored for 120Hz ProMotion displays (Airbnb grade fluidity)
public enum NomadSprings {
    /// Fluid, natural motion for card morphing & page transitions
    public static let fluidSpring = Animation.spring(response: 0.38, dampingFraction: 0.82, blendDuration: 0)
    
    /// Snappy feedback for button presses, micro-interactions & detent snaps
    public static let snappySpring = Animation.spring(response: 0.26, dampingFraction: 0.72, blendDuration: 0)
    
    /// Bouncy spring for location radar pulses and map pin drop
    public static let bouncySpring = Animation.spring(response: 0.45, dampingFraction: 0.62, blendDuration: 0)
    
    /// Smooth shared-element expansion spring
    public static let sharedElementSpring = Animation.interpolatingSpring(stiffness: 300, damping: 24)
    
    /// Velocity-preserving interactive dismiss gesture spring
    public static func interactiveDismiss(velocity: CGFloat) -> Animation {
        let damping = max(0.6, min(0.9, 0.85 - Double(abs(velocity) / 3000.0)))
        return Animation.spring(response: 0.32, dampingFraction: damping, blendDuration: 0)
    }
}
