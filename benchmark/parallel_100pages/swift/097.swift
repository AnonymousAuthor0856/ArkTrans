import SwiftUI


struct Dimensions {
    static let screenPadding: CGFloat = 24
    static let headerTopPadding: CGFloat = 16 
    static let headerSpacerHeight: CGFloat = 40
    static let dialSectionSpacerHeight: CGFloat = 40

        static let dialOuterBoxSize: CGFloat = 280 
    static let dialCanvasSize: CGFloat = 240 
    static let dialStrokeWidth: CGFloat = 40
    static let knobRadiusOuter: CGFloat = 16
    static let knobRadiusInner: CGFloat = 10
    static let tempControlsSpacerHeight: CGFloat = 32
    static let tempControlsHorizontalSpacing: CGFloat = 32

        static let roundControlButtonSize: CGFloat = 56
    static let roundControlButtonBorderWidth: CGFloat = 1
    static let roundControlButtonIconSize: CGFloat = 28

        static let quickActionsTitleBottomPadding: CGFloat = 16
    static let quickActionsRowSpacing: CGFloat = 16
    static let quickActionCardHeight: CGFloat = 100
    static let quickActionCardCornerRadius: CGFloat = 20
    static let quickActionCardPadding: CGFloat = 16
    static let quickActionCardIconSize: CGFloat = 24

        static let letterSpacingSmall: CGFloat = 2 
    static let fontSizeLabelMedium: CGFloat = 13 
    static let fontSizeBodySmall: CGFloat = 11 
    static let fontSizeDisplayMedium: CGFloat = 45 
    static let fontSizeLabelLarge: CGFloat = 15 
    static let fontSizeLabelSmall: CGFloat = 11 
    static let fontWeightSemiBold: Font.Weight = .semibold 
}

extension Color {
    static let pureWhite = Color(hex: 0xFFFFFFFF)
    static let textBlack = Color(hex: 0xFF1C1C1E)
    static let textGray = Color(hex: 0xFF8E8E93)
    static let accentBlue = Color(hex: 0xFF007AFF)
    static let softGrayBg = Color(hex: 0xFFF2F2F7)
    static let activeOrange = Color(hex: 0xFFFF9500) 
    static let lightGrayBg = Color(hex: 0xFFF9F9F9) 
    static let lightBorderGray = Color(hex: 0xFFEEEEEE) 
    static let disabledIconGray = Color(hex: 0xFFD1D1D6) 
}

extension Color {
    init(hex: UInt) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0
        )
    }
}


@main
struct ClimateControllerApp: App {
    var body: some Scene {
        WindowGroup {
            ClimateControllerView()
                                .ignoresSafeArea() 
                .statusBarHidden(true) 
        }
    }
}


struct ClimateControllerView: View {
    var body: some View {
                Color.pureWhite
            .ignoresSafeArea() 
            .overlay(
                VStack(spacing: 0) { 
                    HeaderSection()
                                                .padding(.top, Dimensions.headerTopPadding)

                    Spacer()
                        .frame(height: Dimensions.headerSpacerHeight)

                    TemperatureDialSection()

                    Spacer()
                        .frame(height: Dimensions.dialSectionSpacerHeight)

                    ControlGridSection()

                    Spacer() 
                }
                .padding(.horizontal, Dimensions.screenPadding) 
            )
    }
}


struct HeaderSection: View {
    var body: some View {
        HStack {
            Button(action: {  }) {
                Image(systemName: "line.horizontal.3") 
                    .font(.system(size: Dimensions.roundControlButtonIconSize)) 
                    .foregroundColor(.textBlack)
            }
            .buttonStyle(PlainButtonStyle()) 

            Spacer()

            VStack {
                Text("LIVING ROOM")
                    .font(.system(size: Dimensions.fontSizeLabelMedium, weight: .bold))
                    .foregroundColor(.textGray)
                    .tracking(Dimensions.letterSpacingSmall) 
                Text("Connected")
                    .font(.system(size: Dimensions.fontSizeBodySmall, weight: .regular))
                    .foregroundColor(.accentBlue)
            }

            Spacer()

            Button(action: {  }) {
                Image(systemName: "gearshape.fill") 
                    .font(.system(size: Dimensions.roundControlButtonIconSize)) 
                    .foregroundColor(.textBlack)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .frame(maxWidth: .infinity) 
    }
}


struct TemperatureDialSection: View {
    @State private var targetTemp: Float = 21.5
    @State private var isActive: Bool = true

        private func adjustTemp(delta: Float) {
        let newTemp = (targetTemp + delta).clamped(to: 16.0...30.0)
        targetTemp = (round(newTemp * 10) / 10.0)
    }

    var body: some View {
        VStack(alignment: .center) { 
            ZStack { 
                                Circle()
                    .stroke(Color.softGrayBg, lineWidth: Dimensions.dialStrokeWidth)
                    .frame(width: Dimensions.dialCanvasSize, height: Dimensions.dialCanvasSize)

                                TemperatureDial(
                    progress: (targetTemp - 16.0) / (30.0 - 16.0), 
                    isActive: isActive
                )
                .frame(width: Dimensions.dialCanvasSize, height: Dimensions.dialCanvasSize)

                                VStack(alignment: .center) { 
                    Text("\(targetTemp, specifier: "%.1f")°") 
                        .font(.system(size: Dimensions.fontSizeDisplayMedium, weight: .bold))
                        .foregroundColor(isActive ? .textBlack : .textGray)
                    Text(isActive ? "COOLING" : "OFF")
                        .font(.system(size: Dimensions.fontSizeLabelLarge, weight: .medium))
                        .foregroundColor(.textGray)
                }
            }
            .frame(width: Dimensions.dialOuterBoxSize, height: Dimensions.dialOuterBoxSize) 

            Spacer()
                .frame(height: Dimensions.tempControlsSpacerHeight)

                        HStack(spacing: Dimensions.tempControlsHorizontalSpacing) { 
                RoundControlButton(
                    iconName: "chevron.down", 
                    action: { adjustTemp(delta: -0.5) },
                    enabled: isActive
                )

                                Toggle(isOn: $isActive) {
                                    }
                .toggleStyle(SwitchToggleStyle(tint: .textBlack)) 
                                                                                                
                RoundControlButton(
                    iconName: "chevron.up", 
                    action: { adjustTemp(delta: 0.5) },
                    enabled: isActive
                )
            }
        }
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}


struct TemperatureDial: View {
    var progress: Float 
    var isActive: Bool

        @State private var animatedProgress: Float = 0.0

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let strokeWidth = Dimensions.dialStrokeWidth
            let startAngleDegrees: Double = 135
            let sweepAngleDegrees: Double = 270 * Double(animatedProgress)
            let endAngleDegrees: Double = startAngleDegrees + sweepAngleDegrees

                        let radius = (min(size.width, size.height) - strokeWidth) / 2
            let center = CGPoint(x: size.width / 2, y: size.height / 2)

            Path { path in
                path.addArc(
                    center: center,
                    radius: radius,
                    startAngle: .degrees(startAngleDegrees),
                    endAngle: .degrees(endAngleDegrees),
                    clockwise: false 
                )
            }
            .stroke(isActive ? Color.accentBlue : Color.textGray,
                    style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
            .onAppear {
                                withAnimation(.easeOut(duration: 0.5)) {
                    animatedProgress = progress
                }
            }
            .onChange(of: progress) { newValue in 
                withAnimation(.easeOut(duration: 0.5)) {
                    animatedProgress = newValue
                }
            }
            .overlay(
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


struct RoundControlButton: View {
    let iconName: String 
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
        .clipShape(Circle()) 
        .overlay(
            Circle() 
                .stroke(enabled ? Color.clear : Color.lightBorderGray, lineWidth: Dimensions.roundControlButtonBorderWidth)
        )
        .disabled(!enabled) 
        .buttonStyle(PlainButtonStyle()) 
    }
}


struct ControlGridSection: View {
    var body: some View {
        VStack(alignment: .leading) { 
            Text("QUICK ACTIONS")
                .font(.system(size: Dimensions.fontSizeLabelSmall, weight: .bold))
                .foregroundColor(.textGray)
                .padding(.bottom, Dimensions.quickActionsTitleBottomPadding)

            HStack(spacing: Dimensions.quickActionsRowSpacing) { 
                QuickActionCard(
                    iconName: "arrow.clockwise", 
                    label: "Fan Speed",
                    status: "Auto"
                )
                QuickActionCard(
                    iconName: "heart.fill", 
                    label: "Eco Mode",
                    status: "On",
                    isActive: true
                )
            }

            Spacer()
                .frame(height: Dimensions.quickActionsRowSpacing) 

            HStack(spacing: Dimensions.quickActionsRowSpacing) {
                QuickActionCard(
                    iconName: "info.circle.fill", 
                    label: "Timer",
                    status: "Set 2h"
                )
                QuickActionCard(
                    iconName: "house.fill", 
                    label: "Away",
                    status: "Off"
                )
            }
        }
        .frame(maxWidth: .infinity) 
    }
}


struct QuickActionCard: View {
    let iconName: String 
    let label: String
    let status: String
    var isActive: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) { 
            Image(systemName: iconName)
                .font(.system(size: Dimensions.quickActionCardIconSize))
                .foregroundColor(isActive ? .pureWhite : .textBlack)
                .padding(.bottom, 8) 

            Spacer() 

            VStack(alignment: .leading) {
                Text(label)
                    .font(.system(size: Dimensions.fontSizeLabelMedium, weight: Dimensions.fontWeightSemiBold))
                    .foregroundColor(isActive ? .pureWhite : .textBlack)
                Text(status)
                    .font(.system(size: Dimensions.fontSizeBodySmall, weight: .regular))
                    .foregroundColor(.textGray) 
            }
        }
        .padding(Dimensions.quickActionCardPadding) 
        .frame(height: Dimensions.quickActionCardHeight) 
        .frame(maxWidth: .infinity) 
        .background(isActive ? Color.textBlack : Color.softGrayBg) 
        .cornerRadius(Dimensions.quickActionCardCornerRadius) 
            }
}


struct ClimateControllerView_Previews: PreviewProvider {
    static var previews: some View {
        ClimateControllerView()
    }
}