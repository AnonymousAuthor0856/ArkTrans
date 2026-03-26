import SwiftUI

@main
struct SmartHomeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        SmartHomeDashboard()
            .statusBarHidden(true)
    }
}

struct SmartHomeDashboard: View {
    var body: some View {
        ZStack {
            Color(red: 0.957, green: 0.965, blue: 0.973) // #F4F6F8
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    
                    // Top Header Spacer
                    Spacer().frame(height: 16)
                    
                    // Header
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Good Morning,")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.gray)
                            Text("Alex Johnson")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 48, height: 48)
                            
                            Image(systemName: "person.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer().frame(height: 32)
                    
                    // Energy Usage Card
                    VStack {
                        HStack(alignment: .center) {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Energy Usage")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white.opacity(0.8))
                                
                                Text("28.5 kWh")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text("Today")
                                    .font(.system(size: 12))
                                    .foregroundColor(.white.opacity(0.6))
                            }
                            
                            Spacer()
                            
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.2))
                                    .frame(width: 56, height: 56)
                                
                                Image(systemName: "bell.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(24)
                    }
                    .background(Color(red: 0.369, green: 0.376, blue: 0.808)) // #5E60CE
                    .cornerRadius(24)
                    .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                    .padding(.horizontal, 24)
                    
                    Spacer().frame(height: 32)
                    
                    // Scenes Section
                    Text("Scenes")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 24)
                    
                    Spacer().frame(height: 16)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            // Leading padding for scroll view content
                            Spacer().frame(width: 24).padding(.trailing, -12)
                            
                            SceneButton(text: "Home", icon: "house.fill", isSelected: true)
                            SceneButton(text: "Away", icon: "lock.fill", isSelected: false)
                            SceneButton(text: "Sleep", icon: "star.fill", isSelected: false)
                            
                            // Trailing padding for scroll view content
                            Spacer().frame(width: 24).padding(.leading, -12)
                        }
                    }
                    
                    Spacer().frame(height: 32)
                    
                    // Devices Section
                    Text("Devices")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 24)
                    
                    Spacer().frame(height: 16)
                    
                    // Devices Grid
                    HStack(alignment: .top, spacing: 16) {
                        VStack(spacing: 16) {
                            DeviceCard(
                                name: "Smart Lamp",
                                icon: "star.fill",
                                isActive: true,
                                accentColor: Color(red: 1.0, green: 0.757, blue: 0.027) // #FFC107
                            )
                            DeviceCard(
                                name: "Thermostat",
                                icon: "line.3.horizontal",
                                isActive: true,
                                accentColor: Color(red: 1.0, green: 0.439, blue: 0.263) // #FF7043
                            )
                        }
                        
                        VStack(spacing: 16) {
                            DeviceCard(
                                name: "Main Lock",
                                icon: "lock.fill",
                                isActive: false,
                                accentColor: Color(red: 0.298, green: 0.686, blue: 0.314) // #4CAF50
                            )
                            DeviceCard(
                                name: "Wi-Fi Router",
                                icon: "gearshape.fill",
                                isActive: true,
                                accentColor: Color(red: 0.129, green: 0.588, blue: 0.953) // #2196F3
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer().frame(height: 24)
                }
                .padding(.vertical, 24)
            }
        }
    }
}

struct SceneButton: View {
    let text: String
    let icon: String
    let isSelected: BooleanLiteralType
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 18, height: 18)
                .foregroundColor(isSelected ? .white : .black)
            
            Text(text)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(isSelected ? .white : .black)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(isSelected ? Color(red: 0.129, green: 0.129, blue: 0.129) : Color.white) // #212121
        .cornerRadius(30)
    }
}

struct DeviceCard: View {
    let name: String
    let icon: String
    let isActive: Bool
    let accentColor: Color
    
    @State private var switchState: Bool
    
    init(name: String, icon: String, isActive: Bool, accentColor: Color) {
        self.name = name
        self.icon = icon
        self.isActive = isActive
        self.accentColor = accentColor
        _switchState = State(initialValue: isActive)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ZStack {
                    Circle()
                        .fill(switchState ? accentColor.opacity(0.1) : Color(red: 0.941, green: 0.941, blue: 0.941)) // #F0F0F0
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(switchState ? accentColor : .gray)
                }
                Spacer()
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                
                Text(switchState ? "On" : "Off")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(switchState ? accentColor : .gray)
            }
            
            Spacer()
            
            HStack {
                Spacer()
                Toggle("", isOn: $switchState)
                    .labelsHidden()
                    .toggleStyle(SwitchToggleStyle(tint: accentColor))
                    .scaleEffect(0.8)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        // Aspect ratio 0.85 means width/height = 0.85, so height = width / 0.85
        // In a grid context, aspect ratio modifier works well.
        .aspectRatio(0.85, contentMode: .fit)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}