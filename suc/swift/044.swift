import SwiftUI

struct AppTokens {
    struct Colors {
        static let primary = Color(red: 1.0, green: 0.44, blue: 0.26)
        static let secondary = Color(red: 1.0, green: 0.72, blue: 0.3)
        static let tertiary = Color(red: 1.0, green: 0.82, blue: 0.5)
        static let background = Color(red: 1.0, green: 0.95, blue: 0.88)
        static let surface = Color(red: 1.0, green: 1.0, blue: 1.0)
        static let surfaceVariant = Color(red: 1.0, green: 0.88, blue: 0.7)
        static let outline = Color(red: 0.84, green: 0.8, blue: 0.78)
        static let success = Color(red: 0.4, green: 0.73, blue: 0.42)
        static let warning = Color(red: 1.0, green: 0.79, blue: 0.16)
        static let error = Color(red: 0.83, green: 0.18, blue: 0.18)
        static let onPrimary = Color(red: 1.0, green: 1.0, blue: 1.0)
        static let onSecondary = Color(red: 0.24, green: 0.15, blue: 0.14)
        static let onBackground = Color(red: 0.24, green: 0.15, blue: 0.14)
        static let onSurface = Color(red: 0.24, green: 0.15, blue: 0.14)
    }

    struct TypographyTokens {
        static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small: CGFloat = 6.0
        static let medium: CGFloat = 10.0
        static let large: CGFloat = 16.0
    }

    struct Spacing {
        static let sm: CGFloat = 6.0
        static let md: CGFloat = 10.0
        static let lg: CGFloat = 16.0
        static let xl: CGFloat = 24.0
    }
}

struct CustomSlider: View {
    @Binding var value: Float
    let activeColor: Color
    let inactiveColor: Color
    let thumbColor: Color
    let trackHeight: CGFloat = 10
    let thumbDiameter: CGFloat = 20

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(inactiveColor)
                    .frame(height: trackHeight)

                Capsule()
                    .fill(activeColor)
                    .frame(width: geometry.size.width * CGFloat(value), height: trackHeight)

                Circle()
                    .fill(thumbColor)
                    .frame(width: thumbDiameter, height: thumbDiameter)
                    .offset(x: geometry.size.width * CGFloat(value) - thumbDiameter / 2)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let dragLocation = gesture.location.x
                                let newValue = Float(min(max(0, dragLocation / geometry.size.width), 1))
                                self.value = newValue
                            }
                    )
            }
        }
        .frame(height: thumbDiameter)
    }
}

struct RootScreen: View {
    @State private var progress: Float = 0.42 // 与原图42%进度保持一致

    var body: some View {
        ZStack {
            // 背景色铺满整个屏幕，无额外边距
            AppTokens.Colors.background.ignoresSafeArea(.all)

            // 主内容容器：移除顶部额外留白，与原 Kotlin Column 布局对齐
            VStack(spacing: AppTokens.Spacing.lg) {
                // 标题：仅跟随容器统一内边距，无额外顶部间距
                Text("Order Tracking")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onBackground)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // 订单信息卡片（与原 Kotlin Card 布局一致）
                VStack(spacing: AppTokens.Spacing.md) {
                    Text("Order #25491")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("Estimated Delivery: 2 days")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    // 进度条（与原 Kotlin LinearProgressIndicator 尺寸一致）
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(AppTokens.Colors.surfaceVariant)
                                .frame(height: 10)

                            Capsule()
                                .fill(AppTokens.Colors.primary)
                                .frame(width: geometry.size.width * CGFloat(progress), height: 10)
                        }
                    }
                    .frame(height: 10)

                    // 进度文本（左右对齐，与原图一致）
                    HStack {
                        Text("Processing")
                            .font(AppTokens.TypographyTokens.label)
                            .foregroundColor(AppTokens.Colors.secondary)

                        Spacer() // 用 Spacer 确保左右对齐，比 frame(maxWidth) 更精准

                        Text("\(Int(progress * 100))%")
                            .font(AppTokens.TypographyTokens.label)
                            .foregroundColor(AppTokens.Colors.primary)
                    }
                }
                .padding(AppTokens.Spacing.lg)
                .background(AppTokens.Colors.surface)
                .cornerRadius(AppTokens.Shapes.large)
                .shadow(
                    color: Color.black.opacity(0.15),
                    radius: 8,
                    x: 0,
                    y: 4 // 与原 Kotlin ElevationMapping.level2 阴影参数一致
                )

                // 进度调整区域（与原 Kotlin Box 布局一致）
                VStack(spacing: AppTokens.Spacing.md) {
                    Text("Adjust Progress")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)
                        .frame(maxWidth: .infinity, alignment: .center)

                    CustomSlider(
                        value: $progress,
                        activeColor: AppTokens.Colors.primary,
                        inactiveColor: AppTokens.Colors.surfaceVariant,
                        thumbColor: AppTokens.Colors.primary
                    )

                    Button(action: {
                        progress = 1.0 // 点击后进度设为100%（已送达）
                    }) {
                        Text("Mark as Delivered")
                            .font(AppTokens.TypographyTokens.label)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .padding(.vertical, AppTokens.Spacing.md)
                            .frame(maxWidth: .infinity)
                            .background(AppTokens.Colors.primary)
                            .cornerRadius(AppTokens.Shapes.medium)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(AppTokens.Spacing.lg)
                .background(AppTokens.Colors.surface)
                .cornerRadius(AppTokens.Shapes.large)
            }
            // 关键修改：统一容器内边距（仅横向+纵向统一16dp，无额外顶部8dp）
            // 与原 Kotlin Column 的 .padding(AppTokens.Spacing.lg) 完全对齐
            .padding(AppTokens.Spacing.lg)
        }
        .ignoresSafeArea(.all)
        .statusBarHidden(true) // 隐藏状态栏，避免额外留白
    }
}

@main
struct OrderTrackingApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}