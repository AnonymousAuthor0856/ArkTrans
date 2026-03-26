import SwiftUI

// MARK: - Color Extension for Hex
extension Color {
    /// Initializes a Color from a hex value (e.g., 0xFF00FF) and an optional alpha.
    /// - Parameters:
    ///   - hex: The hex value of the color.
    ///   - alpha: The alpha component of the color, default is 1.0.
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double(hex & 0xff) / 255,
            opacity: alpha
        )
    }
}

// MARK: - AppTokens
struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xD7BBA8)
        static let secondary = Color(hex: 0xA2C4C9)
        static let tertiary = Color(hex: 0xB3C9A2)
        static let background = Color(hex: 0xF0EBE3)
        static let surface = Color(hex: 0xFFFFFF)
        static let surfaceVariant = Color(hex: 0xE6E0D9)
        static let outline = Color(hex: 0xDCD7CF)
        static let success = Color(hex: 0x7EA87E)
        static let warning = Color(hex: 0xD9B872)
        static let error = Color(hex: 0xD98B8B)
        static let onPrimary = Color(hex: 0x433E3A)
        static let onSecondary = Color(hex: 0x433E3A)
        static let onTertiary = Color(hex: 0x433E3A)
        static let onBackground = Color(hex: 0x433E3A)
        static let onSurface = Color(hex: 0x433E3A)
    }

    struct TypographyTokens {
        static let display = Font.system(size: 28, weight: .bold)
        static let headline = Font.system(size: 22, weight: .semibold)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small = RoundedRectangle(cornerRadius: 8)
        static let medium = RoundedRectangle(cornerRadius: 16)
        static let large = RoundedRectangle(cornerRadius: 24)
        static let circle = Circle()
    }

    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
    }

    struct ShadowSpec {
        let elevation: CGFloat // Kept for reference, but SwiftUI shadow uses radius, x, y directly
        let color: Color
        let offsetX: CGFloat
        let offsetY: CGFloat
        let blurRadius: CGFloat
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 3, color: Color.black.opacity(0.05), offsetX: 4, offsetY: 4, blurRadius: 8)
        static let level2 = ShadowSpec(elevation: 6, color: Color.black.opacity(0.08), offsetX: 6, offsetY: 6, blurRadius: 12)
    }
}

// MARK: - Custom View Modifier for Shadows
struct AppShadowModifier: ViewModifier {
    let shadowSpec: AppTokens.ShadowSpec

    func body(content: Content) -> some View {
        content
            .shadow(color: shadowSpec.color, radius: shadowSpec.blurRadius, x: shadowSpec.offsetX, y: shadowSpec.offsetY)
    }
}

extension View {
    /// Applies a custom shadow based on AppTokens.ShadowSpec.
    func appShadow(_ shadowSpec: AppTokens.ShadowSpec) -> some View {
        self.modifier(AppShadowModifier(shadowSpec: shadowSpec))
    }
}

// MARK: - Data Models
struct Filter: Identifiable {
    let id: String
    let name: String
}

struct FilterItem: Identifiable {
    let id: Int
    let name: String
    let author: String
    let price: String
    let color: Color
}

// MARK: - TopBarSection
struct TopBarSection: View {
    let filters: [Filter]
    @Binding var selectedFilter: String

    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.md) {
            Text("Filter Shop")
                .font(AppTokens.TypographyTokens.display)
                .foregroundColor(AppTokens.Colors.onBackground)
            
            HStack(spacing: AppTokens.Spacing.sm) {
                ForEach(filters) { filter in
                    let isSelected = filter.id == selectedFilter
                    Text(filter.name)
                        .font(AppTokens.TypographyTokens.label)
                        .kerning(0.5) // Corresponds to letterSpacing
                        .foregroundColor(isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onBackground)
                        .padding(.horizontal, AppTokens.Spacing.md)
                        .padding(.vertical, AppTokens.Spacing.sm)
                        .background(
                            AppTokens.Shapes.large
                                .fill(isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                        )
                        .overlay(
                            AppTokens.Shapes.large
                                .stroke(isSelected ? AppTokens.Colors.onBackground.opacity(0.1) : AppTokens.Colors.outline, lineWidth: 2)
                        )
                        .onTapGesture {
                            selectedFilter = filter.id
                        }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading) // Corresponds to Modifier.fillMaxWidth()
    }
}

// MARK: - FilterCard
struct FilterCard: View {
    let item: FilterItem

    var body: some View {
        VStack(alignment: .leading, spacing: 0) { // Outer VStack, content of the Card
            item.color
                .aspectRatio(1, contentMode: .fit)
                .clipShape(AppTokens.Shapes.medium)
            
            VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) { // Inner VStack for text content
                Text(item.name)
                    .font(AppTokens.TypographyTokens.title)
                    .fontWeight(.bold)
                    .foregroundColor(AppTokens.Colors.onSurface)
                
                Text(item.author)
                    .font(AppTokens.TypographyTokens.label)
                    .kerning(0.5) // Corresponds to letterSpacing
                    .foregroundColor(AppTokens.Colors.onSurface.opacity(0.6))
                
                Text(item.price)
                    .font(AppTokens.TypographyTokens.title)
                    .fontWeight(.bold)
                    .foregroundColor(AppTokens.Colors.primary)
            }
            .padding(AppTokens.Spacing.sm) // Padding for the inner text VStack
        }
        .padding(AppTokens.Spacing.sm) // Padding for the outer VStack, inside the card
        .background(AppTokens.Colors.surface)
        .clipShape(AppTokens.Shapes.large)
        .appShadow(AppTokens.ElevationMapping.level1)
    }
}

// MARK: - BottomBarSection
struct BottomBarSection: View {
    var body: some View {
        HStack(alignment: .center) {
            Text("3 items in cart")
                .font(AppTokens.TypographyTokens.body)
                .lineSpacing(6) // Corresponds to lineHeight = 20.sp for fontSize = 14.sp (20-14=6)
                .foregroundColor(AppTokens.Colors.onSurface)
            
            Spacer()
            
            Button(action: {
                // Handle checkout action
                print("Checkout tapped")
            }) {
                HStack(spacing: AppTokens.Spacing.sm) {
                    AppTokens.Colors.onPrimary.opacity(0.2)
                        .frame(width: 16, height: 16)
                        .clipShape(AppTokens.Shapes.circle)
                    Text("Checkout")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onPrimary)
                }
                // ButtonDefaults.ContentPadding in Compose is typically (horizontal = 24.dp, vertical = 8.dp)
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
            }
            .background(AppTokens.Colors.primary)
            .clipShape(AppTokens.Shapes.large) // Clip shape before applying shadow
            .appShadow(AppTokens.ElevationMapping.level1)
            .buttonStyle(PlainButtonStyle()) // Remove default SwiftUI button styling
        }
        .padding(.horizontal, AppTokens.Spacing.lg)
        .padding(.vertical, AppTokens.Spacing.md)
        .frame(maxWidth: .infinity)
    }
}

// MARK: - RootScreen
struct RootScreen: View {
    @State private var selectedFilter: String = "vintage"
    
    let filters = [
        Filter(id: "vintage", name: "Vintage"),
        Filter(id: "grain", name: "Grain"),
        Filter(id: "b&w", name: "B&W"),
        Filter(id: "neon", name: "Neon")
    ]
    
    let items = [
        FilterItem(id: 1, name: "Redscale", author: "by UserA", price: "$4.99", color: AppTokens.Colors.error),
        FilterItem(id: 2, name: "Sepia Tone", author: "by UserB", price: "$2.99", color: AppTokens.Colors.primary),
        FilterItem(id: 3, name: "Aqua", author: "by UserC", price: "$4.99", color: AppTokens.Colors.secondary),
        FilterItem(id: 4, name: "Forest", author: "by UserD", price: "$3.99", color: AppTokens.Colors.tertiary),
        FilterItem(id: 5, name: "Golden Hour", author: "by UserE", price: "$5.99", color: AppTokens.Colors.warning),
        FilterItem(id: 6, name: "Monochrome", author: "by UserF", price: "$1.99", color: AppTokens.Colors.outline),
    ]

    var body: some View {
        VStack(spacing: 0) { // Mimics Scaffold structure
            TopBarSection(filters: filters, selectedFilter: $selectedFilter)
                .padding(.horizontal, AppTokens.Spacing.lg)
                .padding(.vertical, AppTokens.Spacing.md)
                .background(AppTokens.Colors.background) // Top bar background
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: AppTokens.Spacing.md) {
                    ForEach(items) { item in
                        FilterCard(item: item)
                    }
                }
                .padding(AppTokens.Spacing.lg) // Corresponds to contentPadding for LazyVerticalGrid
            }
            .background(AppTokens.Colors.background) // Content background
            // .ignoresSafeArea(.container, edges: .bottom) // Not strictly needed if bottom bar is part of VStack
            
            BottomBarSection()
                .background(AppTokens.Colors.surface) // Bottom bar background
                .appShadow(AppTokens.ElevationMapping.level2) // Apply shadow to bottom bar
        }
        .background(AppTokens.Colors.background.ignoresSafeArea()) // Overall background, extends to safe areas
        .statusBarHidden(true) // Hide the status bar
    }
}

// MARK: - App Entry Point
@main
struct SingleFileUIApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}