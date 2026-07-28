import SwiftUI

struct NomadVisaInfo: Identifiable {
    let id = UUID()
    let countryName: String
    let countryCode: String
    let stayDuration: String
    let minIncomeUSD: String
    let taxPerk: String
    let flagEmoji: String
}

struct VisaTrackerView: View {
    @State private var daysUsedInSchengen: Int = 42
    private let totalSchengenAllowance: Int = 90
    
    @State private var popularVisas: [NomadVisaInfo] = [
        NomadVisaInfo(countryName: "Spain", countryCode: "ES", stayDuration: "1 - 3 Years", minIncomeUSD: "$2,600 / mo", taxPerk: "Beckham Law (15% Tax)", flagEmoji: "🇪🇸"),
        NomadVisaInfo(countryName: "Portugal D8", countryCode: "PT", stayDuration: "1 - 2 Years", minIncomeUSD: "$3,400 / mo", taxPerk: "NHR Tax Regime", flagEmoji: "🇵🇹"),
        NomadVisaInfo(countryName: "Indonesia (E33G)", countryCode: "ID", stayDuration: "1 - 5 Years", minIncomeUSD: "$60,000 / yr", taxPerk: "0% Foreign Income Tax", flagEmoji: "🇮🇩"),
        NomadVisaInfo(countryName: "Croatia", countryCode: "HR", stayDuration: "1 Year", minIncomeUSD: "$2,700 / mo", taxPerk: "Exempt from Local Income Tax", flagEmoji: "🇭🇷")
    ]
    
    var body: some View {
        ZStack {
            NomadColors.background.ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("PASSPORT & TAX")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(NomadColors.primaryCoral)
                            .tracking(2)
                        Text("Visa & Stay Tracker")
                            .font(.system(size: 26, weight: .heavy))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 54)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        // Schengen 90/180 Tracker Gauge Card
                        VStack(spacing: 16) {
                            HStack {
                                Image(systemName: "globe.europe.africa.fill")
                                    .foregroundColor(NomadColors.primaryCoral)
                                Text("Schengen Zone 90/180 Counter")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                Spacer()
                                Text("48 Days Left")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(NomadColors.wifiGreen)
                            }
                            
                            // Visual Progress Arc
                            ZStack {
                                Circle()
                                    .stroke(Color.white.opacity(0.1), lineWidth: 14)
                                
                                Circle()
                                    .trim(from: 0.0, to: CGFloat(daysUsedInSchengen) / CGFloat(totalSchengenAllowance))
                                    .stroke(
                                        LinearGradient(colors: [NomadColors.primaryCoral, NomadColors.nomadCyan], startPoint: .topLeading, endPoint: .bottomTrailing),
                                        style: StrokeStyle(lineWidth: 14, lineCap: .round)
                                    )
                                    .rotationEffect(.degrees(-90))
                                
                                VStack(spacing: 4) {
                                    Text("\(daysUsedInSchengen) / \(totalSchengenAllowance)")
                                        .font(.system(size: 28, weight: .black, design: .rounded))
                                        .foregroundColor(.white)
                                    Text("DAYS SPENT")
                                        .font(.system(size: 11, weight: .bold))
                                        .foregroundColor(NomadColors.textMuted)
                                        .tracking(1)
                                }
                            }
                            .frame(height: 140)
                            .padding(.vertical, 8)
                            
                            HStack {
                                Label("Reset Date: Oct 24, 2026", systemImage: "calendar")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(NomadColors.textSecondary)
                                Spacer()
                                Text("Safe Zone")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(NomadColors.wifiGreen)
                            }
                        }
                        .padding(20)
                        .glassmorphicCard(cornerRadius: 24)
                        
                        // Digital Nomad Visa Directory
                        VStack(alignment: .leading, spacing: 14) {
                            Text("Top Digital Nomad Visas 2026")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                            
                            ForEach(popularVisas) { visa in
                                HStack(spacing: 14) {
                                    Text(visa.flagEmoji)
                                        .font(.system(size: 32))
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        HStack {
                                            Text(visa.countryName)
                                                .font(.system(size: 16, weight: .bold))
                                                .foregroundColor(.white)
                                            Spacer()
                                            Text(visa.stayDuration)
                                                .font(.system(size: 12, weight: .bold))
                                                .foregroundColor(NomadColors.nomadCyan)
                                        }
                                        
                                        HStack {
                                            Text("Min: \(visa.minIncomeUSD)")
                                                .font(.system(size: 13, weight: .medium))
                                                .foregroundColor(NomadColors.textSecondary)
                                            Spacer()
                                            Text(visa.taxPerk)
                                                .font(.system(size: 12, weight: .semibold))
                                                .foregroundColor(NomadColors.wifiGreen)
                                        }
                                    }
                                }
                                .padding(16)
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
