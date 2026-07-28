#if canImport(UIKit)
import UIKit

public enum NomadHaptics {
    public static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
    
    public static func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    
    public static func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
}
#else
public enum NomadHaptics {
    public enum ImpactStyle { case light, medium, heavy }
    public enum NotificationType { case success, warning, error }
    
    public static func impact(_ style: ImpactStyle = .medium) {}
    public static func selection() {}
    public static func notification(_ type: NotificationType = .success) {}
}
#endif


