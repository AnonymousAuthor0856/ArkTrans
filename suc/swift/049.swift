import SwiftUI

// MARK: - AppTokens
// 翻译自 Kotlin 的 AppTokens 对象，用于集中管理应用的颜色、字体、形状、间距和阴影。
// 这种结构使得样式修改更加方便和统一。

struct AppTokens {
    struct Colors {
        // Kotlin Color(0xFFFF7043) -> Swift Color(red: 255/255.0, green: 112/255.0, blue: 67/255.0)
        static let primary = Color(red: 0xFF / 255.0, green: 0x70 / 255.0, blue: 0x43 / 255.0)
        static let secondary = Color(red: 0xFF / 255.0, green: 0xB7 / 255.0, blue: 0x4D / 255.0)
        static let tertiary = Color(red: 0xFF / 255.0, green: 0xD1 / 255.0, blue: 0x80 / 255.0)
        static let background = Color(red: 0xFF / 255.0, green: 0xF8 / 255.0, blue: 0xF2 / 255.0)
        static let surface = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let surfaceVariant = Color(red: 0xFF / 255.0, green: 0xE0 / 255.0, blue: 0xB2 / 255.0)
        static let outline = Color(red: 0xD7 / 255.0, green: 0xCC / 255.0, blue: 0xC8 / 255.0)
        static let success = Color(red: 0x43 / 255.0, green: 0xA0 / 255.0, blue: 0x47 / 255.0)
        static let warning = Color(red: 0xFF / 255.0, green: 0xB3 / 255.0, blue: 0x00 / 255.0)
        static let error = Color(red: 0xE5 / 255.0, green: 0x39 / 255.0, blue: 0x35 / 255.0)
        static let onPrimary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onSecondary = Color(red: 0x3E / 255.0, green: 0x27 / 255.0, blue: 0x23 / 255.0)
        static let onTertiary = Color(red: 0x3E / 255.0, green: 0x27 / 255.0, blue: 0x23 / 255.0)
        static let onBackground = Color(red: 0x3E / 255.0, green: 0x27 / 255.0, blue: 0x23 / 255.0)
        static let onSurface = Color(red: 0x3E / 255.0, green: 0x27 / 255.0, blue: 0x23 / 255.0)
    }

    struct TypographyTokens {
        // Kotlin sp 单位直接映射为 SwiftUI 的 pt (CGFloat)
        static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) // Kotlin's FontWeight.Normal 对应 SwiftUI 的 .regular
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        // Kotlin Dp 单位直接映射为 SwiftUI 的 CGFloat
        static let small: CGFloat = 8
        static let medium: CGFloat = 14
        static let large: CGFloat = 20
    }

    struct Spacing {
        // Kotlin Dp 单位直接映射为 SwiftUI 的 CGFloat
        static let sm: CGFloat = 6
        static let md: CGFloat = 10
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 36
    }

    // 阴影规范，用于精确映射 Kotlin 的 ShadowSpec
    struct ShadowSpec {
        let elevation: CGFloat // Kotlin 中的 elevation，在 SwiftUI 中通常通过 radius 和 y 偏移来模拟
        let radius: CGFloat    // 阴影的模糊半径
        let dy: CGFloat        // 阴影的 Y 轴偏移
        let opacity: Double    // 阴影颜色的不透明度

        var shadowColor: Color {
            Color.black.opacity(opacity)
        }
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.1)
        static let level2 = ShadowSpec(elevation: 6, radius: 8, dy: 4, opacity: 0.15)
        static let level3 = ShadowSpec(elevation: 10, radius: 12, dy: 6, opacity: 0.18)
    }
    
    // LazyVGrid 的最小项宽度，对应 Kotlin 的 GridCells.Adaptive(160.dp)
    static let gridItemMinSize: CGFloat = 160
}

// MARK: - Data Model
// 翻译自 Kotlin 的 TripCard 数据类

struct TripCard: Identifiable {
    let id: Int
    let title: String
    let days: Int
    let price: String
}

// MARK: - TripCardView
// 辅助视图，用于渲染单个行程卡片，保持 RootScreen 的整洁。
// 对应 Kotlin 代码中的 Card Composable。

struct TripCardView: View {
    let trip: TripCard

    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
            // 图像占位符 Box，对应 Kotlin 中的 Box with background and shape
            RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                .fill(AppTokens.Colors.surfaceVariant)
                .frame(maxWidth: .infinity) // 对应 Modifier.fillMaxWidth()
                .frame(height: 100)          // 对应 Modifier.height(100.dp)

            Text(trip.title)
                .font(AppTokens.TypographyTokens.title)
                .foregroundColor(AppTokens.Colors.onSurface)

            Text("\(trip.days) days")
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.onSurface.opacity(0.7)) // 对应 .copy(alpha = 0.7f)

            HStack { // 对应 Kotlin 的 Row
                Text(trip.price)
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.primary)

                Spacer() // 对应 Kotlin 的 Arrangement.SpaceBetween

                Button(action: {
                    // 按钮点击事件，此处仅打印日志
                    print("Details for \(trip.title)")
                }) {
                    Text("Details")
                        .font(AppTokens.TypographyTokens.label)
                        .foregroundColor(AppTokens.Colors.onPrimary)
                        // 按钮内部填充，为了原子级对应 Kotlin 按钮的视觉效果
                        .padding(.horizontal, AppTokens.Spacing.md)
                        .padding(.vertical, AppTokens.Spacing.sm / 2) // 调整垂直填充以达到 36.dp 的高度
                }
                .background(AppTokens.Colors.primary) // 对应 ButtonDefaults.buttonColors(containerColor = ...)
                .cornerRadius(AppTokens.Shapes.medium) // 对应 shape = AppTokens.Shapes.medium
                .frame(height: 36) // 对应 Modifier.height(36.dp)
            }
        }
        .padding(AppTokens.Spacing.md) // 卡片内容的内部填充，对应 Column 的 padding
        .background(AppTokens.Colors.surface) // 卡片背景色，对应 CardDefaults.cardColors
        .cornerRadius(AppTokens.Shapes.large) // 卡片圆角，对应 shape = AppTokens.Shapes.large
        .shadow(color: AppTokens.ElevationMapping.level2.shadowColor, // 对应 CardDefaults.cardElevation
                radius: AppTokens.ElevationMapping.level2.radius,
                x: 0, // Kotlin 的 elevation 通常只影响 Y 轴偏移，X 轴默认为 0
                y: AppTokens.ElevationMapping.level2.dy)
    }
}

// MARK: - RootScreen
// 翻译自 Kotlin 的 RootScreen Composable，是应用的主要 UI 布局。

struct RootScreen: View {
    // 数据列表，对应 Kotlin 中的 remember { listOf(...) }
    let trips: [TripCard] = [
        TripCard(id: 1, title: "Kyoto Cherry Trail", days: 4, price: "$460"),
        TripCard(id: 2, title: "Tokyo City Break", days: 3, price: "$390"),
        TripCard(id: 3, title: "Osaka Gourmet Tour", days: 5, price: "$520"),
        TripCard(id: 4, title: "Mount Fuji Escape", days: 2, price: "$280"),
        TripCard(id: 5, title: "Okinawa Beach Week", days: 6, price: "$740"),
        TripCard(id: 6, title: "Hokkaido Winter Lights", days: 5, price: "$680")
    ]

    var body: some View {
        // 对应 Kotlin 的 Scaffold，背景渐变覆盖整个屏幕，内容在 VStack 中布局。
        VStack(alignment: .leading, spacing: AppTokens.Spacing.md) { // 对应 Kotlin Column 的 verticalArrangement
            Text("Itinerary Planner")
                .font(AppTokens.TypographyTokens.display)
                .foregroundColor(AppTokens.Colors.primary)
                .padding(.horizontal, AppTokens.Spacing.lg) // 标题的水平填充，与整体内容对齐

            ScrollView { // 对应 Kotlin 的 LazyVerticalGrid 外层的可滚动区域
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: AppTokens.gridItemMinSize), spacing: AppTokens.Spacing.lg)], // 对应 GridCells.Adaptive 和 horizontalArrangement
                    spacing: AppTokens.Spacing.lg // 对应 verticalArrangement
                ) {
                    ForEach(trips) { trip in // 对应 items(trips)
                        TripCardView(trip: trip)
                    }
                }
                .padding(.horizontal, AppTokens.Spacing.lg) // Grid 的水平填充，与整体内容对齐
                .padding(.bottom, AppTokens.Spacing.xxl)    // 对应 contentPadding = PaddingValues(bottom = ...)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // 对应 Modifier.fillMaxSize()
        .background(
            LinearGradient( // 对应 Brush.verticalGradient
                gradient: Gradient(colors: [
                    AppTokens.Colors.secondary.opacity(0.3), // 对应 .copy(alpha = 0.3f)
                    AppTokens.Colors.background,
                    AppTokens.Colors.primary.opacity(0.3)    // 对应 .copy(alpha = 0.3f)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        // Kotlin Column 的 Modifier.padding(AppTokens.Spacing.lg) 被分解为
        // 标题和 ScrollView 的水平填充，以及 VStack 的垂直 spacing，
        // 确保视觉效果一致。
    }
}

// MARK: - App Entry Point
// 翻译自 Kotlin 的 MainActivity 和 AppTheme，作为 SwiftUI 应用的入口。

@main
struct ItineraryPlannerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        RootScreen()
            .ignoresSafeArea() // 对应 WindowCompat.setDecorFitsSystemWindows(window, false) 和 hide(WindowInsetsCompat.Type.systemBars())
            .statusBarHidden(true) // 对应 hide(WindowInsetsCompat.Type.systemBars())
    }
}

// MARK: - Preview
// 翻译自 Kotlin 的 PreviewRoot Composable，用于 Xcode 预览。

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}