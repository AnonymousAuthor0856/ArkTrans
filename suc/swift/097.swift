import SwiftUI

// MARK: - 1. Constants and Colors for Atomic Correspondence

// Define dimensions as constants for easy modification and atomic correspondence
struct Dimensions {
    static let screenPadding: CGFloat = 24
    static let headerTopPadding: CGFloat = 16 // Extra padding for immersive status bar area
    static let headerSpacerHeight: CGFloat = 40
    static let dialSectionSpacerHeight: CGFloat = 40

    // Temperature Dial Section
    static let dialOuterBoxSize: CGFloat = 280 // Corresponds to Modifier.size(280.dp)
    static let dialCanvasSize: CGFloat = 240 // Corresponds to Canvas Modifier.size(240.dp)
    static let dialStrokeWidth: CGFloat = 40
    static let knobRadiusOuter: CGFloat = 16
    static let knobRadiusInner: CGFloat = 10
    static let tempControlsSpacerHeight: CGFloat = 32
    static let tempControlsHorizontalSpacing: CGFloat = 32

    // Round Control Button
    static let roundControlButtonSize: CGFloat = 56
    static let roundControlButtonBorderWidth: CGFloat = 1
    static let roundControlButtonIconSize: CGFloat = 28

    // Control Grid Section
    static let quickActionsTitleBottomPadding: CGFloat = 16
    static let quickActionsRowSpacing: CGFloat = 16
    static let quickActionCardHeight: CGFloat = 100
    static let quickActionCardCornerRadius: CGFloat = 20
    static let quickActionCardPadding: CGFloat = 16
    static let quickActionCardIconSize: CGFloat = 24

    // Typography specific values
    static let letterSpacingSmall: CGFloat = 2 // Corresponds to 2.sp
    static let fontSizeLabelMedium: CGFloat = 13 // Estimate for MaterialTheme.typography.labelMedium
    static let fontSizeBodySmall: CGFloat = 11 // Estimate for MaterialTheme.typography.bodySmall
    static let fontSizeDisplayMedium: CGFloat = 45 // Estimate for MaterialTheme.typography.displayMedium
    static let fontSizeLabelLarge: CGFloat = 15 // Estimate for MaterialTheme.typography.labelLarge
    static let fontSizeLabelSmall: CGFloat = 11 // Estimate for MaterialTheme.typography.labelSmall
    static let fontWeightSemiBold: Font.Weight = .semibold // For labelMedium in QuickActionCard
}

// Define custom colors using hex values for precise matching
extension Color {
    static let pureWhite = Color(hex: 0xFFFFFFFF)
    static let textBlack = Color(hex: 0xFF1C1C1E)
    static let textGray = Color(hex: 0xFF8E8E93)
    static let accentBlue = Color(hex: 0xFF007AFF)
    static let softGrayBg = Color(hex: 0xFFF2F2F7)
    static let activeOrange = Color(hex: 0xFFFF9500) // Not used in this specific UI, but defined for completeness
    static let lightGrayBg = Color(hex: 0xFFF9F9F9) // Corresponds to Color(0xFFF9F9F9)
    static let lightBorderGray = Color(hex: 0xFFEEEEEE) // Corresponds to Color(0xFFEEEEEE)
    static let disabledIconGray = Color(hex: 0xFFD1D1D6) // Corresponds to Color(0xFFD1D1D6)
}

// Helper for Hex Colors initialization
extension Color {
    init(hex: UInt) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0
        )
    }
}

// MARK: - 5. @main Entry Point

@main
struct ClimateControllerApp: App {
    var body: some Scene {
        WindowGroup {
            ClimateControllerView()
                // Requirement 2: App must be full screen and top status bar hidden
                .ignoresSafeArea() // Extends content to the edges, including under the status bar
                .statusBarHidden(true) // Hides the status bar for the entire app
        }
    }
}

// MARK: - Main View (ClimateControllerApp equivalent)

struct ClimateControllerView: View {
    var body: some View {
        // Constraint: Global Pure White Background
        Color.pureWhite
            .ignoresSafeArea() // Ensure the background fills the entire screen
            .overlay(
                VStack(spacing: 0) { // Use spacing: 0 and explicit Spacers for precise control
                    HeaderSection()
                        // Extra padding for immersive status bar area, as in Android's .padding(top = 16.dp)
                        .padding(.top, Dimensions.headerTopPadding)

                    Spacer()
                        .frame(height: Dimensions.headerSpacerHeight)

                    TemperatureDialSection()

                    Spacer()
                        .frame(height: Dimensions.dialSectionSpacerHeight)

                    ControlGridSection()

                    Spacer() // Pushes content to top if there's extra space
                }
                .padding(.horizontal, Dimensions.screenPadding) // Horizontal padding for the whole column
            )
    }
}

// MARK: - Header Section

struct HeaderSection: View {
    var body: some View {
        HStack {
            Button(action: { /* No op */ }) {
                Image(systemName: "line.horizontal.3") // SF Symbol for Menu
                    .font(.system(size: Dimensions.roundControlButtonIconSize)) // Match icon size
                    .foregroundColor(.textBlack)
            }
            .buttonStyle(PlainButtonStyle()) // Remove default button styling

            Spacer()

            VStack {
                Text("LIVING ROOM")
                    .font(.system(size: Dimensions.fontSizeLabelMedium, weight: .bold))
                    .foregroundColor(.textGray)
                    .tracking(Dimensions.letterSpacingSmall) // letterSpacing = 2.sp
                Text("Connected")
                    .font(.system(size: Dimensions.fontSizeBodySmall, weight: .regular))
                    .foregroundColor(.accentBlue)
            }

            Spacer()

            Button(action: { /* No op */ }) {
                Image(systemName: "gearshape.fill") // SF Symbol for Settings
                    .font(.system(size: Dimensions.roundControlButtonIconSize)) // Match icon size
                    .foregroundColor(.textBlack)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .frame(maxWidth: .infinity) // Equivalent to Modifier.fillMaxWidth()
    }
}

// MARK: - Temperature Dial Section

struct TemperatureDialSection: View {
    @State private var targetTemp: Float = 21.5
    @State private var isActive: Bool = true

    // Logic to clamp temperature, ensuring one decimal place
    private func adjustTemp(delta: Float) {
        let newTemp = (targetTemp + delta).clamped(to: 16.0...30.0)
        targetTemp = (round(newTemp * 10) / 10.0)
    }

    var body: some View {
        VStack(alignment: .center) { // Equivalent to Column(horizontalAlignment = Alignment.CenterHorizontally)
            ZStack { // Equivalent to Box(contentAlignment = Alignment.Center)
                // Background Circle
                Circle()
                    .stroke(Color.softGrayBg, lineWidth: Dimensions.dialStrokeWidth)
                    .frame(width: Dimensions.dialCanvasSize, height: Dimensions.dialCanvasSize)

                // Animated Arc Indicator and Knob
                TemperatureDial(
                    progress: (targetTemp - 16.0) / (30.0 - 16.0), // Normalize 0..1
                    isActive: isActive
                )
                .frame(width: Dimensions.dialCanvasSize, height: Dimensions.dialCanvasSize)

                // Center Text
                VStack(alignment: .center) { // Equivalent to Column(horizontalAlignment = Alignment.CenterHorizontally)
                    Text("\(targetTemp, specifier: "%.1f")°") // Format to one decimal place
                        .font(.system(size: Dimensions.fontSizeDisplayMedium, weight: .bold))
                        .foregroundColor(isActive ? .textBlack : .textGray)
                    Text(isActive ? "COOLING" : "OFF")
                        .font(.system(size: Dimensions.fontSizeLabelLarge, weight: .medium))
                        .foregroundColor(.textGray)
                }
            }
            .frame(width: Dimensions.dialOuterBoxSize, height: Dimensions.dialOuterBoxSize) // Corresponds to Modifier.size(280.dp)

            Spacer()
                .frame(height: Dimensions.tempControlsSpacerHeight)

            // Temp Controls
            HStack(spacing: Dimensions.tempControlsHorizontalSpacing) { // Equivalent to Arrangement.spacedBy(32.dp)
                RoundControlButton(
                    iconName: "chevron.down", // SF Symbol for KeyboardArrowDown
                    action: { adjustTemp(delta: -0.5) },
                    enabled: isActive
                )

                // Power Switch
                Toggle(isOn: $isActive) {
                    // Empty label, as we only want the switch visual
                }
                .toggleStyle(SwitchToggleStyle(tint: .textBlack)) // Sets the track color when "on"
                // Note: Customizing the unchecked thumb color and unchecked track color
                // for Toggle in iOS 16 is challenging without a custom ToggleStyle
                // that rebuilds the UI from scratch. The default gray for unchecked
                // thumb and track is visually close to the Kotlin version's TextGray
                // and SoftGrayBg respectively, prioritizing direct translation and
                // iOS 16 compatibility.

                RoundControlButton(
                    iconName: "chevron.up", // SF Symbol for KeyboardArrowUp (increasing temperature)
                    action: { adjustTemp(delta: 0.5) },
                    enabled: isActive
                )
            }
        }
    }
}

// Helper for clamping floats
extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

// MARK: - Custom Temperature Dial Drawing (Canvas equivalent)

struct TemperatureDial: View {
    var progress: Float // Normalized progress 0.0 to 1.0
    var isActive: Bool

    // Animate progress using @State and withAnimation
    @State private var animatedProgress: Float = 0.0

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let strokeWidth = Dimensions.dialStrokeWidth
            let startAngleDegrees: Double = 135
            let sweepAngleDegrees: Double = 270 * Double(animatedProgress)
            let endAngleDegrees: Double = startAngleDegrees + sweepAngleDegrees

            // Calculate radius for the arc
            let radius = (min(size.width, size.height) - strokeWidth) / 2
            let center = CGPoint(x: size.width / 2, y: size.height / 2)

            Path { path in
                path.addArc(
                    center: center,
                    radius: radius,
                    startAngle: .degrees(startAngleDegrees),
                    endAngle: .degrees(endAngleDegrees),
                    clockwise: false // In SwiftUI, for startAngle < endAngle, clockwise: false sweeps clockwise
                )
            }
            .stroke(isActive ? Color.accentBlue : Color.textGray,
                    style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
            .onAppear {
                // Apply animation when the view appears
                withAnimation(.easeOut(duration: 0.5)) {
                    animatedProgress = progress
                }
            }
            .onChange(of: progress) { newValue in // Animate when progress changes
                withAnimation(.easeOut(duration: 0.5)) {
                    animatedProgress = newValue
                }
            }
            .overlay(
                // Knob Indicator
                knobView(center: center, radius: radius, angleDegrees: endAngleDegrees)
            )
        }
    }

    @ViewBuilder
    private func knobView(center: CGPoint, radius: CGFloat, angleDegrees: Double) -> some View {
        let angleInRadians = Angle.degrees(angleDegrees).radians
        let knobX = center.x + radius * cos(angleInRadians)
        let knobY = center.y + radius * sin(angleInRadians)

        ZStack {
            Circle()
                .fill(Color.pureWhite)
                .frame(width: Dimensions.knobRadiusOuter * 2, height: Dimensions.knobRadiusOuter * 2)
            Circle()
                .fill(isActive ? Color.accentBlue : Color.textGray)
                .frame(width: Dimensions.knobRadiusInner * 2, height: Dimensions.knobRadiusInner * 2)
        }
        .position(x: knobX, y: knobY)
    }
}

// MARK: - Round Control Button

struct RoundControlButton: View {
    let iconName: String // SF Symbol name
    let action: () -> Void
    let enabled: Bool

    var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .font(.system(size: Dimensions.roundControlButtonIconSize))
                .foregroundColor(enabled ? .textBlack : .disabledIconGray)
        }
        .frame(width: Dimensions.roundControlButtonSize, height: Dimensions.roundControlButtonSize)
        .background(enabled ? Color.softGrayBg : Color.lightGrayBg)
        .clipShape(Circle()) // Equivalent to .clip(CircleShape)
        .overlay(
            Circle() // Equivalent to .border(..., CircleShape)
                .stroke(enabled ? Color.clear : Color.lightBorderGray, lineWidth: Dimensions.roundControlButtonBorderWidth)
        )
        .disabled(!enabled) // Disable button interaction
        .buttonStyle(PlainButtonStyle()) // Remove default button styling
    }
}

// MARK: - Control Grid Section

struct ControlGridSection: View {
    var body: some View {
        VStack(alignment: .leading) { // Equivalent to Column(horizontalAlignment = Alignment.Start)
            Text("QUICK ACTIONS")
                .font(.system(size: Dimensions.fontSizeLabelSmall, weight: .bold))
                .foregroundColor(.textGray)
                .padding(.bottom, Dimensions.quickActionsTitleBottomPadding)

            HStack(spacing: Dimensions.quickActionsRowSpacing) { // Equivalent to Arrangement.spacedBy(16.dp)
                QuickActionCard(
                    iconName: "arrow.clockwise", // SF Symbol for Refresh
                    label: "Fan Speed",
                    status: "Auto"
                )
                QuickActionCard(
                    iconName: "heart.fill", // SF Symbol for Favorite
                    label: "Eco Mode",
                    status: "On",
                    isActive: true
                )
            }

            Spacer()
                .frame(height: Dimensions.quickActionsRowSpacing) // Equivalent to Modifier.height(16.dp)

            HStack(spacing: Dimensions.quickActionsRowSpacing) {
                QuickActionCard(
                    iconName: "info.circle.fill", // SF Symbol for Info (used as timer icon)
                    label: "Timer",
                    status: "Set 2h"
                )
                QuickActionCard(
                    iconName: "house.fill", // SF Symbol for Home
                    label: "Away",
                    status: "Off"
                )
            }
        }
        .frame(maxWidth: .infinity) // Equivalent to Modifier.fillMaxWidth()
    }
}

// MARK: - Quick Action Card

struct QuickActionCard: View {
    let iconName: String // SF Symbol name
    let label: String
    let status: String
    var isActive: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) { // Equivalent to Column(horizontalAlignment = Alignment.Start)
            Image(systemName: iconName)
                .font(.system(size: Dimensions.quickActionCardIconSize))
                .foregroundColor(isActive ? .pureWhite : .textBlack)
                .padding(.bottom, 8) // Manual spacing between icon and text

            Spacer() // Equivalent to verticalArrangement = Arrangement.SpaceBetween, pushing content apart

            VStack(alignment: .leading) {
                Text(label)
                    .font(.system(size: Dimensions.fontSizeLabelMedium, weight: Dimensions.fontWeightSemiBold))
                    .foregroundColor(isActive ? .pureWhite : .textBlack)
                Text(status)
                    .font(.system(size: Dimensions.fontSizeBodySmall, weight: .regular))
                    .foregroundColor(.textGray) // TextGray for both active/inactive status as per Kotlin
            }
        }
        .padding(Dimensions.quickActionCardPadding) // Equivalent to Modifier.padding(16.dp)
        .frame(height: Dimensions.quickActionCardHeight) // Equivalent to Modifier.height(100.dp)
        .frame(maxWidth: .infinity) // Equivalent to Modifier.weight(1f) in a Row
        .background(isActive ? Color.textBlack : Color.softGrayBg) // Equivalent to CardDefaults.cardColors
        .cornerRadius(Dimensions.quickActionCardCornerRadius) // Equivalent to RoundedCornerShape(20.dp)
        // No shadow needed as elevation = 0.dp in Kotlin
    }
}

// MARK: - Preview

struct ClimateControllerView_Previews: PreviewProvider {
    static var previews: some View {
        ClimateControllerView()
    }
}