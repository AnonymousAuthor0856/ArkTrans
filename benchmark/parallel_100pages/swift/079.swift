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
        SmartHomeScreen()
            .preferredColorScheme(.light)
            .statusBarHidden(true)
    }
}

struct DeviceItem: Identifiable {
    let id = UUID()
    let name: String
    let status: String
    let icon: String
    let isActive: Bool
}

struct SmartHomeScreen: View {
        let primaryColor = Color(red: 0.29, green: 0.40, blue: 0.45) 
    let backgroundColor = Color(red: 0.96, green: 0.96, blue: 0.97) 
    
    var body: some View {
        ZStack(alignment: .bottom) {
            backgroundColor.ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        Spacer().frame(height: 24)
                        
                        HeaderSection(primaryColor: primaryColor)
                            .padding(.horizontal, 24)
                        
                        Spacer().frame(height: 32)
                        
                        EnvironmentSummary()
                            .padding(.horizontal, 24)
                        
                        Spacer().frame(height: 32)
                        
                        DevicesGrid(primaryColor: primaryColor)
                            .padding(.horizontal, 24)
                        
                                                Spacer().frame(height: 100)
                    }
                }
            }
            
            SmartHomeBottomBar(primaryColor: primaryColor)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}


struct HeaderSection: View {
    let primaryColor: Color
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Welcome Home,")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                Text("Alex Johnson")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            ZStack {
                Circle()
                    .fill(primaryColor.opacity(0.1))
                    .frame(width: 48, height: 48)
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                    .foregroundColor(primaryColor)
            }
        }
    }
}

struct EnvironmentSummary: View {
    var body: some View {
                                                
                                                                                                                                                                                                                                                                                                                        
                                                                                                                                        
        HStack(spacing: 16) {
            EnvironmentCard(
                title: "Temperature",
                value: "24°C",
                subtitle: "Comfortable",
                bgColor: Color(red: 0.89, green: 0.95, blue: 0.99), 
                textColor: Color(red: 0.08, green: 0.40, blue: 0.75) 
            )
            
            EnvironmentCard(
                title: "Humidity",
                value: "45%",
                subtitle: "Normal",
                bgColor: Color(red: 0.91, green: 0.96, blue: 0.91), 
                textColor: Color(red: 0.18, green: 0.49, blue: 0.20) 
            )
        }
    }
}

struct EnvironmentCard: View {
    let title: String
    let value: String
    let subtitle: String
    let bgColor: Color
    let textColor: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(textColor.opacity(0.8))
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 0) {
                Text(value)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(textColor)
                Text(subtitle)
                    .font(.system(size: 11))
                    .foregroundColor(textColor.opacity(0.7))
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 100)
        .background(bgColor)
        .cornerRadius(16)
    }
}

struct DevicesGrid: View {
    let primaryColor: Color
    
        let devices = [
        DeviceItem(name: "Living Room", status: "2 Lights On", icon: "house.fill", isActive: true),
        DeviceItem(name: "Smart Lock", status: "Locked", icon: "lock.fill", isActive: true),
        DeviceItem(name: "Bedroom AC", status: "22°C", icon: "star.fill", isActive: false),
        DeviceItem(name: "Router", status: "Online", icon: "location.circle.fill", isActive: true),
        DeviceItem(name: "Kitchen", status: "All Off", icon: "info.circle.fill", isActive: false),
        DeviceItem(name: "Corridor", status: "Motion Detected", icon: "bell.fill", isActive: true)
    ]
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("My Devices")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(devices) { device in
                    DeviceCard(device: device, primaryColor: primaryColor)
                }
            }
        }
    }
}

struct DeviceCard: View {
    let device: DeviceItem
    let primaryColor: Color
    @State private var isChecked: Bool
    
    init(device: DeviceItem, primaryColor: Color) {
        self.device = device
        self.primaryColor = primaryColor
        _isChecked = State(initialValue: device.isActive)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ZStack {
                    Circle()
                        .fill(isChecked ? Color.white.opacity(0.2) : Color(red: 0.94, green: 0.94, blue: 0.94))
                        .frame(width: 36, height: 36)
                    
                    Image(systemName: device.icon)
                        .font(.system(size: 14)) 
                        .foregroundColor(isChecked ? .white : .gray)
                }
                
                Spacer()
                
                Toggle("", isOn: $isChecked)
                    .labelsHidden()
                    .toggleStyle(SwitchToggleStyle(tint: Color.white.opacity(0.4))) 
                    .scaleEffect(0.7)
                    .overlay(
                                                RoundedRectangle(cornerRadius: 16)
                            .stroke(isChecked ? Color.clear : Color.gray, lineWidth: 1)
                            .opacity(isChecked ? 0 : 0.5)
                    )
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(device.name)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(isChecked ? .white : .black)
                
                Text(isChecked ? "On" : "Off")
                    .font(.system(size: 11))
                    .foregroundColor(isChecked ? .white.opacity(0.7) : .gray)
            }
        }
        .padding(16)
        .frame(height: 140)
        .background(isChecked ? primaryColor : Color.white)
        .cornerRadius(20)
        .shadow(color: isChecked ? primaryColor.opacity(0.3) : Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

struct SmartHomeBottomBar: View {
    let primaryColor: Color
    
    var body: some View {
        ZStack(alignment: .top) {
                        Color.white
                .frame(height: 80)
                .cornerRadius(24, corners: [.topLeft, .topRight])
                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: -2)
            
            HStack {
                Spacer()
                NavBarItem(icon: "house.fill", label: "Home", isSelected: true, primaryColor: primaryColor)
                Spacer()
                NavBarItem(icon: "star.fill", label: "Scenes", isSelected: false, primaryColor: primaryColor)
                Spacer()
                NavBarItem(icon: "gearshape.fill", label: "Settings", isSelected: false, primaryColor: primaryColor)
                Spacer()
            }
            .padding(.top, 16)
        }
        .frame(height: 80)
    }
}

struct NavBarItem: View {
    let icon: String
    let label: String
    let isSelected: Bool
    let primaryColor: Color
    
    var body: some View {
        VStack(spacing: 4) {
            ZStack {
                if isSelected {
                    Capsule()
                        .fill(primaryColor.opacity(0.1))
                        .frame(width: 64, height: 32)
                }
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? primaryColor : .gray)
            }
            Text(label)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(isSelected ? primaryColor : .gray)
        }
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}