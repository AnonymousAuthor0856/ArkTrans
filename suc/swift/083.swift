import SwiftUI

@main
struct ServerStatusApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        ServerStatusScreen()
            .preferredColorScheme(.light)
            .statusBarHidden(true)
    }
}

struct ServerStatusScreen: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Bar
                TopBar()
                    .padding(.top, 48)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        
                        // Hero Status Section
                        HeroStatusCard()
                            .padding(.vertical, 16)
                        
                        Spacer().frame(height: 16)
                        
                        // Quick Actions Grid
                        Text("Control Panel")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.bottom, 16)
                        
                        HStack(spacing: 16) {
                            ActionButton(
                                iconName: "play.fill",
                                label: "Start",
                                color: Color(red: 0.89, green: 0.95, blue: 0.99), // #E3F2FD
                                iconColor: Color(red: 0.13, green: 0.59, blue: 0.95) // #2196F3
                            )
                            ActionButton(
                                iconName: "arrow.clockwise",
                                label: "Reboot",
                                color: Color(red: 1.00, green: 0.95, blue: 0.88), // #FFF3E0
                                iconColor: Color(red: 1.00, green: 0.60, blue: 0.00) // #FF9800
                            )
                            ActionButton(
                                iconName: "lock.fill",
                                label: "Lock",
                                color: Color(red: 1.00, green: 0.92, blue: 0.93), // #FFEBEE
                                iconColor: Color(red: 0.96, green: 0.26, blue: 0.21) // #F44336
                            )
                            ActionButton(
                                iconName: "gearshape.fill",
                                label: "Config",
                                color: Color(red: 0.95, green: 0.90, blue: 0.96), // #F3E5F5
                                iconColor: Color(red: 0.61, green: 0.15, blue: 0.69) // #9C27B0
                            )
                        }
                        
                        Spacer().frame(height: 32)
                        
                        // Recent Logs Header
                        HStack {
                            Text("Recent Logs")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                            Spacer()
                            Button(action: {}) {
                                Text("View All")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color(red: 0.13, green: 0.59, blue: 0.95)) // #2196F3
                            }
                        }
                        
                        Spacer().frame(height: 8)
                        
                        // Recent Logs List
                        VStack(spacing: 12) {
                            LogItem(
                                iconName: "exclamationmark.triangle.fill",
                                title: "High Memory Usage",
                                time: "10:42 AM",
                                typeColor: Color(red: 1.00, green: 0.95, blue: 0.88), // #FFF3E0
                                iconTint: Color(red: 1.00, green: 0.60, blue: 0.00) // #FF9800
                            )
                            LogItem(
                                iconName: "person.fill",
                                title: "Admin Login: root",
                                time: "09:15 AM",
                                typeColor: Color(red: 0.89, green: 0.95, blue: 0.99), // #E3F2FD
                                iconTint: Color(red: 0.13, green: 0.59, blue: 0.95) // #2196F3
                            )
                            LogItem(
                                iconName: "info.circle.fill",
                                title: "Backup Completed",
                                time: "04:00 AM",
                                typeColor: Color(red: 0.91, green: 0.96, blue: 0.91), // #E8F5E9
                                iconTint: Color(red: 0.30, green: 0.69, blue: 0.31) // #4CAF50
                            )
                        }
                        .padding(.bottom, 16)
                    }
                    .padding(.horizontal, 24)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct TopBar: View {
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "line.3.horizontal")
                    .foregroundColor(.black)
                    .font(.system(size: 24))
            }
            Spacer()
            Text("NodeLink")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.black)
            Spacer()
            ZStack(alignment: .topTrailing) {
                Button(action: {}) {
                    Image(systemName: "bell.fill")
                        .foregroundColor(.black)
                        .font(.system(size: 24))
                }
                Circle()
                    .fill(Color.red)
                    .frame(width: 10, height: 10)
                    .padding(2)
            }
        }
    }
}

struct HeroStatusCard: View {
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 100, height: 100)
                    
                    ZStack {
                        Circle()
                            .fill(Color(red: 0.91, green: 0.96, blue: 0.91)) // #E8F5E9
                            .frame(width: 84, height: 84) // 100 - padding 8*2
                        
                        Image(systemName: "checkmark")
                            .font(.system(size: 40, weight: .bold)) // Approx 48dp visual
                            .foregroundColor(Color(red: 0.30, green: 0.69, blue: 0.31)) // #4CAF50
                    }
                }
                
                Spacer().frame(height: 16)
                
                Text("System Operational")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                
                Text("Uptime: 14d 2h 15m")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .padding(.top, 4)
                
                Spacer().frame(height: 24)
                
                HStack(spacing: 0) {
                    StatBadge(label: "CPU", value: "12%")
                        .frame(maxWidth: .infinity)
                    StatBadge(label: "RAM", value: "4.2GB")
                        .frame(maxWidth: .infinity)
                    StatBadge(label: "NET", value: "1Gbps")
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(24)
        }
        .background(Color(red: 0.96, green: 0.97, blue: 0.98)) // #F5F7FA
        .cornerRadius(24)
    }
}

struct StatBadge: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
    }
}

struct ActionButton: View {
    let iconName: String
    let label: String
    let color: Color
    let iconColor: Color
    
    var body: some View {
        VStack {
            Button(action: {}) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(color)
                        .frame(height: 64)
                    
                    Image(systemName: iconName)
                        .font(.system(size: 24)) // Approx 28dp visual
                        .foregroundColor(iconColor)
                }
            }
            Spacer().frame(height: 8)
            Text(label)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
    }
}

struct LogItem: View {
    let iconName: String
    let title: String
    let time: String
    let typeColor: Color
    let iconTint: Color
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(typeColor)
                    .frame(width: 40, height: 40)
                
                Image(systemName: iconName)
                    .font(.system(size: 16)) // Approx 20dp visual
                    .foregroundColor(iconTint)
            }
            
            Spacer().frame(width: 16)
            
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)
            
            Spacer()
            
            Text(time)
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
        .background(Color.white)
    }
}