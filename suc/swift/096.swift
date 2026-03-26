import SwiftUI

// MARK: - 1. Colors
// 定义自定义颜色常量，以便在整个应用中保持一致性，并易于修改。
extension Color {
    static let pureWhite = Color(red: 1.0, green: 1.0, blue: 1.0)
    static let offWhite = Color(red: 0xFA / 255.0, green: 0xFA / 255.0, blue: 0xFA / 255.0)
    static let textPrimary = Color(red: 0x1A / 255.0, green: 0x1A / 255.0, blue: 0x1A / 255.0)
    static let textSecondary = Color(red: 0x75 / 255.0, green: 0x75 / 255.0, blue: 0x75 / 255.0)
    static let accentGreen = Color(red: 0x4C / 255.0, green: 0xAF / 255.0, blue: 0x50 / 255.0)
    static let accentWarning = Color(red: 0xFF / 255.0, green: 0x98 / 255.0, blue: 0x00 / 255.0)
    static let dividerColor = Color(red: 0xEE / 255.0, green: 0xEE / 255.0, blue: 0xEE / 255.0)
}

// MARK: - 2. Main App Structure (@main 入口)
// 这是 SwiftUI 应用的入口点。
@main
struct AeroSenseApp: App {
    var body: some Scene {
        WindowGroup {
            AeroSenseContentView()
                // 要求 2: App 必须设置为全屏显示，并确保顶部状态栏隐藏。
                // .ignoresSafeArea(.all) 使内容延伸到屏幕边缘。
                // .statusBarHidden() 隐藏顶部状态栏。
                .ignoresSafeArea(.all)
                .statusBarHidden()
        }
    }
}

// 整个应用的主视图，模拟 Android 的 Scaffold 结构。
struct AeroSenseContentView: View {
    var body: some View {
        ZStack { // 使用 ZStack 来分层内容，将底部控制栏置于最上层。
            Color.pureWhite.ignoresSafeArea() // 设置整个屏幕的背景色。

            VStack(spacing: 0) { // 主垂直堆栈，用于顶部标题、主要内容和底部控制栏。
                TopHeader()
                    .padding(.horizontal, 24) // 对应 Android 的 padding(horizontal = 24.dp)
                    .padding(.vertical, 24)   // 对应 Android 的 padding(vertical = 24.dp)

                // MainContent 包含滚动视图，并填充可用空间。
                MainContent()
                    .padding(.horizontal, 24) // 对应 Android 的 contentPadding(horizontal = 24.dp)
                    .padding(.bottom, 16)     // 在滚动内容和底部栏之间添加一些底部留白
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // 使 MainContent 填充所有可用空间。
            }
            .background(Color.pureWhite) // 确保内容后面的背景是白色。

            VStack {
                Spacer() // 将 BottomControlBar 推到底部。
                BottomControlBar()
            }
        }
    }
}

// MARK: - 3. Top Header (顶部标题栏)
struct TopHeader: View {
    var body: some View {
        HStack { // 对应 Android 的 Row
            VStack(alignment: .leading) { // 对应 Android 的 Column
                Text("Living Room")
                    // 对应 MaterialTheme.typography.titleMedium (通常为 16sp)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.textSecondary)
                Text("AeroSense")
                    // 对应 MaterialTheme.typography.headlineMedium (通常为 34sp)
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.textPrimary)
            }
            Spacer() // 对应 Android 的 horizontalArrangement = Arrangement.SpaceBetween
            Button(action: { /* No op */ }) {
                Image(systemName: "gearshape.fill") // 对应 Icons.Filled.Settings (SF Symbols)
                    .font(.system(size: 24)) // 对应 Icon 默认大小
                    .foregroundColor(.textPrimary)
                    .frame(width: 48, height: 48) // 对应 Modifier.size(48.dp)
                    .background(Color.offWhite) // 对应 Modifier.background(OffWhite, CircleShape)
                    .clipShape(Circle()) // 对应 CircleShape
            }
        }
    }
}

// MARK: - 4. Main Content (主内容区域)
struct MainContent: View {
    var body: some View {
        // 对应 Android 的 LazyColumn
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 32) { // 对应 Android 的 verticalArrangement = Arrangement.spacedBy(32.dp)
                // 1. Main Air Quality Indicator
                AirQualityCircle(aqi: 42)
                
                // 2. Metrics Grid
                VStack(spacing: 16) { // 对应 Android 的 Spacer(modifier = Modifier.height(16.dp))
                    HStack(spacing: 16) { // 对应 Android 的 Row, horizontalArrangement = Arrangement.spacedBy(16.dp)
                        MetricCard(
                            label: "Temp",
                            value: "23°C",
                            iconName: "info.circle.fill", // 对应 Icons.Filled.Info
                            statusColor: .textPrimary
                        )
                        MetricCard(
                            label: "Humidity",
                            value: "45%",
                            iconName: "checkmark.circle.fill", // 对应 Icons.Filled.Check
                            statusColor: .accentGreen
                        )
                    }
                    HStack(spacing: 16) { // 对应 Android 的 Row, horizontalArrangement = Arrangement.spacedBy(16.dp)
                        MetricCard(
                            label: "PM 2.5",
                            value: "12",
                            iconName: "checkmark.circle.fill", // 对应 Icons.Filled.CheckCircle
                            statusColor: .accentGreen
                        )
                        MetricCard(
                            label: "CO2",
                            value: "850",
                            iconName: "exclamationmark.triangle.fill", // 对应 Icons.Filled.Warning
                            statusColor: .accentWarning
                        )
                    }
                }
                
                // 3. Status Message
                StatusBanner()
            }
            .padding(.vertical, 16) // 对应 Android 的 contentPadding(vertical = 16.dp)
        }
    }
}

// MARK: - 5. Air Quality Circle (空气质量指示器)
struct AirQualityCircle: View {
    let aqi: Int
    
    var body: some View {
        // 使用 ZStack 模拟 Android 的 Box，并设置内容居中对齐。
        ZStack(alignment: .center) {
            // 使用 Canvas 进行自定义绘图，iOS 15.0+ 支持。
            Canvas { context, size in
                let lineWidth: CGFloat = 40.0 // 对应 Stroke(width = 40f)
                let radius = (min(size.width, size.height) - lineWidth) / 2
                let center = CGPoint(x: size.width / 2, y: size.height / 2)
                
                // 背景轨道
                var backgroundPath = Path()
                backgroundPath.addArc(
                    center: center,
                    radius: radius,
                    startAngle: .degrees(135), // 对应 startAngle = 135f
                    endAngle: .degrees(135 + 270), // 对应 sweepAngle = 270f
                    clockwise: false // 逆时针绘制
                )
                context.stroke(backgroundPath, with: .color(.offWhite), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                
                // 进度轨道 (根据 AQI 42/100 大致计算)
                var progressPath = Path()
                progressPath.addArc(
                    center: center,
                    radius: radius,
                    startAngle: .degrees(135), // 对应 startAngle = 135f
                    endAngle: .degrees(135 + 110), // 对应 sweepAngle = 110f (270 * 42/100 ≈ 113.4，这里使用 110 接近)
                    clockwise: false
                )
                context.stroke(progressPath, with: .color(.accentGreen), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                
                // 装饰点 (位于进度条的末端)
                let dotRadius: CGFloat = 12.0 // 对应 radius = 12f
                let angleForDot: Angle = .degrees(135 + 110) // 进度条结束的角度
                let xOffset = radius * cos(angleForDot.radians)
                let yOffset = radius * sin(angleForDot.radians)
                let dotCenter = CGPoint(x: center.x + xOffset, y: center.y + yOffset)
                
                context.fill(Path(ellipseIn: CGRect(x: dotCenter.x - dotRadius / 2, y: dotCenter.y - dotRadius / 2, width: dotRadius, height: dotRadius)), with: .color(.pureWhite))
            }
            .frame(width: 220, height: 220) // 对应 Modifier.size(220.dp)
            
            VStack(alignment: .center) { // 对应 Android 的 Column, horizontalAlignment = Alignment.CenterHorizontally
                Text("AQI")
                    // 对应 MaterialTheme.typography.labelLarge (通常为 14sp)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.textSecondary)
                    .kerning(2) // 对应 letterSpacing = 2.sp
                Text("\(aqi)")
                    // 对应 MaterialTheme.typography.displayLarge, fontSize = 80.sp
                    .font(.system(size: 80, weight: .medium))
                    .foregroundColor(.textPrimary)
                Text("Excellent")
                    // 对应 MaterialTheme.typography.titleMedium (通常为 16sp)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.accentGreen)
                    .padding(.horizontal, 12) // 对应 padding(horizontal = 12.dp)
                    .padding(.vertical, 6)   // 对应 padding(vertical = 6.dp)
                    .background(
                        RoundedRectangle(cornerRadius: 16) // 对应 RoundedCornerShape(16.dp)
                            .fill(Color.accentGreen.opacity(0.1)) // 对应 AccentGreen.copy(alpha = 0.1f)
                    )
            }
        }
        .frame(maxWidth: .infinity) // 对应 Modifier.fillMaxWidth()
        .aspectRatio(1.2, contentMode: .fit) // 对应 Modifier.aspectRatio(1.2f)
    }
}

// MARK: - 6. Metric Card (指标卡片)
struct MetricCard: View {
    let label: String
    let value: String
    let iconName: String
    let statusColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) { // 对应 Android 的 Column, verticalArrangement = Arrangement.SpaceBetween
            HStack {
                Image(systemName: iconName)
                    .font(.system(size: 20))
                    .foregroundColor(statusColor)
                Spacer() // 确保图标在左侧，并填充剩余空间
            }
            Spacer() // 将内容推向顶部和底部
            VStack(alignment: .leading, spacing: 4) { // 对应 Android 的 Column
                Text(value)
                    // 对应 MaterialTheme.typography.headlineSmall (通常为 24sp)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.textPrimary)
                Text(label)
                    // 对应 MaterialTheme.typography.bodySmall (通常为 12sp)
                    .font(.system(size: 12))
                    .foregroundColor(.textSecondary)
            }
        }
        .padding(16) // 对应 Modifier.padding(16.dp)
        .frame(height: 110) // 对应 Modifier.height(110.dp)
        .frame(maxWidth: .infinity) // 对应 Modifier.weight(1f)
        .background(Color.offWhite) // 对应 CardDefaults.cardColors(containerColor = OffWhite)
        .cornerRadius(24) // 对应 RoundedCornerShape(24.dp)
        // Android 的 CardDefaults.cardElevation(defaultElevation = 0.dp) 在 SwiftUI 中默认没有阴影，无需额外处理。
    }
}

// MARK: - 7. Status Banner (状态横幅)
struct StatusBanner: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) { // 对应 Android 的 Column
            HStack(alignment: .center) { // 对应 Android 的 Row, verticalAlignment = Alignment.CenterVertically
                Image(systemName: "house.fill") // 对应 Icons.Filled.Home
                    .font(.system(size: 24))
                    .foregroundColor(.textPrimary)
                Spacer()
                    .frame(width: 12) // 对应 Spacer(modifier = Modifier.width(12.dp))
                Text("Room Analysis")
                    // 对应 MaterialTheme.typography.titleMedium (通常为 16sp)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.textPrimary)
            }
            Spacer()
                .frame(height: 12) // 对应 Spacer(modifier = Modifier.height(12.dp))
            Text("Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.")
                // 对应 MaterialTheme.typography.bodyMedium (通常为 14sp)
                .font(.system(size: 14))
                .foregroundColor(.textSecondary)
                // 对应 lineHeight = 22.sp。对于 14sp 的字体，22sp 的行高意味着行间距增加。
                // lineSpacing 在 SwiftUI 中是行与行之间的额外空间。
                .lineSpacing(8) // 22sp - 14sp = 8sp
                .fixedSize(horizontal: false, vertical: true) // 允许文本换行并占据所需垂直空间
        }
        .padding(20) // 对应 Modifier.padding(20.dp)
        .frame(maxWidth: .infinity) // 对应 Modifier.fillMaxWidth()
        .background(
            RoundedRectangle(cornerRadius: 20) // 对应 RoundedCornerShape(20.dp)
                .stroke(Color.dividerColor, lineWidth: 1) // 对应 border(1.dp, DividerColor, RoundedCornerShape(20.dp))
        )
    }
}

// MARK: - 8. Bottom Control Bar (底部控制栏)
struct BottomControlBar: View {
    var body: some View {
        VStack(spacing: 0) { // 对应 Android 的 Column
            Divider() // 对应 HorizontalDivider(color = DividerColor)
                .background(Color.dividerColor) // 设置 Divider 的颜色
            
            HStack(alignment: .center) { // 对应 Android 的 Row, verticalAlignment = Alignment.CenterVertically
                ControlIcon(iconName: "line.horizontal.3", description: "Menu") // 对应 Icons.Filled.Menu
                
                Button(action: { /* No op */ }) {
                    HStack(spacing: 8) { // 对应 Spacer(modifier = Modifier.width(8.dp))
                        Image(systemName: "arrow.clockwise") // 对应 Icons.Filled.Refresh
                            .font(.system(size: 18)) // 对应 Icon 默认大小
                        Text("Refresh Data")
                            .font(.system(size: 16, weight: .medium)) // 对应 Text 默认大小
                    }
                    .padding(.horizontal, 24) // 对应 contentPadding = PaddingValues(horizontal = 24.dp)
                    .padding(.vertical, 16)   // 对应 contentPadding = PaddingValues(vertical = 16.dp)
                    .background(Color.textPrimary) // 对应 ButtonDefaults.buttonColors(containerColor = TextPrimary)
                    .foregroundColor(.pureWhite)    // 对应 ButtonDefaults.buttonColors(contentColor = PureWhite)
                    .cornerRadius(16) // 对应 RoundedCornerShape(16.dp)
                }
                
                ControlIcon(iconName: "plus", description: "Add Room") // 对应 Icons.Filled.Add
            }
            .padding(24) // 对应 Modifier.padding(24.dp)
            .frame(maxWidth: .infinity) // 对应 Modifier.fillMaxWidth()
            .background(Color.pureWhite) // 对应 Modifier.background(PureWhite)
        }
    }
}

// MARK: - 9. Control Icon (底部控制图标)
struct ControlIcon: View {
    let iconName: String
    let description: String
    
    var body: some View {
        Button(action: { /* No op */ }) {
            Image(systemName: iconName)
                .font(.system(size: 24)) // 对应 Icon 默认大小
                .foregroundColor(.textPrimary)
                .frame(width: 48, height: 48) // 对应 Modifier.size(48.dp)
                .background(
                    Circle() // 对应 CircleShape
                        .stroke(Color.dividerColor, lineWidth: 1) // 对应 border(1.dp, DividerColor, CircleShape)
                )
        }
        .accessibilityLabel(description) // 为无障碍功能提供描述
    }
}

// MARK: - Preview (预览)
struct AeroSenseContentView_Previews: PreviewProvider {
    static var previews: some View {
        AeroSenseContentView()
            .previewDisplayName("AeroSense App")
    }
}