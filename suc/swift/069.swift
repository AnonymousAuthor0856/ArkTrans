import SwiftUI

// MARK: - Data Models

struct CargoCard: Identifiable {
    let id = UUID()
    let title: String
    let itemId: String
    let fill: String
}

struct HubFilter: Identifiable {
    let id = UUID()
    let label: String
}

// MARK: - Design Tokens

struct DesignTokens {
    struct Colors {
        static let primary = Color(red: 139/255, green: 107/255, blue: 76/255)
        static let secondary = Color(red: 194/255, green: 125/255, blue: 56/255)
        static let tertiary = Color(red: 242/255, green: 197/255, blue: 124/255)
        static let background = Color(red: 16/255, green: 12/255, blue: 8/255)
        static let surface = Color(red: 25/255, green: 17/255, blue: 13/255)
        static let surfaceVariant = Color(red: 42/255, green: 28/255, blue: 20/255)
        static let outline = Color(red: 79/255, green: 58/255, blue: 44/255)
        static let success = Color(red: 110/255, green: 206/255, blue: 137/255)
        static let warning = Color(red: 225/255, green: 159/255, blue: 65/255)
        static let error = Color(red: 217/255, green: 102/255, blue: 102/255)
        static let onPrimary = Color(red: 16/255, green: 12/255, blue: 8/255)
        static let onSecondary = Color(red: 16/255, green: 12/255, blue: 8/255)
        static let onTertiary = Color(red: 18/255, green: 14/255, blue: 4/255)
        static let onBackground = Color(red: 247/255, green: 234/255, blue: 216/255)
        static let onSurface = Color(red: 251/255, green: 239/255, blue: 224/255)
    }
    
    struct Typography {
        static let display = Font.system(size: 28, weight: .bold)
        static let headline = Font.system(size: 22, weight: .semibold)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }
    
    struct Spacing {
        static let xxs: CGFloat = 6
        static let xs: CGFloat = 10
        static let sm: CGFloat = 14
        static let md: CGFloat = 18
        static let lg: CGFloat = 26
        static let xl: CGFloat = 36
        static let xxl: CGFloat = 48
        static let xxxl: CGFloat = 62
    }
    
    struct CornerRadius {
        static let small: CGFloat = 10
        static let medium: CGFloat = 18
        static let large: CGFloat = 26
    }
}

// MARK: - Main Content View

struct ContentView: View {
    @State private var activeFilter = "All"
    
    private let cards = [
        CargoCard(title: "Copper stack", itemId: "SH-014", fill: "78%"),
        CargoCard(title: "Fiber reels", itemId: "SH-022", fill: "64%"),
        CargoCard(title: "Agro crates", itemId: "SH-031", fill: "92%"),
        CargoCard(title: "Glass kits", itemId: "SH-045", fill: "51%"),
        CargoCard(title: "Steel mesh", itemId: "SH-057", fill: "88%"),
        CargoCard(title: "Raw silica", itemId: "SH-063", fill: "43%")
    ]
    
    private let filters = [
        HubFilter(label: "All"),
        HubFilter(label: "Atlantic"),
        HubFilter(label: "Pacific"),
        HubFilter(label: "Inland")
    ]
    
    var body: some View {
        ZStack {
            DesignTokens.Colors.background
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top App Bar
                TopAppBar()
                
                // Main Content
                ScrollView {
                    VStack(alignment: .leading, spacing: DesignTokens.Spacing.lg) {
                        // Filter Buttons
                        FilterButtons(activeFilter: $activeFilter, filters: filters)
                        
                        // Cargo Grid Section
                        Text("Cargo grid")
                            .font(DesignTokens.Typography.headline)
                            .foregroundColor(DesignTokens.Colors.onSurface)
                            .padding(.horizontal, DesignTokens.Spacing.lg)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: DesignTokens.Spacing.sm),
                            GridItem(.flexible(), spacing: DesignTokens.Spacing.sm)
                        ], spacing: DesignTokens.Spacing.sm) {
                            ForEach(cards) { card in
                                CargoCardView(card: card)
                            }
                        }
                        .padding(.horizontal, DesignTokens.Spacing.lg)
                        
                        // Manifest Filter Section
                        VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
                            Text("Manifest filter")
                                .font(DesignTokens.Typography.label)
                                .foregroundColor(DesignTokens.Colors.onSurface.opacity(0.7))
                            
                            Text(activeFilter)
                                .font(DesignTokens.Typography.title)
                                .foregroundColor(DesignTokens.Colors.onSurface)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, DesignTokens.Spacing.lg)
                        .padding(.vertical, DesignTokens.Spacing.md)
                        .background(DesignTokens.Colors.surfaceVariant.opacity(0.85))
                        .cornerRadius(DesignTokens.CornerRadius.medium)
                        .padding(.horizontal, DesignTokens.Spacing.lg)
                    }
                    .padding(.vertical, DesignTokens.Spacing.md)
                }
            }
        }
        .statusBar(hidden: true)
        .preferredColorScheme(.dark)
    }
}

// MARK: - Subviews

struct TopAppBar: View {
    var body: some View {
        ZStack {
            DesignTokens.Colors.surface
                .opacity(0.95)
            
            HStack {
                // Navigation Icon
                Circle()
                    .fill(DesignTokens.Colors.surfaceVariant)
                    .frame(width: 26, height: 26)
                
                Spacer()
                
                // Title
                VStack(spacing: 2) {
                    Text("SupplyHub")
                        .font(DesignTokens.Typography.title)
                        .foregroundColor(DesignTokens.Colors.onSurface)
                    
                    Text("Logistics grid")
                        .font(DesignTokens.Typography.label)
                        .foregroundColor(DesignTokens.Colors.onSurface.opacity(0.7))
                }
                
                Spacer()
                
                // Action Icon
                Circle()
                    .fill(DesignTokens.Colors.surfaceVariant)
                    .frame(width: 26, height: 26)
            }
            .padding(.horizontal, DesignTokens.Spacing.lg)
            .padding(.vertical, DesignTokens.Spacing.md)
        }
        .frame(height: 64)
    }
}

struct FilterButtons: View {
    @Binding var activeFilter: String
    let filters: [HubFilter]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: DesignTokens.Spacing.xs) {
                ForEach(filters) { filter in
                    Button(action: {
                        activeFilter = filter.label
                    }) {
                        Text(filter.label)
                            .font(DesignTokens.Typography.label)
                            .foregroundColor(activeFilter == filter.label ? 
                                           DesignTokens.Colors.onSecondary : 
                                           DesignTokens.Colors.onSurface)
                            .padding(.horizontal, DesignTokens.Spacing.sm)
                            .padding(.vertical, DesignTokens.Spacing.xxs)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.small)
                            .fill(activeFilter == filter.label ? 
                                 DesignTokens.Colors.secondary : 
                                 DesignTokens.Colors.surfaceVariant)
                    )
                }
            }
            .padding(.horizontal, DesignTokens.Spacing.lg)
        }
    }
}

struct CargoCardView: View {
    let card: CargoCard
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
            // Image placeholder
            RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.small)
                .fill(DesignTokens.Colors.surface)
                .frame(height: 90)
                .overlay(
                    Circle()
                        .fill(DesignTokens.Colors.tertiary.opacity(0.4))
                        .frame(width: 60, height: 60)
                )
            
            VStack(alignment: .leading, spacing: DesignTokens.Spacing.xxs) {
                Text(card.title)
                    .font(DesignTokens.Typography.title)
                    .foregroundColor(DesignTokens.Colors.onSurface)
                
                Text(card.itemId)
                    .font(DesignTokens.Typography.body)
                    .foregroundColor(DesignTokens.Colors.onSurface.opacity(0.7))
                
                Text("Fill \(card.fill)")
                    .font(DesignTokens.Typography.label)
                    .foregroundColor(DesignTokens.Colors.success)
            }
        }
        .padding(DesignTokens.Spacing.md)
        .background(
            RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.medium)
                .fill(DesignTokens.Colors.surfaceVariant.opacity(0.92))
        )
    }
}

// MARK: - App Entry

@main
struct SupplyHubApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}