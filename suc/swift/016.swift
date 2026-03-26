import SwiftUI

// MARK: - AppTokens
struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF00FFFF)
        static let secondary = Color(hex: 0xFF9D00FF)
        static let tertiary = Color(hex: 0xFF00FFA3)
        static let background = Color(hex: 0xFF0B0B0D)
        static let surface = Color(hex: 0xFF1A1A1D)
        static let surfaceVariant = Color(hex: 0xFF2E2E33)
        static let outline = Color(hex: 0xFF3F3F46)
        static let success = Color(hex: 0xFF22C55E)
        static let warning = Color(hex: 0xFFF59E0B)
        static let error = Color(hex: 0xFFEF4444)
        static let onPrimary = Color(hex: 0xFF000000)
        static let onSecondary = Color(hex: 0xFFFFFFFF)
        static let onTertiary = Color(hex: 0xFF000000)
        static let onBackground = Color(hex: 0xFFE5E7EB)
        static let onSurface = Color(hex: 0xFFE5E7EB)
    }

    struct TypographyTokens {
        static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let smallCornerRadius: CGFloat = 6.0
        static let mediumCornerRadius: CGFloat = 10.0
        static let largeCornerRadius: CGFloat = 14.0
    }

    struct Spacing {
        static let xs: CGFloat = 4.0
        static let sm: CGFloat = 8.0
        static let md: CGFloat = 12.0
        static let lg: CGFloat = 16.0
        static let xl: CGFloat = 24.0
        static let xxl: CGFloat = 32.0
    }
}

// MARK: - Color Extension for Hex Initialization
extension Color {
    init(hex: UInt) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: Double((hex >> 24) & 0xFF) / 255.0 == 0 && hex <= 0xFFFFFF ? 1 : Double((hex >> 24) & 0xFF) / 255.0
        )
    }
}

// MARK: - RootScreen
struct ContentView: View {
    @State private var title: String = ""
    @State private var recording: Bool = false
    @State private var seconds: Int = 0
    @State private var timer: Timer?

    var body: some View {
        VStack(spacing: 0) {
            // 顶部栏
            Text("Neon Recorder")
                .font(AppTokens.TypographyTokens.display)
                .foregroundColor(AppTokens.Colors.primary)
                .padding(.vertical, AppTokens.Spacing.lg)
                .frame(maxWidth: .infinity)
                .background(AppTokens.Colors.background)
            
            // 内容区域
            VStack(spacing: AppTokens.Spacing.lg) {
                // 录音名称输入框
                VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
                    Text("Recording name")
                        .font(AppTokens.TypographyTokens.label)
                        .foregroundColor(AppTokens.Colors.onSurface.opacity(0.7))
                    
                    TextField("", text: $title)
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.onSurface)
                        .padding(AppTokens.Spacing.md)
                        .background(AppTokens.Colors.surface)
                        .cornerRadius(AppTokens.Shapes.mediumCornerRadius)
                        .overlay(
                            RoundedRectangle(cornerRadius: AppTokens.Shapes.mediumCornerRadius)
                                .stroke(title.isEmpty ? AppTokens.Colors.outline : AppTokens.Colors.primary, lineWidth: 1)
                        )
                        .accentColor(AppTokens.Colors.primary)
                }
                
                // 录音状态卡片
                ZStack {
                    RoundedRectangle(cornerRadius: AppTokens.Shapes.largeCornerRadius)
                        .fill(AppTokens.Colors.surfaceVariant)
                    
                    Text(recording ? "Recording... \(seconds)s" : "Press Record")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(recording ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
                }
                .frame(height: 200)
                
                // 按钮行
                HStack(spacing: AppTokens.Spacing.xl) {
                    Button(action: {
                        recording.toggle()
                        if recording {
                            seconds = 0
                            startTimer()
                        } else {
                            stopTimer()
                        }
                    }) {
                        Text(recording ? "Stop" : "Record")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .frame(width: 160, height: 52)
                            .background(
                                RoundedRectangle(cornerRadius: AppTokens.Shapes.largeCornerRadius)
                                    .fill(recording ? AppTokens.Colors.error : AppTokens.Colors.primary)
                            )
                    }
                    .buttonStyle(PlainButtonStyle())

                    Button(action: {
                        seconds = 0
                        if recording {
                            stopTimer()
                            startTimer()
                        }
                    }) {
                        Text("Reset")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onSecondary)
                            .frame(width: 120, height: 52)
                            .background(
                                RoundedRectangle(cornerRadius: AppTokens.Shapes.largeCornerRadius)
                                    .fill(AppTokens.Colors.secondary)
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Spacer()
                    .frame(height: AppTokens.Spacing.xxl)
                
                Text("Output Path: /storage/recordings/\(title.isEmpty ? "untitled" : title).mp3")
                    .font(AppTokens.TypographyTokens.body)
                    .foregroundColor(AppTokens.Colors.onSurface.opacity(0.7))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(AppTokens.Spacing.lg)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [AppTokens.Colors.background, AppTokens.Colors.surfaceVariant]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .background(AppTokens.Colors.background)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .ignoresSafeArea(.all, edges: .all)
        .statusBar(hidden: true)
    }
    
    // MARK: - Timer Functions
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            seconds += 1
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

// MARK: - App Entry Point
@main
struct NeonRecorderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}