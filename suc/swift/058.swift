import SwiftUI

// MARK: - AppTokens
// 定义应用程序的颜色、排版、形状和间距。
// 这些常量在整个应用中提供一致的UI样式。
struct AppTokens {
    struct Colors {
        static let primary = Color(hex: "111827")
        static let secondary = Color(hex: "374151")
        static let tertiary = Color(hex: "6B7280")
        static let background = Color(hex: "F9FAFB")
        static let surface = Color(hex: "FFFFFF")
        static let surfaceVariant = Color(hex: "E5E7EB")
        static let outline = Color(hex: "D1D5DB")
        static let success = Color(hex: "16A34A")
        static let warning = Color(hex: "F59E0B")
        static let error = Color(hex: "EF4444")
        static let onPrimary = Color(hex: "FFFFFF")
        static let onSecondary = Color(hex: "FFFFFF")
        static let onTertiary = Color(hex: "111827")
        static let onBackground = Color(hex: "111827")
        static let onSurface = Color(hex: "1F2937")
    }

    struct TypographyTokens {
        // Compose的TextStyle被翻译为SwiftUI的Font
        static let display = Font.system(size: 28, weight: .bold)
        static let headline = Font.system(size: 20, weight: .semibold)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        // Compose的RoundedCornerShape(X.dp)被翻译为SwiftUI的CGFloat圆角值
        static let small = 8.0
        static let medium = 12.0
        static let large = 16.0
    }

    struct Spacing {
        // Compose的X.dp被翻译为SwiftUI的CGFloat间距值
        static let xs = 4.0
        static let sm = 8.0
        static let md = 12.0
        static let lg = 16.0
        static let xl = 24.0
        static let xxl = 36.0
    }
    
    // Kotlin中的ShadowSpec未在UI中直接使用，因此在SwiftUI中无需直接翻译为结构体。
    // 如果需要阴影效果，可以直接使用SwiftUI的 .shadow() 修饰符。
}

// MARK: - Color Extension for Hex Initialization
// 允许使用十六进制字符串初始化颜色，方便与AppTokens中的颜色定义对应。
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        // 确保扫描成功
        guard scanner.scanHexInt64(&rgbValue) else {
            self.init(red: 0, green: 0, blue: 0) // Fallback to black if hex is invalid
            return
        }

        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}

// MARK: - RootScreen
// 对应Kotlin的RootScreen Composable，是应用的主界面。
struct RootScreen: View {
    // @State 对应 Compose 的 rememberPagerState，用于管理当前选中的Tab和Pager页面。
    @State private var selectedTabIndex: Int = 0
    let tabs = ["Overview", "Ranking", "Stats"]

    var body: some View {
        // GeometryReader 用于获取父视图的尺寸，以便进行响应式布局和原子级尺寸匹配。
        GeometryReader { geometry in
            VStack(spacing: 0) { // spacing: 0 对应 Compose 的 Column 默认无间距，间距由子视图的 padding 或 Spacer 控制。
                // 顶部标题区域，对应 Kotlin 中的 Box
                Text("Step Challenge")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onBackground)
                    .padding(AppTokens.Spacing.lg) // 对应 Modifier.padding(AppTokens.Spacing.lg)
                    .frame(maxWidth: .infinity, alignment: .center) // 对应 Modifier.fillMaxWidth() 和 Alignment.Center

                // 自定义 TabRow，模仿 Compose 的 TabRow 行为和样式。
                CustomTabRow(tabs: tabs, selectedTabIndex: $selectedTabIndex)
                    .frame(maxWidth: .infinity) // 对应 Modifier.fillMaxWidth()
                
                // HorizontalPager 对应 SwiftUI 的 TabView，并设置为分页样式。
                TabView(selection: $selectedTabIndex) {
                    OverviewPage()
                        .tag(0) // 对应 pagerState 的页面索引
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // 确保页面内容填充可用空间
                    RankingPage()
                        .tag(1)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    StatsPage()
                        .tag(2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .tabViewStyle(.page(indexDisplayMode: .never)) // 设置为分页样式，并隐藏页面指示器（小圆点）
                .animation(.easeInOut, value: selectedTabIndex) // 页面切换时添加动画，value参数确保iOS 14+兼容性
                .background(AppTokens.Colors.surface) // Pager内容区域的默认背景色
            }
            // 整个RootScreen的背景渐变，对应 Kotlin 中的 Brush.verticalGradient
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [AppTokens.Colors.surfaceVariant, AppTokens.Colors.surface]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            // 忽略安全区域，实现全屏显示，对应 Android 的 WindowCompat.setDecorFitsSystemWindows(window, false)
            .ignoresSafeArea(.all, edges: .all)
        }
    }
}

// MARK: - CustomTabRow
// 自定义 TabRow 组件，以精确匹配 Compose TabRow 的视觉和交互。
struct CustomTabRow: View {
    let tabs: [String]
    @Binding var selectedTabIndex: Int // 使用 @Binding 与 RootScreen 的 selectedTabIndex 同步

    var body: some View {
        VStack(spacing: 0) { // 垂直堆叠，无额外间距
            HStack(spacing: 0) { // 水平堆叠 Tab 按钮，无额外间距
                ForEach(tabs.indices, id: \.self) { index in
                    Button(action: {
                        selectedTabIndex = index // 点击 Tab 按钮时更新选中索引
                    }) {
                        Text(tabs[index])
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(selectedTabIndex == index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
                            .padding(.vertical, AppTokens.Spacing.md) // 垂直内边距
                            .frame(maxWidth: .infinity) // 每个 Tab 按钮填充可用宽度
                    }
                }
            }
            
            // 下划线指示器，用于显示当前选中的 Tab
            GeometryReader { geometry in // 使用 GeometryReader 获取 TabRow 的实际宽度
                Rectangle()
                    .fill(AppTokens.Colors.primary) // 下划线颜色
                    .frame(width: geometry.size.width / CGFloat(tabs.count), height: 2) // 下划线宽度为每个 Tab 的宽度，高度为2dp
                    // 根据 selectedTabIndex 计算下划线的偏移量
                    .offset(x: (geometry.size.width / CGFloat(tabs.count)) * CGFloat(selectedTabIndex))
                    .animation(.easeInOut(duration: 0.2), value: selectedTabIndex) // 动画效果
            }
            .frame(height: 2) // GeometryReader 本身的高度，即下划线的高度
        }
        .background(AppTokens.Colors.surface) // TabRow 的背景色
    }
}

// MARK: - OverviewPage
// 对应 Kotlin 的 OverviewPage Composable。
struct OverviewPage: View {
    var body: some View {
        VStack(spacing: AppTokens.Spacing.md) { // 对应 verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
            Text("Today's Steps: 8452")
                .font(AppTokens.TypographyTokens.headline)
                .foregroundColor(AppTokens.Colors.onSurface)
            
            Spacer() // 对应 Spacer(modifier = Modifier.height(AppTokens.Spacing.lg))
                .frame(height: AppTokens.Spacing.lg)
            
            Button(action: {
                // 处理 Sync Device 按钮点击事件
            }) {
                Text("Sync Device")
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.onPrimary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // 文本填充按钮内部
            }
            // 按钮尺寸，对应 Modifier.fillMaxWidth(0.6f).height(48.dp)
            .frame(width: UIScreen.main.bounds.width * 0.6, height: 48)
            .background(AppTokens.Colors.primary) // 按钮背景色
            .cornerRadius(AppTokens.Shapes.large) // 按钮圆角，对应 shape = AppTokens.Shapes.large
            
            Spacer() // 垂直居中内容
        }
        .padding(AppTokens.Spacing.lg) // 对应 Modifier.padding(AppTokens.Spacing.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity) // 对应 Modifier.fillMaxSize()
    }
}

// MARK: - RankingPage
// 对应 Kotlin 的 RankingPage Composable。
struct RankingPage: View {
    var body: some View {
        VStack(spacing: AppTokens.Spacing.sm) { // 对应 verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
            ForEach(0..<5) { it in // 对应 repeat(5)
                HStack { // 对应 Row，默认 horizontalArrangement = Arrangement.SpaceBetween
                    Text("User \(it + 1)")
                        .foregroundColor(AppTokens.Colors.onSurface)
                        .font(AppTokens.TypographyTokens.body) // 假设使用 body 样式
                    
                    Spacer() // 将文本推向两端
                    
                    Text("\(9000 - it * 500) steps")
                        .foregroundColor(AppTokens.Colors.onSurface)
                        .font(AppTokens.TypographyTokens.body) // 假设使用 body 样式
                }
                .padding(AppTokens.Spacing.md) // 对应 Modifier.padding(AppTokens.Spacing.md)
                .background(AppTokens.Colors.surfaceVariant) // 对应 background(AppTokens.Colors.surfaceVariant)
                .cornerRadius(AppTokens.Shapes.medium) // 对应 AppTokens.Shapes.medium
                .frame(maxWidth: .infinity) // 对应 Modifier.fillMaxWidth()
            }
        }
        .padding(AppTokens.Spacing.lg) // 对应 Modifier.padding(AppTokens.Spacing.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) // 对应 Modifier.fillMaxSize()，并顶部对齐
    }
}

// MARK: - StatsPage
// 对应 Kotlin 的 StatsPage Composable。
struct StatsPage: View {
    var body: some View {
        VStack(spacing: AppTokens.Spacing.sm) { // 对应 verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
            Text("Weekly Progress")
                .font(AppTokens.TypographyTokens.headline)
                .foregroundColor(AppTokens.Colors.onSurface)
            
            ForEach(0..<7) { it in // 对应 repeat(7)
                GeometryReader { geometry in // 使用 GeometryReader 获取父视图宽度，用于计算进度条填充比例
                    HStack(spacing: 0) { // 进度条的填充部分和剩余部分
                        Rectangle()
                            .fill(AppTokens.Colors.primary) // 填充颜色
                            // 计算填充宽度，对应 fillMaxWidth((0.3f + it * 0.1f).coerceAtMost(1f))
                            .frame(width: geometry.size.width * (0.3 + CGFloat(it) * 0.1).clamped(to: 0...1))
                            .cornerRadius(AppTokens.Shapes.small) // 填充部分的圆角
                        
                        Spacer(minLength: 0) // 确保填充部分左对齐并占据计算出的宽度
                    }
                    .frame(height: 20) // 对应 height(20.dp)
                    .background(AppTokens.Colors.surfaceVariant) // 背景条颜色
                    .cornerRadius(AppTokens.Shapes.small) // 背景条圆角
                }
                .frame(height: 20) // GeometryReader 本身的高度
                .frame(maxWidth: .infinity) // 对应 Modifier.fillMaxWidth()
            }
            Spacer() // 将内容推向顶部
        }
        .padding(AppTokens.Spacing.lg) // 对应 Modifier.padding(AppTokens.Spacing.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) // 对应 Modifier.fillMaxSize()，并顶部对齐
    }
}

// MARK: - Clamped Extension
// 辅助扩展，用于将数值限制在给定范围内，对应 Kotlin 的 .coerceAtMost(1f)
extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

// MARK: - App Entry Point
// SwiftUI 应用的入口点，对应 Kotlin 的 MainActivity。
@main
struct StepChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                // 隐藏状态栏，对应 Android 的 WindowInsetsControllerCompat.hide(WindowInsetsCompat.Type.systemBars())
                .statusBarHidden(true)
        }
    }
}
