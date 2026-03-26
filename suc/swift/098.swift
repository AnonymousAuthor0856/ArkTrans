import SwiftUI

// MARK: - Color Extension for Hex Initialization
// 方便地通过十六进制颜色值初始化 SwiftUI Color
extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }

    // 自定义主题颜色，与 Kotlin 版本保持一致
    static let primaryBlack = Color(hex: 0xFF121212)
    static let textGrey = Color(hex: 0xFF757575)
    static let backgroundWhite = Color.white
    static let cardBackground = Color(hex: 0xFFF9F9F9)
    static let promoCardBackground = Color(hex: 0xFFF0F0F0)
    static let lightGreyBorder = Color(hex: 0xFFEEEEEE)
    static let veryLightGreyBorder = Color(hex: 0xFFE0E0E0)
}

// MARK: - Data Models (纯 UI 模拟数据)
// TeaGuide 数据模型，添加 Identifiable 协议以用于 ForEach
struct TeaGuide: Identifiable {
    let id: Int
    let name: String
    let origin: String
    let temp: String
    let time: String
    let colorCode: Color
}

// 模拟茶叶数据，与 Kotlin 版本保持一致
let sampleTeas = [
    TeaGuide(id: 1, name: "Sencha Green", origin: "Japan", temp: "70°C / 158°F", time: "1-2 min", colorCode: Color(hex: 0xFF8BC34A)),
    TeaGuide(id: 2, name: "Earl Grey", origin: "Blend", temp: "95°C / 203°F", time: "3-5 min", colorCode: Color(hex: 0xFF795548)),
    TeaGuide(id: 3, name: "Silver Needle", origin: "China", temp: "80°C / 176°F", time: "3-4 min", colorCode: Color(hex: 0xFFE0E0E0)),
    TeaGuide(id: 4, name: "Darjeeling", origin: "India", temp: "90°C / 194°F", time: "3 min", colorCode: Color(hex: 0xFFD7CCC8)),
    TeaGuide(id: 5, name: "Chamomile", origin: "Egypt", temp: "100°C / 212°F", time: "5-7 min", colorCode: Color(hex: 0xFFFFEB3B)),
    TeaGuide(id: 6, name: "Matcha", origin: "Japan", temp: "80°C / 176°F", time: "Whisk", colorCode: Color(hex: 0xFF4CAF50)),
    TeaGuide(id: 7, name: "Oolong", origin: "Taiwan", temp: "85°C / 185°F", time: "3-5 min", colorCode: Color(hex: 0xFFFF9800))
]

// MARK: - UI Components

// 主应用视图，对应 Kotlin 的 ZenBrewApp Composable
struct ZenBrewAppView: View {
    var body: some View {
        // ZStack 用于分层布局，将浮动按钮置于内容之上
        ZStack(alignment: .bottomTrailing) {
            // 主内容区域，可滚动
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) { // 对应 Kotlin 的 verticalArrangement = Arrangement.spacedBy(16.dp)
                    // 顶部栏 (模拟 TopAppBar)
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text("ZenBrew")
                                .font(.system(size: 24, weight: .bold)) // fontSize = 24.sp, fontWeight = FontWeight.Bold
                                .foregroundColor(.primaryBlack)
                                .kerning(-0.5) // letterSpacing = (-0.5).sp
                            Text("Mindful Steeping Guide")
                                .font(.system(size: 14, weight: .regular)) // fontSize = 14.sp, fontWeight = FontWeight.Normal
                                .foregroundColor(.textGrey)
                        }
                        Spacer()
                        Button(action: {
                            // 处理设置按钮点击
                            print("Settings tapped")
                        }) {
                            Image(systemName: "gear") // 对应 Icons.Default.Settings
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24) // 默认图标大小
                                .foregroundColor(.primaryBlack)
                        }
                        .frame(width: 44, height: 44) // 增大按钮点击区域，符合 iOS 规范
                    }
                    .padding(.horizontal, 20) // 对应 LazyColumn 的 contentPadding horizontal
                    .padding(.top, 10) // 顶部栏自身的顶部内边距，以匹配视觉效果

                    // 推广卡片
                    PromoCard()
                        .padding(.horizontal, 20) // 对应 LazyColumn 的 contentPadding horizontal

                    // "Collections" 标题
                    Text("Collections")
                        .font(.system(size: 18, weight: .semibold)) // fontSize = 18.sp, fontWeight = FontWeight.SemiBold
                        .foregroundColor(.primaryBlack)
                        .frame(maxWidth: .infinity, alignment: .leading) // 对应 modifier = Modifier.fillMaxWidth()
                        .padding(.vertical, 8) // modifier = Modifier.padding(vertical = 8.dp)
                        .padding(.horizontal, 20) // 对应 LazyColumn 的 contentPadding horizontal

                    // 茶叶列表卡片
                    ForEach(sampleTeas) { tea in
                        TeaItemCard(tea: tea)
                            .padding(.horizontal, 20) // 对应 LazyColumn 的 contentPadding horizontal
                    }

                    // 浮动按钮的额外间距，防止内容被遮挡
                    Spacer()
                        .frame(height: 80) // 对应 Spacer(modifier = Modifier.height(80.dp))
                }
                .padding(.vertical, 10) // 对应 LazyColumn 的 contentPadding vertical
            }
            .background(Color.backgroundWhite.ignoresSafeArea()) // 对应 Scaffold containerColor & background
            .edgesIgnoringSafeArea(.all) // 确保内容填充到屏幕边缘，对应 enableEdgeToEdge()

            // 浮动操作按钮 (FAB)
            Button(action: {
                // 处理自定义冲泡按钮点击
                print("Custom Brew tapped")
            }) {
                HStack(spacing: 8) { // 对应 Spacer(modifier = Modifier.width(8.dp))
                    Image(systemName: "plus") // 对应 Icons.Default.Add
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20) // 图标大小
                    Text("Custom Brew")
                        .font(.system(size: 16, weight: .medium)) // 按钮文本大小
                }
                .frame(height: 56) // 对应 modifier = Modifier.height(56.dp)
                .padding(.horizontal, 24) // 按钮内部水平填充
                .background(Color.primaryBlack) // 对应 containerColor = primaryBlack
                .foregroundColor(.white) // 对应 contentColor = Color.White
                .cornerRadius(16) // 对应 shape = RoundedCornerShape(16.dp)
            }
            .padding(.trailing, 20) // FAB 距离右侧的内边距
            .padding(.bottom, 20) // FAB 距离底部的内边距
        }
        .background(Color.backgroundWhite.ignoresSafeArea()) // 确保整个背景是白色
        .statusBarHidden(true) // 隐藏顶部状态栏，对应 WindowInsetsControllerCompat.hide(WindowInsetsCompat.Type.systemBars())
    }
}

// 推广卡片视图，对应 Kotlin 的 PromoCard Composable
struct PromoCard: View {
    var body: some View {
        HStack(alignment: .center) { // 对应 Row
            VStack(alignment: .leading) { // 对应 Column
                Text("Tip of the day")
                    .font(.system(size: 12, weight: .bold)) // fontSize = 12.sp, fontWeight = FontWeight.Bold
                    .foregroundColor(.gray)
                    .padding(.bottom, 4) // modifier = Modifier.padding(bottom = 4.dp)
                Text("Use filtered water for a purer taste profile.")
                    .font(.system(size: 16, weight: .medium)) // fontSize = 16.sp, fontWeight = FontWeight.Medium
                    .foregroundColor(.primaryBlack)
            }
            .frame(maxWidth: .infinity, alignment: .leading) // 对应 modifier = Modifier.weight(1f)
            Spacer()
                .frame(width: 16) // 对应 Spacer(modifier = Modifier.width(16.dp))

            // 右侧圆形图标区域
            ZStack { // 对应 Box(contentAlignment = Alignment.Center)
                Circle()
                    .fill(Color.white) // 对应 color = Color.White
                    .frame(width: 48, height: 48) // 对应 modifier = Modifier.size(48.dp)
                Image(systemName: "info.circle.fill") // 对应 Icons.Default.Info
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24) // 图标大小
                    .foregroundColor(.gray)
            }
        }
        .padding(24) // 对应 modifier = Modifier.padding(24.dp)
        .background(Color.promoCardBackground) // 对应 colors = CardDefaults.cardColors(containerColor = Color(0xFFF0F0F0))
        .cornerRadius(20) // 对应 shape = RoundedCornerShape(20.dp)
        // Kotlin 版本 elevation = 0.dp，SwiftUI 中可省略 shadow 或设置为 radius: 0
    }
}

// 茶叶详情卡片视图，对应 Kotlin 的 TeaItemCard Composable
struct TeaItemCard: View {
    let tea: TeaGuide
    
    var body: some View {
        HStack(alignment: .center) { // 对应 Row
            // 左侧圆形标识符
            ZStack { // 对应 Box
                Circle()
                    .fill(Color.white) // 对应 background(Color.White)
                    .frame(width: 50, height: 50) // 对应 modifier = Modifier.size(50.dp)
                    .overlay(
                        Circle()
                            .stroke(tea.colorCode.opacity(0.3), lineWidth: 2) // 对应 border(BorderStroke(2.dp, tea.colorCode.copy(alpha = 0.3f)), CircleShape)
                    )
                Text(String(tea.name.prefix(1))) // 对应 tea.name.take(1)
                    .font(.system(size: 20, weight: .bold)) // fontSize = 20.sp, fontWeight = FontWeight.Bold
                    .foregroundColor(tea.colorCode)
            }
            .clipShape(Circle()) // 对应 .clip(CircleShape)

            Spacer()
                .frame(width: 16) // 对应 Spacer(modifier = Modifier.width(16.dp))

            VStack(alignment: .leading) { // 对应 Column
                Text(tea.name)
                    .font(.system(size: 17, weight: .bold)) // fontSize = 17.sp, fontWeight = FontWeight.Bold
                    .foregroundColor(.primaryBlack)
                Text(tea.origin)
                    .font(.system(size: 12)) // fontSize = 12.sp
                    .foregroundColor(.textGrey)
                Spacer()
                    .frame(height: 6) // 对应 Spacer(modifier = Modifier.height(6.dp))
                HStack(alignment: .center) { // 对应 Row
                    InfoBadge(label: tea.temp)
                    Spacer()
                        .frame(width: 8) // 对应 Spacer(modifier = Modifier.width(8.dp))
                    InfoBadge(label: tea.time)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading) // 对应 modifier = Modifier.weight(1f)

            // 右侧播放按钮
            Button(action: {
                // 处理播放按钮点击
                print("Play for \(tea.name) tapped")
            }) {
                Image(systemName: "play.fill") // 对应 Icons.Default.PlayArrow
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20) // 对应 modifier = Modifier.size(20.dp)
                    .foregroundColor(.primaryBlack)
            }
            .frame(width: 40, height: 40) // 对应 modifier = Modifier.size(40.dp)
            .background(Color.white) // 对应 background(Color.White)
            .clipShape(Circle()) // 对应 CircleShape
            .overlay(
                Circle()
                    .stroke(Color.veryLightGreyBorder, lineWidth: 1) // 对应 border(1.dp, Color(0xFFE0E0E0), CircleShape)
            )
        }
        .padding(16) // 对应 modifier = Modifier.padding(16.dp)
        .background(Color.cardBackground) // 对应 colors = CardDefaults.cardColors(containerColor = bgColor)
        .cornerRadius(16) // 对应 shape = RoundedCornerShape(16.dp)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.lightGreyBorder, lineWidth: 1) // 对应 border = BorderStroke(1.dp, Color(0xFFEEEEEE))
        )
        // Kotlin 版本 elevation = 0.dp，SwiftUI 中可省略 shadow 或设置为 radius: 0
    }
}

// 信息徽章视图，对应 Kotlin 的 InfoBadge Composable
struct InfoBadge: View {
    let label: String
    
    var body: some View {
        Text(label)
            .font(.system(size: 11)) // fontSize = 11.sp
            .foregroundColor(.black)
            .padding(.horizontal, 6) // 对应 modifier = Modifier.padding(horizontal = 6.dp, vertical = 2.dp)
            .padding(.vertical, 2)
            .background(Color.white) // 对应 color = Color.White
            .cornerRadius(6) // 对应 shape = RoundedCornerShape(6.dp)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.veryLightGreyBorder, lineWidth: 1) // 对应 border = BorderStroke(1.dp, Color(0xFFE0E0E0))
            )
    }
}

// MARK: - App Entry Point
// SwiftUI 应用的入口点，对应 Kotlin 的 MainActivity
@main
struct ZenBrewApp: App {
    var body: some Scene {
        WindowGroup {
            ZenBrewAppView()
        }
    }
}

// MARK: - Preview Section
// Xcode 预览区域，对应 Kotlin 的 @Preview
struct ZenBrewApp_Previews: PreviewProvider {
    static var previews: some View {
        ZenBrewAppView()
    }
}