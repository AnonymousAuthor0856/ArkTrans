import SwiftUI

// MARK: - Color Palette (Custom Muted Earth Tones)
// 扩展 Color 以定义应用中使用的所有自定义颜色
extension Color {
    static let zenGreen = Color(red: 0x6A / 255.0, green: 0x8E / 255.0, blue: 0x6A / 255.0)
    static let zenGreenLight = Color(red: 0xE8 / 255.0, green: 0xF5 / 255.0, blue: 0xE9 / 255.0)
    static let zenBrown = Color(red: 0x8D / 255.0, green: 0x6E / 255.0, blue: 0x63 / 255.0)
    static let zenTextPrimary = Color(red: 0x2C / 255.0, green: 0x3E / 255.0, blue: 0x50 / 255.0)
    static let zenTextSecondary = Color(red: 0x7F / 255.0, green: 0x8C / 255.0, blue: 0x8D / 255.0)
    static let zenWhite = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
    static let zenAccent = Color(red: 0xD4 / 255.0, green: 0xE1 / 255.0, blue: 0x57 / 255.0)

    // 从 Kotlin 代码中提取的额外颜色
    static let statusItemBg = Color(red: 0xF7 / 255.0, green: 0xF9 / 255.0, blue: 0xF9 / 255.0)
    static let statusItemBorder = Color(red: 0xEC / 255.0, green: 0xEF / 255.0, blue: 0xF1 / 255.0)
    static let careLogBg = Color(red: 0xFA / 255.0, green: 0xFA / 255.0, blue: 0xFA / 255.0)
    static let careLogBorder = Color(red: 0xF0 / 255.0, green: 0xF0 / 255.0, blue: 0xF0 / 255.0)
    static let careLogSubtitle = Color(red: 0x9E / 255.0, green: 0x9E / 255.0, blue: 0x9E / 255.0)
    static let navIconInactive = Color(red: 0xCF / 255.0, green: 0xD8 / 255.0, blue: 0xDC / 255.0)
    static let bottomBarDivider = Color(red: 0xF5 / 255.0, green: 0xF5 / 255.0, blue: 0xF5 / 255.0)
    static let lightGrayCircle = Color(red: 0xE0 / 255.0, green: 0xE0 / 255.0, blue: 0xE0 / 255.0)
    static let trunkColor = Color(red: 0x5D / 255.0, green: 0x40 / 255.0, blue: 0x37 / 255.0)
    static let healthRed = Color(red: 0xE5 / 255.0, green: 0x73 / 255.0, blue: 0x73 / 255.0)
    static let waterBlue = Color(red: 0x64 / 255.0, green: 0xB5 / 255.0, blue: 0xF6 / 255.0)
}

// MARK: - Typography Mapping
// 定义应用中使用的字体样式，以便于统一管理和修改
struct AppTypography {
    static let labelMedium = Font.system(size: 12, weight: .medium)
    static let displaySmallLight = Font.system(size: 36, weight: .light)
    static let titleMediumBold = Font.system(size: 16, weight: .bold)
    static let titleMediumSemiBold = Font.system(size: 16, weight: .semibold)
    static let labelSmall = Font.system(size: 11, weight: .regular)
    static let bodyMedium = Font.system(size: 14, weight: .regular)
}

// MARK: - Main App Entry Point
// @main 标记 ZenBonsaiApp 为应用的入口
@main
struct ZenBonsaiApp: App {
    var body: some Scene {
        WindowGroup {
            ZenBonsaiAppView()
                // 确保内容延伸到屏幕边缘，忽略所有安全区域
                .ignoresSafeArea(.all)
                // 隐藏顶部状态栏
                .statusBarHidden(true)
        }
    }
}

// MARK: - ZenBonsaiAppView (Main Content View)
struct ZenBonsaiAppView: View {
    var body: some View {
        // 使用 ZStack 将底部导航栏叠加在主内容之上
        ZStack(alignment: .bottom) {
            // ScrollView 允许主内容滚动
            ScrollView {
                // 主内容区域，垂直布局
                VStack(alignment: .center, spacing: 0) {
                    HeaderSection()
                        .padding(.top, 24) // 对应 Scaffold 的顶部内边距

                    Spacer().frame(height: 32)

                    BonsaiVisual()
                        .frame(width: 220, height: 220) // 对应 Modifier.size(220.dp)

                    Spacer().frame(height: 32)

                    StatusRow()

                    Spacer().frame(height: 32)

                    ActivityLogSection()
                        .padding(.bottom, 24) // 底部内边距，确保内容不会紧贴底部

                }
                .padding(.horizontal, 24) // 对应 Column 的水平内边距
                .background(Color.zenWhite) // 对应 Scaffold 的 containerColor
                // 为底部导航栏预留空间，防止内容被遮挡
                .padding(.bottom, 80) // 底部导航栏高度为 80.dp
            }
            .background(Color.zenWhite) // 确保 ScrollView 的背景色为白色

            // 底部导航栏
            SimpleBottomNav()
                .background(Color.zenWhite) // 底部导航栏背景色
                .ignoresSafeArea(.keyboard) // 忽略键盘安全区域，防止键盘弹出时底部导航栏上移
        }
        .background(Color.zenWhite) // 整个应用的背景色
    }
}

// MARK: - HeaderSection
struct HeaderSection: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("JUNIPER · #04")
                .font(AppTypography.labelMedium)
                .foregroundColor(.zenTextSecondary)
                .kerning(2) // 对应 letterSpacing = 2.sp
            Spacer().frame(height: 8) // 对应 Spacer(modifier = Modifier.height(8.dp))
            Text("Zen Garden")
                .font(AppTypography.displaySmallLight)
                .foregroundColor(.zenTextPrimary)
        }
    }
}

// MARK: - StatusRow
struct StatusRow: View {
    var body: some View {
        // 使用 HStack 结合 Spacer 实现 SpaceEvenly 布局
        HStack(alignment: .center) {
            Spacer() // 左侧 Spacer
            StatusItem(icon: "heart.fill", label: "Health", value: "98%", tint: .healthRed)
            Spacer() // 元素间 Spacer
            StatusItem(icon: "calendar", label: "Age", value: "4 Yrs", tint: .zenBrown)
            Spacer() // 元素间 Spacer
            StatusItem(icon: "checkmark.circle.fill", label: "Water", value: "2 Days", tint: .waterBlue)
            Spacer() // 右侧 Spacer
        }
        .frame(maxWidth: .infinity) // 对应 Modifier.fillMaxWidth()
    }
}

// MARK: - StatusItem
struct StatusItem: View {
    let icon: String // SF Symbol 名称
    let label: String
    let value: String
    let tint: Color

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack {
                Circle()
                    .fill(Color.statusItemBg)
                    .frame(width: 50, height: 50) // 对应 Modifier.size(50.dp)
                    .overlay(
                        Circle()
                            .stroke(Color.statusItemBorder, lineWidth: 1) // 对应 .border(1.dp, Color(0xFFECEFF1), CircleShape)
                    )
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24) // 对应 Modifier.size(24.dp)
                    .foregroundColor(tint)
            }
            Spacer().frame(height: 8) // 对应 Spacer(modifier = Modifier.height(8.dp))
            Text(value)
                .font(AppTypography.titleMediumBold)
                .foregroundColor(.zenTextPrimary)
            Text(label)
                .font(AppTypography.labelSmall)
                .foregroundColor(.zenTextSecondary)
        }
    }
}

// MARK: - ActivityLogSection
struct ActivityLogSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Care Schedule")
                    .font(AppTypography.titleMediumSemiBold)
                    .foregroundColor(.zenTextPrimary)
                Spacer() // 对应 horizontalArrangement = Arrangement.SpaceBetween
                Image(systemName: "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20) // 28.dp - 4.dp*2 = 20.dp icon size
                    .foregroundColor(.zenGreen)
                    .padding(4) // 对应 .padding(4.dp)
                    .background(Color.zenGreenLight)
                    .clipShape(Circle()) // 对应 CircleShape
                    .frame(width: 28, height: 28) // 对应 Modifier.size(28.dp)
                    .onTapGesture {
                        // Handle add log action
                    }
            }
            .frame(maxWidth: .infinity) // 对应 Modifier.fillMaxWidth()

            Spacer().frame(height: 16) // 对应 Spacer(modifier = Modifier.height(16.dp))

            CareLogItem(title: "Watering", subtitle: "Today, 8:00 AM", isDone: true)
            Spacer().frame(height: 12) // 对应 Spacer(modifier = Modifier.height(12.dp))
            CareLogItem(title: "Pruning", subtitle: "Tomorrow", isDone: false)
            Spacer().frame(height: 12) // 对应 Spacer(modifier = Modifier.height(12.dp))
            CareLogItem(title: "Fertilizer", subtitle: "In 5 days", isDone: false)
        }
        .frame(maxWidth: .infinity) // 对应 Modifier.fillMaxWidth()
    }
}

// MARK: - CareLogItem
struct CareLogItem: View {
    let title: String
    let subtitle: String
    let isDone: Bool

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Circle()
                .fill(isDone ? Color.zenGreen : Color.lightGrayCircle)
                .frame(width: 12, height: 12) // 对应 Modifier.size(12.dp)
            Spacer().frame(width: 16) // 对应 Spacer(modifier = Modifier.width(16.dp))
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(AppTypography.bodyMedium)
                    .foregroundColor(isDone ? .zenTextPrimary : .zenTextSecondary)
                Text(subtitle)
                    .font(AppTypography.labelSmall)
                    .foregroundColor(.careLogSubtitle)
            }
            .frame(maxWidth: .infinity, alignment: .leading) // 对应 Modifier.weight(1f)
            if isDone {
                Image(systemName: "checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20) // 对应 Modifier.size(20.dp)
                    .foregroundColor(.zenGreen)
            }
        }
        .padding(16) // 对应 .padding(16.dp)
        .background(Color.careLogBg)
        .cornerRadius(12) // 对应 RoundedCornerShape(12.dp)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.careLogBorder, lineWidth: 1) // 对应 .border(1.dp, Color(0xFFF0F0F0), RoundedCornerShape(12.dp))
        )
        .frame(maxWidth: .infinity) // 对应 Modifier.fillMaxWidth()
    }
}

// MARK: - SimpleBottomNav
struct SimpleBottomNav: View {
    var body: some View {
        VStack(spacing: 0) {
            // 底部导航栏上方的分割线
            Rectangle() // 使用 Rectangle 替代 Divider 以精确控制颜色和高度
                .fill(Color.bottomBarDivider)
                .frame(height: 1) // 对应 border(width = 1.dp)
            HStack(spacing: 0) {
                // NavIcon 内部的 Spacer 会处理 SpaceAround 效果
                NavIcon(icon: "house.fill", isSelected: true)
                NavIcon(icon: "info.circle.fill", isSelected: false)
                NavIcon(icon: "gearshape.fill", isSelected: false)
            }
            .frame(maxWidth: .infinity) // 对应 Modifier.fillMaxWidth()
            .frame(height: 80) // 对应 Modifier.height(80.dp)
            .background(Color.zenWhite) // 对应 .background(ZenWhite)
        }
    }
}

// MARK: - NavIcon
struct NavIcon: View {
    let icon: String // SF Symbol 名称
    let isSelected: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 28, height: 28) // 对应 Modifier.size(28.dp)
                .foregroundColor(isSelected ? .zenGreen : .navIconInactive)
            if isSelected {
                Spacer().frame(height: 4) // 对应 Spacer(modifier = Modifier.height(4.dp))
                Circle()
                    .fill(Color.zenGreen)
                    .frame(width: 4, height: 4) // 对应 Modifier.size(4.dp)
            }
        }
        .frame(maxWidth: .infinity) // 使得每个图标占据等宽空间，实现 SpaceAround 效果
    }
}

// MARK: - Custom Art Logic (BonsaiVisual)
struct BonsaiVisual: View {
    var body: some View {
        // Canvas 视图用于自定义绘制，iOS 15+ 支持
        Canvas { context, size in
            let w = size.width
            let h = size.height

            // 1. 绘制花盆
            let potWidth = w * 0.5
            let potHeight = h * 0.15
            let potTop = h * 0.85

            context.fill(Path(CGRect(x: (w - potWidth) / 2, y: potTop, width: potWidth, height: potHeight)), with: .color(.zenBrown))
            // 花盆边缘
            context.fill(Path(CGRect(x: (w - potWidth) / 2 - 10, y: potTop, width: potWidth + 20, height: 15)), with: .color(Color.zenBrown.opacity(0.8)))

            // 2. 绘制树干 (贝塞尔曲线)
            var trunkPath = Path()
            trunkPath.move(to: CGPoint(x: w * 0.5, y: potTop)) // 底部中心
            // 向上并向左弯曲
            trunkPath.addQuadCurve(to: CGPoint(x: w * 0.35, y: h * 0.5), control: CGPoint(x: w * 0.45, y: h * 0.6))
            // 向右弯曲
            trunkPath.addQuadCurve(to: CGPoint(x: w * 0.6, y: h * 0.3), control: CGPoint(x: w * 0.4, y: h * 0.35))

            context.stroke(trunkPath, with: .color(.trunkColor), style: StrokeStyle(lineWidth: 25, lineCap: .round))

            // 次级树枝
            var secondaryBranchPath = Path()
            secondaryBranchPath.move(to: CGPoint(x: w * 0.38, y: h * 0.55))
            secondaryBranchPath.addLine(to: CGPoint(x: w * 0.25, y: h * 0.45))
            context.stroke(secondaryBranchPath, with: .color(.trunkColor), style: StrokeStyle(lineWidth: 15, lineCap: .round))

            // 3. 绘制叶子 (圆形簇)
            // 叶簇 1 (右上)
            context.fill(Path(ellipseIn: CGRect(x: w * 0.6 - 45, y: h * 0.25 - 45, width: 90, height: 90)), with: .color(.zenGreen))
            context.fill(Path(ellipseIn: CGRect(x: w * 0.68 - 35, y: h * 0.28 - 35, width: 70, height: 70)), with: .color(Color.zenGreen.opacity(0.8)))
            context.fill(Path(ellipseIn: CGRect(x: w * 0.55 - 30, y: h * 0.22 - 30, width: 60, height: 60)), with: .color(Color.zenGreen.opacity(0.9)))

            // 叶簇 2 (中左)
            context.fill(Path(ellipseIn: CGRect(x: w * 0.35 - 35, y: h * 0.5 - 35, width: 70, height: 70)), with: .color(.zenGreen))
            context.fill(Path(ellipseIn: CGRect(x: w * 0.30 - 25, y: h * 0.45 - 25, width: 50, height: 50)), with: .color(Color.zenGreen.opacity(0.8)))

            // 叶簇 3 (最左侧树枝)
            context.fill(Path(ellipseIn: CGRect(x: w * 0.22 - 25, y: h * 0.42 - 25, width: 50, height: 50)), with: .color(.zenGreen))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // 确保 Canvas 填充其父视图的可用空间
    }
}

// MARK: - Preview
// 提供预览功能，方便在 Xcode 中查看 UI 效果
struct ZenBonsaiAppView_Previews: PreviewProvider {
    static var previews: some View {
        ZenBonsaiAppView()
    }
}