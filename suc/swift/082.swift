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

// MARK: - Models
struct DeviceItem: Identifiable {
    let id = UUID()
    let name: String
    let status: String
    let icon: String
    let isActive: Bool
}

// MARK: - Main Screen
struct SmartHomeScreen: View {
    // Colors matching Android theme
    let primaryColor = Color(red: 0.29, green: 0.40, blue: 0.45) // #4A6572
    let backgroundColor = Color(red: 0.96, green: 0.96, blue: 0.97) // #F5F6F8
    
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
                        
                        // Extra padding for bottom bar
                        Spacer().frame(height: 100)
                    }
                }
            }
            
            SmartHomeBottomBar(primaryColor: primaryColor)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

// MARK: - Components

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
        // Temperature card only for this example view layout based on provided image
        // The Android code has two cards in a row (Temp & Humidity), 
        // but image 5 shows one wide card for Temperature. 
        // Following the visual reference (image 5) primarily, but keeping code structure flexible.
        // Image 5 shows "Temperature 24°C Comfortable" in a single large blue card.
        
        // However, checking the Android code provided (file 5.txt), it actually implements:
        // Row with EnvironmentCard(Temp) and EnvironmentCard(Humidity).
        // BUT image 5 shows a large blue card at top.
        // Wait, image 5 top section corresponds to "EnvironmentSummary" but styled differently in the screenshot vs code?
        // Let's look closely at Image 5.
        // It shows "Temperature" label, "24°C", "Comfortable". It spans full width.
        // The Android code provided has two smaller cards.
        // Requirement: "Button sizes, spacing... match Android version".
        // Requirement: "Refer to provided final UI reference image to validate layout consistency".
        // Image 5 shows a single big blue card. Android code shows 2 small cards.
        // Usually visual reference takes precedence for layout.
        // However, if I must port the Android CODE, I should output what the code does?
        // "Migrate Android Kotlin UI code to iOS Swift code". This implies faithful translation of the code logic.
        // BUT "Refer to provided final UI reference image".
        // Image 5 shows: Big blue card "Temperature 24C Comfortable".
        // Android code `EnvironmentSummary` calls `EnvironmentCard` twice.
        // Actually, looking at image 5 again... no, that IS what the Android code produces?
        // Wait, the Android code produces `Row { EnvironmentCard(...), Spacer, EnvironmentCard(...) }`.
        // This would be two columns.
        // Image 5 shows one big card spanning width.
        // Let's re-read the Android code carefully.
        // It puts them in a Row with `Arrangement.SpaceBetween`.
        // If I implement the Android code exactly, I get two cards.
        // If I follow Image 5, I get one card.
        // I will follow the visual reference (Image 5) for the card style since it's the "final UI reference",
        // but I will verify if the code matches.
        // Actually, the provided Android code `EnvironmentSummary` puts TWO cards side-by-side.
        // Image 5 shows ONE card.
        // It is possible the Android code provided doesn't perfectly match Image 5, or I am misinterpreting.
        // Let's look at Image 5 again. "Temperature" ... "24°C" ... "Comfortable".
        // It looks like a single wide card with blue background.
        // The Android code uses `Color(0xFFE3F2FD)` (light blue) for the first card.
        // I will implement the layout as visually seen in Image 5 to satisfy "validate layout consistency",
        // effectively adapting the code to match the visual.
        // Actually, looking closer at Image 5, it seems to be just the Temperature card?
        // Wait, maybe the Humidity card is off-screen or the code is different?
        // I will implement the visual from Image 5 which is a single large card.
        // Code-wise, I'll adapt to make it look like the image.
        
        // CORRECTION: I will implement the logic of the Android code, but style it to look good.
        // If the Android code renders two cards, I will render two cards.
        // But if Image 5 only shows one, there's a conflict.
        // Conflict resolution: Code is the source of truth for functionality, Image for style.
        // If code has 2 items, I should probably show 2 items.
        // BUT Image 5 is titled "Welcome Home, Alex Johnson".
        // It shows "Temperature 24C".
        // It shows "My Devices" with 4 items.
        // The Android code has 6 items in the grid.
        // The Image has 4 items in the grid.
        // It seems the Android Code provided corresponds to a slightly different version or the user provided generic code.
        // I will strictly follow the ANDROID CODE logic (2 cards, 6 devices) but style them as close as possible to the general aesthetic of Image 5.
        // Actually, looking at Image 5's top card: Blue background, white text.
        // Android code: Light blue background (`Color(0xFFE3F2FD)`), Dark blue text (`Color(0xFF1565C0)`).
        // This matches.
        // So I will implement the 2-card row from the Android code.
        
        HStack(spacing: 16) {
            EnvironmentCard(
                title: "Temperature",
                value: "24°C",
                subtitle: "Comfortable",
                bgColor: Color(red: 0.89, green: 0.95, blue: 0.99), // #E3F2FD
                textColor: Color(red: 0.08, green: 0.40, blue: 0.75) // #1565C0
            )
            
            EnvironmentCard(
                title: "Humidity",
                value: "45%",
                subtitle: "Normal",
                bgColor: Color(red: 0.91, green: 0.96, blue: 0.91), // #E8F5E9
                textColor: Color(red: 0.18, green: 0.49, blue: 0.20) // #2E7D32
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
    
    // Data from Android code
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
                        .font(.system(size: 14)) // approx 20dp visual
                        .foregroundColor(isChecked ? .white : .gray)
                }
                
                Spacer()
                
                Toggle("", isOn: $isChecked)
                    .labelsHidden()
                    .toggleStyle(SwitchToggleStyle(tint: Color.white.opacity(0.4))) // Approximating the style
                    .scaleEffect(0.7)
                    .overlay(
                        // Custom styling to match Android Switch colors roughly
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
            // Shadow layer
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

// MARK: - Helper for Corners
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