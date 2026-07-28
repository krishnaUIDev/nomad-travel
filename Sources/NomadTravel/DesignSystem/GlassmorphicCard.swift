import SwiftUI

/// Ultra-thin frosted glassmorphic card modifier matching Apple VisionOS & iOS 17+ aesthetic
public struct GlassmorphicModifier: ViewModifier {
    var cornerRadius: CGFloat
    var opacity: Double
    var borderWidth: CGFloat
    
    public init(cornerRadius: CGFloat = 24, opacity: Double = 0.85, borderWidth: CGFloat = 1) {
        self.cornerRadius = cornerRadius
        self.opacity = opacity
        self.borderWidth = borderWidth
    }
    
    public func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .background(NomadColors.cardBackground.opacity(opacity))
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.35),
                                Color.white.opacity(0.08),
                                Color.white.opacity(0.02)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: borderWidth
                    )
            )
            .shadow(color: Color.black.opacity(0.35), radius: 16, x: 0, y: 8)
    }
}

public extension View {
    func glassmorphicCard(cornerRadius: CGFloat = 24, opacity: Double = 0.85, borderWidth: CGFloat = 1) -> some View {
        self.modifier(GlassmorphicModifier(cornerRadius: cornerRadius, opacity: opacity, borderWidth: borderWidth))
    }
}
