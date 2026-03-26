import SwiftUI

// MARK: - 1. Entry Point
@main
struct QuizForgeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}

// MARK: - 2. Color Palette
extension Color {
    static let qfBackground = Color(hex: "FFFCF9") // Global background
    static let qfCardBg = Color(hex: "FFF5F0") // Main Card Background
    
    static let qfTextDark = Color(hex: "291E17") // Dark Brown Text
    static let qfTextSub = Color(hex: "6E6661") // Gray Text
    static let qfTextGold = Color(hex: "FCD462") // 45% text
    
    static let qfHeaderCircle = Color(hex: "FCE4D1")
    
    static let qfProgressOrange = Color(hex: "FF9642")
    static let qfProgressTrack = Color(hex: "EBE6F5")
    
    static let qfOptionBg = Color(hex: "FDECD9") // Peach button fill
    static let qfOptionBorder = Color(hex: "EBCBA6") // Darker peach border
    
    static let qfHintBg = Color(hex: "FCECCF")
    
    static let qfTrackerBg = Color(hex: "FFE4CE") // Tracker Card Bg
}

// MARK: - 3. Main Content View
struct ContentView: View {
    var body: some View {
        ZStack {
            // Global Background
            Color.qfBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // Header
                HeaderView()
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                        
                        // Quiz Card Section
                        VStack(alignment: .leading, spacing: 0) {
                            // Card Header: Title + Progress
                            HStack {
                                Text("Citrus crafts")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.qfTextDark)
                                Spacer()
                                Text("45%")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.qfTextGold)
                            }
                            .padding(.horizontal, 24)
                            .padding(.top, 24)
                            
                            // Progress Bar
                            HStack(spacing: 4) {
                                Capsule()
                                    .fill(Color.qfProgressOrange)
                                    .frame(width: 100, height: 5) // Fixed width for 45% approx
                                
                                Capsule()
                                    .fill(Color.qfProgressTrack)
                                    .frame(height: 5)
                                    .overlay(
                                        // Small orange dot at end for detail
                                        Circle()
                                            .fill(Color.qfProgressOrange)
                                            .frame(width: 4, height: 4)
                                            .offset(x: 2),
                                        alignment: .trailing
                                    )
                            }
                            .padding(.horizontal, 24)
                            .padding(.top, 10)
                            .padding(.bottom, 12)
                            
                            // Question
                            Text("Which zest carrier gives the brightest aroma when infused cold?")
                                .font(.system(size: 23, weight: .bold)) // Large, readable
                                .foregroundColor(.qfTextDark)
                                .lineSpacing(4)
                                .padding(.horizontal, 24)
                                .padding(.bottom, 24)
                            
                            // Options
                            VStack(spacing: 12) {
                                OptionButton(text: "Dried peel sachet")
                                OptionButton(text: "Twist garnish")
                                OptionButton(text: "Zester microplane")
                                OptionButton(text: "Candied strip")
                            }
                            .padding(.horizontal, 24)
                            .padding(.bottom, 24)
                            
                            // Hint Tag
                            Text("Hint: Think surface area")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.qfTextDark)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 16)
                                .background(Color.qfHintBg)
                                .cornerRadius(12)
                                .padding(.horizontal, 24)
                                .padding(.bottom, 24)
                            
                        }
                        .background(Color(red: 1, green: 243/255, blue: 232/255))
                        .cornerRadius(36)
                        
                        // Trackers Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Trackers")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.qfTextDark)
                                .padding(.leading, 4)
                            
                            HStack(spacing: 12) {
                                TrackerCard(
                                    label: "Current\nstreak",
                                    value: "5 days"
                                )
                                
                                TrackerCard(
                                    label: "Accuracy",
                                    value: "84%"
                                )
                                
                                TrackerCard(
                                    label: "Rank",
                                    value: "Top 12%"
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 40)
                }
            }
        }
        .statusBar(hidden: true)
    }
}

// MARK: - 4. Components

struct HeaderView: View {
    var body: some View {
        HStack {
            Circle()
                .fill(Color.qfHeaderCircle)
                .frame(width: 48, height: 48)
            
            Spacer()
            
            VStack(spacing: 2) {
                Text("QuizForge")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                Text("Aroma sprint")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.qfTextSub)
            }
            
            Spacer()
            
            Circle()
                .fill(Color.qfHeaderCircle)
                .frame(width: 48, height: 48)
        }
        .padding(.horizontal, 24)
    }
}

struct OptionButton: View {
    let text: String
    
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(.qfTextDark)
            Spacer()
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 18)
        .background(Color(red: 1, green: 228/255, blue: 204/255))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(red: 223/255, green: 170/255, blue: 128/255), lineWidth: 1)
        )
    }
}

struct TrackerCard: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(.qfTextSub)
                .fixedSize(horizontal: false, vertical: true) // Allow multiline wrapping
            
            Spacer()
            
            Text(value)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.qfTextDark)
                .minimumScaleFactor(0.8) // Shrink if text is too long
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, minHeight: 100, alignment: .leading)
        .background(Color.qfTrackerBg)
        .cornerRadius(24)
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
