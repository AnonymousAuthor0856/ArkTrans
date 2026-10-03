import SwiftUI


struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF00FFFF) 
        static let secondary = Color(hex: 0xFF00B4FF) 
        static let tertiary = Color(hex: 0xFF8A2BE2) 
        static let background = Color(hex: 0xFF0A0A1A) 
        static let surface = Color(hex: 0xFF141436) 
        static let surfaceVariant = Color(hex: 0xFF1E1E4A) 
        static let outline = Color(hex: 0xFF2E2E5C) 
        static let success = Color(hex: 0xFF00FFAA) 
        static let warning = Color(hex: 0xFFFFCC00) 
        static let error = Color(hex: 0xFFFF4444) 
        static let onPrimary = Color(hex: 0xFF0A0A1A) 
        static let onSecondary = Color(hex: 0xFFFFFFFF) 
        static let onBackground = Color(hex: 0xFFFFFFFF) 
        static let onSurface = Color(hex: 0xFFFFFFFF) 
    }

    struct TypographyTokens {
                static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) 
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
                static let smallCornerRadius: CGFloat = 8
        static let mediumCornerRadius: CGFloat = 14
        static let largeCornerRadius: CGFloat = 22
    }

    struct Spacing {
                static let sm: CGFloat = 6
        static let md: CGFloat = 10
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 36
    }

    struct ShadowSpec {
        let elevation: CGFloat 
        let radius: CGFloat    
        let dy: CGFloat        
        let opacity: Double    
    }

    struct ElevationMapping {
                static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.1)
        static let level2 = ShadowSpec(elevation: 6, radius: 8, dy: 4, opacity: 0.15)
        static let level3 = ShadowSpec(elevation: 10, radius: 12, dy: 6, opacity: 0.18)
    }
}


extension Color {
        init(hex: UInt) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: 1.0
        )
    }
}


struct RootScreen: View {
    let stations = ["A", "B", "C", "D", "E", "F"]
        let bottomBarHeight: CGFloat = 56 
        let fabSize: CGFloat = 56

    var body: some View {
                        ZStack {
                                    VStack(spacing: AppTokens.Spacing.lg) {
                Text("Metro Planner")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.primary)
                    .frame(maxWidth: .infinity, alignment: .leading) 

                                                Canvas { context, size in
                    var path = Path()
                    let step = size.width / CGFloat(stations.count - 1)

                    for (i, _) in stations.enumerated() {
                        let x = CGFloat(i) * step
                        let y = i % 2 == 0 ? size.height / 4 : size.height * 3 / 4
                        if i == 0 {
                            path.move(to: CGPoint(x: x, y: y))
                        } else {
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }

                                        context.stroke(
                        path,
                        with: .linearGradient(
                            Gradient(colors: [AppTokens.Colors.secondary, AppTokens.Colors.primary]),
                            startPoint: .zero,
                            endPoint: CGPoint(x: size.width, y: 0)
                        ),
                        lineWidth: 6
                    )

                                        for (i, _) in stations.enumerated() {
                        let x = CGFloat(i) * step
                        let y = i % 2 == 0 ? size.height / 4 : size.height * 3 / 4
                        let center = CGPoint(x: x, y: y)

                                                context.fill(
                            Path(ellipseIn: CGRect(x: center.x - 16, y: center.y - 16, width: 32, height: 32)),
                            with: .color(AppTokens.Colors.primary)
                        )
                                                context.fill(
                            Path(ellipseIn: CGRect(x: center.x - 6, y: center.y - 6, width: 12, height: 12)),
                            with: .color(AppTokens.Colors.background)
                        )
                    }
                }
                .padding(AppTokens.Spacing.md) 
                .frame(height: 260) 
                .background(AppTokens.Colors.surfaceVariant) 
                .cornerRadius(AppTokens.Shapes.largeCornerRadius) 
                .padding(.horizontal, AppTokens.Spacing.lg) 


                                                VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
                    Text("Next Departures")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.secondary)

                    ForEach(["08:45 • Line 1", "09:10 • Line 2", "09:30 • Line 3"], id: \.self) { departure in
                        HStack { 
                            Text(departure)
                                .font(AppTokens.TypographyTokens.body)
                                .foregroundColor(AppTokens.Colors.onSurface)
                            Spacer() 
                            Text("On Time")
                                .font(AppTokens.TypographyTokens.label)
                                .foregroundColor(AppTokens.Colors.success)
                        }
                    }
                }
                .padding(AppTokens.Spacing.lg) 
                .background(AppTokens.Colors.surface) 
                .cornerRadius(AppTokens.Shapes.largeCornerRadius) 
                                .shadow(color: AppTokens.Colors.outline.opacity(AppTokens.ElevationMapping.level2.opacity),
                        radius: AppTokens.ElevationMapping.level2.radius,
                        x: 0,
                        y: AppTokens.ElevationMapping.level2.dy)
                .padding(.horizontal, AppTokens.Spacing.lg) 

                                Spacer(minLength: AppTokens.Spacing.md)
            }
            .padding(.top, AppTokens.Spacing.lg) 
                                    .padding(.bottom, bottomBarHeight) 
            .frame(maxWidth: .infinity, maxHeight: .infinity) 
                        .background(
                LinearGradient(
                    gradient: Gradient(colors: [AppTokens.Colors.background, AppTokens.Colors.surfaceVariant, AppTokens.Colors.background]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
                        .ignoresSafeArea(.all, edges: .all)

                                    VStack {
                Spacer() 
                HStack {
                    Spacer() 
                    Button(action: {}) { 
                        Text("+")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .frame(width: fabSize, height: fabSize) 
                            .background(AppTokens.Colors.primary) 
                            .clipShape(Circle()) 
                    }
                    .padding(.trailing, AppTokens.Spacing.lg) 
                                        .padding(.bottom, bottomBarHeight + AppTokens.Spacing.lg) 
                }
            }
            .ignoresSafeArea(.all, edges: .all) 

                                    VStack(spacing: 0) {
                Spacer() 
                HStack(spacing: 0) { 
                    Text("Routes")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.secondary) 
                    Spacer()
                    Text("Planner")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.onSurface)
                    Spacer()
                    Text("Tickets")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.onSurface)
                    Spacer()
                    Text("Profile")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.onSurface)
                }
                .padding(.horizontal, AppTokens.Spacing.lg) 
                .frame(maxWidth: .infinity) 
                .frame(height: bottomBarHeight) 
                .background(AppTokens.Colors.surface) 
            }
                        .ignoresSafeArea(.all, edges: .bottom)
        }
        .background(AppTokens.Colors.background) 
        .statusBarHidden(true) 
    }
}


@main
struct MetroPlannerApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}