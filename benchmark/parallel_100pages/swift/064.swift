import SwiftUI

struct AppTokens {
    struct Colors {
        static let primary = Color(red: 0x11 / 255.0, green: 0x11 / 255.0, blue: 0x11 / 255.0)
        static let secondary = Color(red: 0x2A / 255.0, green: 0x2A / 255.0, blue: 0x2A / 255.0)
        static let tertiary = Color(red: 0x44 / 255.0, green: 0x44 / 255.0, blue: 0x44 / 255.0)
        static let background = Color(red: 0xF7 / 255.0, green: 0xF7 / 255.0, blue: 0xF7 / 255.0)
        static let surface = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let surfaceVariant = Color(red: 0xED / 255.0, green: 0xED / 255.0, blue: 0xED / 255.0)
        static let outline = Color(red: 0xD6 / 255.0, green: 0xD6 / 255.0, blue: 0xD6 / 255.0)
        static let success = Color(red: 0x1E / 255.0, green: 0x7D / 255.0, blue: 0x4C / 255.0)
        static let warning = Color(red: 0xB9 / 255.0, green: 0x84 / 255.0, blue: 0x00 / 255.0)
        static let error = Color(red: 0xB3 / 255.0, green: 0x26 / 255.0, blue: 0x1E / 255.0)
        static let onPrimary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onSecondary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onTertiary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onBackground = Color(red: 0x0A / 255.0, green: 0x0A / 255.0, blue: 0x0A / 255.0)
        static let onSurface = Color(red: 0x0A / 255.0, green: 0x0A / 255.0, blue: 0x0A / 255.0)
    }

    struct TypographyTokens {
                        static let display = Font.system(size: 28, weight: .semibold)
        static let headline = Font.system(size: 20, weight: .medium)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small = CGFloat(8)
        static let medium = CGFloat(12)
        static let large = CGFloat(16)
    }

    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
    }

    struct ShadowSpec {
        let elevation: CGFloat 
        let radius: CGFloat    
        let dy: CGFloat        
        let opacity: Double    
    }

    struct ElevationMapping {
                        static let level1 = ShadowSpec(elevation: 1, radius: 4, dy: 2, opacity: 0.10)
        static let level2 = ShadowSpec(elevation: 3, radius: 8, dy: 4, opacity: 0.14)
        static let level3 = ShadowSpec(elevation: 6, radius: 12, dy: 6, opacity: 0.16)
    }
}


extension View {
    func appShadow(spec: AppTokens.ShadowSpec) -> some View {
        self.shadow(color: Color.black.opacity(spec.opacity), radius: spec.radius, x: 0, y: spec.dy)
    }
}

extension View {
    func appBorder<S: Shape>(width: CGFloat, color: Color, shape: S) -> some View {
        self.overlay(shape.stroke(color, lineWidth: width))
    }
}

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func ifLet<V, Content: View>(_ value: V?, transform: (Self, V) -> Content) -> some View {
        if let value = value {
            transform(self, value)
        } else {
            self
        }
    }
}


private struct AppColorSchemeKey: EnvironmentKey {
    static let defaultValue: AppColorScheme = AppColorScheme()
}

extension EnvironmentValues {
    var appColorScheme: AppColorScheme {
        get { self[AppColorSchemeKey.self] }
        set { self[AppColorSchemeKey.self] = newValue }
    }
}

struct AppColorScheme {
    let primary = AppTokens.Colors.primary
    let onPrimary = AppTokens.Colors.onPrimary
    let secondary = AppTokens.Colors.secondary
    let onSecondary = AppTokens.Colors.onSecondary
    let tertiary = AppTokens.Colors.tertiary
    let onTertiary = AppTokens.Colors.onTertiary
    let background = AppTokens.Colors.background
    let onBackground = AppTokens.Colors.onBackground
    let surface = AppTokens.Colors.surface
    let onSurface = AppTokens.Colors.onSurface
    let surfaceVariant = AppTokens.Colors.surfaceVariant
    let outline = AppTokens.Colors.outline
    let error = AppTokens.Colors.error
    let success = AppTokens.Colors.success
    let warning = AppTokens.Colors.warning
}

private struct AppTypographyKey: EnvironmentKey {
    static let defaultValue: AppTypography = AppTypography()
}

extension EnvironmentValues {
    var appTypography: AppTypography {
        get { self[AppTypographyKey.self] }
        set { self[AppTypographyKey.self] = newValue }
    }
}

struct AppTypography {
    let displayLarge = AppTokens.TypographyTokens.display
    let headlineMedium = AppTokens.TypographyTokens.headline
    let titleMedium = AppTokens.TypographyTokens.title
    let bodyMedium = AppTokens.TypographyTokens.body
    let labelMedium = AppTokens.TypographyTokens.label
}

struct AppThemeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .environment(\.appColorScheme, AppColorScheme())
            .environment(\.appTypography, AppTypography())
    }
}

extension View {
    func appTheme() -> some View {
        self.modifier(AppThemeModifier())
    }
}


struct ApprovalPin: Identifiable {
    let id: Int
    let title: String
    let status: String
    let x: CGFloat
    let y: CGFloat
}


struct FilterChipView: View {
    @Environment(\.appColorScheme) private var colorScheme
    @Environment(\.appTypography) private var typography
    let text: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(text)
                .font(isSelected ? typography.titleMedium : typography.bodyMedium)
                .foregroundColor(isSelected ? colorScheme.onPrimary : colorScheme.onSurface)
                .padding(.horizontal, AppTokens.Spacing.sm)
                .padding(.vertical, AppTokens.Spacing.xs)
                .background(
                    RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                        .fill(isSelected ? colorScheme.primary : colorScheme.surface)
                )
                .appBorder(width: 1, color: colorScheme.outline, shape: RoundedRectangle(cornerRadius: AppTokens.Shapes.small))
        }
        .buttonStyle(PlainButtonStyle()) 
    }
}

struct CardView<Content: View>: View {
    @Environment(\.appColorScheme) private var colorScheme
    let elevation: AppTokens.ShadowSpec
    let cornerRadius: CGFloat
    let border: (width: CGFloat, color: Color)?
    let onClick: (() -> Void)?
    let content: Content

    init(elevation: AppTokens.ShadowSpec = AppTokens.ElevationMapping.level1,
         cornerRadius: CGFloat = AppTokens.Shapes.small,
         border: (width: CGFloat, color: Color)? = (1, AppTokens.Colors.outline),
         onClick: (() -> Void)? = nil,
         @ViewBuilder content: () -> Content) {
        self.elevation = elevation
        self.cornerRadius = cornerRadius
        self.border = border
        self.onClick = onClick
        self.content = content()
    }

    var body: some View {
        let cardContent = content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(colorScheme.surface)
            )
            .appShadow(spec: elevation)
            .ifLet(border) { view, borderSpec in
                view.appBorder(width: borderSpec.width, color: borderSpec.color, shape: RoundedRectangle(cornerRadius: cornerRadius))
            }

        if let onClick = onClick {
            Button(action: onClick) {
                cardContent
            }
            .buttonStyle(PlainButtonStyle())
        } else {
            cardContent
        }
    }
}

struct MapPinView: View {
    @Environment(\.appColorScheme) private var colorScheme
    @Environment(\.appTypography) private var typography
    let pin: ApprovalPin
    let selected: Bool
    let onClick: () -> Void

    var body: some View {
        let pinSize: CGFloat = selected ? 28 : 22
        let baseColor: Color = {
            switch pin.status {
            case "Approved": return colorScheme.success
            case "Pending": return colorScheme.warning
            case "Rejected": return colorScheme.error
            default: return .gray
            }
        }()

                ZStack(alignment: .topLeading) {
                        Circle()
                .fill(baseColor)
                .frame(width: pinSize, height: pinSize)
                .overlay(
                    Circle()
                        .stroke(selected ? colorScheme.primary : colorScheme.surface, lineWidth: 2)
                )

                        CardView(elevation: AppTokens.ElevationMapping.level1, cornerRadius: AppTokens.Shapes.small, onClick: onClick) {
                Text(pin.title)
                    .font(typography.labelMedium)
                    .foregroundColor(colorScheme.onSurface)
                    .padding(.horizontal, AppTokens.Spacing.sm)
                    .padding(.vertical, AppTokens.Spacing.xs)
            }
                        .offset(x: 18, y: -4)
        }
    }
}

struct MapGridOverlay: View {
    @Environment(\.appColorScheme) private var colorScheme

    var body: some View {
        ZStack {
                        VStack(spacing: 0) {
                ForEach(0..<6) { _ in
                    Spacer()
                    Rectangle()
                        .fill(colorScheme.surfaceVariant)
                        .frame(height: 1)
                }
                Spacer()
            }
            .padding(.horizontal, AppTokens.Spacing.lg) 

                        HStack(spacing: 0) {
                ForEach(0..<6) { _ in
                    Spacer()
                    Rectangle()
                        .fill(colorScheme.surfaceVariant)
                        .frame(width: 1)
                }
                Spacer()
            }
            .padding(.vertical, AppTokens.Spacing.lg) 
        }
    }
}


struct RootScreen: View {
    @Environment(\.appColorScheme) private var colorScheme
    @Environment(\.appTypography) private var typography

    @State private var filters: [String] = ["Pending", "Approved"]
    @State private var activeFilters: [String] = ["Pending"]
    @State private var pins: [ApprovalPin] = [
        ApprovalPin(id: 1, title: "Purchase Order #1042", status: "Pending", x: 0.18, y: 0.35),
        ApprovalPin(id: 2, title: "Travel Request #552", status: "Approved", x: 0.52, y: 0.42),
        ApprovalPin(id: 3, title: "Contract #A77", status: "Pending", x: 0.76, y: 0.58),
        ApprovalPin(id: 4, title: "Budget Change #09", status: "Rejected", x: 0.33, y: 0.72)
    ]
    @State private var selectedPinId: Int? = nil

    var body: some View {
        ZStack { 
            colorScheme.background.ignoresSafeArea() 

            VStack(spacing: 0) { 
                                VStack {
                    Text("Approval Flow")
                        .font(typography.displayLarge)
                        .foregroundColor(colorScheme.onSurface)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, AppTokens.Spacing.md) 
                .background(colorScheme.surface)

                                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: AppTokens.Spacing.md) { 
                                                ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: AppTokens.Spacing.sm) {
                                ForEach(filters, id: \.self) { f in
                                    FilterChipView(
                                        text: f,
                                        isSelected: activeFilters.contains(f),
                                        onTap: {
                                            if activeFilters.contains(f) {
                                                activeFilters.removeAll(where: { $0 == f })
                                            } else {
                                                activeFilters.append(f)
                                            }
                                        }
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, AppTokens.Spacing.lg) 
                        .padding(.top, AppTokens.Spacing.md) 

                                                GeometryReader { geometry in
                            let maxWidth = geometry.size.width
                            let maxHeight = geometry.size.height

                            ZStack {
                                MapGridOverlay() 

                                                                ForEach(pins.filter { p in
                                                                        switch p.status {
                                    case "Pending": return activeFilters.contains("Pending")
                                    case "Approved": return activeFilters.contains("Approved")
                                    case "Rejected": return true 
                                    default: return true
                                    }
                                }) { p in
                                    MapPinView(
                                        pin: p,
                                        selected: selectedPinId == p.id,
                                        onClick: {
                                            selectedPinId = selectedPinId == p.id ? nil : p.id
                                        }
                                    )
                                                                        .offset(x: maxWidth * p.x, y: maxHeight * p.y)
                                }

                                                                if let selectedId = selectedPinId,
                                   let sel = pins.first(where: { $0.id == selectedId }) {
                                    VStack { 
                                        Spacer()
                                        CardView(elevation: AppTokens.ElevationMapping.level3, cornerRadius: AppTokens.Shapes.large, border: (1, colorScheme.outline)) {
                                            HStack(alignment: .center) {
                                                VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) {
                                                    Text(sel.title)
                                                        .font(typography.titleMedium)
                                                        .foregroundColor(colorScheme.onSurface)
                                                    Text(sel.status)
                                                        .font(typography.labelMedium)
                                                        .foregroundColor(colorScheme.onSurface)
                                                }
                                                Spacer()
                                                HStack(spacing: AppTokens.Spacing.sm) {
                                                    Button(action: {}) {
                                                        Text("Details")
                                                            .font(typography.labelMedium)
                                                            .foregroundColor(colorScheme.onSurface)
                                                            .padding(.horizontal, AppTokens.Spacing.md)
                                                    }
                                                    .frame(height: 40)
                                                    .background(
                                                        RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                                                            .fill(colorScheme.surfaceVariant)
                                                    )
                                                    .buttonStyle(PlainButtonStyle())
                                                }
                                            }
                                            .padding(AppTokens.Spacing.lg)
                                            .frame(maxWidth: .infinity)
                                        }
                                        .padding(AppTokens.Spacing.md) 
                                    }
                                }
                            }
                            .background(
                                RoundedRectangle(cornerRadius: AppTokens.Shapes.large)
                                    .fill(AppTokens.Colors.surface)
                            )
                            .appBorder(width: 1, color: AppTokens.Colors.outline, shape: RoundedRectangle(cornerRadius: AppTokens.Shapes.large))
                            .frame(maxWidth: .infinity)
                            .frame(minHeight: 360)
                            .aspectRatio(0.9, contentMode: .fit) 
                        }
                        .frame(maxWidth: .infinity)
                        .frame(minHeight: 360) 
                        .aspectRatio(0.9, contentMode: .fit) 
                        .padding(.horizontal, AppTokens.Spacing.lg) 
                        .padding(.bottom, AppTokens.Spacing.md) 
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity) 

                                VStack {
                    HStack(spacing: AppTokens.Spacing.md) {
                        Button(action: {}) {
                            Text("Reject")
                                .font(typography.titleMedium)
                                .foregroundColor(colorScheme.onSurface)
                                .frame(maxWidth: .infinity) 
                                .frame(height: 48)
                                .background(
                                    RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                                        .fill(colorScheme.surfaceVariant)
                                )
                        }
                        .disabled(selectedPinId == nil)
                        .buttonStyle(PlainButtonStyle())

                        Button(action: {}) {
                            Text("Approve")
                                .font(typography.titleMedium)
                                .foregroundColor(colorScheme.onPrimary)
                                .frame(maxWidth: .infinity) 
                                .frame(height: 48)
                                .background(
                                    RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                                        .fill(colorScheme.primary)
                                )
                        }
                        .disabled(selectedPinId == nil)
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, AppTokens.Spacing.lg)
                    .padding(.vertical, AppTokens.Spacing.md)
                }
                .background(colorScheme.surface)
                .appShadow(spec: AppTokens.ElevationMapping.level2) 
            }

                        VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Text("+")
                            .font(typography.headlineMedium)
                            .foregroundColor(colorScheme.onPrimary)
                            .frame(width: 56, height: 56) 
                            .background(Circle().fill(colorScheme.primary))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(AppTokens.Spacing.lg) 
                }
            }
        }
        .ignoresSafeArea(.all, edges: .all) 
        .statusBarHidden(true) 
    }
}

@main
struct ApprovalFlowApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                .appTheme() 
        }
    }
}

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
            .appTheme()
    }
}
