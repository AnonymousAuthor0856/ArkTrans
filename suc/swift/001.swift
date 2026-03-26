//
//  ContentView.swift
//  ECommerceApp
//
//  Created by hang on 2025/10/12.
//

import SwiftUI

// MARK: - Design Tokens
struct AppTokens {
    struct Colors {
        static let primary = Color(red: 0.404, green: 0.314, blue: 0.643)
        static let onPrimary = Color.white
        static let secondary = Color(red: 0.424, green: 0.761, blue: 0.290)
        static let onSecondary = Color(red: 0.039, green: 0.059, blue: 0.039)
        static let tertiary = Color(red: 1.000, green: 0.702, blue: 0.000)
        static let onTertiary = Color(red: 0.122, green: 0.078, blue: 0.000)
        static let background = Color(red: 0.965, green: 0.969, blue: 0.984)
        static let onBackground = Color(red: 0.059, green: 0.090, blue: 0.165)
        static let surface = Color(red: 0.988, green: 0.988, blue: 1.000)
        static let onSurface = Color(red: 0.067, green: 0.094, blue: 0.153)
        static let surfaceVariant = Color(red: 0.933, green: 0.941, blue: 0.965)
        static let outline = Color(red: 0.816, green: 0.835, blue: 0.867)
        static let success = Color(red: 0.086, green: 0.639, blue: 0.290)
        static let warning = Color(red: 0.961, green: 0.620, blue: 0.043)
        static let error = Color(red: 0.851, green: 0.176, blue: 0.125)
    }
    
    struct TypographyTokens {
        static let display = Font.system(size: 22, weight: .semibold)
        static let headline = Font.system(size: 18, weight: .semibold)
        static let title = Font.system(size: 14, weight: .medium)
        static let body = Font.system(size: 12, weight: .regular)
        static let label = Font.system(size: 10, weight: .medium)
    }
    
    struct Spacing {
        static let xs: CGFloat = 2
        static let sm: CGFloat = 4
        static let md: CGFloat = 6
        static let lg: CGFloat = 8
        static let xl: CGFloat = 12
        static let xxl: CGFloat = 16
        static let xxxl: CGFloat = 24
    }
    
    struct Shapes {
        static let small = RoundedRectangle(cornerRadius: 4)
        static let medium = RoundedRectangle(cornerRadius: 8)
        static let large = RoundedRectangle(cornerRadius: 12)
    }
}

// MARK: - Data Models
struct ProductUi: Identifiable {
    let id: Int
    let title: String
    let price: String
    let badge: String
    let rating: String
    let color: Color
}

// MARK: - Main Content View
struct ContentView: View {
    @State private var selectedCategory = "All"
    @State private var selectedFilters: Set<String> = ["In Stock"]
    
    private let categories = ["All", "Snacks", "Drinks", "Fruits", "Bakery", "Dairy"]
    
    private var products: [ProductUi] {
        let palette = [
            Color(red: 0.878, green: 0.906, blue: 1.000),
            Color(red: 0.820, green: 0.980, blue: 0.898),
            Color(red: 1.000, green: 0.929, blue: 0.835),
            Color(red: 0.992, green: 0.902, blue: 0.541)
        ]
        
        return [
            ProductUi(id: 0, title: "Product 1", price: "$14.99", badge: "", rating: "4.0", color: palette[0]),
            ProductUi(id: 1, title: "Product 2", price: "$35.99", badge: "NEW", rating: "4.9", color: palette[1]),
            ProductUi(id: 2, title: "Product 3", price: "$12.00", badge: "", rating: "4.5", color: palette[2]),
            ProductUi(id: 3, title: "Product 4", price: "$29.00", badge: "", rating: "4.8", color: palette[3])
        ]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                AppTokens.Colors.background
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Top Bar
                    Text("Shop")
                        .font(AppTokens.TypographyTokens.display)
                        .foregroundColor(AppTokens.Colors.onSurface)
                        .padding(.vertical, AppTokens.Spacing.xxl)
                        .frame(maxWidth: .infinity)
                        .background(AppTokens.Colors.background)
                    
                    // Content
                    ScrollView {
                        VStack(alignment: .leading, spacing: AppTokens.Spacing.xxxl) {
                            // Category Row
                            CategoryRow(
                                items: categories,
                                selected: selectedCategory,
                                onSelect: { selectedCategory = $0 }
                            )
                            .padding(.horizontal, AppTokens.Spacing.lg)
                            
                            // Filter Row
                            FilterRow(
                                selectedFilters: selectedFilters,
                                onToggle: { filter in
                                    if selectedFilters.contains(filter) {
                                        selectedFilters.remove(filter)
                                    } else {
                                        selectedFilters.insert(filter)
                                    }
                                }
                            )
                            .padding(.horizontal, AppTokens.Spacing.lg)
                            
                            // Product Grid
                            ProductGrid(products: products)
                                .padding(.horizontal, AppTokens.Spacing.lg)
                        }
                        .padding(.bottom, 100) // Space for bottom bar
                    }
                    .background(AppTokens.Colors.background)
                }
                
                // Bottom Action Bar
                VStack {
                    Spacer()
                    BottomActionBar(subtotal: "$129.96", actionLabel: "Checkout") {
                        // Checkout action
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .statusBar(hidden: true)
        .ignoresSafeArea()
    }
}

// MARK: - Category Row
struct CategoryRow: View {
    let items: [String]
    let selected: String
    let onSelect: (String) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AppTokens.Spacing.sm) {
                ForEach(items, id: \.self) { item in
                    Button(action: { onSelect(item) }) {
                        Text(item)
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(selected == item ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                            .padding(.horizontal, AppTokens.Spacing.xl)
                            .padding(.vertical, AppTokens.Spacing.lg)
                    }
                    .background(
                        AppTokens.Shapes.medium
                            .fill(selected == item ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                    )
                    .overlay(
                        AppTokens.Shapes.medium
                            .stroke(AppTokens.Colors.outline, lineWidth: 1)
                    )
                }
            }
            .padding(.vertical, AppTokens.Spacing.sm)
        }
        .frame(height: 50)
    }
}

// MARK: - Filter Row
struct FilterRow: View {
    let selectedFilters: Set<String>
    let onToggle: (String) -> Void
    
    private let filterOptions = ["In Stock", "Under $20", "Rating 4+"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AppTokens.Spacing.sm) {
                ForEach(filterOptions, id: \.self) { filter in
                    Button(action: { onToggle(filter) }) {
                        Text(filter)
                            .font(AppTokens.TypographyTokens.label)
                            .foregroundColor(selectedFilters.contains(filter) ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
                            .padding(.horizontal, AppTokens.Spacing.xl)
                            .padding(.vertical, AppTokens.Spacing.md)
                    }
                    .background(
                        AppTokens.Shapes.small
                            .fill(selectedFilters.contains(filter) ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
                    )
                    .overlay(
                        AppTokens.Shapes.small
                            .stroke(AppTokens.Colors.outline, lineWidth: 1)
                    )
                }
            }
            .padding(.vertical, AppTokens.Spacing.xs)
        }
        .frame(height: 40)
    }
}

// MARK: - Product Grid
struct ProductGrid: View {
    let products: [ProductUi]
    
    private let columns = [
        GridItem(.flexible(), spacing: AppTokens.Spacing.lg),
        GridItem(.flexible(), spacing: AppTokens.Spacing.lg)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: AppTokens.Spacing.lg) {
            ForEach(products) { product in
                ProductCard(product: product)
            }
        }
    }
}

// MARK: - Product Card
struct ProductCard: View {
    let product: ProductUi
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.lg) {
            // Product Image
            ZStack {
                AppTokens.Shapes.medium
                    .fill(product.color)
                
                Text("Image")
                    .font(AppTokens.TypographyTokens.label)
                    .foregroundColor(AppTokens.Colors.onSurface.opacity(0.7))
            }
            .aspectRatio(1.0, contentMode: .fit)
            .frame(maxWidth: .infinity)
            
            // Title and Badge
            HStack(alignment: .top) {
                Text(product.title)
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.onSurface)
                
                Spacer()
                
                if !product.badge.isEmpty {
                    Text(product.badge)
                        .font(AppTokens.TypographyTokens.label)
                        .foregroundColor(AppTokens.Colors.onTertiary)
                        .padding(.horizontal, AppTokens.Spacing.md)
                        .padding(.vertical, AppTokens.Spacing.xs)
                        .background(
                            AppTokens.Shapes.small
                                .fill(AppTokens.Colors.tertiary)
                        )
                }
            }
            
            // Price
            Text(product.price)
                .font(AppTokens.TypographyTokens.headline)
                .foregroundColor(AppTokens.Colors.primary)
            
            // Rating
            HStack(spacing: AppTokens.Spacing.sm) {
                Circle()
                    .fill(AppTokens.Colors.warning)
                    .frame(width: 8, height: 8)
                
                Text("\(product.rating) rating")
                    .font(AppTokens.TypographyTokens.body)
                    .foregroundColor(AppTokens.Colors.onSurface.opacity(0.7))
            }
            
            // Add to Cart Button
            Button(action: {}) {
                Text("Add to Cart")
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.onPrimary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 36)
            }
            .background(
                AppTokens.Shapes.medium
                    .fill(AppTokens.Colors.primary)
            )
        }
        .padding(AppTokens.Spacing.lg)
        .background(
            AppTokens.Shapes.large
                .fill(AppTokens.Colors.surface)
                .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 1)
        )
        .overlay(
            AppTokens.Shapes.large
                .stroke(AppTokens.Colors.outline, lineWidth: 1)
        )
    }
}

// MARK: - Bottom Action Bar
struct BottomActionBar: View {
    let subtotal: String
    let actionLabel: String
    let onAction: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(AppTokens.Colors.outline)
                .frame(height: 1)
            
            HStack {
                VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) {
                    Text("Subtotal")
                        .font(AppTokens.TypographyTokens.label)
                        .foregroundColor(AppTokens.Colors.onSurface.opacity(0.7))
                    
                    Text(subtotal)
                        .font(AppTokens.TypographyTokens.headline)
                        .foregroundColor(AppTokens.Colors.onSurface)
                }
                
                Spacer()
                
                Button(action: onAction) {
                    Text(actionLabel)
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSecondary)
                        .frame(width: 120, height: 40)
                }
                .background(
                    AppTokens.Shapes.large
                        .fill(AppTokens.Colors.secondary)
                )
            }
            .padding(.horizontal, AppTokens.Spacing.lg)
            .padding(.vertical, AppTokens.Spacing.lg)
            .background(AppTokens.Colors.surface)
        }
        .background(AppTokens.Colors.surface)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone SE (3rd generation)")
    }
}
