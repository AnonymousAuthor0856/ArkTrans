import SwiftUI

// MARK: - 1. Entry Point
@main
struct ReliefFundApp: App {
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
    static let rfBackground = Color(hex: "FBF8F3")
    static let rfCardBg = Color(hex: "F7F3EE")
    
    // Header & Summary
    static let rfHeaderCircle = Color(hex: "EBE2D6")
    static let rfSummaryRow = Color(hex: "EBE2D6")
    
    // Text
    static let rfTextDark = Color(hex: "3D352E")
    static let rfTextGray = Color(hex: "8A8A8E")
    static let rfPlaceholder = Color(hex: "6D5F58")
    
    // Buttons & Borders
    static let rfBorder = Color(hex: "C5B8A9")
    static let rfButtonBack = Color(hex: "EBE2D6")
    static let rfButtonNext = Color(hex: "B58B5A")
}

// MARK: - 3. Main Content View
struct ContentView: View {
    var body: some View {
        ZStack {
            // Global Background
            Color.rfBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // Header
                HeaderView()
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                
                // Scrollable Content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        // Main Form Card
                        ApplicantDetailsCard()
                        
                        // Summary Card
                        SummaryCard()
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 40)
                }
            }
        }
        .statusBar(hidden: true) // Requirement: Hide Status Bar
    }
}

// MARK: - 4. Components

struct HeaderView: View {
    var body: some View {
        HStack {
            Circle().fill(Color.rfHeaderCircle).frame(width: 48, height: 48)
            Spacer()
            VStack(spacing: 2) {
                Text("ReliefFund")
                    .font(.system(size: 19, weight: .bold))
                    .foregroundColor(.rfTextDark)
                Text("Civic support intake")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.rfTextGray)
            }
            Spacer()
            Circle().fill(Color.rfHeaderCircle).frame(width: 48, height: 48)
        }
        .padding(.horizontal, 24)
    }
}

struct ApplicantDetailsCard: View {
    @State private var fullName = ""
    @State private var organization = ""
    @State private var contact = ""
    @State private var narrative = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Applicant details")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.rfTextDark)
                .padding(.bottom, 4)
            
            // Form Fields
            CustomTextField(placeholder: "Full name", text: $fullName,height: 18)
            CustomTextField(placeholder: "Organization", text: $organization, height: 18)
            CustomTextField(placeholder: "Contact", text: $contact, height: 18)
            
            // Using a simple text field styled to look like a text editor for this layout
            CustomTextField(placeholder: "Relief narrative", text: $narrative, height: 18, alignment: .topLeading)
                .padding(.bottom, 90)
            
            // Navigation Buttons
            HStack(spacing: 2) {
                FormButton(label: "Back", isPrimary: false)
                Spacer()
                FormButton(label: "Next", isPrimary: true)
            }
            .padding(.top, 80)
        }
        .padding(24)
        .background(Color.rfCardBg)
        .cornerRadius(32)
    }
}

struct SummaryCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Summary")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.rfTextDark)
            
            SummaryRow(label: "Requested", value: "$4,500")
        }
        .padding(24)
        .background(Color.rfCardBg)
        .cornerRadius(32)
    }
}

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    var height: CGFloat = 40
    var alignment: Alignment = .leading
    
    var body: some View {
        TextField(placeholder, text: $text, axis: height > 60 ? .vertical : .horizontal)
            .font(.system(size: 16))
            .foregroundColor(.rfTextDark)
            .padding(.horizontal, 16)
            .frame(height: height, alignment: alignment)
            .background(Color.rfBackground) // Slightly lighter than card bg
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.rfBorder, lineWidth: 1.5)
            )
            .onTapGesture {
                // Allows tapping entire area
            }
    }
}

struct FormButton: View {
    let label: String
    let isPrimary: Bool
    
    var body: some View {
        Button(action: {}) {
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
                .padding(.vertical, 48)
                .frame(maxWidth: 600)
                .background(isPrimary ? Color.rfButtonNext : Color.rfButtonBack)
                .cornerRadius(16)
        }
    }
}

struct SummaryRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.rfTextDark)
            Spacer()
            Text(value)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.black)
        }
        .padding(20)
        .background(Color.rfSummaryRow)
        .cornerRadius(16)
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
