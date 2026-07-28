import SwiftUI
import MapKit

struct StaysMainView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var locationManager: LocationManager
    
    @State private var stays: [Stay] = Stay.mockStays
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -8.6478, longitude: 115.1385), // Canggu, Bali
            span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
        )
    )
    @State private var selectedFilterWifi: Double = 100.0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            NomadColors.background
                .ignoresSafeArea()
            
            // Tab Content Switcher
            Group {
                switch appState.selectedTab {
                case .explore:
                    exploreMapView
                case .radar:
                    NomadRadarView()
                case .visa:
                    VisaTrackerView()
                case .profile:
                    ProfileView()
                }
            }
            .transition(.opacity)
            
            // Custom Floating Nomad Glass Tab Bar
            CustomNomadTabBar()
                .padding(.bottom, 24)
            
            // Full Screen Expandable Detail Overlay
            if appState.isDetailExpanded, let stay = appState.selectedStay {
                StayDetailView(stay: stay) {
                    appState.dismissStayDetail()
                }
                .transition(.asymmetric(
                    insertion: .opacity.combined(with: .scale(scale: 0.96)),
                    removal: .opacity.combined(with: .scale(scale: 0.96))
                ))
                .zIndex(10)
            }
        }
        .onAppear {
            locationManager.requestLocationPermission()
        }
    }
    
    // Main Explore Map View
    private var exploreMapView: some View {
        ZStack(alignment: .bottom) {
            Map(position: $cameraPosition) {
                ForEach(stays) { stay in
                    Annotation(stay.title, coordinate: CLLocationCoordinate2D(latitude: stay.latitude, longitude: stay.longitude)) {
                        Button {
                            appState.selectStay(stay)
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "wifi")
                                    .font(.system(size: 10, weight: .bold))
                                Text("$\(Int(stay.pricePerNightUSD))")
                                    .font(.system(size: 13, weight: .black, design: .rounded))
                            }
                            .foregroundColor(.black)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(NomadColors.wifiGreen)
                            .cornerRadius(14)
                            .shadow(color: NomadColors.wifiGreen.opacity(0.4), radius: 8, x: 0, y: 4)
                            .scaleEffect(appState.selectedStay?.id == stay.id ? 1.2 : 1.0)
                        }
                    }
                }
            }
            .ignoresSafeArea()

            
            VStack(spacing: 0) {
                // Top Floating Search Header (Airbnb Style)
                HStack(spacing: 12) {
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(NomadColors.primaryCoral)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Where to next?")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                            Text("\(locationManager.currentCityName) • Any week • >\(Int(selectedFilterWifi)) Mbps")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(NomadColors.textSecondary)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .glassmorphicCard(cornerRadius: 24)
                    
                    Button {
                        NomadHaptics.selection()
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding(14)
                            .glassmorphicCard(cornerRadius: 24)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 54)
                
                Spacer()
                
                // Listing Carousel Feed
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        Capsule()
                            .fill(Color.white.opacity(0.3))
                            .frame(width: 40, height: 5)
                            .padding(.top, 10)
                        
                        HStack {
                            Text("Featured Co-Living Stays")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                            Spacer()
                            Text("\(stays.count) available")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(NomadColors.textMuted)
                        }
                        .padding(.horizontal, 20)
                        
                        ForEach(stays) { stay in
                            StayCardView(stay: stay) {
                                appState.selectStay(stay)
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.bottom, 110)
                }
                .frame(maxHeight: 460)
                .background(NomadColors.background.opacity(0.92))
                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 32, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 32))
                .shadow(color: Color.black.opacity(0.5), radius: 20, x: 0, y: -10)
            }
        }
    }
}

// Custom Glass Tab Bar View
struct CustomNomadTabBar: View {
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

#Preview("Stays Main View") {
    StaysMainView()
        .environmentObject(AppState())
        .environmentObject(AuthManager())
        .environmentObject(LocationManager())
        .preferredColorScheme(.dark)
}

