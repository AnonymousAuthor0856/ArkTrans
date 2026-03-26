import SwiftUI

// MARK: - AppTokens (原子级对应 Kotlin 的 AppTokens)
// 定义应用所需的颜色、字体、形状和间距，方便统一管理和修改。
struct AppTokens {
    struct Colors {
        // Kotlin: Color(0xFF2563EB) -> Swift: Color(red: 37/255, green: 99/255, blue: 235/255)
        static let primary = Color(red: 37/255, green: 99/255, blue: 235/255)
        static let secondary = Color(red: 56/255, green: 189/255, blue: 248/255)
        static let tertiary = Color(red: 96/255, green: 165/255, blue: 250/255)
        static let background = Color(red: 248/255, green: 250/255, blue: 252/255)
        static let surface = Color(red: 255/255, green: 255/255, blue: 255/255)
        static let surfaceVariant = Color(red: 226/255, green: 232/255, blue: 240/255)
        static let outline = Color(red: 203/255, green: 213/255, blue: 225/255)
        static let onPrimary = Color(red: 255/255, green: 255/255, blue: 255/255)
        static let onSecondary = Color(red: 15/255, green: 23/255, blue: 42/255)
        static let onTertiary = Color(red: 255/255, green: 255/255, blue: 255/255)
        static let onBackground = Color(red: 15/255, green: 23/255, blue: 42/255)
        static let onSurface = Color(red: 30/255, green: 41/255, blue: 59/255)
    }

    struct TypographyTokens {
        // Kotlin: TextStyle(fontSize = 24.sp, fontWeight = FontWeight.Bold) -> Swift: Font.system(size: 24, weight: .bold)
        static let display = Font.system(size: 24, weight: .bold)
        static let headline = Font.system(size: 18, weight: .semibold)
        static let title = Font.system(size: 14, weight: .medium)
        static let body = Font.system(size: 12, weight: .regular) // Kotlin's FontWeight.Normal 对应 Swift 的 .regular
    }

    struct Shapes {
        // Kotlin: RoundedCornerShape(6.dp) -> Swift: 6.0 (CGFloat)
        static let small = 6.0
        static let medium = 10.0
        static let large = 14.0
    }

    struct Spacing {
        // Kotlin: 6.dp -> Swift: 6.0 (CGFloat)
        static let sm = 6.0
        static let md = 10.0
        static let lg = 14.0
        static let xl = 20.0
        // Kotlin Compose Material3 Button 的默认内容内边距为 horizontal = 16.dp, vertical = 8.dp
        static let buttonContentHorizontal = 16.0
        static let buttonContentVertical = 8.0
    }
}

// MARK: - CustomUnitButton (自定义按钮样式，实现原子级对应)
// 这个自定义按钮样式模仿了 Compose Button 的条件颜色和形状。
struct CustomUnitButton: ButtonStyle {
    var isActive: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTokens.TypographyTokens.title) // 应用 AppTokens 中定义的字体样式
            .padding(.horizontal, AppTokens.Spacing.buttonContentHorizontal) // 匹配 Compose Button 的默认水平内边距
            .padding(.vertical, AppTokens.Spacing.buttonContentVertical) // 匹配 Compose Button 的默认垂直内边距
            .background(
                isActive ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant
            )
            .foregroundColor(
                isActive ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface
            )
            .cornerRadius(AppTokens.Shapes.small) // 按钮通常使用 small 形状的圆角
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // 按下时的缩放效果
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed) // 动画效果
    }
}

// MARK: - MarkerBox (对应 Kotlin 的 MarkerBox Composable)
struct MarkerBox: View {
    let unit: String
    let value: String
    let active: Bool

    var body: some View {
        VStack(alignment: .leading) { // 对应 Compose 的 Column
            Text(unit)
                .font(AppTokens.TypographyTokens.headline)
                .foregroundColor(AppTokens.Colors.onSurface)
            Text(value)
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.onSurface)
        }
        .padding(AppTokens.Spacing.md) // 对应 padding(AppTokens.Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading) // 对应 fillMaxWidth() 和 contentAlignment = Alignment.CenterStart
        .frame(height: 80) // 对应 height(80.dp)
        .background(
            active ? AppTokens.Colors.secondary.opacity(0.3) : AppTokens.Colors.surface
        )
        .cornerRadius(AppTokens.Shapes.medium) // 对应 AppTokens.Shapes.medium
        .overlay(
            // 对应 border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.medium)
            RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                .stroke(AppTokens.Colors.outline, lineWidth: 1)
        )
    }
}

// MARK: - MapArea (对应 Kotlin 的 MapArea Composable)
struct MapArea: View {
    let selected: String

    var body: some View {
        VStack(spacing: AppTokens.Spacing.md) { // 对应 Compose Column 中的 Text 和 Spacer
            Text("Unit Map Visualization")
                .font(AppTokens.TypographyTokens.headline)
                .foregroundColor(AppTokens.Colors.onSurface)
            Text("Active Unit: \(selected)")
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.onSurface)
        }
        .frame(maxWidth: .infinity, maxHeight: 240) // 对应 fillMaxWidth() 和 height(240.dp)
        .background(AppTokens.Colors.surfaceVariant) // 对应 background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.large)
        .cornerRadius(AppTokens.Shapes.large) // 应用圆角
        .overlay(
            // 对应 border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.large)
            RoundedRectangle(cornerRadius: AppTokens.Shapes.large)
                .stroke(AppTokens.Colors.outline, lineWidth: 1)
        )
        .padding(AppTokens.Spacing.lg) // 对应 padding(AppTokens.Spacing.lg)
        // 注意: VStack 默认居中对齐，匹配 horizontalAlignment = Alignment.CenterHorizontally 和 verticalArrangement = Arrangement.Center
    }
}

// MARK: - RootScreen (对应 Kotlin 的 RootScreen Composable)
struct RootScreen: View {
    let markers = ["Length", "Weight", "Temperature", "Speed"]
    @State private var active: String // 对应 remember { mutableStateOf(markers.first()) }

    init() {
        _active = State(initialValue: markers.first ?? "")
    }

    var body: some View {
        VStack(spacing: AppTokens.Spacing.lg) { // 对应 Column with verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
            Text("Unit Converter")
                .font(AppTokens.TypographyTokens.display)
                .foregroundColor(AppTokens.Colors.onBackground)
            
            MapArea(selected: active)
            
            ForEach(markers, id: \.self) { marker in
                MarkerBox(unit: marker, value: "Tap to convert", active: self.active == marker)
            }
            
            // 此 Spacer 对应 Kotlin 中的 Spacer(Modifier.height(AppTokens.Spacing.md))。
            // VStack 的 `spacing: AppTokens.Spacing.lg` 会在其所有直接子视图之间添加 `lg` 间距。
            // 因此，最后一个 MarkerBox 和此 Spacer 之间有 `lg` 间距。
            // Spacer 自身的高度为 `md`。
            // 此 Spacer 和 Button Row (HStack) 之间也有 `lg` 间距。
            // 所以，最后一个 MarkerBox 和 Button Row 之间的总有效间距为：lg (VStack间距) + md (Spacer高度) + lg (VStack间距)。
            Spacer().frame(height: AppTokens.Spacing.md)
            
            HStack(spacing: AppTokens.Spacing.md) { // 对应 Row with horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
                ForEach(markers, id: \.self) { marker in
                    Button(action: {
                        self.active = marker
                    }) {
                        Text(marker)
                    }
                    // 应用自定义按钮样式，实现条件颜色和形状的原子级对应
                    .buttonStyle(CustomUnitButton(isActive: self.active == marker))
                }
            }
        }
        .padding(AppTokens.Spacing.lg) // 对应 padding(AppTokens.Spacing.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity) // 对应 fillMaxSize()
        .background(
            // 对应 Brush.verticalGradient(...)
            LinearGradient(
                gradient: Gradient(colors: [
                    AppTokens.Colors.secondary.opacity(0.15),
                    AppTokens.Colors.primary.opacity(0.15)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .ignoresSafeArea(.all, edges: .all) // 确保应用全屏显示，包括状态栏和导航栏区域
        .statusBarHidden(true) // 隐藏顶部状态栏
    }
}

// MARK: - App Entry Point (应用入口)
// 对应 Kotlin 的 MainActivity，但以 SwiftUI 的方式实现全屏和状态栏隐藏。
@main
struct UnitConverterApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}
