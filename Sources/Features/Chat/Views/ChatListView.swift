import SwiftUI

struct ChatListView: View {
    @State private var rooms: [ChatRoom] = ChatRoom.mockRooms
    
    var body: some View {
        ZStack {
            NomadColors.background.ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("MESSAGES & GROUPS")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(NomadColors.primaryCoral)
                            .tracking(2)
                        Text("Nomad Chat")
                            .font(.system(size: 26, weight: .heavy))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 54)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 14) {
                        ForEach(rooms) { room in
                            HStack(spacing: 14) {
                                ZStack {
                                    Circle()
                                        .fill(room.type == .cityGroup ? NomadColors.nomadCyan.opacity(0.2) : NomadColors.primaryCoral.opacity(0.2))
                                        .frame(width: 52, height: 52)
                                    
                                    Image(systemName: room.type == .cityGroup ? "building.2.crop.circle.fill" : "person.fill")
                                        .font(.system(size: 22))
                                        .foregroundColor(room.type == .cityGroup ? NomadColors.nomadCyan : NomadColors.primaryCoral)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text(room.title)
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(.white)
                                        Spacer()
                                        if room.unreadCount > 0 {
                                            Text("\(room.unreadCount)")
                                                .font(.system(size: 11, weight: .black))
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(NomadColors.primaryCoral)
                                                .clipShape(Circle())
                                        }
                                    }
                                    
                                    Text(room.lastMessageText ?? "No messages yet")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(NomadColors.textSecondary)
                                        .lineLimit(1)
                                }
                            }
                            .padding(16)
                            .glassmorphicCard(cornerRadius: 20)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 120)
                }
            }
        }
    }
}
