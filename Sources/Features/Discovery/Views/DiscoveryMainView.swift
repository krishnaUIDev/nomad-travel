import SwiftUI
import MapKit

enum DiscoveryMode: String, CaseIterable {
    case swipe = "Swipe Cards"
    case map = "Nearby Map"
}

struct DiscoveryMainView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var locationManager: LocationManager
    
    @State private var mode: DiscoveryMode = .swipe
    @State private var users: [NomadUser] = NomadUser.mockUsers
    @State private var topCardIndex: Int = 0
    @State private var cardDragOffset: CGSize = .zero
    
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 38.7167, longitude: -9.1333), // Lisbon
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )
    
    var body: some View {
        ZStack(alignment: .bottom) {
            NomadColors.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Header with Segment Selector & Filter Button
                HStack(spacing: 12) {
                    // Mode Picker (Cards vs Map)
                    HStack(spacing: 4) {
                        ForEach(DiscoveryMode.allCases, id: \.self) { m in
                            Button {
                                withAnimation(NomadSprings.snappySpring) {
                                    self.mode = m
                                }
                                NomadHaptics.selection()
                            } label: {
                                Text(m.rawValue)
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(mode == m ? .white : NomadColors.textMuted)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 8)
                                    .background(mode == m ? NomadColors.primaryCoral : Color.clear)
                                    .cornerRadius(16)
                            }
                        }
                    }
                    .padding(4)
                    .glassmorphicCard(cornerRadius: 20)
                    
                    Spacer()
                    
                    // Filter Pill Button
                    Button {
                        NomadHaptics.selection()
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .font(.system(size: 22))
                            .foregroundColor(NomadColors.nomadCyan)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 54)
                .padding(.bottom, 12)
                
                // Content View (Swipe Stack vs Fuzzed Map)
                ZStack {
                    if mode == .swipe {
                        swipeCardStack
                    } else {
                        fuzzedMapView
                    }
                }
                .frame(maxHeight: .infinity)
            }
            
            // Custom Glass Tab Bar
            CustomSocialTabBar()
                .padding(.bottom, 24)
        }
    }
    
    // Tinder-Style Swipeable Card Stack View
    private var swipeCardStack: some View {
        VStack(spacing: 20) {
            ZStack {
                if topCardIndex < users.count {
                    ForEach(Array(users.enumerated().reversed()), id: \.element.id) { index, user in
                        if index >= topCardIndex && index < topCardIndex + 2 {
                            TravelerCardView(user: user)
                                .offset(x: index == topCardIndex ? cardDragOffset.width : 0, y: index == topCardIndex ? cardDragOffset.height : CGFloat((index - topCardIndex) * 12))
                                .scaleEffect(index == topCardIndex ? 1.0 : 0.95)
                                .rotationEffect(.degrees(index == topCardIndex ? Double(cardDragOffset.width / 18.0) : 0))
                                .gesture(
                                    index == topCardIndex ?
                                    DragGesture()
                                        .onChanged { gesture in
                                            cardDragOffset = gesture.translation
                                        }
                                        .onEnded { gesture in
                                            if gesture.translation.width > 120 {
                                                swipeCard(liked: true)
                                            } else if gesture.translation.width < -120 {
                                                swipeCard(liked: false)
                                            } else {
                                                withAnimation(NomadSprings.fluidSpring) {
                                                    cardDragOffset = .zero
                                                }
                                            }
                                        }
                                    : nil
                                )
                        }
                    }
                } else {
                    // Empty State when all cards swiped
                    VStack(spacing: 16) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 48))
                            .foregroundColor(NomadColors.nomadCyan)
                        Text("You're all caught up!")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        Text("Check back soon for new travelers arriving in your city.")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(NomadColors.textSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                        
                        Button {
                            withAnimation(NomadSprings.snappySpring) {
                                topCardIndex = 0
                            }
                        } label: {
                            Text("Reset Discovery Stack")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.black)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(NomadColors.nomadCyan)
                                .cornerRadius(14)
                        }
                    }
                    .padding(32)
                    .glassmorphicCard(cornerRadius: 28)
                }
            }
            .padding(.horizontal, 20)
            
            // Bottom Action Controls (Pass, SuperLike, Like)
            if topCardIndex < users.count {
                HStack(spacing: 28) {
                    // Pass Button ❌
                    Button {
                        swipeCard(liked: false)
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(NomadColors.primaryCoral)
                            .frame(width: 60, height: 60)
                            .glassmorphicCard(cornerRadius: 30)
                    }
                    
                    // Super Like Button ⭐️
                    Button {
                        swipeCard(liked: true)
                    } label: {
                        Image(systemName: "star.fill")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(NomadColors.nomadCyan)
                            .frame(width: 50, height: 50)
                            .glassmorphicCard(cornerRadius: 25)
                    }
                    
                    // Like Button ❤️
                    Button {
                        swipeCard(liked: true)
                    } label: {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(NomadColors.wifiGreen)
                            .frame(width: 60, height: 60)
                            .glassmorphicCard(cornerRadius: 30)
                    }
                }
                .padding(.bottom, 100)
            }
        }
    }
    
    // Location Fuzzed Nearby Map View (~2km Privacy Mask)
    private var fuzzedMapView: some View {
        ZStack(alignment: .bottom) {
            Map(position: $cameraPosition) {
                ForEach(users) { user in
                    Annotation(user.displayName, coordinate: CLLocationCoordinate2D(latitude: user.latitude + 0.005, longitude: user.longitude - 0.003)) {
                        VStack(spacing: 4) {
                            AsyncImage(url: URL(string: user.profilePhotos.first ?? "")) { phase in
                                switch phase {
                                case .success(let img):
                                    img.resizable().aspectRatio(contentMode: .fill)
                                default:
                                    Circle().fill(Color.gray)
                                }
                            }
                            .frame(width: 44, height: 44)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(NomadColors.nomadCyan, lineWidth: 2))
                            .shadow(color: NomadColors.nomadCyan.opacity(0.4), radius: 8, x: 0, y: 4)
                            
                            Text("~2km away")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.black.opacity(0.75))
                                .cornerRadius(8)
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .padding(.bottom, 90)
        }
    }
    
    private func swipeCard(liked: Bool) {
        withAnimation(NomadSprings.interactiveDismiss(velocity: 1500)) {
            cardDragOffset = CGSize(width: liked ? 500 : -500, height: 0)
        }
        NomadHaptics.impact(liked ? .medium : .light)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            topCardIndex += 1
            cardDragOffset = .zero
        }
    }
}

// Traveler Discovery Card View
struct TravelerCardView: View {
    let user: NomadUser
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Photo Header
            AsyncImage(url: URL(string: user.profilePhotos.first ?? "")) { phase in
                switch phase {
                case .success(let img):
                    img.resizable().aspectRatio(contentMode: .fill)
                default:
                    Rectangle().fill(NomadColors.cardBackground)
                }
            }
            .frame(height: 500)
            .clipped()
            
            // Gradient Overlay
            LinearGradient(
                colors: [Color.clear, Color.black.opacity(0.95)],
                startPoint: .center,
                endPoint: .bottom
            )
            
            // Profile Info Overlay
            VStack(alignment: .leading, spacing: 10) {
                // Crossing Paths / Date Overlap Pill Badge
                HStack(spacing: 6) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 11, weight: .bold))
                    Text("Crossing Paths in \(user.currentCity) • 16 Days Overlap")
                        .font(.system(size: 12, weight: .bold))
                }
                .foregroundColor(.black)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(NomadColors.wifiGreen)
                .cornerRadius(14)
                
                HStack(alignment: .firstTextBaseline) {
                    Text(user.displayName)
                        .font(.system(size: 26, weight: .heavy))
                        .foregroundColor(.white)
                    Text(user.homeCountryFlag)
                        .font(.system(size: 20))
                    
                    Spacer()
                    
                    Text("\(user.trustScore)% Trust")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(NomadColors.nomadCyan)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(NomadColors.nomadCyan.opacity(0.15))
                        .cornerRadius(8)
                }
                
                Text("\(user.profession) • \(user.homeCountry)")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(NomadColors.textSecondary)
                
                Text(user.bio)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(NomadColors.textPrimary)
                    .lineLimit(2)
                
                // Travel Style Tags
                HStack(spacing: 6) {
                    ForEach(user.travelStyles) { style in
                        HStack(spacing: 4) {
                            Image(systemName: style.iconName)
                                .font(.system(size: 10))
                            Text(style.rawValue)
                                .font(.system(size: 11, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(10)
                    }
                }
            }
            .padding(20)
        }
        .frame(height: 500)
        .cornerRadius(28)
        .overlay(RoundedRectangle(cornerRadius: 28).stroke(NomadColors.glassBorder, lineWidth: 1))
        .shadow(color: Color.black.opacity(0.4), radius: 16, x: 0, y: 8)
    }
}

// Custom Social Tab Bar View
struct CustomSocialTabBar: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(NomadTab.allCases) { tab in
                Button {
                    withAnimation(NomadSprings.snappySpring) {
                        appState.selectedTab = tab
                    }
                    NomadHaptics.selection()
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.iconName)
                            .font(.system(size: 18, weight: appState.selectedTab == tab ? .bold : .medium))
                        Text(tab.rawValue)
                            .font(.system(size: 11, weight: appState.selectedTab == tab ? .bold : .regular))
                    }
                    .foregroundColor(appState.selectedTab == tab ? NomadColors.primaryCoral : NomadColors.textMuted)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 4)
        .glassmorphicCard(cornerRadius: 32)
        .padding(.horizontal, 24)
    }
}

#Preview("Social Discovery Stack") {
    DiscoveryMainView()
        .environmentObject(AppState())
        .environmentObject(LocationManager())
        .preferredColorScheme(.dark)
}


