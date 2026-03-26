import SwiftUI
import UIKit

// MARK: - 1. AppTokens Definition

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF1E3A8A)
        static let secondary = Color(hex: 0xFF2563EB)
        static let tertiary = Color(hex: 0xFF60A5FA)
        static let background = Color(hex: 0xFFF5F8FF)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFE8EEFA)
        static let outline = Color(hex: 0xFFCBD5E1)
        static let success = Color(hex: 0xFF16A34A)
        static let warning = Color(hex: 0xFFF59E0B)
        static let error = Color(hex: 0xFFEF4444)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFFFFFFFF)
        static let onTertiary = Color(hex: 0xFF0B1220)
        static let onBackground = Color(hex: 0xFF0B1220)
        static let onSurface = Color(hex: 0xFF0B1220)
    }

    struct TypographyTokens {
        static let display = Font.system(size: 28, weight: .bold)
        static let headline = Font.system(size: 20, weight: .semibold)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let smallCornerRadius: CGFloat = 8
        static let mediumCornerRadius: CGFloat = 12
        static let largeCornerRadius: CGFloat = 18
    }

    struct Spacing {
        static let xs: CGFloat = 6
        static let sm: CGFloat = 10
        static let md: CGFloat = 14
        static let lg: CGFloat = 18
        static let xl: CGFloat = 26
        static let xxl: CGFloat = 36
    }

    struct ShadowSpec {
        let elevation: CGFloat
        let radius: CGFloat
        let dy: CGFloat
        let opacity: Double
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 6, radius: 8, dy: 4, opacity: 0.16)
        static let level3 = ShadowSpec(elevation: 10, radius: 12, dy: 6, opacity: 0.18)
    }
}

// MARK: - 2. Status Bar Hiding Implementation

class HiddenStatusBarHostingController<Content: View>: UIHostingController<Content> {
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

struct HiddenStatusBarView<Content: View>: UIViewControllerRepresentable {
    let content: Content

    func makeUIViewController(context: Context) -> HiddenStatusBarHostingController<Content> {
        return HiddenStatusBarHostingController(rootView: content)
    }

    func updateUIViewController(_ uiViewController: HiddenStatusBarHostingController<Content>, context: Context) {}
}

// MARK: - 3. Custom Segmented Control with Checkmarks

struct SegmentedControl: View {
    @Binding var selectedIndex: Int
    let labels: [String]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<labels.count, id: \.self) { index in
                Button(action: {
                    selectedIndex = index
                }) {
                    HStack(spacing: AppTokens.Spacing.xs) {
                        if selectedIndex == index {
                            Image(systemName: "checkmark")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(AppTokens.Colors.onPrimary)
                        }
                        
                        Text(labels[index])
                            .font(AppTokens.TypographyTokens.label)
                            .foregroundColor(selectedIndex == index ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(
                        segmentShape(for: index)
                            .fill(selectedIndex == index ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                    )
                }
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: AppTokens.Shapes.mediumCornerRadius)
                .stroke(AppTokens.Colors.outline, lineWidth: 1)
        )
    }
    
    private func segmentShape(for index: Int) -> RoundedRectangle {
        let radius = AppTokens.Shapes.mediumCornerRadius
        if labels.count == 1 {
            return RoundedRectangle(cornerRadius: radius)
        } else if index == 0 {
            return RoundedRectangle(cornerRadius: radius, style: .continuous)
        } else if index == labels.count - 1 {
            return RoundedRectangle(cornerRadius: radius, style: .continuous)
        } else {
            return RoundedRectangle(cornerRadius: 0)
        }
    }
}

// MARK: - 4. RootScreen with Adjusted Passenger Card Size

struct RootScreen: View {
    @State private var name: String = ""
    @State private var code: String = ""
    @State private var selectedSeat: Int = 0
    @State private var showDialog: Bool = false

    let seatTabs = ["Economy", "Premium", "Business"]

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    AppTokens.Colors.tertiary.opacity(0.25),
                    AppTokens.Colors.background,
                    AppTokens.Colors.secondary.opacity(0.2)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea(.all)

            VStack(spacing: 0) {
                HStack {
                    Circle()
                        .fill(AppTokens.Colors.primary)
                        .frame(width: 22, height: 22)
                        .padding(.leading, AppTokens.Spacing.lg)

                    Spacer()

                    Text("Flight Check-in")
                        .font(AppTokens.TypographyTokens.display)
                        .foregroundColor(AppTokens.Colors.onSurface)

                    Spacer()

                    Circle()
                        .fill(AppTokens.Colors.secondary)
                        .frame(width: 22, height: 22)
                        .padding(.trailing, AppTokens.Spacing.lg)
                }
                .frame(height: 56)
                .padding(.bottom, AppTokens.Spacing.md)

                ScrollView {
                    VStack(spacing: AppTokens.Spacing.lg) {
                        // Passenger & Booking Card - 增大这个卡片
                        VStack(alignment: .leading, spacing: AppTokens.Spacing.lg) { // 增加内部间距
                            Text("Passenger")
                                .font(AppTokens.TypographyTokens.headline)
                                .foregroundColor(AppTokens.Colors.onSurface)

                            TextField("Full name", text: $name)
                                .font(AppTokens.TypographyTokens.body)
                                .padding(AppTokens.Spacing.md)
                                .background(AppTokens.Colors.surfaceVariant)
                                .cornerRadius(AppTokens.Shapes.mediumCornerRadius)
                                .foregroundColor(AppTokens.Colors.onSurface)
                                .overlay(
                                    RoundedRectangle(cornerRadius: AppTokens.Shapes.mediumCornerRadius)
                                        .stroke(AppTokens.Colors.outline, lineWidth: 1)
                                )

                            Text("Booking Code")
                                .font(AppTokens.TypographyTokens.headline)
                                .foregroundColor(AppTokens.Colors.onSurface)

                            TextField("e.g. XY7ZK2", text: $code)
                                .font(AppTokens.TypographyTokens.body)
                                .padding(AppTokens.Spacing.md)
                                .background(AppTokens.Colors.surfaceVariant)
                                .cornerRadius(AppTokens.Shapes.mediumCornerRadius)
                                .foregroundColor(AppTokens.Colors.onSurface)
                                .overlay(
                                    RoundedRectangle(cornerRadius: AppTokens.Shapes.mediumCornerRadius)
                                        .stroke(AppTokens.Colors.outline, lineWidth: 1)
                                )

                            Text("Seat Class")
                                .font(AppTokens.TypographyTokens.headline)
                                .foregroundColor(AppTokens.Colors.onSurface)

                            SegmentedControl(selectedIndex: $selectedSeat, labels: seatTabs)
                        }
                        .padding(AppTokens.Spacing.xl) // 增加内边距使卡片更大
                        .background(AppTokens.Colors.surface)
                        .cornerRadius(AppTokens.Shapes.largeCornerRadius)
                        .shadow(color: .black.opacity(AppTokens.ElevationMapping.level2.opacity),
                                radius: AppTokens.ElevationMapping.level2.radius,
                                x: 0,
                                y: AppTokens.ElevationMapping.level2.dy)

                        // Flight Details Card
                        VStack(alignment: .leading, spacing: AppTokens.Spacing.md) {
                            // Flight信息行 - 添加白色背景
                            HStack {
                                VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) {
                                    Text("Flight")
                                        .font(AppTokens.TypographyTokens.title)
                                        .foregroundColor(AppTokens.Colors.onSurface)
                                    Text("BL 213 • HND → CTS")
                                        .font(AppTokens.TypographyTokens.body)
                                        .foregroundColor(AppTokens.Colors.onSurface)
                                }
                                Spacer()
                                Circle()
                                    .fill(AppTokens.Colors.secondary)
                                    .frame(width: 36, height: 36)
                            }
                            .padding(AppTokens.Spacing.md)
                            .background(AppTokens.Colors.surface)
                            .cornerRadius(AppTokens.Shapes.mediumCornerRadius)

                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Boarding")
                                        .font(AppTokens.TypographyTokens.label)
                                        .foregroundColor(AppTokens.Colors.onSurface)
                                    Text("12:35")
                                        .font(AppTokens.TypographyTokens.title)
                                        .foregroundColor(AppTokens.Colors.primary)
                                }
                                Spacer()
                                VStack(alignment: .leading) {
                                    Text("Gate")
                                        .font(AppTokens.TypographyTokens.label)
                                        .foregroundColor(AppTokens.Colors.onSurface)
                                    Text("A12")
                                        .font(AppTokens.TypographyTokens.title)
                                        .foregroundColor(AppTokens.Colors.primary)
                                }
                                Spacer()
                                VStack(alignment: .leading) {
                                    Text("Seat")
                                        .font(AppTokens.TypographyTokens.label)
                                        .foregroundColor(AppTokens.Colors.onSurface)
                                    Text(seatNumber(for: selectedSeat))
                                        .font(AppTokens.TypographyTokens.title)
                                        .foregroundColor(AppTokens.Colors.primary)
                                }
                            }
                            .padding(.vertical, AppTokens.Spacing.md)

                            Button(action: {
                                showDialog = true
                            }) {
                                Text("Confirm Check-in")
                                    .font(AppTokens.TypographyTokens.title)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 52)
                                    .background(AppTokens.Colors.primary)
                                    .foregroundColor(AppTokens.Colors.onPrimary)
                                    .cornerRadius(AppTokens.Shapes.largeCornerRadius)
                            }
                        }
                        .padding(AppTokens.Spacing.lg)
                        .background(AppTokens.Colors.surface)
                        .cornerRadius(AppTokens.Shapes.largeCornerRadius)
                        .shadow(color: .black.opacity(AppTokens.ElevationMapping.level2.opacity),
                                radius: AppTokens.ElevationMapping.level2.radius,
                                x: 0,
                                y: AppTokens.ElevationMapping.level2.dy)
                    }
                    .padding(.horizontal, AppTokens.Spacing.lg)
                    .padding(.vertical, AppTokens.Spacing.md)
                }
            }
        }
        .alert("Check-in Successful", isPresented: $showDialog) {
            Button("Done") {
                showDialog = false
            }
        } message: {
            Text("Boarding pass is ready. Have a nice flight.")
        }
    }

    private func seatNumber(for index: Int) -> String {
        if index == 0 {
            return "23C"
        } else if index == 1 {
            return "11A"
        } else {
            return "2F"
        }
    }
}

// MARK: - 5. App Entry Point

@main
struct FlightCheckinApp: App {
    var body: some Scene {
        WindowGroup {
            HiddenStatusBarView(content: RootScreen())
        }
    }
}