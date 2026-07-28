import SwiftUI

struct ItineraryListView: View {
    @State private var trips: [Trip] = Trip.mockTrips
    
    var body: some View {
        ZStack {
            NomadColors.background.ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("TRIP PLANNER")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(NomadColors.nomadCyan)
                            .tracking(2)
                        Text("My & Friends Trips")
                            .font(.system(size: 26, weight: .heavy))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    
                    Button {
                        NomadHaptics.selection()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(NomadColors.primaryCoral)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 54)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(trips) { trip in
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Text("\(trip.countryFlag) \(trip.city), \(trip.country)")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text(trip.visibility.rawValue)
                                        .font(.system(size: 11, weight: .bold))
                                        .foregroundColor(NomadColors.wifiGreen)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(NomadColors.wifiGreen.opacity(0.15))
                                        .cornerRadius(8)
                                }
                                
                                HStack(spacing: 6) {
                                    Image(systemName: "calendar")
                                        .font(.system(size: 13))
                                        .foregroundColor(NomadColors.textMuted)
                                    Text("\(trip.startDate.formatted(date: .abbreviated, time: .omitted)) – \(trip.endDate.formatted(date: .abbreviated, time: .omitted))")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(NomadColors.textSecondary)
                                }
                                
                                if let notes = trip.notes {
                                    Text(notes)
                                        .font(.system(size: 13))
                                        .foregroundColor(NomadColors.textPrimary)
                                }
                                
                                // Crossing Paths Overlap Banner
                                HStack(spacing: 8) {
                                    Image(systemName: "person.2.fill")
                                        .font(.system(size: 12))
                                        .foregroundColor(NomadColors.nomadCyan)
                                    Text("2 travelers you follow overlap in \(trip.city)!")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(NomadColors.nomadCyan)
                                }
                                .padding(10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(NomadColors.nomadCyan.opacity(0.12))
                                .cornerRadius(12)
                            }
                            .padding(18)
                            .glassmorphicCard(cornerRadius: 22)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 120)
                }
            }
        }
    }
}
