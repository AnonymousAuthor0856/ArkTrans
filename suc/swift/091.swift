import SwiftUI

@main
struct ThermostatApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        ThermostatScreen()
            .preferredColorScheme(.light)
            .statusBarHidden(true)
    }
}

// MARK: - Main Screen
struct ThermostatScreen: View {
    // State
    @State private var currentTemp = 22
    @State private var targetTemp = 24
    @State private var isPowerOn = true
    @State private var selectedMode = "Cool"
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Bar
                TopBar(isPowerOn: isPowerOn)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                
                Spacer().frame(height: 10)
                
                // Temperature Circle Control
                TemperatureControl(
                    currentTemp: currentTemp,
                    targetTemp: $targetTemp,
                    isPowerOn: isPowerOn
                )
                
                Spacer()
                
                // Mode Selection
                ModeSelection(
                    selectedMode: $selectedMode,
                    isPowerOn: isPowerOn
                )
                
                Spacer()
                
                // Info Cards
                InfoCardsRow()
                    .padding(.horizontal, 24)
                
                Spacer()
                
                // Master Power Switch
                PowerSwitch(isPowerOn: $isPowerOn)
                    .padding(.bottom, 40)
                    .padding(.horizontal, 24)
            }
        }
    }
}

// MARK: - Subcomponents

struct TopBar: View {
    let isPowerOn: Bool
    
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 24))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(spacing: 2) {
                Text("LIVING ROOM")
                    .font(.system(size: 12, weight: .bold))
                    .tracking(2)
                    .foregroundColor(.gray)
                
                Text(isPowerOn ? "Active" : "Off")
                    .font(.system(size: 11))
                    .foregroundColor(isPowerOn ? Color(red: 0.30, green: 0.69, blue: 0.31) : .gray) // #4CAF50 or LightGray
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.gray)
            }
        }
    }
}

struct TemperatureControl: View {
    let currentTemp: Int
    @Binding var targetTemp: Int
    let isPowerOn: Bool
    
    var body: some View {
        ZStack {
            // Background Circle
            Circle()
                .strokeBorder(Color(red: 0.93, green: 0.93, blue: 0.93), lineWidth: 1) // #EEEEEE
                .background(Circle().fill(Color.white))
                .frame(width: 280, height: 280)
            
            // Text Content
            VStack {
                Text("\(targetTemp)°")
                    .font(.system(size: 96, weight: .light))
                    .foregroundColor(isPowerOn ? .black : Color(red: 0.83, green: 0.83, blue: 0.83)) // LightGray
                
                Text("CURRENT: \(currentTemp)°")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            // Buttons
            if isPowerOn {
                HStack {
                    // Decrease Button (Left)
                    Button(action: { targetTemp -= 1 }) {
                        Image(systemName: "chevron.down")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                            .frame(width: 48, height: 48)
                            .background(Color(red: 0.96, green: 0.96, blue: 0.96)) // #F5F5F5
                            .clipShape(Circle())
                    }
                    .padding(.leading, 20)
                    
                    Spacer()
                    
                    // Increase Button (Right)
                    Button(action: { targetTemp += 1 }) {
                        Image(systemName: "plus")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                            .frame(width: 48, height: 48)
                            .background(Color(red: 0.96, green: 0.96, blue: 0.96)) // #F5F5F5
                            .clipShape(Circle())
                    }
                    .padding(.trailing, 20)
                }
                .frame(width: 280) // Match circle width
            }
        }
    }
}

struct ModeSelection: View {
    @Binding var selectedMode: String
    let isPowerOn: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            Text("MODE")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(.gray)
            
            HStack(spacing: 12) {
                ModeButton(
                    iconName: "house.fill",
                    label: "Auto",
                    isSelected: selectedMode == "Auto",
                    isEnabled: isPowerOn,
                    action: { selectedMode = "Auto" }
                )
                ModeButton(
                    iconName: "arrow.clockwise",
                    label: "Fan",
                    isSelected: selectedMode == "Fan",
                    isEnabled: isPowerOn,
                    action: { selectedMode = "Fan" }
                )
                ModeButton(
                    iconName: "star.fill",
                    label: "Cool",
                    isSelected: selectedMode == "Cool",
                    isEnabled: isPowerOn,
                    action: { selectedMode = "Cool" }
                )
            }
        }
    }
}

struct ModeButton: View {
    let iconName: String
    let label: String
    let isSelected: Bool
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Button(action: action) {
                Image(systemName: iconName)
                    .font(.system(size: 24))
                    .frame(width: 60, height: 60)
                    .foregroundColor(
                        isSelected && isEnabled ? .white :
                            (isEnabled ? .black : Color(red: 0.83, green: 0.83, blue: 0.83))
                    )
                    .background(
                        isSelected && isEnabled ? Color.black : Color.white
                    )
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(
                                !isSelected ? Color(red: 0.88, green: 0.88, blue: 0.88) : Color.clear,
                                lineWidth: 1
                            )
                    )
            }
            .disabled(!isEnabled)
            
            Text(label)
                .font(.system(size: 11))
                .foregroundColor(isEnabled ? .gray : Color(red: 0.83, green: 0.83, blue: 0.83))
        }
    }
}

struct InfoCardsRow: View {
    var body: some View {
        HStack(spacing: 16) {
            InfoCard(
                title: "Humidity",
                value: "45%",
                iconName: "info.circle.fill"
            )
            InfoCard(
                title: "Energy",
                value: "12 kWh",
                iconName: "chevron.up"
            )
        }
    }
}

struct InfoCard: View {
    let title: String
    let value: String
    let iconName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: iconName)
                .font(.system(size: 20))
                .foregroundColor(.gray)
            
            Text(value)
                .font(.system(size: 24, weight: .bold)) // HeadlineSmall approx
                .foregroundColor(.black)
            
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 0.98, green: 0.98, blue: 0.98)) // #F9F9F9
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(red: 0.94, green: 0.94, blue: 0.94), lineWidth: 1) // #F0F0F0
        )
    }
}

struct PowerSwitch: View {
    @Binding var isPowerOn: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Master Power")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                Text(isPowerOn ? "System is running" : "System is off")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Toggle("", isOn: $isPowerOn)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: .black))
        }
        .padding(20)
        .background(Color(red: 0.98, green: 0.98, blue: 0.98)) // #F9F9F9
        .cornerRadius(16)
    }
}