import SwiftUI

// MARK: - Entry Point
@main
struct ChargingProgressApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// MARK: - Design System Tokens
struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0x3B82F6)
        static let secondary = Color(hex: 0x22C55E)
        static let background = Color(hex: 0xF5F5F4)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let outline = Color(hex: 0xD4D4D8)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onBackground = Color(hex: 0x111827)
        static let onSurface = Color(hex: 0x1F2937)
        static let accent = Color(hex: 0xF59E0B)
    }
    
    struct Typography {
        static func display(size: CGFloat = 24) -> Font { .system(size: size, weight: .bold) }
        static let headline = Font.system(size: 18, weight: .semibold)
        static let title = Font.system(size: 14, weight: .medium)
        static let body = Font.system(size: 12, weight: .regular)
    }
    
    struct Spacing {
        static let sm: CGFloat = 6
        static let md: CGFloat = 10
        static let lg: CGFloat = 14
        static let xl: CGFloat = 20
        static let xxl: CGFloat = 40
    }
}

// MARK: - Main Content View
struct ContentView: View {
    var body: some View {
        RootScreen()
            .statusBarHidden(true)
    }
}

struct RootScreen: View {
    @State private var progress: Float = 0.45
    
    var body: some View {
        ZStack {
            // Background
            AppTokens.Colors.background
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Bar
                CustomTopBar()
                
                // Content - 使用更紧凑的布局
                VStack(spacing: AppTokens.Spacing.lg) {
                    // 电池和百分比组合，紧贴顶部栏
                    VStack(spacing: AppTokens.Spacing.md) {
                        // Custom Vertical Battery Icon
                        BatteryIcon(progress: progress)
                            .frame(width: 60, height: 100)
                        
                        // Percentage Text
                        Text("\(Int(progress * 100))%")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(AppTokens.Colors.onBackground)
                    }
                    .padding(.top, AppTokens.Spacing.md)
                    
                    // Progress Bar
                    CustomProgressBar(progress: progress)
                        .frame(height: 12)
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.7)
                        .padding(.top, AppTokens.Spacing.lg)
                    
                    // Simulate Button
                    Button(action: {
                        withAnimation {
                            progress += 0.1
                            if progress > 1.0 {
                                progress = 0.0
                            }
                        }
                    }) {
                        Text("Simulate Charge")
                            .font(AppTokens.Typography.title)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(AppTokens.Colors.secondary)
                            .clipShape(Capsule())
                    }
                    .padding(.top, AppTokens.Spacing.lg)
                    
                    // Status Text
                    Text(progress < 1.0 ? "Charging..." : "Fully Charged!")
                        .font(AppTokens.Typography.headline)
                        .foregroundColor(progress < 1.0 ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
                        .padding(.top, AppTokens.Spacing.md)
                    
                    Spacer()
                }
                .padding(AppTokens.Spacing.lg)
                .frame(maxWidth: .infinity)
            }
        }
    }
}

// MARK: - Components

struct CustomTopBar: View {
    var body: some View {
        HStack {
            // Navigation Icon (Electric Car)
            Image(systemName: "bolt.car.fill")
                .font(.system(size: 24))
                .foregroundColor(AppTokens.Colors.primary)
                .padding(.leading, 8)
            
            Spacer()
            
            // Title
            Text("Charging Progress")
                .font(AppTokens.Typography.display(size: 24))
                .foregroundColor(AppTokens.Colors.onBackground)
            
            Spacer()
            
            // Action Icon (Settings)
            Button(action: {}) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 24))
                    .foregroundColor(AppTokens.Colors.accent)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(AppTokens.Colors.surface)
    }
}

struct BatteryIcon: View {
    var progress: Float
    
    var body: some View {
        ZStack {
            // 电池主体 - 全蓝色
            RoundedRectangle(cornerRadius: 8)
                .fill(AppTokens.Colors.primary)
                .frame(width: 50, height: 90)
            
            // 电池顶部凸起
            RoundedRectangle(cornerRadius: 3)
                .fill(AppTokens.Colors.primary)
                .frame(width: 20, height: 10)
                .offset(y: -50)
            
            // 自定义闪电图标 - 更接近原图
            LightningBolt()
                .fill(AppTokens.Colors.onPrimary)
                .frame(width: 25, height: 40)
        }
    }
}

// 自定义闪电形状
struct LightningBolt: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // 闪电形状的路径
        path.move(to: CGPoint(x: rect.midX, y: rect.minY + 5))
        path.addLine(to: CGPoint(x: rect.midX - 8, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX + 2, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX - 5, y: rect.maxY - 5))
        path.addLine(to: CGPoint(x: rect.midX + 8, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX - 2, y: rect.midY))
        path.closeSubpath()
        
        return path
    }
}

struct CustomProgressBar: View {
    var progress: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Track
                Capsule()
                    .fill(AppTokens.Colors.surface)
                    .overlay(
                        Capsule()
                            .stroke(AppTokens.Colors.outline, lineWidth: 1)
                    )
                
                // Indicator
                Capsule()
                    .fill(AppTokens.Colors.primary)
                    .frame(width: CGFloat(min(max(progress, 0), 1)) * geometry.size.width)
                    .padding(1)
            }
        }
        .clipShape(Capsule())
    }
}

// MARK: - Extensions

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