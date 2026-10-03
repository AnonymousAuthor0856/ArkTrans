import SwiftUI

struct AppTokens {
    struct Colors {
                static let primary = Color(red: 17/255, green: 24/255, blue: 39/255) 
        static let secondary = Color(red: 55/255, green: 65/255, blue: 81/255) 
        static let tertiary = Color(red: 107/255, green: 114/255, blue: 128/255) 
        static let background = Color(red: 249/255, green: 250/255, blue: 251/255) 
        static let surface = Color(red: 255/255, green: 255/255, blue: 255/255) 
        static let surfaceVariant = Color(red: 229/255, green: 231/255, blue: 235/255) 
        static let outline = Color(red: 209/255, green: 213/255, blue: 219/255) 
        static let success = Color(red: 22/255, green: 163/255, blue: 74/255) 
        static let warning = Color(red: 245/255, green: 158/255, blue: 11/255) 
        static let error = Color(red: 239/255, green: 68/255, blue: 68/255) 
        static let onPrimary = Color(red: 255/255, green: 255/255, blue: 255/255) 
        static let onSecondary = Color(red: 255/255, green: 255/255, blue: 255/255) 
        static let onTertiary = Color(red: 17/255, green: 24/255, blue: 39/255) 
        static let onBackground = Color(red: 17/255, green: 24/255, blue: 39/255) 
        static let onSurface = Color(red: 31/255, green: 41/255, blue: 55/255) 
    }

    struct TypographyTokens {
                static let displayLarge = Font.system(size: 28, weight: .bold)
        static let headlineMedium = Font.system(size: 20, weight: .semibold)
        static let titleMedium = Font.system(size: 16, weight: .medium)
        static let bodyMedium = Font.system(size: 14, weight: .regular)
        static let labelMedium = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
                static let small = 8.0
        static let medium = 12.0
        static let large = 16.0
    }

    struct Spacing {
                static let xs = 4.0
        static let sm = 8.0
        static let md = 12.0
        static let lg = 16.0
        static let xl = 24.0
        static let xxl = 36.0
    }

    struct ShadowSpec {
        let elevation: CGFloat 
        let radius: CGFloat    
        let dy: CGFloat        
        let opacity: Double    
    }

    struct ElevationMapping {
                static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 4, radius: 8, dy: 4, opacity: 0.14)
        static let level3 = ShadowSpec(elevation: 8, radius: 12, dy: 6, opacity: 0.16)
    }
}

struct Medicine: Identifiable {
    let id: Int
    let name: String
    let time: String
}

struct MedicineItem: View {
    let medicine: Medicine

    var body: some View {
        HStack(alignment: .center) { 
            VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) { 
                Text(medicine.name)
                    .font(AppTokens.TypographyTokens.titleMedium)
                    .foregroundColor(AppTokens.Colors.onSurface)
                Text(medicine.time)
                    .font(AppTokens.TypographyTokens.bodyMedium)
                    .foregroundColor(AppTokens.Colors.onSurface)
            }
            Spacer() 
            Circle()
                .fill(AppTokens.Colors.primary)
                .frame(width: 16, height: 16) 
        }
        .padding(AppTokens.Spacing.md) 
        .background(AppTokens.Colors.surface) 
        .cornerRadius(AppTokens.Shapes.medium) 
        .overlay( 
            RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                .stroke(AppTokens.Colors.outline, lineWidth: 1)
        )
        .frame(maxWidth: .infinity) 
    }
}

struct MedicineList: View {
    let items = [
        Medicine(id: 1, name: "Vitamin C", time: "08:00 AM"),
        Medicine(id: 2, name: "Aspirin", time: "12:30 PM"),
        Medicine(id: 3, name: "Insulin", time: "06:00 PM"),
        Medicine(id: 4, name: "Melatonin", time: "10:00 PM")
    ]

    var body: some View {
                ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: AppTokens.Spacing.md) { 
                ForEach(items) { m in
                    MedicineItem(medicine: m)
                }
            }
            .padding(.bottom, AppTokens.Spacing.xxl) 
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) 
    }
}

struct RootScreen: View {
    var body: some View {
                ZStack(alignment: .bottomTrailing) { 
            VStack(spacing: 0) { 
                                VStack(spacing: AppTokens.Spacing.md) { 
                    Text("Medicine Reminder")
                        .font(AppTokens.TypographyTokens.displayLarge)
                        .foregroundColor(AppTokens.Colors.onBackground)

                    MedicineList()

                    Spacer() 

                    Button(action: {}) {
                        Text("Mark All Taken")
                            .font(AppTokens.TypographyTokens.titleMedium)
                            .foregroundColor(AppTokens.Colors.onSecondary)
                            .frame(height: 48) 
                            .frame(maxWidth: .infinity) 
                            .background(AppTokens.Colors.secondary) 
                            .cornerRadius(AppTokens.Shapes.large) 
                    }
                                                                                                                        .padding(.horizontal, (UIScreen.main.bounds.width - 2 * AppTokens.Spacing.lg) * 0.1)
                    .padding(.bottom, AppTokens.Spacing.md) 
                }
                .padding(.top, AppTokens.Spacing.lg) 
                .padding(.horizontal, AppTokens.Spacing.lg) 
                .background(
                    LinearGradient( 
                        gradient: Gradient(colors: [AppTokens.Colors.surfaceVariant, AppTokens.Colors.surface]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity) 
                .ignoresSafeArea(.keyboard, edges: .bottom) 
                                .padding(.bottom, 56) 
            }
            .background(AppTokens.Colors.background) 
            .ignoresSafeArea(.all, edges: .top) 

                        VStack { 
                Spacer()
                HStack(alignment: .center) { 
                    Text("Today")
                        .font(AppTokens.TypographyTokens.titleMedium)
                        .foregroundColor(AppTokens.Colors.primary) 
                    Spacer()
                    Text("History")
                        .font(AppTokens.TypographyTokens.titleMedium)
                        .foregroundColor(AppTokens.Colors.onSurface)
                    Spacer()
                    Text("Profile")
                        .font(AppTokens.TypographyTokens.titleMedium)
                        .foregroundColor(AppTokens.Colors.onSurface)
                }
                .padding(.horizontal, AppTokens.Spacing.lg) 
                .frame(maxWidth: .infinity) 
                .frame(height: 56) 
                .background(AppTokens.Colors.surface) 
                .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),
                        radius: AppTokens.ElevationMapping.level2.radius,
                        x: 0,
                        y: AppTokens.ElevationMapping.level2.dy) 
            }
            .ignoresSafeArea(.all, edges: .bottom) 

                        Button(action: {}) {
                Text("+")
                    .font(AppTokens.TypographyTokens.displayLarge)
                    .foregroundColor(AppTokens.Colors.onPrimary)
                    .frame(width: 56, height: 56) 
                    .background(AppTokens.Colors.primary) 
                    .clipShape(Circle()) 
            }
            .padding(AppTokens.Spacing.lg) 
        }
        .statusBarHidden(true) 
    }
}

@main
struct MedicineReminderApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}
