import SwiftUI

struct StayCardView: View {
    let stay: Stay
    let onTap: () -> Void
    @State private var isHoveredOrPressed: Bool = false
    
    var body: some View {
        Button {
            onTap()
        } label: {
            VStack(alignment: .leading, spacing: 14) {
                // Hero Image Carousel Container with Badge Overlay
                ZStack(alignment: .topTrailing) {
                    AsyncImage(url: URL(string: stay.heroImageUrl)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 230)
                                .clipped()
                        case .failure, .empty:
                            Rectangle()
                                .fill(NomadColors.cardBackground)
                                .frame(height: 230)
                                .overlay(
                                    Image(systemName: "photo")
                                        .foregroundColor(NomadColors.textMuted)
                                )
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .cornerRadius(20)
                    
                    // Top Badges (Wifi Speed & Superhost)
                    HStack(spacing: 8) {
                        HStack(spacing: 4) {
                            Image(systemName: "wifi")
                                .font(.system(size: 11, weight: .bold))
                            Text("\(stay.wifiSpeedMbps) Mbps")
                                .font(.system(size: 12, weight: .bold))
                        }
                        .foregroundColor(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(NomadColors.wifiGreen)
                        .cornerRadius(12)
                        .shadow(color: NomadColors.wifiGreen.opacity(0.4), radius: 8, x: 0, y: 4)
                        
                        if stay.isSuperhost {
                            Text("SUPERHOST")
                                .font(.system(size: 10, weight: .black))
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 6)
                                .background(Color.black.opacity(0.65))
                                .cornerRadius(10)
                        }
                    }
                    .padding(14)
                }
                
                // Listing Metadata
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(stay.locationName)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(NomadColors.nomadCyan)
                            .textCase(.uppercase)
                            .tracking(1)
                        
                        Spacer()
                        
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 12))
                                .foregroundColor(.yellow)
                            Text(String(format: "%.2f (%d)", stay.rating, stay.reviewCount))
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(NomadColors.textPrimary)
                        }
                    }
                    
                    Text(stay.title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(NomadColors.textPrimary)
                        .lineLimit(1)
                    
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("$\(Int(stay.pricePerNightUSD))")
                            .font(.system(size: 20, weight: .heavy, design: .rounded))
                            .foregroundColor(NomadColors.textPrimary)
                        Text("/ night")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(NomadColors.textSecondary)
                        
                        Spacer()
                        
                        Text("$\(Int(stay.pricePerMonthUSD))/mo")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(NomadColors.primaryCoral)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(NomadColors.primaryCoral.opacity(0.12))
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 4)
            }
            .padding(12)
            .background(NomadColors.cardBackground)
            .cornerRadius(24)
            .overlay(RoundedRectangle(cornerRadius: 24).stroke(NomadColors.glassBorder, lineWidth: 1))
            .scaleEffect(isHoveredOrPressed ? 0.98 : 1.0)
            .shadow(color: Color.black.opacity(0.3), radius: 12, x: 0, y: 6)
        }
        .buttonStyle(PlainButtonStyle())
        .animation(NomadSprings.snappySpring, value: isHoveredOrPressed)
    }
}
