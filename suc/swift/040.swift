
import SwiftUI

// MARK: - AppTokens
// 统一的 UI 令牌，方便管理颜色、字体、形状、间距和阴影，实现原子级设计
struct AppTokens {
    struct Colors {
        static let primary = Color(red: 1.0, green: 123/255.0, blue: 0/255.0) // #FF7B00
        static let secondary = Color(red: 1.0, green: 209/255.0, blue: 102/255.0) // #FFD166
        static let background = Color(red: 1.0, green: 246/255.0, blue: 229/255.0) // #FFF6E5
        static let surface = Color(red: 1.0, green: 1.0, blue: 1.0) // #FFFFFF
        static let surfaceVariant = Color(red: 1.0, green: 240/255.0, blue: 193/255.0) // #FFF0C1
        static let outline = Color(red: 224/255.0, green: 192/255.0, blue: 128/255.0) // #E0C080
        static let onPrimary = Color(red: 1.0, green: 1.0, blue: 1.0) // #FFFFFF
        static let onSecondary = Color(red: 62/255.0, green: 39/255.0, blue: 35/255.0) // #3E2723
        static let onBackground = Color(red: 62/255.0, green: 39/255.0, blue: 35/255.0) // #3E2723
        static let onSurface = Color(red: 62/255.0, green: 39/255.0, blue: 35/255.0) // #3E2723
    }

    struct TypographyTokens {
        // 使用 .system 字体，并提供字号和字重，以便精确匹配 Android Compose 的 TextStyle
        static let display = Font.system(size: 28, weight: .bold)
        static let headline = Font.system(size: 20, weight: .semibold)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
        
        // 方便计算按钮内文本的垂直填充，直接提供字号
        static let labelFontSize: CGFloat = 12.0
    }

    struct Shapes {
        // 圆角半径，直接从 dp 转换为 CGFloat
        static let small: CGFloat = 6.0
        static let medium: CGFloat = 10.0
        static let large: CGFloat = 14.0
    }

    struct Spacing {
        // 间距，直接从 dp 转换为 CGFloat
        static let sm: CGFloat = 8.0
        static let md: CGFloat = 12.0
        static let lg: CGFloat = 16.0
    }

    struct ShadowSpec {
        let elevation: CGFloat // 阴影扩散半径
        let radius: CGFloat // 阴影模糊半径
        let dy: CGFloat // Y轴偏移
        let opacity: Double // 不透明度
    }

    struct ElevationMapping {
        // 阴影规格，对应 Android Compose 的 CardDefaults.cardElevation
        static let level2 = ShadowSpec(elevation: 4.0, radius: 8.0, dy: 4.0, opacity: 0.12)
    }
}

// MARK: - ResultItem
// 数据模型，对应 Kotlin 的 data class ResultItem
struct ResultItem: Identifiable {
    let id: Int
    let title: String
}

// MARK: - RootScreen
// 核心 UI 视图，对应 Kotlin 的 @Composable fun RootScreen()
struct RootScreen: View {
    // 状态管理，对应 Kotlin 的 remember { mutableStateOf(...) }
    @State private var query: String = ""
    // 拖动旋钮的初始位置，已根据 Canvas 内部 padding 调整
    @State private var knobOffset: CGSize = CGSize(width: 144, height: 104) // (160 - 16, 120 - 16)
    
    // 列表数据，对应 Kotlin 的 List(6) { ... }
    let results: [ResultItem] = Array(0..<6).map { i in ResultItem(id: i, title: "Result \(i + 1)") }

    // 用于 TextField 的焦点状态，以便模拟 Material Design 的指示器颜色变化
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        // ZStack 模拟 Scaffold 的 containerColor 和 ignoresSafeArea
        ZStack {
            AppTokens.Colors.background.ignoresSafeArea() // 背景色并忽略安全区域以实现全屏

            VStack(spacing: AppTokens.Spacing.md) { // 对应 Kotlin 的 Column, verticalArrangement
                Text("Retro Filter Search")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onBackground)
                    .frame(maxWidth: .infinity, alignment: .leading) // 对应 Modifier.fillMaxWidth().align(Alignment.Start)

                // 搜索输入框，对应 Kotlin 的 TextField
                TextField("", text: $query) // 空字符串作为占位符，实际占位符通过 overlay 实现
                    .font(AppTokens.TypographyTokens.body)
                    .foregroundColor(AppTokens.Colors.onSurface)
                    // 自定义占位符视图
                    .placeholder(when: query.isEmpty, alignment: .leading) {
                        Text("Search products")
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onSurface.opacity(0.4))
                            .padding(.leading, AppTokens.Spacing.lg) // 占位符的左侧内边距
                    }
                    .padding(.horizontal, AppTokens.Spacing.lg) // TextField 文本的左右内边距
                    .frame(height: 56) // Material Design 默认 TextField 高度通常为 56dp
                    .background(AppTokens.Colors.surface)
                    .cornerRadius(AppTokens.Shapes.medium)
                    // 模拟 TextField 的指示器颜色变化
                    .overlay(
                        RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                            .stroke(isTextFieldFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline, lineWidth: 1)
                    )
                    .focused($isTextFieldFocused) // 绑定焦点状态
                    .textInputAutocapitalization(.never) // 禁用首字母大写
                    .autocorrectionDisabled() // 禁用自动更正

                // 筛选按钮行，对应 Kotlin 的 Row
                HStack(spacing: AppTokens.Spacing.sm) { // 对应 horizontalArrangement
                    ForEach(["Popular", "New", "Discount", "Premium"], id: \.self) { text in
                        Button(action: {
                            // 按钮点击事件
                        }) {
                            Text(text)
                                .font(AppTokens.TypographyTokens.label)
                                .foregroundColor(AppTokens.Colors.onSecondary)
                                .padding(.horizontal, AppTokens.Spacing.md) // 按钮文本的左右内边距
                                // 计算垂直内边距以使按钮总高度为 36pt (对应 36.dp)
                                .padding(.vertical, (36 - AppTokens.TypographyTokens.labelFontSize) / 2)
                        }
                        .frame(height: 36) // 对应 Modifier.height(36.dp)
                        .background(AppTokens.Colors.secondary)
                        .cornerRadius(AppTokens.Shapes.small)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading) // 确保 HStack 靠左对齐

                // Canvas 区域，对应 Kotlin 的 Box 和 Canvas
                ZStack {
                    // Box 的背景和圆角
                    AppTokens.Colors.surface
                        .cornerRadius(AppTokens.Shapes.large)

                    Canvas { context, size in
                        // 绘制背景矩形，对应 drawRect
                        context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(AppTokens.Colors.surfaceVariant))

                        // 绘制径向渐变圆，对应 drawCircle(brush = Brush.radialGradient(...))
                        let center = CGPoint(x: size.width / 2, y: size.height / 2)
                        let radialGradient = Gradient(colors: [AppTokens.Colors.secondary, AppTokens.Colors.primary])
                        context.fill(
                            Path(ellipseIn: CGRect(x: center.x - 60, y: center.y - 60, width: 120, height: 120)),
                            with: .radialGradient(radialGradient, center: center, startRadius: 0, endRadius: 60)
                        )

                        // 绘制可拖动旋钮，对应 drawCircle(color = ..., center = knob.value)
                        let knobCenter = CGPoint(x: knobOffset.width, y: knobOffset.height)
                        context.fill(
                            Path(ellipseIn: CGRect(x: knobCenter.x - 16, y: knobCenter.y - 16, width: 32, height: 32)),
                            with: .color(AppTokens.Colors.primary)
                        )
                    }
                    .padding(AppTokens.Spacing.lg) // Canvas 内部内容填充，对应 Modifier.padding(16.dp)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                // 限制旋钮在 Canvas 绘制区域内移动，并考虑旋钮半径 16pt
                                let minX: CGFloat = 8
                                let maxX: CGFloat = 8
                                let minY: CGFloat = 8
                                let maxY: CGFloat = 8
                                let clampedX = max(minX, min(value.location.x, maxX))
                                let clampedY = max(minY, min(value.location.y, maxY))

                                knobOffset = CGSize(width: clampedX, height: clampedY)
                            }
                    )
                }
                .frame(height: 180) // 对应 Modifier.height(180.dp)
                .frame(maxWidth: .infinity) // 对应 Modifier.fillMaxWidth()

                // 结果网格，对应 Kotlin 的 LazyVerticalGrid
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: AppTokens.Spacing.lg), // 两列，水平间距 lg
                        GridItem(.flexible(), spacing: AppTokens.Spacing.lg)
                    ],
                    spacing: AppTokens.Spacing.lg // 垂直间距 lg
                ) {
                    ForEach(results) { item in
                        CardView(item: item) // 使用独立的 CardView 组件
                    }
                }
                .padding(.bottom, 24) // 对应 contentPadding = PaddingValues(bottom = 24.dp)
            }
            .padding(AppTokens.Spacing.lg) // 整个 Column 的外部填充，对应 Modifier.padding(pad).padding(AppTokens.Spacing.lg)
        }
    }
}

// MARK: - CardView
// 单个卡片视图，对应 Kotlin 的 Card Composable
struct CardView: View {
    let item: ResultItem

    var body: some View {
        VStack(spacing: AppTokens.Spacing.sm) { // 对应 Column, verticalArrangement
            // 图片占位符，对应 Box(modifier = Modifier.size(96.dp).background(...))
            RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                .fill(AppTokens.Colors.surfaceVariant)
                .frame(width: 96, height: 96)

            Text(item.title)
                .font(AppTokens.TypographyTokens.title)
                .foregroundColor(AppTokens.Colors.onSurface)

            // 添加按钮，对应 Kotlin 的 Button
            Button(action: {
                // 按钮点击事件
            }) {
                Text("Add")
                    .font(AppTokens.TypographyTokens.label)
                    .foregroundColor(AppTokens.Colors.onPrimary)
                    .frame(maxWidth: .infinity) // 对应 Modifier.fillMaxWidth()
                    // 垂直内边距，使其总高度与 Android 视觉效果一致 (约 48pt 高度)
                    .padding(.vertical, 10) // (48 - 12) / 2 = 18.0
            }
            .background(AppTokens.Colors.primary) // 对应 ButtonDefaults.buttonColors
            .cornerRadius(AppTokens.Shapes.medium) // 对应 shape
        }
        .padding(AppTokens.Spacing.lg) // 卡片内部内容填充，对应 Modifier.padding(AppTokens.Spacing.lg)
        .background(AppTokens.Colors.surface) // 对应 CardDefaults.cardColors
        .cornerRadius(AppTokens.Shapes.large) // 对应 shape
        // 阴影效果，对应 CardDefaults.cardElevation
        .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),
                radius: AppTokens.ElevationMapping.level2.radius,
                x: 0, // Android Compose 默认 x 偏移为 0
                y: AppTokens.ElevationMapping.level2.dy)
    }
}

// MARK: - TextField Placeholder Extension
// SwiftUI TextField 默认没有直接的 placeholder 视图，通过 ZStack 实现
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

// MARK: - App Entry Point
// 应用入口，对应 Kotlin 的 MainActivity
@main
struct SingleFileUIApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                // 隐藏顶部状态栏，兼容 iOS 16.0
                .statusBarHidden(true)
                // 确保视图内容延伸到屏幕边缘，覆盖安全区域
                .ignoresSafeArea()
        }
    }
}

// MARK: - Preview
// 预览功能，对应 Kotlin 的 @Preview
struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
