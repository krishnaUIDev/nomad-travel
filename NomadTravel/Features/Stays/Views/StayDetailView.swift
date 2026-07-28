import SwiftUI

struct StayDetailView: View {
    let stay: Stay
    let onDismiss: () -> Void
    
    @State private var dragOffset: CGFloat = 0
    @State private var isSpeedTestRunning: Bool = false
    @State private var simulatedSpeedMbps: Double = 0.0
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            NomadColors.background
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    // Parallax Hero Image Container
                    ZStack(alignment: .bottomLeading) {
                        AsyncImage(url: URL(string: stay.heroImageUrl)) { phase in
                            switch phase {
                            case .success(let img):
                                img.resizable().aspectRatio(contentMode: .fill)
                            default:
                                Rectangle().fill(NomadColors.cardBackground)
                            }
                        }
                        .frame(height: 380)
                        .clipped()
                        
                        LinearGradient(
                            colors: [Color.clear, NomadColors.background],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 140)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(stay.locationName.uppercased())
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(NomadColors.nomadCyan)
                                Spacer()
                                HStack(spacing: 4) {
                                    Image(systemName: "star.fill").foregroundColor(.yellow)
                                    Text(String(format: "%.2f", stay.rating))
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(.white)
                                }
                            }
                            
                            Text(stay.title)
                                .font(.system(size: 26, weight: .heavy))
                                .foregroundColor(.white)
                        }
                        .padding(20)
                    }
                    
                    VStack(alignment: .leading, spacing: 24) {
                        // Wifi Speed Meter Interactive Widget
                        VStack(alignment: .leading, spacing: 14) {
                            HStack {
                                Image(systemName: "wifi.circle.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(NomadColors.wifiGreen)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Verified High-Speed Connection")
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(.white)
                                    Text("Host tested via Ookla Speedtest")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(NomadColors.textSecondary)
                                }
                                Spacer()
                                
                                Button {
                                    runSpeedTest()
                                } label: {
                                    Text(isSpeedTestRunning ? "Testing..." : "Test Speed")
                                        .font(.system(size: 13, weight: .bold))
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 8)
                                        .background(NomadColors.wifiGreen)
                                        .cornerRadius(12)
                                }
                            }
                            
                            // Live Gauge Bar
                            ZStack(alignment: .leading) {
                                Capsule().fill(Color.white.opacity(0.1)).frame(height: 12)
                                Capsule()
                                    .fill(NomadColors.wifiGreen)
                                    .frame(width: isSpeedTestRunning ? CGFloat(simulatedSpeedMbps / 600.0) * 300 : CGFloat(Double(stay.wifiSpeedMbps) / 600.0) * 300, height: 12)
                            }
                            
                            HStack {
                                Text("\(isSpeedTestRunning ? Int(simulatedSpeedMbps) : stay.wifiSpeedMbps) Mbps Download")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(NomadColors.wifiGreen)
                                Spacer()
                                Text("Ping: 12 ms")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(NomadColors.textMuted)
                            }
                        }
                        .padding(20)
                        .background(NomadColors.cardBackground)
                        .cornerRadius(20)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(NomadColors.glassBorder, lineWidth: 1))
                        
                        // Workspace Amenities Grid
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Nomad Work Features")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                            
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                                AmenityBadge(icon: "chair.lounge.fill", text: "Herman Miller Chair")
                                AmenityBadge(icon: "display", text: "4K 32\" Monitor")
                                AmenityBadge(icon: "powerplug.fill", text: "240V Power Strips")
                                AmenityBadge(icon: "building.2.crop.circle", text: "24/7 Co-working Access")
                            }
                        }
                        
                        // Host Profile Callout
                        HStack(spacing: 16) {
                            AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80")) { phase in
                                switch phase {
                                case .success(let image):
                                    image.resizable().aspectRatio(contentMode: .fill)
                                default:
                                    Circle().fill(Color.gray)
                                }
                            }

                            .frame(width: 54, height: 54)
                            .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Hosted by \(stay.hostName)")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                Text("Digital Nomad Host • 4.9★ Rating")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(NomadColors.textSecondary)
                            }
                        }
                        .padding(16)
                        .background(Color.white.opacity(0.04))
                        .cornerRadius(16)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 120)
                }
            }
            .offset(y: max(0, dragOffset))
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.height > 0 {
                            dragOffset = value.translation.height
                        }
                    }
                    .onEnded { value in
                        if value.translation.height > 120 {
                            onDismiss()
                        } else {
                            withAnimation(NomadSprings.fluidSpring) {
                                dragOffset = 0
                            }
                        }
                    }
            )
            
            // Top Floating Close Button
            Button {
                onDismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Color.black.opacity(0.6))
                    .clipShape(Circle())
                    .overlay(Circle().stroke(NomadColors.glassBorder, lineWidth: 1))
            }
            .padding(.top, 54)
            .padding(.leading, 20)
            
            // Bottom Sticky Reserve Bar
            VStack {
                Spacer()
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text("$\(Int(stay.pricePerNightUSD))")
                                .font(.system(size: 22, weight: .heavy, design: .rounded))
                                .foregroundColor(.white)
                            Text("/ night")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(NomadColors.textSecondary)
                        }
                        Text("$\(Int(stay.pricePerMonthUSD)) / month rate")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(NomadColors.wifiGreen)
                    }
                    Spacer()
                    
                    Button {
                        NomadHaptics.notification(.success)
                    } label: {
                        Text("Reserve Stay")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 28)
                            .padding(.vertical, 16)
                            .background(NomadColors.primaryCoral)
                            .cornerRadius(16)
                            .shadow(color: NomadColors.primaryCoral.opacity(0.4), radius: 12, x: 0, y: 6)
                    }
                }
                .padding(20)
                .background(NomadColors.cardBackground.opacity(0.95))
                .overlay(Rectangle().frame(height: 1).foregroundColor(NomadColors.glassBorder), alignment: .top)
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
    
    private func runSpeedTest() {
        isSpeedTestRunning = true
        NomadHaptics.impact(.medium)
        simulatedSpeedMbps = 10.0
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if simulatedSpeedMbps < Double(stay.wifiSpeedMbps) {
                simulatedSpeedMbps += Double.random(in: 15...35)
            } else {
                timer.invalidate()
                isSpeedTestRunning = false
                NomadHaptics.notification(.success)
            }
        }
    }
}

struct AmenityBadge: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundColor(NomadColors.nomadCyan)
            Text(text)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.white)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.05))
        .cornerRadius(12)
    }
}
