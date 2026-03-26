import SwiftUI

// MARK: - Color Extension for Hex
// 方便地从十六进制值创建 SwiftUI 颜色
extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double(hex & 0xff) / 255,
            opacity: alpha
        )
    }
}

// MARK: - Entry Point
// App 的入口点，遵循 iOS 16.0 语法
@main
struct LumenApp: App {
    var body: some Scene {
        WindowGroup {
            LumenAppScreen()
                // 要求2: App 必须设置为全屏显示，并确保顶部状态栏隐藏。
                // ignoresSafeArea() 使得视图内容扩展到屏幕边缘，包括安全区域。
                // statusBarHidden(true) 隐藏顶部状态栏。
                .ignoresSafeArea()
                .statusBarHidden(true)
        }
    }
}

// MARK: - Main Screen
// 对应 Kotlin 的 LumenAppScreen Composable
struct LumenAppScreen: View {
    // 对应 Kotlin 的 @Composable 状态管理
    @State private var selectedIso: String = "400"
    @State private var apertureValue: Double = 2.8 // 改为 Double 以兼容 Slider
    @State private var selectedSpeedIndex: Int = 4
    
    let shutterSpeeds = ["1/1000", "1/500", "1/250", "1/125", "1/60", "1/30", "1/15", "1/8"]
    
    // 定义常量，方便修改比例和控件大小，满足要求7
    private let screenPadding: CGFloat = 24
    private let verticalSpacingLarge: CGFloat = 32
    private let verticalSpacingMedium: CGFloat = 16
    private let horizontalSpacingSmall: CGFloat = 12

    var body: some View {
        // 对应 Kotlin 的 MaterialTheme 和 Surface(color = Color.White)
        Color.white
            .ignoresSafeArea() // 确保背景覆盖整个屏幕，包括安全区域
            .overlay(
                VStack(spacing: 0) { // 对应 Kotlin 的 Column，spacing 0 允许内部 Spacer 控制间距
                    // 1. Header
                    HeaderSection()
                        .padding(.bottom, verticalSpacingMedium) // 对应 padding(bottom = 16.dp)

                    // 2. Main Display (The "Shot")
                    CurrentSettingsDisplay(
                        iso: selectedIso,
                        aperture: String(format: "%.1f", apertureValue), // 格式化浮点数
                        shutter: shutterSpeeds[selectedSpeedIndex]
                    )

                    // Spacer 模拟 Arrangement.SpaceBetween，将内容推向顶部和底部
                    Spacer()
                    
                    // 3. Controls
                    VStack(spacing: verticalSpacingLarge) { // 对应 Arrangement.spacedBy(32.dp)
                        // ISO Selector
                        IsoSelector(
                            currentIso: selectedIso,
                            onIsoSelected: { iso in selectedIso = iso }
                        )

                        // Aperture Slider
                        ApertureControl(
                            value: $apertureValue // 使用 Binding 传递 Slider 状态
                        )
                        
                        // Shutter Speed Selector
                        ShutterSpeedControl(
                            speeds: shutterSpeeds,
                            selectedIndex: selectedSpeedIndex,
                            onSelect: { index in selectedSpeedIndex = index }
                        )
                    }
                    
                    // Spacer 模拟 Arrangement.SpaceBetween
                    Spacer()

                    // 4. Bottom Action
                    LogShotButton()
                }
                .padding(screenPadding) // 对应 Modifier.padding(24.dp)
            )
    }
}

// MARK: - Sub-Components
// 对应 Kotlin 的 HeaderSection Composable
struct HeaderSection: View {
    private let bottomPadding: CGFloat = 16
    private let letterSpacingHeader: CGFloat = 2 // 对应 letterSpacing = 2.sp
    private let iconButtonSize: CGFloat = 44 // 对应 Material IconButton 的默认触摸目标大小

    var body: some View {
        HStack { // 对应 Kotlin 的 Row
            VStack(alignment: .leading, spacing: 0) { // 对应 Kotlin 的 Column
                Text("LUMEN LOG")
                    .font(.system(size: 14, weight: .bold))
                    .kerning(letterSpacingHeader) // 对应 letterSpacing
                    .foregroundColor(.gray)
                Text("Roll #034")
                    .font(.system(size: 24, weight: .heavy)) // ExtraBold 对应 .heavy
                    .foregroundColor(.black)
            }
            
            Spacer() // 对应 fillMaxWidth 和 SpaceBetween
            
            HStack(spacing: 0) { // 对应 Kotlin 的 Row
                Button(action: { /* No-op */ }) {
                    Image(systemName: "line.horizontal.3") // 对应 Icons.Default.Menu (SF Symbol)
                        .font(.system(size: 22)) // 调整图标大小
                        .foregroundColor(.black)
                }
                .frame(width: iconButtonSize, height: iconButtonSize) // 确保触摸区域
                
                Button(action: { /* No-op */ }) {
                    Image(systemName: "gear") // 对应 Icons.Default.Settings (SF Symbol)
                        .font(.system(size: 22)) // 调整图标大小
                        .foregroundColor(.black)
                }
                .frame(width: iconButtonSize, height: iconButtonSize) // 确保触摸区域
            }
        }
    }
}

// 对应 Kotlin 的 CurrentSettingsDisplay Composable
struct CurrentSettingsDisplay: View {
    let iso: String
    let aperture: String
    let shutter: String
    
    private let cardHeight: CGFloat = 160 // 对应 height(160.dp)
    private let cornerRadius: CGFloat = 16 // 对应 RoundedCornerShape(16.dp)
    private let horizontalPadding: CGFloat = 24 // 对应 padding(start = 24.dp)
    private let dividerHeight: CGFloat = 80 // 对应 height(80.dp)
    private let detailSpacing: CGFloat = 16 // 对应 Spacer(modifier = Modifier.height(16.dp))

    var body: some View {
        // 对应 Kotlin 的 Card
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color(hex: 0xFFF8F8F8)) // 对应 CardDefaults.cardColors(containerColor)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color(hex: 0xFFEEEEEE), lineWidth: 1) // 对应 BorderStroke(1.dp)
            )
            .frame(height: cardHeight) // 对应 height(160.dp)
            .frame(maxWidth: .infinity) // 对应 fillMaxWidth()
            .overlay( // 使用 overlay 放置内容
                HStack(spacing: 0) { // 对应 Kotlin 的 Row，spacing 0 因为 Divider 是显式的
                    // Aperture (Main Focus)
                    VStack(alignment: .leading, spacing: 0) { // 对应 Column, verticalArrangement = Arrangement.Center
                        Text("f/\(aperture)")
                            .font(.system(size: 56, weight: .light))
                            .foregroundColor(.black)
                            .kerning(-2) // 对应 letterSpacing = (-2).sp
                        Text("APERTURE")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, horizontalPadding)
                    .frame(maxWidth: .infinity, alignment: .leading) // 模拟 weight(1.5f)
                    .layoutPriority(1.5) // 赋予更高的布局优先级
                    
                    // 使用 Rectangle 作为分隔线
                    Rectangle()
                        .fill(Color(hex: 0xFFE0E0E0)) // 替代 Color.lightGray
                        .frame(width: 1, height: dividerHeight) // 对应 width(1.dp).height(80.dp)
                    
                    // Details Column
                    VStack(alignment: .leading, spacing: 0) { // 对应 Column, verticalArrangement = Arrangement.Center
                        SettingItemSmall(label: "ISO", value: iso)
                        Spacer() // 对应 Spacer(modifier = Modifier.height(16.dp))
                            .frame(height: detailSpacing)
                        SettingItemSmall(label: "SHUTTER", value: shutter)
                    }
                    .padding(.leading, horizontalPadding)
                    .frame(maxWidth: .infinity, alignment: .leading) // 模拟 weight(1f)
                    .layoutPriority(1) // 赋予较低的布局优先级
                }
            )
    }
}

// 对应 Kotlin 的 SettingItemSmall Composable
struct SettingItemSmall: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) { // 对应 Kotlin 的 Column
            Text(value)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.black)
            Text(label)
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(.gray)
        }
    }
}

// 对应 Kotlin 的 IsoSelector Composable
struct IsoSelector: View {
    let isoValues = ["100", "200", "400", "800", "1600", "3200"]
    let currentIso: String
    let onIsoSelected: (String) -> Void
    
    private let bottomPadding: CGFloat = 12 // 对应 padding(bottom = 12.dp)
    private let itemWidth: CGFloat = 60 // 对应 size(width = 60.dp)
    private let itemHeight: CGFloat = 36 // 对应 size(height = 36.dp)
    private let cornerRadius: CGFloat = 50 // 对应 RoundedCornerShape(50)
    private let horizontalSpacing: CGFloat = 12 // 对应 Arrangement.spacedBy(12.dp)

    var body: some View {
        VStack(alignment: .leading, spacing: 0) { // 对应 Kotlin 的 Column
            Text("Film Stock ISO")
                .font(.system(size: 14, weight: .medium))
                .padding(.bottom, bottomPadding)
            
            ScrollView(.horizontal, showsIndicators: false) { // 对应 LazyRow
                LazyHStack(spacing: horizontalSpacing) { // 对应 Arrangement.spacedBy(12.dp)
                    ForEach(isoValues, id: \.self) { iso in
                        let isSelected = currentIso == iso
                        
                        Text(iso)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(isSelected ? .white : .black)
                            .frame(width: itemWidth, height: itemHeight) // 对应 size(width, height)
                            .background(isSelected ? Color.black : Color.clear) // 对应 background(if (isSelected) Color.Black else Color.Transparent)
                            .clipShape(RoundedRectangle(cornerRadius: cornerRadius)) // 对应 clip(RoundedCornerShape(50))
                            // 对应 Kotlin 的自定义 border 辅助函数，使用 overlay(stroke) 实现视觉等效
                            .overlay(
                                RoundedRectangle(cornerRadius: cornerRadius)
                                    .stroke(isSelected ? Color.black : Color(hex: 0xFFE0E0E0), lineWidth: 1) // 对应 border(width = 1.dp, color = ...)
                            )
                            .contentShape(RoundedRectangle(cornerRadius: cornerRadius)) // 使整个区域可点击
                            .onTapGesture { // 对应 clickable
                                onIsoSelected(iso)
                            }
                    }
                }
            }
        }
    }
}

// 对应 Kotlin 的 ApertureControl Composable
struct ApertureControl: View {
    @Binding var value: Double // 使用 Binding 传递 Slider 状态，改为 Double
    
    private let sliderTopSpacing: CGFloat = 8 // 对应 Spacer(modifier = Modifier.height(8.dp))
    private let iconSize: CGFloat = 16 // 对应 Modifier.size(16.dp)
    private let sliderStep: Double = (16.0 - 1.4) / 20.0 // (valueRange.end - valueRange.start) / steps，改为 Double
    private let trackHeight: CGFloat = 2 // 对应 Compose SliderDefaults 的轨道高度
    private let thumbDiameter: CGFloat = 28 // 估算 Material3 Slider 的滑块直径

    var body: some View {
        VStack(alignment: .leading, spacing: 0) { // 对应 Kotlin 的 Column
            HStack { // 对应 Kotlin 的 Row
                Text("Aperture Control")
                    .font(.system(size: 14, weight: .medium))
                Spacer()
                Image(systemName: "gear") // 对应 Icons.Default.Settings
                    .resizable()
                    .frame(width: iconSize, height: iconSize)
                    .foregroundColor(.gray)
            }
            
            Spacer() // 对应 Spacer(modifier = Modifier.height(8.dp))
                .frame(height: sliderTopSpacing)
            
            // 为了原子级对应 SliderDefaults.colors，使用 ZStack 结合透明 Slider
            GeometryReader { geometry in
                let totalRange = 16.0 - 1.4 // valueRange = 1.4f..16f
                let normalizedValue = CGFloat((value - 1.4) / totalRange) // 当前值在范围内的比例，value 现在为 Double
                
                ZStack(alignment: .leading) {
                    // 非活跃轨道 (inactiveTrackColor)
                    Capsule()
                        .fill(Color(hex: 0xFFE0E0E0))
                        .frame(height: trackHeight)
                    
                    // 活跃轨道 (activeTrackColor)
                    Capsule()
                        .fill(Color.black)
                        .frame(width: geometry.size.width * normalizedValue, height: trackHeight)
                    
                    // 滑块 (thumbColor)
                    Circle()
                        .fill(Color.black)
                        .frame(width: thumbDiameter, height: thumbDiameter)
                        .offset(x: geometry.size.width * normalizedValue - thumbDiameter / 2)
                        .shadow(radius: 2) // 增加一点阴影以匹配 Material Design 风格
                }
                .frame(height: geometry.size.height, alignment: .center) // 垂直居中自定义轨道和滑块
                
                // 实际的 Slider，使其透明以显示自定义视觉效果，但保留交互功能
                Slider(value: $value, in: 1.4...16.0, step: sliderStep) {
                    Text("") // 无标签
                } minimumValueLabel: {
                    Text("") // 无最小值标签
                } maximumValueLabel: {
                    Text("") // 无最大值标签
                }
                .opacity(0.001) // 几乎完全透明，但仍可交互
                .accentColor(.clear) // 清除默认的 accentColor，避免影响自定义滑块颜色
            }
            .frame(height: thumbDiameter) // 确保 Slider 有足够的高度来显示和交互滑块
            
            HStack { // 对应 Kotlin 的 Row
                Text("f/1.4")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Spacer()
                Text("f/16")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
        }
    }
}

// 对应 Kotlin 的 ShutterSpeedControl Composable
struct ShutterSpeedControl: View {
    let speeds: [String]
    let selectedIndex: Int
    let onSelect: (Int) -> Void
    
    private let bottomPadding: CGFloat = 12 // 对应 padding(bottom = 12.dp)
    private let horizontalSpacing: CGFloat = 12 // 假设与 ISO 选择器相似的间距

    var body: some View {
        VStack(alignment: .leading, spacing: 0) { // 对应 Kotlin 的 Column
            Text("Shutter Speed")
                .font(.system(size: 14, weight: .medium))
                .padding(.bottom, bottomPadding)
            
            HStack(spacing: horizontalSpacing) { // 对应 Kotlin 的 Row, Arrangement.SpaceBetween
                // 简化显示，只显示选中项及其前后项
                let prev = speeds.indices.contains(selectedIndex - 1) ? speeds[selectedIndex - 1] : "-"
                let curr = speeds[selectedIndex]
                let next = speeds.indices.contains(selectedIndex + 1) ? speeds[selectedIndex + 1] : "-"
                
                SpeedOption(text: prev, isSelected: false) {
                    if selectedIndex > 0 { onSelect(selectedIndex - 1) }
                }
                
                SpeedOption(text: curr, isSelected: true, onClick: {}) // 选中项不可点击
                
                SpeedOption(text: next, isSelected: false) {
                    if selectedIndex < speeds.count - 1 { onSelect(selectedIndex + 1) }
                }
            }
            .frame(maxWidth: .infinity) // 确保 HStack 填充可用宽度
        }
    }
}

// 对应 Kotlin 的 SpeedOption Composable
struct SpeedOption: View {
    let text: String
    let isSelected: Bool
    let onClick: () -> Void
    
    private let itemWidth: CGFloat = 100 // 对应 width(100.dp)
    private let itemHeight: CGFloat = 50 // 对应 height(50.dp)
    private let cornerRadius: CGFloat = 12 // 对应 RoundedCornerShape(12.dp)

    var body: some View {
        Text(text)
            .font(.system(size: isSelected ? 22 : 16, weight: isSelected ? .bold : .regular)) // Normal 对应 .regular
            .foregroundColor(isSelected ? .black : Color(hex: 0xFFE0E0E0)) // 修复：使用自定义灰色
            .frame(width: itemWidth, height: itemHeight) // 对应 width(100.dp).height(50.dp)
            .background(isSelected ? Color(hex: 0xFFF0F0F0) : Color.clear) // 对应 background
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius)) // 对应 clip(RoundedCornerShape(12.dp))
            .contentShape(RoundedRectangle(cornerRadius: cornerRadius)) // 使整个区域可点击
            .onTapGesture { // 对应 clickable(enabled = ...)
                if !isSelected && text != "-" {
                    onClick()
                }
            }
    }
}

// 对应 Kotlin 的 LogShotButton Composable
struct LogShotButton: View {
    private let buttonHeight: CGFloat = 56 // 对应 height(56.dp)
    private let cornerRadius: CGFloat = 12 // 对应 RoundedCornerShape(12.dp)
    private let iconBoxSize: CGFloat = 24 // 对应 size(24.dp)
    private let iconSize: CGFloat = 16 // 对应 size(16.dp)
    private let iconTextSpacing: CGFloat = 12 // 对应 Spacer(modifier = Modifier.width(12.dp))
    private let letterSpacingButton: CGFloat = 1 // 对应 letterSpacing = 1.sp

    var body: some View {
        Button(action: { /* No-op */ }) {
            HStack(alignment: .center, spacing: iconTextSpacing) { // 对应 Row, verticalAlignment = Alignment.Center
                ZStack { // 对应 Kotlin 的 Box
                    Circle()
                        .fill(Color.white) // 对应 background(Color.White, CircleShape)
                        .frame(width: iconBoxSize, height: iconBoxSize) // 对应 size(24.dp)
                    Image(systemName: "plus") // 对应 Icons.Default.Add (SF Symbol)
                        .resizable()
                        .frame(width: iconSize, height: iconSize) // 对应 size(16.dp)
                        .foregroundColor(.black)
                }
                // Spacer(modifier = Modifier.width(12.dp)) 由 HStack 的 spacing 处理
                Text("LOG EXPOSURE")
                    .font(.system(size: 16, weight: .bold))
                    .kerning(letterSpacingButton) // 对应 letterSpacing
                    .foregroundColor(.white) // 对应 contentColor
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // 使内容填充按钮
        }
        .frame(height: buttonHeight) // 对应 height(56.dp)
        .frame(maxWidth: .infinity) // 对应 fillMaxWidth()
        .background(Color.black) // 对应 containerColor
        .cornerRadius(cornerRadius) // 对应 shape = RoundedCornerShape(12.dp)
    }
}

// MARK: - Preview
// SwiftUI 的预览功能，对应 Kotlin 的 @Preview
struct LumenAppScreen_Previews: PreviewProvider {
    static var previews: some View {
        LumenAppScreen()
    }
}