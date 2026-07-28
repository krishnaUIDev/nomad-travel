import SwiftUI

struct MeetupListView: View {
    @State private var meetups: [Meetup] = Meetup.mockMeetups
    
    var body: some View {
        ZStack {
            NomadColors.background.ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("MEETUPS & EVENTS")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(NomadColors.wifiGreen)
                            .tracking(2)
                        Text("Co-Working & Drinks")
                            .font(.system(size: 26, weight: .heavy))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    
                    Button {
                        NomadHaptics.selection()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(NomadColors.wifiGreen)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 54)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(meetups) { meetup in
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    HStack(spacing: 6) {
                                        Image(systemName: meetup.category.iconName)
                                        Text(meetup.category.rawValue)
                                    }
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .background(NomadColors.wifiGreen)
                                    .cornerRadius(10)
                                    
                                    Spacer()
                                    
                                    Text("\(meetup.rsvpUserIds.count)/\(meetup.maxAttendees) Attending")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(NomadColors.textMuted)
                                }
                                
                                Text(meetup.title)
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text(meetup.description)
                                    .font(.system(size: 13))
                                    .foregroundColor(NomadColors.textSecondary)
                                
                                HStack {
                                    Label(meetup.locationName, systemImage: "mappin.and.ellipse")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(NomadColors.nomadCyan)
                                    Spacer()
                                    Button {
                                        NomadHaptics.notification(.success)
                                    } label: {
                                        Text("RSVP Spot")
                                            .font(.system(size: 13, weight: .bold))
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 8)
                                            .background(NomadColors.primaryCoral)
                                            .cornerRadius(12)
                                    }
                                }
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
