import SwiftUI

// MARK: - AppTokens
struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF1976D2)
        static let secondary = Color(hex: 0xFF607D8B)
        static let tertiary = Color(hex: 0xFF757575)
        static let background = Color(hex: 0xFFECEFF1)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFCFD8DC)
        static let outline = Color(hex: 0xFFB0BEC5)
        static let success = Color(hex: 0xFF4CAF50)
        static let warning = Color(hex: 0xFFFFC107)
        static let error = Color(hex: 0xFFF44336)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFFFFFFFF)
        static let onTertiary = Color(hex: 0xFFFFFFFF)
        static let onBackground = Color(hex: 0xFF263238)
        static let onSurface = Color(hex: 0xFF263238)
    }

    struct TypographyTokens {
        static let display = Font.system(size: 36, weight: .bold)
        static let headline = Font.system(size: 24, weight: .semibold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small = RoundedRectangle(cornerRadius: 4)
        static let medium = RoundedRectangle(cornerRadius: 8)
        static let large = RoundedRectangle(cornerRadius: 12)
    }

    struct Spacing {
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24 // 增加到24
        static let xxl: CGFloat = 32 // 新增更大的间距
    }
    
    static let topBarHeight: CGFloat = 64
}

// 扩展 Color 以支持从十六进制值初始化
extension Color {
    init(hex: UInt) {
        let alpha = Double((hex >> 24) & 0xFF) / 255.0
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        
        self.init(
            .sRGB,
            red: red,
            green: green,
            blue: blue,
            opacity: alpha
        )
    }
}

// MARK: - Data Models
struct StoryLayer: Identifiable {
    let id: Int
    let type: String
    let content: String
}

// MARK: - RootScreen
struct RootScreen: View {
    @State private var textOpacity: Double = 1.0
    @State private var uploadProgress: Double = 0.65
    @State private var layers: [StoryLayer] = [
        StoryLayer(id: 1, type: "BG", content: "Gradient"),
        StoryLayer(id: 2, type: "IMG", content: "User Photo"),
        StoryLayer(id: 3, type: "TXT", content: "Hello World"),
        StoryLayer(id: 4, type: "ICO", content: "Sticker")
    ]
    @State private var selectedLayer: Int = 3

    var body: some View {
        ZStack(alignment: .bottom) {
            // 主内容区域
            VStack(spacing: 0) {
                // 顶部栏 - 对应 CenterAlignedTopAppBar
                HStack {
                    // 左侧按钮 - Exit (透明背景)
                    Button(action: {}) {
                        Text("Exit")
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onBackground)
                    }
                    .padding(.horizontal, AppTokens.Spacing.sm)
                    
                    Spacer()
                    
                    // 中间标题
                    Text("Story Editor")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)
                    
                    Spacer()
                    
                    // 右侧按钮 - Post (蓝色背景)
                    Button(action: {}) {
                        Text("Post")
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .padding(.horizontal, AppTokens.Spacing.md)
                            .padding(.vertical, AppTokens.Spacing.sm)
                    }
                    .background(AppTokens.Colors.primary)
                    .clipShape(AppTokens.Shapes.medium)
                    .padding(.horizontal, AppTokens.Spacing.sm)
                }
                .frame(height: AppTokens.topBarHeight)
                .background(AppTokens.Colors.surface)
                
                // 主要内容区域 - 对应 Scaffold 的 content
                ScrollView {
                    VStack(spacing: AppTokens.Spacing.lg) {
                        // 预览卡片 - 对应 Card with weight(1f)
                        ZStack {
                            AppTokens.Shapes.large
                                .fill(AppTokens.Colors.tertiary)
                                .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 1)
                            
                            Text("Your Story Preview")
                                .font(AppTokens.TypographyTokens.headline)
                                .foregroundColor(AppTokens.Colors.onTertiary.opacity(textOpacity))
                                .multilineTextAlignment(.center)
                        }
                        .frame(height: 200)
                        .padding(.horizontal, AppTokens.Spacing.lg)
                        
                        // 上传状态 - 对应 Column
                        VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
                            Text("Upload Status")
                                .font(AppTokens.TypographyTokens.label)
                                .foregroundColor(AppTokens.Colors.secondary)
                            
                            // 自定义进度条 - 对应 LinearProgressIndicator
                            GeometryReader { geometry in
                                ZStack(alignment: .leading) {
                                    // 轨道背景
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(AppTokens.Colors.surfaceVariant)
                                        .frame(height: AppTokens.Spacing.sm)
                                    
                                    // 进度条
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(AppTokens.Colors.success)
                                        .frame(width: geometry.size.width * CGFloat(uploadProgress), height: AppTokens.Spacing.sm)
                                }
                            }
                            .frame(height: AppTokens.Spacing.sm)
                        }
                        .padding(.horizontal, AppTokens.Spacing.lg)
                        
                        // 图层列表 - 对应 LazyRow
                        VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
                            Text("Story Layers")
                                .font(AppTokens.TypographyTokens.label)
                                .foregroundColor(AppTokens.Colors.secondary)
                                .padding(.horizontal, AppTokens.Spacing.lg)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: AppTokens.Spacing.lg) {
                                    ForEach(layers) { layer in
                                        LayerItemView(
                                            layer: layer,
                                            isSelected: layer.id == selectedLayer,
                                            onSelect: { selectedLayer = layer.id }
                                        )
                                    }
                                }
                                .padding(.horizontal, AppTokens.Spacing.lg)
                                .padding(.vertical, AppTokens.Spacing.md)
                            }
                        }
                    }
                    .padding(.vertical, AppTokens.Spacing.lg)
                }
                .background(AppTokens.Colors.background)
            }
            
            // 底部栏 - 对应 BottomBar 的 Surface
            VStack(alignment: .leading, spacing: AppTokens.Spacing.md) {
                Text("Layer Properties")
                    .font(AppTokens.TypographyTokens.label)
                    .foregroundColor(AppTokens.Colors.secondary)
                
                HStack {
                    Text("Opacity")
                        .font(AppTokens.TypographyTokens.body)
                        .frame(width: 80, alignment: .leading)
                    
                    Slider(value: $textOpacity, in: 0...1)
                        .tint(AppTokens.Colors.primary)
                }
            }
            .padding(AppTokens.Spacing.lg)
            .frame(maxWidth: .infinity)
            .background(AppTokens.Colors.surface)
            .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: -2)
        }
        .background(AppTokens.Colors.background)
        .ignoresSafeArea(.all, edges: .all)
        .statusBar(hidden: true) // 隐藏状态栏
    }
}

// MARK: - Layer Item View
struct LayerItemView: View {
    let layer: StoryLayer
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            VStack(spacing: AppTokens.Spacing.sm) {
                // 图标区域 - 对应 Box with CircleShape
                Circle()
                    .fill(isSelected ? AppTokens.Colors.onPrimary.opacity(0.2) : AppTokens.Colors.surfaceVariant)
                    .frame(width: 32, height: 32)
                
                // 类型标签
                Text(layer.type)
                    .font(AppTokens.TypographyTokens.label)
                    .foregroundColor(isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface.opacity(0.7))
                
                // 内容文本
                Text(layer.content)
                    .font(AppTokens.TypographyTokens.body)
                    .foregroundColor(isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .padding(.horizontal, AppTokens.Spacing.xxl) // 使用更大的水平内边距
            .padding(.vertical, AppTokens.Spacing.md)
            .frame(width: 130) // 进一步增加宽度以容纳更大的内边距
            .background(isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSelected ? AppTokens.Colors.primary : AppTokens.Colors.outline, lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - App Entry Point
@main
struct StoryEditorApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}

// MARK: - Preview Provider
struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}