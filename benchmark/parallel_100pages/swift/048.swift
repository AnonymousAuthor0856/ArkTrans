
import SwiftUI

struct AppTokens {
    struct Colors {
        static let primary = Color(red: 0x1E / 255.0, green: 0x3A / 255.0, blue: 0x8A / 255.0)
        static let secondary = Color(red: 0x3B / 255.0, green: 0x82 / 255.0, blue: 0xF6 / 255.0)
        static let tertiary = Color(red: 0x60 / 255.0, green: 0xA5 / 255.0, blue: 0xFA / 255.0)
        static let background = Color(red: 0xF5 / 255.0, green: 0xF8 / 255.0, blue: 0xFF / 255.0)
        static let surface = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let surfaceVariant = Color(red: 0xE8 / 255.0, green: 0xEE / 255.0, blue: 0xFA / 255.0)
        static let outline = Color(red: 0xCB / 255.0, green: 0xD5 / 255.0, blue: 0xE1 / 255.0)
        static let success = Color(red: 0x22 / 255.0, green: 0xC5 / 255.0, blue: 0x5E / 255.0)
        static let warning = Color(red: 0xF5 / 255.0, green: 0x9E / 255.0, blue: 0x0B / 255.0)
        static let error = Color(red: 0xEF / 255.0, green: 0x44 / 255.0, blue: 0x44 / 255.0)
        static let onPrimary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onSecondary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onTertiary = Color(red: 0x0B / 255.0, green: 0x12 / 255.0, blue: 0x20 / 255.0)
        static let onBackground = Color(red: 0x0B / 255.0, green: 0x12 / 255.0, blue: 0x20 / 255.0)
        static let onSurface = Color(red: 0x0B / 255.0, green: 0x12 / 255.0, blue: 0x20 / 255.0)
    }

    struct TypographyTokens {
        static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) 
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small = RoundedCornerShape(cornerRadius: 6)
        static let medium = RoundedCornerShape(cornerRadius: 10)
        static let large = RoundedCornerShape(cornerRadius: 16)
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
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 6, radius: 8, dy: 4, opacity: 0.15)
        static let level3 = ShadowSpec(elevation: 10, radius: 12, dy: 6, opacity: 0.18)
    }
    
        struct MaterialDefaults {
        static let bottomAppBarHeight: CGFloat = 80
        static let fabSize: CGFloat = 56
        static let buttonHorizontalPadding: CGFloat = 16 
        static let buttonVerticalPadding: CGFloat = 8 
        static let fabBottomMargin: CGFloat = 16 
        static let fabTrailingMargin: CGFloat = 16 
        static let lazyColumnContentBottomPadding: CGFloat = 96 
    }
}

struct RoundedCornerShape {
    let cornerRadius: CGFloat
}

struct LiveItem: Identifiable {
    let id: Int
    let title: String
    let viewers: Int
    let price: String
}

struct RootScreen: View {
    let liveList: [LiveItem] = [
        LiveItem(id: 1, title: "Smartphone Flash Deal", viewers: 1234, price: "$699"),
        LiveItem(id: 2, title: "Gaming Chair Special", viewers: 880, price: "$249"),
        LiveItem(id: 3, title: "Headphones Clearance", viewers: 1640, price: "$99"),
        LiveItem(id: 4, title: "Mechanical Keyboard", viewers: 512, price: "$129")
    ]

    var body: some View {
                ZStack {
                        VStack(alignment: .leading, spacing: AppTokens.Spacing.md) {
                Text("Live Shop Events")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.primary)
                
                ScrollView {
                    LazyVStack(spacing: AppTokens.Spacing.md) {
                        ForEach(liveList) { item in
                            LiveItemCard(item: item)
                        }
                    }
                                        .padding(.bottom, AppTokens.MaterialDefaults.lazyColumnContentBottomPadding)
                }
            }
                        .padding(AppTokens.Spacing.lg)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient( 
                    gradient: Gradient(colors: [
                        AppTokens.Colors.background,
                        AppTokens.Colors.surfaceVariant,
                        AppTokens.Colors.background
                    ]),
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
                            .foregroundColor(AppTokens.Colors.onSecondary)
                            .frame(width: AppTokens.MaterialDefaults.fabSize, height: AppTokens.MaterialDefaults.fabSize)
                            .background(AppTokens.Colors.secondary)
                            .clipShape(Circle()) 
                    }
                                        .padding(.trailing, AppTokens.MaterialDefaults.fabTrailingMargin)
                    .padding(.bottom, AppTokens.MaterialDefaults.fabBottomMargin + AppTokens.MaterialDefaults.bottomAppBarHeight)
                }
            }

                        VStack { 
                Spacer()
                BottomNavBar()
            }
        }
        .background(AppTokens.Colors.background) 
        .statusBarHidden(true) 
    }
}

struct LiveItemCard: View {
    let item: LiveItem

    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
                        Rectangle()
                .fill(AppTokens.Colors.secondary)
                .frame(maxWidth: .infinity)
                .frame(height: 160)
                .clipShape(RoundedRectangle(cornerRadius: AppTokens.Shapes.medium.cornerRadius))

            Text(item.title)
                .font(AppTokens.TypographyTokens.title)
                .foregroundColor(AppTokens.Colors.onSurface)

            Text("\(item.viewers) viewers")
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.tertiary)

            HStack {
                Text(item.price)
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.primary)

                Spacer() 

                Button(action: {}) {
                    Text("Join Live")
                        .font(AppTokens.TypographyTokens.label)
                        .foregroundColor(AppTokens.Colors.onPrimary)
                                                .padding(.vertical, AppTokens.MaterialDefaults.buttonVerticalPadding)
                        .padding(.horizontal, AppTokens.MaterialDefaults.buttonHorizontalPadding)
                        .background(AppTokens.Colors.primary)
                        .clipShape(RoundedRectangle(cornerRadius: AppTokens.Shapes.medium.cornerRadius))
                }
                .buttonStyle(PlainButtonStyle()) 
            }
        }
        .padding(AppTokens.Spacing.lg) 
        .background(AppTokens.Colors.surface)
        .clipShape(RoundedRectangle(cornerRadius: AppTokens.Shapes.large.cornerRadius)) 
        .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity), 
                radius: AppTokens.ElevationMapping.level1.radius,
                x: 0,
                y: AppTokens.ElevationMapping.level1.dy)
    }
}

struct BottomNavBar: View {
    var body: some View {
        HStack(spacing: 0) { 
            Spacer()
            Text("Home")
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.primary) 
            Spacer()
            Text("Live")
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.onSurface)
            Spacer()
            Text("Cart")
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.onSurface)
            Spacer()
            Text("Profile")
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.onSurface)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: AppTokens.MaterialDefaults.bottomAppBarHeight) 
        .background(AppTokens.Colors.surface) 
        .shadow(color: Color.black.opacity(0.1), radius: 0.5, x: 0, y: -1) 
    }
}

@main
struct LiveShopApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}