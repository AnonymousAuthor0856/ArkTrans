import SwiftUI

// MARK: - App Entry Point
@main
struct HoloChatApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// MARK: - Root View
struct ContentView: View {
    var body: some View {
        HoloChatDockScreen()
            .preferredColorScheme(.dark)
            .statusBarHidden(true)
    }
}

// MARK: - App Tokens & Colors
struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0x7C3AED)
        static let secondary = Color(hex: 0x22D3EE)
        static let tertiary = Color(hex: 0xF97316)
        static let background = Color(hex: 0x050714)
        static let surface = Color(hex: 0x0F172A)
        static let surfaceVariant = Color(hex: 0x1F2937)
        static let outline = Color(hex: 0x334155)
        static let onPrimary = Color(hex: 0x050714)
        static let onSecondary = Color(hex: 0x011014)
        static let onTertiary = Color(hex: 0x110200)
        static let onBackground = Color(hex: 0xF8FAFC)
        static let onSurface = Color(hex: 0xE2E8F0)
    }
    
    struct Typography {
        static let display = Font.system(size: 28, weight: .semibold)
        static let headline = Font.system(size: 22, weight: .medium)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }
    
    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
        static let xxxl: CGFloat = 44
    }
    
    struct Shapes {
        static let small: CGFloat = 12
        static let medium: CGFloat = 16
        static let large: CGFloat = 20
    }
}

// MARK: - Models
struct ChatThread: Identifiable {
    let id = UUID()
    let name: String
    let status: String
    let unread: Int
    let snippet: String
    let isPriority: BooleanLiteralType
}

// MARK: - Main Screen
struct HoloChatDockScreen: View {
    @State private var activeFilter = "Live"
    @State private var draftMessage = ""
    
    let filters = ["Live", "Pinned", "Escalated", "Silent"]
    let threads = [
        ChatThread(name: "Orbital Finance", status: "Rolling sync", unread: 5, snippet: "Need rates for Q4", isPriority: true),
        ChatThread(name: "Beacon Ops", status: "Docked", unread: 0, snippet: "Switching to holo feed", isPriority: false),
        ChatThread(name: "Nova Crew", status: "Hotline", unread: 2, snippet: "Uploading scan pack now", isPriority: true)
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Background
            AppTokens.Colors.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Bar
                CustomTopBar()
                
                // Content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: AppTokens.Spacing.md) {
                        
                        // Filters
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: AppTokens.Spacing.sm) {
                                ForEach(filters, id: \.self) { filter in
                                    AssistChip(
                                        label: filter,
                                        isSelected: activeFilter == filter,
                                        action: { activeFilter = filter }
                                    )
                                }
                            }
                            .padding(.horizontal, AppTokens.Spacing.lg)
                        }
                        
                        // Status Summary
                        StatusSummary()
                            .padding(.horizontal, AppTokens.Spacing.lg)
                        
                        // Threads List
                        ForEach(threads) { thread in
                            ChatThreadCard(thread: thread)
                                .padding(.horizontal, AppTokens.Spacing.lg)
                        }
                        
                        // Action Footer
                        ActionFooter()
                            .padding(.horizontal, AppTokens.Spacing.lg)
                        
                        // Spacer for bottom bar + FAB area
                        Spacer().frame(height: 100)
                    }
                    .padding(.vertical, AppTokens.Spacing.md)
                }
            }
            
            // FAB (Floating Action Button) overlay
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Text("New")
                            .font(AppTokens.Typography.label)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 16)
                            .background(AppTokens.Colors.primary)
                            .clipShape(RoundedRectangle(cornerRadius: AppTokens.Shapes.medium))
                            .shadow(radius: 4)
                    }
                    .padding(.trailing, AppTokens.Spacing.lg)
                    .padding(.bottom, 80) // Lift above bottom bar
                }
            }
            
            // Bottom Bar
            BottomInputBar(text: $draftMessage)
        }
        .statusBarHidden(true)
    }
}

// MARK: - Components

struct CustomTopBar: View {
    var body: some View {
        HStack {
            Button(action: {}) {
                Text("Hub")
                    .font(AppTokens.Typography.label)
                    .foregroundColor(AppTokens.Colors.onSurface)
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("HoloChat Dock")
                    .font(AppTokens.Typography.title)
                    .foregroundColor(AppTokens.Colors.onSurface)
                Text("Dark neon bridge")
                    .font(AppTokens.Typography.label)
                    .foregroundColor(AppTokens.Colors.onSurface.opacity(0.7))
            }
            
            Spacer()
            
            Button(action: {}) {
                Text("Status")
                    .font(AppTokens.Typography.label)
                    .foregroundColor(AppTokens.Colors.secondary)
            }
        }
        .padding(.horizontal, AppTokens.Spacing.lg)
        .padding(.vertical, AppTokens.Spacing.sm)
        .background(AppTokens.Colors.surface)
    }
}

struct AssistChip: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(AppTokens.Typography.label)
                .foregroundColor(isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                        .fill(isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
                        .overlay(
                            RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                                .stroke(AppTokens.Colors.outline, lineWidth: isSelected ? 0 : 1)
                        )
                )
        }
    }
}

struct StatusSummary: View {
    var body: some View {
        HStack(spacing: AppTokens.Spacing.sm) {
            SummaryBlock(title: "Live docks", value: "12", accent: AppTokens.Colors.secondary)
            SummaryBlock(title: "Escalations", value: "3", accent: AppTokens.Colors.tertiary)
            SummaryBlock(title: "Queued", value: "5", accent: AppTokens.Colors.primary)
        }
    }
}

struct SummaryBlock: View {
    let title: String
    let value: String
    let accent: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) {
            Circle()
                .fill(accent)
                .frame(width: 12, height: 12)
            
            Text(title.uppercased())
                .font(AppTokens.Typography.label)
                .foregroundColor(AppTokens.Colors.onSurface.opacity(0.7))
            
            Text(value)
                .font(AppTokens.Typography.display)
                .foregroundColor(accent)
        }
        .padding(AppTokens.Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTokens.Colors.surface)
        .cornerRadius(AppTokens.Shapes.medium)
    }
}

struct ChatThreadCard: View {
    let thread: ChatThread
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
            HStack {
                VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) {
                    Text(thread.name)
                        .font(AppTokens.Typography.headline)
                        .foregroundColor(AppTokens.Colors.onSurface)
                    
                    Text(thread.status)
                        .font(AppTokens.Typography.label)
                        .foregroundColor(thread.isPriority ? AppTokens.Colors.secondary : AppTokens.Colors.onSurface.opacity(0.7))
                }
                
                Spacer()
                
                Text(thread.unread > 0 ? "+\(thread.unread)" : "✓")
                    .font(AppTokens.Typography.label)
                    .foregroundColor(AppTokens.Colors.onSurface)
                    .padding(.horizontal, AppTokens.Spacing.sm)
                    .padding(.vertical, AppTokens.Spacing.xs)
                    .background(AppTokens.Colors.surfaceVariant)
                    .cornerRadius(AppTokens.Shapes.small)
            }
            
            Text(thread.snippet)
                .font(AppTokens.Typography.body)
                .foregroundColor(AppTokens.Colors.onSurface.opacity(0.9))
            
            HStack(spacing: AppTokens.Spacing.sm) {
                Text(thread.isPriority ? "Priority" : "Standard")
                    .font(AppTokens.Typography.label)
                    .foregroundColor(AppTokens.Colors.onSurface)
                    .padding(.horizontal, AppTokens.Spacing.sm)
                    .padding(.vertical, AppTokens.Spacing.xs)
                    .background(AppTokens.Colors.surfaceVariant)
                    .cornerRadius(AppTokens.Shapes.small)
                
                Button(action: {}) {
                    Text("Open")
                        .font(AppTokens.Typography.label)
                        .foregroundColor(AppTokens.Colors.secondary)
                }
            }
        }
        .padding(AppTokens.Spacing.md)
        .background(AppTokens.Colors.surface)
        .cornerRadius(AppTokens.Shapes.large)
        .overlay(
            RoundedRectangle(cornerRadius: AppTokens.Shapes.large)
                .stroke(AppTokens.Colors.outline, lineWidth: 1)
        )
    }
}

struct ActionFooter: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
            Text("Dock filters")
                .font(AppTokens.Typography.title)
                .foregroundColor(AppTokens.Colors.onSurface)
            
            HStack(spacing: AppTokens.Spacing.sm) {
                Button(action: {}) {
                    Text("Calm")
                        .font(AppTokens.Typography.label)
                        .foregroundColor(AppTokens.Colors.primary) // Default button text color
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(AppTokens.Colors.onPrimary) // Using onPrimary (white/light) for surface feel if not specified, assuming default button style
                        .cornerRadius(AppTokens.Shapes.medium)
                        // Note: Android default Button uses primary color usually, but code uses 'Button' with no color spec for 'Calm', implying default Primary container.
                        // Let's match Android Button default: Primary container, OnPrimary content.
                        .background(AppTokens.Colors.primary)
                        .foregroundColor(AppTokens.Colors.onPrimary)
                }
                
                Button(action: {}) {
                    Text("Fire")
                        .font(AppTokens.Typography.label)
                        .foregroundColor(AppTokens.Colors.onTertiary)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(AppTokens.Colors.tertiary)
                        .cornerRadius(AppTokens.Shapes.medium)
                }
            }
        }
        .padding(AppTokens.Spacing.lg)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTokens.Colors.surfaceVariant)
        .cornerRadius(AppTokens.Shapes.large)
    }
}

struct BottomInputBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: AppTokens.Spacing.sm) {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text("Message dock...")
                        .font(AppTokens.Typography.label)
                        .foregroundColor(AppTokens.Colors.onSurface.opacity(0.6))
                        .padding(.horizontal, AppTokens.Spacing.md)
                }
                TextField("", text: $text)
                    .font(AppTokens.Typography.body)
                    .foregroundColor(AppTokens.Colors.onSurface)
                    .padding(.horizontal, AppTokens.Spacing.md)
                    .padding(.vertical, AppTokens.Spacing.sm)
            }
            .frame(height: 48)
            .background(AppTokens.Colors.surface)
            .cornerRadius(AppTokens.Shapes.medium)
            
            Button(action: {}) {
                Text("Send")
                    .font(AppTokens.Typography.label)
                    .foregroundColor(AppTokens.Colors.onPrimary)
                    .padding(.horizontal, 20)
                    .frame(height: 48)
                    .background(AppTokens.Colors.primary)
                    .cornerRadius(AppTokens.Shapes.medium)
            }
        }
        .padding(.horizontal, AppTokens.Spacing.lg)
        .padding(.vertical, AppTokens.Spacing.sm)
        .background(AppTokens.Colors.surfaceVariant)
        .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: -2)
    }
}

// MARK: - Color Hex Extension
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}