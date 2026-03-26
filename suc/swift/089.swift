import SwiftUI

@main
struct CryoGenApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        CryoGenMonitorScreen()
            .preferredColorScheme(.light)
            .statusBarHidden(true)
    }
}

// MARK: - App Colors
struct CryoColors {
    static let primaryBlue = Color(red: 0.0, green: 0.40, blue: 0.80) // #0066CC
    static let alertRed = Color(red: 0.83, green: 0.18, blue: 0.18) // #D32F2F
    static let safeGreen = Color(red: 0.22, green: 0.56, blue: 0.24) // #388E3C
    static let backgroundWhite = Color.white
    static let surfaceGrey = Color(red: 0.96, green: 0.96, blue: 0.96) // #F5F5F5
    static let textDark = Color(red: 0.13, green: 0.13, blue: 0.13) // #212121
    static let textGrey = Color(red: 0.46, green: 0.46, blue: 0.46) // #757575
}

// MARK: - Main Screen
struct CryoGenMonitorScreen: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            CryoColors.backgroundWhite.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Bar
                SimpleTopBar()
                    .padding(.top, 24)
                    .padding(.bottom, 12)
                    .padding(.horizontal, 24)
                    .background(CryoColors.backgroundWhite)
                
                // Content
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        Spacer().frame(height: 16)
                        
                        // Status Badge
                        SystemStatusBadge()
                        
                        Spacer().frame(height: 32)
                        
                        // Temperature Display
                        MainTemperatureDisplay()
                        
                        Spacer().frame(height: 32)
                        
                        // Grid
                        SensorGrid()
                        
                        Spacer().frame(height: 24)
                        
                        // Activity Log Header
                        Text("MAINTENANCE LOG")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(CryoColors.textGrey)
                            .tracking(1.5)
                        
                        Spacer().frame(height: 8)
                        
                        // Log List
                        ActivityLogList()
                        
                        // Space for bottom bar
                        Spacer().frame(height: 100)
                    }
                    .padding(.horizontal, 24)
                }
            }
            
            // Bottom Bar Overlay
            BottomControlBar()
        }
    }
}

// MARK: - Components

struct SimpleTopBar: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("UNIT-04")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(CryoColors.textGrey)
                
                Text("CryoGen Monitor")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(CryoColors.textDark)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 24))
                    .foregroundColor(CryoColors.textDark)
            }
        }
        .frame(height: 56)
    }
}

struct SystemStatusBadge: View {
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "checkmark")
                .font(.system(size: 14, weight: .bold)) // Visual size adjust
                .foregroundColor(CryoColors.safeGreen)
            
            Text("SYSTEM NOMINAL")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(CryoColors.safeGreen)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 50)
                .stroke(CryoColors.safeGreen.opacity(0.5), lineWidth: 1)
        )
    }
}

struct MainTemperatureDisplay: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("CORE TEMPERATURE")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(CryoColors.textGrey)
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text("-184.2")
                    .font(.system(size: 64, weight: .light))
                    .foregroundColor(CryoColors.textDark)
                    .tracking(-2)
                
                Text("°C")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(CryoColors.textGrey)
            }
        }
    }
}

struct SensorGrid: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                SensorCard(
                    title: "PRESSURE",
                    value: "1.02",
                    unit: "Bar",
                    iconName: "info.circle.fill",
                    isWarning: false
                )
                
                SensorCard(
                    title: "O2 LEVEL",
                    value: "19.5",
                    unit: "%",
                    iconName: "exclamationmark.triangle.fill",
                    isWarning: true
                )
            }
            
            HStack(spacing: 12) {
                SensorCard(
                    title: "POWER",
                    value: "Stable",
                    unit: "AC",
                    iconName: "wrench.and.screwdriver.fill",
                    isWarning: false
                )
                
                SensorCard(
                    title: "LIQUID N2",
                    value: "88",
                    unit: "%",
                    iconName: "arrow.clockwise",
                    isWarning: false
                )
            }
        }
    }
}

struct SensorCard: View {
    let title: String
    let value: String
    let unit: String
    let iconName: String
    let isWarning: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header Row
            HStack {
                Image(systemName: iconName)
                    .font(.system(size: 20))
                    .foregroundColor(isWarning ? CryoColors.alertRed : CryoColors.primaryBlue)
                
                Spacer()
                
                if isWarning {
                    Circle()
                        .fill(CryoColors.alertRed)
                        .frame(width: 6, height: 6)
                }
            }
            
            Spacer().frame(height: 12)
            
            // Value Column
            VStack(alignment: .leading, spacing: 0) {
                Text(value)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(CryoColors.textDark)
                
                Text("\(unit)  \(title)")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(CryoColors.textGrey)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(CryoColors.surfaceGrey)
        .cornerRadius(12)
    }
}

struct ActivityLogList: View {
    let logs = [
        LogEntry(time: "08:00 AM", message: "Auto-Cycle Complete", isSystem: true),
        LogEntry(time: "07:45 AM", message: "Pressure stabilized", isSystem: true),
        LogEntry(time: "06:30 AM", message: "Technician access", isSystem: false),
        LogEntry(time: "02:15 AM", message: "Nitrogen refill", isSystem: true),
        LogEntry(time: "Yesterday", message: "System Reboot", isSystem: true)
    ]
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(logs) { log in
                VStack(spacing: 0) {
                    HStack(alignment: .center, spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(CryoColors.surfaceGrey)
                                .frame(width: 32, height: 32)
                            
                            Image(systemName: log.isSystem ? "info.circle.fill" : "wrench.fill")
                                .font(.system(size: 16))
                                .foregroundColor(CryoColors.textGrey)
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(log.message)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(CryoColors.textDark)
                            
                            Text(log.time)
                                .font(.system(size: 11))
                                .foregroundColor(CryoColors.textGrey)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 4)
                    
                    Divider()
                        .background(CryoColors.surfaceGrey)
                }
            }
        }
    }
}

struct LogEntry: Identifiable {
    let id = UUID()
    let time: String
    let message: String
    let isSystem: Bool
}

struct BottomControlBar: View {
    @State private var isLocked = true
    
    var body: some View {
        VStack(spacing: 0) {
            // Shadow simulation via overlay or background logic if needed, but standard shadow works fine
            Rectangle()
                .fill(Color.white)
                .frame(height: 1)
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: -2)
            
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("MANUAL OVERRIDE")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(CryoColors.textGrey)
                    
                    Text(isLocked ? "LOCKED" : "ACTIVE")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(isLocked ? CryoColors.textDark : CryoColors.alertRed)
                }
                
                Spacer()
                
                Toggle("", isOn: Binding(
                    get: { !isLocked },
                    set: { isLocked = !$0 }
                ))
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: CryoColors.alertRed))
                .overlay(
                    // Custom overlay icon on toggle not standard in SwiftUI ToggleStyle without custom view
                    // Just keeping standard toggle visual for cleaner code as per requirements "no warnings/errors"
                    // Or implement a custom toggle view if exact icon match is critical. 
                    // Given constraints, standard toggle is safest and functional.
                    EmptyView() 
                )
            }
            .padding(24)
            .background(CryoColors.backgroundWhite)
            .shadow(color: Color.black.opacity(0.1), radius: 12, x: 0, y: -4)
        }
    }
}