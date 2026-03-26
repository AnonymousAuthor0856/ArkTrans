import SwiftUI

// MARK: - 1. Entry Point
@main
struct LeaseWizardApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}

// MARK: - 2. Color Palette
extension Color {
    // Backgrounds
    static let lwBackground = Color(hex: "FBFBFE")
    static let lwCardBg = Color(hex: "F5F3FD") // Pale lavender card
    static let lwHeaderCircle = Color(hex: "EEE9FC")
    
    // Accents
    static let lwPurpleActive = Color(hex: "8B5CF6") // Vibrant purple
    static let lwPurpleInactive = Color(hex: "EBE7F6") // Muted lavender
    static let lwTextInactive = Color(hex: "1F2937")
    static let lwButtonPink = Color(hex: "F4AECF") // Soft pink
    static let lwButtonText = Color(hex: "2D0D1B")
    
    // Text & Borders
    static let lwTextDark = Color(hex: "111827")
    static let lwTextGray = Color(hex: "6B7280")
    static let lwBorder = Color(hex: "C4B5FD")
}

// MARK: - 3. Main Content View
struct ContentView: View {
    var body: some View {
        ZStack {
            // Global Background
            Color.lwBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HeaderView()
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        // Section 1: Steps Container
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Steps")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.lwTextDark)
                            
                            VStack(spacing: 0) {
                                StepRow(
                                    step: "1",
                                    title: "Profile",
                                    subtitle: "Tenant basics",
                                    btnText: "Edit",
                                    isActive: true,
                                    isLast: false
                                )
                                
                                StepRow(
                                    step: "2",
                                    title: "Income",
                                    subtitle: "Proof details",
                                    btnText: "Edit",
                                    isActive: true,
                                    isLast: false
                                )
                                
                                StepRow(
                                    step: "3",
                                    title: "References",
                                    subtitle: "Upload letters",
                                    btnText: "Go",
                                    isActive: false,
                                    isLast: false
                                )
                                
                                StepRow(
                                    step: "4",
                                    title: "Summary",
                                    subtitle: "Confirm submission",
                                    btnText: "Go",
                                    isActive: false,
                                    isLast: true
                                )
                            }
                        }
                        .padding(24)
                        .background(Color.lwCardBg)
                        .cornerRadius(24)
                        
                        // Section 2: Form Container
                        VStack(alignment: .leading, spacing: 25) {
                            Text("Form")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.lwTextDark)
                            
                            // Custom Floating Label Inputs
                            CustomTextField(label: "Full name", text: "Avery Tenant")
                            
                            CustomTextField(label: "Contact", text: "avery@example.com")
                            
                            // Spacer to ensure bottom padding visible in scroll
                            Color.clear.frame(height: 10)
                        }
                        .padding(24)
                        .background(Color.lwCardBg)
                        .cornerRadius(24)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 40)
                }
            }
        }
        .statusBar(hidden: true) // Requirement: Status bar hidden
    }
}

// MARK: - 4. Components

struct HeaderView: View {
    var body: some View {
        HStack {
            // Left Circle
            Circle()
                .fill(Color.lwHeaderCircle)
                .frame(width: 44, height: 44)
            
            Spacer()
            
            // Title Block
            VStack(spacing: 2) {
                Text("LeaseWizard")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                Text("Guided handoff")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.lwTextGray)
            }
            
            Spacer()
            
            // Right Circle
            Circle()
                .fill(Color.lwHeaderCircle)
                .frame(width: 44, height: 44)
        }
        .padding(.horizontal, 20)
    }
}

struct StepRow: View {
    let step: String
    let title: String
    let subtitle: String
    let btnText: String
    let isActive: Bool
    let isLast: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Indicator Column
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .fill(isActive ? Color(red: 160/255, green: 124/255, blue: 1) : Color.lwPurpleInactive)
                        .frame(width: 32, height: 32)
                    
                    Text(step)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(isActive ? .black : .lwTextDark)
                }
                
                // Vertical Connecting Line
                if !isLast {
                    Rectangle()
                        .fill(Color.lwHeaderCircle) // Subtle line color
                        .frame(width: 2)
                        .frame(minHeight: 40) // Ensures spacing between rows
                }
            }
            .frame(width: 32) // Fixed width for alignment
            
            // Text Content
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.lwTextDark)
                    .padding(.top, 4) // Align visually with circle
                
                Text(subtitle)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.lwTextGray)
                
                Spacer().frame(height: 24) // Bottom spacing
            }
            
            Spacer()
            
            // Action Button
            Button(action: {}) {
                Text(btnText)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.lwButtonText)
                    .frame(width: 60, height: 36)
                    .background(Color.lwButtonPink)
                    .cornerRadius(8)
            }
            .padding(.top, 2) // Align button with top text
        }
    }
}

struct CustomTextField: View {
    let label: String
    let text: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // The Input Field Box
            HStack {
                Text(text)
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.lwTextDark)
                Spacer()
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 16)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.lwBorder, lineWidth: 1)
            )
            
            // The Floating Label
            Text(label)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.lwTextGray)
                .padding(.horizontal, 4)
                .background(Color.lwCardBg) // Masks the border behind the text
                .offset(x: 12, y: -10) // Move up to intersect border
        }
    }
}

// MARK: - 5. Helper: Hex Color Initializer
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
