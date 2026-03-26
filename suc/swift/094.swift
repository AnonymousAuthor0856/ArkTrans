import SwiftUI

@main
struct SecureKeyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        SecureKeyScreen()
            .preferredColorScheme(.light)
            .statusBarHidden(true)
    }
}

// MARK: - Models
struct AccessPoint: Identifiable {
    let id: String
    let name: String
    let status: String
    let isLocked: Bool
    let lastAccessed: String
}

// MARK: - Colors
struct SecureColors {
    static let primary = Color.black
    static let surface = Color(red: 0.97, green: 0.97, blue: 0.97) // #F8F8F8
    static let locked = Color(red: 0.13, green: 0.13, blue: 0.13) // #212121
    static let unlocked = Color(red: 0.30, green: 0.69, blue: 0.31) // #4CAF50
    static let border = Color(red: 0.94, green: 0.94, blue: 0.94) // #EFEFEF
    static let textGray = Color.gray
    static let backgroundWhite = Color.white
}

// MARK: - Main Screen
struct SecureKeyScreen: View {
    @State private var masterLockState = true
    
    let accessPoints = [
        AccessPoint(id: "1", name: "Main Entrance", status: "Active", isLocked: true, lastAccessed: "2h ago"),
        AccessPoint(id: "2", name: "Garage Door", status: "Active", isLocked: false, lastAccessed: "12m ago"),
        AccessPoint(id: "3", name: "Server Room", status: "Restricted", isLocked: true, lastAccessed: "Yesterday")
    ]
    
    var body: some View {
        ZStack {
            SecureColors.backgroundWhite.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    
                    // Header
                    HeaderSection()
                        .padding(.top, 24)
                    
                    Spacer().frame(height: 40)
                    
                    // Master Status Card
                    MasterStatusCard(isLocked: masterLockState) {
                        masterLockState.toggle()
                    }
                    
                    Spacer().frame(height: 32)
                    
                    // Access Points Header
                    Text("My Access Points")
                        .font(.system(size: 16, weight: .bold)) // TitleMedium approx
                        .foregroundColor(Color(white: 0.2)) // DarkGray
                    
                    Spacer().frame(height: 16)
                    
                    // Access Points List
                    VStack(spacing: 12) {
                        ForEach(accessPoints) { point in
                            AccessPointRow(item: point)
                        }
                    }
                    
                    Spacer().frame(height: 32)
                    
                    // Recent Activity Header
                    Text("Recent Activity")
                        .font(.system(size: 16, weight: .bold)) // TitleMedium approx
                        .foregroundColor(Color(white: 0.2))
                    
                    Spacer().frame(height: 16)
                    
                    // Activity Log
                    VStack(spacing: 0) {
                        ActivityLogItem(time: "10:42 AM", event: "Main Gate unlocked", user: "You")
                        ActivityLogItem(time: "09:15 AM", event: "Guest Entry Denied", user: "System")
                        ActivityLogItem(time: "08:30 AM", event: "Garage Door opened", user: "Alice")
                    }
                    
                    Spacer().frame(height: 24)
                }
                .padding(.horizontal, 24)
            }
        }
    }
}

// MARK: - Components

struct HeaderSection: View {
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Welcome back,")
                    .font(.system(size: 14)) // BodyMedium approx
                    .foregroundColor(SecureColors.textGray)
                
                Text("David Miller")
                    .font(.system(size: 24, weight: .black)) // HeadlineSmall + ExtraBold approx
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Color(red: 0.96, green: 0.96, blue: 0.96)) // #F5F5F5
                    .frame(width: 48, height: 48)
                    .overlay(
                        Circle()
                            .stroke(Color(red: 0.88, green: 0.88, blue: 0.88), lineWidth: 1) // #E0E0E0
                    )
                
                Image(systemName: "person.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
            }
        }
    }
}

struct MasterStatusCard: View {
    let isLocked: Bool
    let onToggle: () -> Void
    
    var statusColor: Color {
        isLocked ? SecureColors.locked : SecureColors.unlocked
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Icon Button
            Button(action: onToggle) {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 80, height: 80)
                        .overlay(
                            Circle()
                                .stroke(statusColor.opacity(0.1), lineWidth: 2)
                        )
                    
                    Image(systemName: isLocked ? "lock.fill" : "checkmark.circle.fill")
                        .font(.system(size: 36))
                        .foregroundColor(statusColor)
                }
            }
            .padding(.bottom, 16)
            
            // Status Text
            Text(isLocked ? "SECURE" : "UNLOCKED")
                .font(.system(size: 22, weight: .black))
                .tracking(2)
                .foregroundColor(statusColor)
            
            Spacer().frame(height: 8)
            
            // Subtext
            Text(isLocked ? "All perimeter doors are locked." : "Perimeter access is currently open.")
                .font(.system(size: 14))
                .foregroundColor(SecureColors.textGray)
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(SecureColors.surface)
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(SecureColors.border, lineWidth: 1)
        )
    }
}

struct AccessPointRow: View {
    let item: AccessPoint
    @State private var checked: Bool
    
    init(item: AccessPoint) {
        self.item = item
        _checked = State(initialValue: !item.isLocked)
    }
    
    var body: some View {
        HStack {
            HStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 0.98, green: 0.98, blue: 0.98)) // #FAFAFA
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: "house.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(item.name)
                        .font(.system(size: 16, weight: .semibold)) // BodyLarge + SemiBold
                        .foregroundColor(.black)
                    
                    Text(item.lastAccessed)
                        .font(.system(size: 11)) // LabelSmall
                        .foregroundColor(Color(white: 0.8)) // LightGray approximation
                }
            }
            
            Spacer()
            
            Toggle("", isOn: $checked)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: .black))
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(red: 0.93, green: 0.93, blue: 0.93), lineWidth: 1) // #EEEEEE
        )
    }
}

struct ActivityLogItem: View {
    let time: String
    let event: String
    let user: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(time)
                .font(.system(size: 12)) // LabelMedium
                .foregroundColor(SecureColors.textGray)
                .frame(width: 70, alignment: .leading)
            
            Rectangle()
                .fill(Color(red: 0.93, green: 0.93, blue: 0.93)) // #EEEEEE
                .frame(width: 1, height: 20)
                .padding(.trailing, 16)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(event)
                    .font(.system(size: 14, weight: .medium)) // BodyMedium + Medium
                    .foregroundColor(.black)
                
                Text("by \(user)")
                    .font(.system(size: 11)) // LabelSmall
                    .foregroundColor(SecureColors.textGray)
            }
            
            Spacer()
        }
        .padding(.vertical, 12)
    }
}