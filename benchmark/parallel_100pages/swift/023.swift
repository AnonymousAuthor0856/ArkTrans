import SwiftUI

struct AppTokens {
    struct Colors {
        static let primary = Color(red: 255/255, green: 143/255, blue: 171/255)
        static let secondary = Color(red: 180/255, green: 227/255, blue: 208/255)
        static let tertiary = Color(red: 255/255, green: 214/255, blue: 165/255)
        static let background = Color(red: 255/255, green: 252/255, blue: 249/255)
        static let surface = Color(red: 255/255, green: 255/255, blue: 255/255)
        static let surfaceVariant = Color(red: 253/255, green: 226/255, blue: 228/255)
        static let outline = Color(red: 252/255, green: 194/255, blue: 215/255)
        static let success = Color(red: 74/255, green: 222/255, blue: 128/255)
        static let warning = Color(red: 250/255, green: 204/255, blue: 21/255)
        static let error = Color(red: 251/255, green: 113/255, blue: 133/255)
        static let onPrimary = Color(red: 255/255, green: 255/255, blue: 255/255)
        static let onSecondary = Color(red: 30/255, green: 30/255, blue: 30/255)
        static let onTertiary = Color(red: 30/255, green: 30/255, blue: 30/255)
        static let onBackground = Color(red: 30/255, green: 30/255, blue: 30/255)
        static let onSurface = Color(red: 30/255, green: 30/255, blue: 30/255)
    }

    struct TypographyTokens {
        static let display = Font.system(size: 30, weight: .bold)
        static let title = Font.system(size: 20, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Spacing {
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
    }

    struct ShadowSpec {
        let radius: CGFloat
        let y: CGFloat
        let opacity: Double
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(radius: 4, y: 2, opacity: 0.12)
        static let level2 = ShadowSpec(radius: 8, y: 4, opacity: 0.18)
    }
}

struct RootScreen: View {
    @State private var knobPosition: CGPoint = CGPoint(x: 140, y: 140)
    @State private var isRunning = false

    var body: some View {
        ZStack {
            AppTokens.Colors.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                                Spacer()
                    .frame(height: AppTokens.Spacing.lg)
                
                HStack {
                    Text("Pomodoro Timer")
                        .font(AppTokens.TypographyTokens.display)
                        .foregroundColor(AppTokens.Colors.onSurface)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 64)
                .background(AppTokens.Colors.background)
                
                                VStack(spacing: AppTokens.Spacing.xl) {
                                        ZStack {
                                                Circle()
                            .fill(AppTokens.Colors.surfaceVariant)
                            .frame(width: 280, height: 280)
                            .shadow(
                                color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),
                                radius: AppTokens.ElevationMapping.level2.radius,
                                x: 0,
                                y: AppTokens.ElevationMapping.level2.y
                            )
                        
                                                Circle()
                            .fill(AppTokens.Colors.secondary.opacity(0.4))
                            .frame(width: 180, height: 180) 
                        
                                                Circle()
                            .fill(AppTokens.Colors.primary)
                            .frame(width: 60, height: 60)
                            .position(knobPosition)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                                                                let center = CGPoint(x: 140, y: 140)
                                        let vector = CGPoint(
                                            x: value.location.x - center.x,
                                            y: value.location.y - center.y
                                        )
                                        let distance = sqrt(vector.x * vector.x + vector.y * vector.y)
                                        let normalizedVector = CGPoint(
                                            x: vector.x / distance,
                                            y: vector.y / distance
                                        )
                                        
                                                                                let trackRadius: CGFloat = 90
                                        knobPosition = CGPoint(
                                            x: center.x + normalizedVector.x * trackRadius,
                                            y: center.y + normalizedVector.y * trackRadius
                                        )
                                    }
                            )
                    }
                    .frame(width: 280, height: 280)
                    
                                        Text(isRunning ? "Focus Mode ON" : "Focus Mode OFF")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(isRunning ? AppTokens.Colors.success : AppTokens.Colors.error)
                    
                                        HStack(spacing: AppTokens.Spacing.lg) {
                        Button(action: { isRunning = true }) {
                            Text("Start")
                                .font(AppTokens.TypographyTokens.body)
                                .foregroundColor(AppTokens.Colors.onPrimary)
                                .frame(width: 90, height: 90)
                                .background(AppTokens.Colors.primary)
                                .clipShape(Circle())
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Button(action: { isRunning = false }) {
                            Text("Stop")
                                .font(AppTokens.TypographyTokens.body)
                                .foregroundColor(AppTokens.Colors.onSecondary)
                                .frame(width: 90, height: 90)
                                .background(AppTokens.Colors.tertiary)
                                .clipShape(Circle())
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                                        ZStack(alignment: .leading) {
                                                Capsule()
                            .fill(AppTokens.Colors.surfaceVariant)
                            .frame(height: 8)
                        
                                                Capsule()
                            .fill(AppTokens.Colors.primary)
                            .frame(
                                width: (UIScreen.main.bounds.width - 64) * 0.4, 
                                height: 8
                            )
                    }
                    .padding(.horizontal, AppTokens.Spacing.lg)
                }
                .padding(.top, AppTokens.Spacing.lg)
            }
        }
        .statusBar(hidden: true)
    }
}

@main
struct PomodoroTimerApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}