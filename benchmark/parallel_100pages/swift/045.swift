import SwiftUI

struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF8E6BF2)
        static let secondary = Color(hex: 0xFFD3C1FF)
        static let tertiary = Color(hex: 0xFFB39DDB)
        static let background = Color(hex: 0xFFF5F3FF)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFECE6F8)
        static let outline = Color(hex: 0xFFD1C4E9)
        static let success = Color(hex: 0xFF4CAF50)
        static let warning = Color(hex: 0xFFFFB300)
        static let error = Color(hex: 0xFFE53935)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFF2E1A47)
        static let onBackground = Color(hex: 0xFF2E1A47)
        static let onSurface = Color(hex: 0xFF2E1A47)
    }

    struct TypographyTokens {
        static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) 
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small = 8.0
        static let medium = 14.0
        static let large = 20.0
    }

    struct Spacing {
        static let sm = 6.0
        static let md = 10.0
        static let lg = 16.0
        static let xl = 24.0
    }

    struct ShadowSpec {
        let elevation: CGFloat 
        let radius: CGFloat    
        let dy: CGFloat        
        let opacity: Double    
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 4.0, radius: 8.0, dy: 2.0, opacity: 0.18)
        static let level2 = ShadowSpec(elevation: 8.0, radius: 12.0, dy: 4.0, opacity: 0.22)
        static let level3 = ShadowSpec(elevation: 12.0, radius: 20.0, dy: 8.0, opacity: 0.26)
    }
}

extension Color {
    init(hex: UInt) {
        self.init(
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0
        )
    }
}

struct CustomCardStyle: ViewModifier {
    var cornerRadius: CGFloat
    var backgroundColor: Color
    var shadowSpec: AppTokens.ShadowSpec
            var spotColor: Color 
    var ambientColor: Color

    func body(content: Content) -> some View {
        content
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
                                    .shadow(color: ambientColor.opacity(shadowSpec.opacity), radius: shadowSpec.radius, x: 0, y: shadowSpec.dy)
    }
}

struct RootScreen: View {
    @State private var orderId: String = ""
    @State private var issue: String = ""
    @State private var submitted: Bool = false

        @FocusState private var orderIdIsFocused: Bool
    @FocusState private var issueIsFocused: Bool

    var body: some View {
        ZStack { 
            AppTokens.Colors.background.ignoresSafeArea() 

            VStack(spacing: AppTokens.Spacing.lg) { 
                Text("After-Sale Service")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onBackground)
                    .frame(maxWidth: .infinity, alignment: .leading) 

                                VStack(alignment: .leading, spacing: AppTokens.Spacing.md) { 
                    Text("Order ID")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)

                                        ZStack(alignment: .topLeading) { 
                        if orderId.isEmpty && !orderIdIsFocused { 
                            Text("Enter order number")
                                .font(AppTokens.TypographyTokens.body)
                                .foregroundColor(AppTokens.Colors.onSurface.opacity(0.5))
                                .padding(.horizontal, AppTokens.Spacing.md)
                                .padding(.vertical, (56 - AppTokens.TypographyTokens.body.pointSize) / 2) 
                        }
                        TextField("", text: $orderId) 
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onSurface)
                            .padding(.horizontal, AppTokens.Spacing.md)
                            .frame(height: 56) 
                            .background(
                                RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                                    .fill(AppTokens.Colors.surfaceVariant) 
                                    .overlay(
                                        RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                                            .stroke(orderIdIsFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline, lineWidth: 1)
                                    )
                            )
                            .focused($orderIdIsFocused)
                    }

                    Text("Issue Description")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)

                                        ZStack(alignment: .topLeading) { 
                        if issue.isEmpty && !issueIsFocused { 
                            Text("Describe your issue")
                                .font(AppTokens.TypographyTokens.body)
                                .foregroundColor(AppTokens.Colors.onSurface.opacity(0.5))
                                .padding(.horizontal, AppTokens.Spacing.md)
                                .padding(.vertical, AppTokens.Spacing.sm + 4) 
                        }
                        TextEditor(text: $issue)
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onSurface)
                            .padding(.horizontal, AppTokens.Spacing.md)
                            .padding(.vertical, AppTokens.Spacing.sm + 4) 
                            .frame(height: 120) 
                            .background(
                                RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                                    .fill(AppTokens.Colors.surfaceVariant) 
                                    .overlay(
                                        RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                                            .stroke(issueIsFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline, lineWidth: 1)
                                    )
                            )
                            .focused($issueIsFocused)
                    }
                }
                .frame(maxWidth: .infinity) 
                .modifier(CustomCardStyle(
                    cornerRadius: AppTokens.Shapes.large,
                    backgroundColor: AppTokens.Colors.surface,
                    shadowSpec: AppTokens.ElevationMapping.level2,
                    spotColor: AppTokens.Colors.secondary,
                    ambientColor: AppTokens.Colors.outline
                ))

                                Button(action: {
                    submitted = true
                }) {
                    Text("Submit Request")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onPrimary)
                        .frame(maxWidth: .infinity) 
                        .frame(height: 56) 
                        .background(AppTokens.Colors.primary)
                        .cornerRadius(AppTokens.Shapes.large)
                }

                                if submitted {
                    Text("Request submitted successfully!")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.success)
                        .frame(maxWidth: .infinity) 
                        .padding(AppTokens.Spacing.lg)
                        .background(AppTokens.Colors.success.opacity(0.15))
                        .cornerRadius(AppTokens.Shapes.medium)
                        .multilineTextAlignment(.center) 
                }

                Spacer() 
            }
            .padding(AppTokens.Spacing.lg) 
        }
        .ignoresSafeArea(.all, edges: .all) 
        .statusBarHidden(true) 
    }
}

extension Font {
            var pointSize: CGFloat {
                if self == AppTokens.TypographyTokens.body {
            return 14.0
        }
                return 14.0 
    }
}


@main
struct AfterSaleServiceApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}