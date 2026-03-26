import SwiftUI

// MARK: - Color Extension for Hex Initialization
// 方便使用十六进制颜色值，与 Android Compose 的 Color(0xFF...) 对应
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
}

// MARK: - MatchaBrewingScreen
struct MatchaBrewingScreen: View {
    var body: some View {
        // STRICT: Pure White Background
        // 使用 Color.white 作为背景，并忽略安全区域，实现全屏效果
        Color.white
            .ignoresSafeArea() // 确保内容延伸到屏幕边缘，包括状态栏和导航栏区域
            .overlay( // 使用 overlay 将内容放置在白色背景之上
                VStack(alignment: .center) { // 对应 Android 的 Column(horizontalAlignment = Alignment.CenterHorizontally)
                    // Top Section: Title
                    VStack(alignment: .center) {
                        // Spacer 对应 Android 的 Spacer(modifier = Modifier.height(X.dp))
                        Spacer().frame(height: 48)
                        Text("MATCHA RITUAL")
                            .font(.system(size: 14)) // fontSize = 14.sp
                            .kerning(4) // letterSpacing = 4.sp
                            .fontWeight(.bold) // fontWeight = FontWeight.Bold
                            .foregroundColor(.gray) // color = Color.Gray
                        Spacer().frame(height: 8)
                        Text("Ceremonial Grade")
                            .font(.system(size: 28)) // fontSize = 28.sp
                            .fontWeight(.light) // fontWeight = FontWeight.Light
                            .foregroundColor(.black) // color = Color.Black
                    }

                    // Middle Section: Visual Art & Stats
                    // 使用 Spacer().frame(maxHeight: .infinity) 配合 VStack 实现 SpaceBetween 效果
                    VStack(alignment: .center) {
                        MatchaBowlCanvas()
                            .frame(width: 160, height: 160) // modifier = Modifier.size(160.dp)

                        Spacer().frame(height: 40) // Spacer(modifier = Modifier.height(40.dp))

                        // Info Row - 使用 Spacers 实现 SpaceEvenly 效果
                        HStack(spacing: 0) { // 对应 Android 的 Row(horizontalArrangement = Arrangement.SpaceEvenly)
                            Spacer() // 左侧 Spacer
                            InfoItem(label: "TEMP", value: "80°C")
                            Spacer() // 元素间 Spacer
                            InfoItem(label: "WATER", value: "70ml")
                            Spacer() // 元素间 Spacer
                            InfoItem(label: "BAMBOO", value: "Whisk")
                            Spacer() // 右侧 Spacer
                        }
                        .frame(maxWidth: .infinity) // modifier = Modifier.fillMaxWidth()
                    }
                    .frame(maxHeight: .infinity) // 允许中间部分占据所有可用空间，实现垂直方向的 SpaceBetween

                    // Bottom Section: Instructions & Action
                    VStack(alignment: .center) { // 对应 Android 的 Column(horizontalAlignment = Alignment.CenterHorizontally)
                        StepCard(number: "01", text: "Sift 2g of matcha powder.")
                        Spacer().frame(height: 12) // Spacer(modifier = Modifier.height(12.dp))
                        StepCard(number: "02", text: "Add hot water. Whisk in 'M' shape.")

                        Spacer().frame(height: 32) // Spacer(modifier = Modifier.height(32.dp))

                        Button(action: {
                            // No logic required, just a placeholder action
                        }) {
                            HStack(spacing: 8) { // 对应 Android Button 内部的 Icon 和 Text 以及 Spacer(modifier = Modifier.width(8.dp))
                                Image(systemName: "play.fill") // Icons.Default.PlayArrow 对应 SF Symbols 的 play.fill
                                    .font(.system(size: 20)) // modifier = Modifier.size(20.dp)
                                Text("START TIMER")
                                    .font(.system(size: 16)) // fontSize = 16.sp
                                    .fontWeight(.semibold) // fontWeight = FontWeight.SemiBold
                            }
                            .foregroundColor(.white) // 按钮内容颜色，对应 onPrimary = Color.White
                            .frame(maxWidth: .infinity, maxHeight: 56) // fillMaxWidth().height(56.dp)
                            .background(Color(hex: 0xFF556B2F)) // containerColor = Color(0xFF556B2F)
                            .cornerRadius(28) // shape = RoundedCornerShape(28.dp)
                        }
                        .buttonStyle(PlainButtonStyle()) // 移除 SwiftUI 默认的按钮样式，以便自定义背景和圆角
                        .frame(maxWidth: .infinity) // 确保按钮占据最大宽度
                        
                        Spacer().frame(height: 24) // Spacer(modifier = Modifier.height(24.dp))
                    }
                    .frame(maxWidth: .infinity) // modifier = Modifier.fillMaxWidth()
                }
                .padding(24) // 对应 Android 的 modifier = Modifier.padding(24.dp)
            )
            .statusBarHidden(true) // 隐藏状态栏，实现全屏沉浸式效果
    }
}

// MARK: - MatchaBowlCanvas
// 自定义绘制抹茶碗和蒸汽，对应 Android 的 @Composable fun MatchaBowlCanvas
struct MatchaBowlCanvas: View {
    let bowlColor = Color(hex: 0xFF333333) // Dark charcoal bowl
    let matchaColor = Color(hex: 0xFF8BBD52) // Bright matcha green
    
    var body: some View {
        Canvas { context, size in // SwiftUI 的 Canvas 视图，用于自定义 2D 绘图
            let w = size.width
            let h = size.height
            
            // 1. Draw the Bowl (Trapezoid-like shape with rounded bottom)
            var bowlPath = Path() // 对应 Android 的 Path()
            bowlPath.move(to: CGPoint(x: w * 0.15, y: h * 0.4)) // moveTo
            bowlPath.addLine(to: CGPoint(x: w * 0.85, y: h * 0.4)) // lineTo
            bowlPath.addQuadCurve(
                to: CGPoint(x: w * 0.5, y: h * 0.9), // 终点
                control: CGPoint(x: w * 0.9, y: h * 0.9) // 控制点
            ) // quadraticBezierTo
            bowlPath.addQuadCurve(
                to: CGPoint(x: w * 0.15, y: h * 0.4), // 终点
                control: CGPoint(x: w * 0.1, y: h * 0.9) // 控制点
            ) // quadraticBezierTo
            bowlPath.closeSubpath() // close()
            
            context.fill(bowlPath, with: .color(bowlColor)) // drawPath
            
            // 2. Draw the Liquid (Matcha) inside
            let matchaRect = CGRect(x: w * 0.2, y: h * 0.42, width: w * 0.6, height: h * 0.15)
            context.fill(Path(ellipseIn: matchaRect), with: .color(matchaColor)) // drawOval
            
            // 3. Draw Steam (Simple lines)
            let steamColor = Color.gray.opacity(0.5) // Color.LightGray.copy(alpha = 0.5f)
            // StrokeStyle 对应 Android 的 Stroke 和 StrokeCap.Round
            let strokeStyle = StrokeStyle(lineWidth: 4, lineCap: .round) // strokeWidth = 4f, cap = StrokeCap.Round
            
            var steamPath1 = Path()
            steamPath1.move(to: CGPoint(x: w * 0.4, y: h * 0.3))
            steamPath1.addLine(to: CGPoint(x: w * 0.4, y: h * 0.15))
            context.stroke(steamPath1, with: .color(steamColor), style: strokeStyle) // drawLine
            
            var steamPath2 = Path()
            steamPath2.move(to: CGPoint(x: w * 0.5, y: h * 0.25))
            steamPath2.addLine(to: CGPoint(x: w * 0.5, y: h * 0.1))
            context.stroke(steamPath2, with: .color(steamColor), style: strokeStyle) // drawLine
            
            var steamPath3 = Path()
            steamPath3.move(to: CGPoint(x: w * 0.6, y: h * 0.3))
            steamPath3.addLine(to: CGPoint(x: w * 0.6, y: h * 0.15))
            context.stroke(steamPath3, with: .color(steamColor), style: strokeStyle) // drawLine
        }
    }
}

// MARK: - InfoItem
// 对应 Android 的 @Composable fun InfoItem
struct InfoItem: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .center) { // horizontalAlignment = Alignment.CenterHorizontally
            Text(label)
                .font(.system(size: 10)) // fontSize = 10.sp
                .fontWeight(.bold) // fontWeight = FontWeight.Bold
                .foregroundColor(.gray.opacity(0.5)) // Color.LightGray
            Spacer().frame(height: 4) // Spacer(modifier = Modifier.height(4.dp))
            Text(value)
                .font(.system(size: 16)) // fontSize = 16.sp
                .fontWeight(.medium) // fontWeight = FontWeight.Medium
                .foregroundColor(.black) // color = Color.Black
        }
    }
}

// MARK: - StepCard
// 对应 Android 的 @Composable fun StepCard
struct StepCard: View {
    let number: String
    let text: String
    
    var body: some View {
        HStack(alignment: .center) { // verticalAlignment = Alignment.CenterVertically
            ZStack { // 对应 Android 的 Box
                Circle() // 对应 Android 的 CircleShape
                    .fill(Color(hex: 0xFFF5F5F5)) // background(Color(0xFFF5F5F5))
                    .frame(width: 32, height: 32) // size(32.dp)
                Text(number)
                    .font(.system(size: 12)) // fontSize = 12.sp
                    .fontWeight(.bold) // fontWeight = FontWeight.Bold
                    .foregroundColor(.black) // color = Color.Black
            }
            Spacer().frame(width: 16) // Spacer(modifier = Modifier.width(16.dp))
            Text(text)
                .font(.system(size: 14)) // fontSize = 14.sp
                .foregroundColor(Color(white: 0.3)) // Color.DarkGray
        }
        .frame(maxWidth: .infinity) // fillMaxWidth()
        .padding(16) // padding(16.dp)
        // 使用 overlay 模拟 Android 的 border 修饰符
        .overlay(
            RoundedRectangle(cornerRadius: 12) // RoundedCornerShape(12.dp)
                .stroke(Color(hex: 0xFFEEEEEE), lineWidth: 1) // border(1.dp, Color(0xFFEEEEEE))
        )
        // 注意：SwiftUI 的 cornerRadius 默认裁剪内容，这里为了确保边框和内容都圆角，可以再加一个
        // 但由于 overlay 已经提供了圆角边框，这里可以省略，或者用于裁剪内容
        // .cornerRadius(12) 
    }
}

// MARK: - App Entry Point
// SwiftUI 应用的入口点，对应 Android 的 MainActivity
@main
struct MatchaApp: App {
    var body: some Scene {
        WindowGroup {
            MatchaBrewingScreen()
                // .statusBarHidden(true) 已经移到 MatchaBrewingScreen 内部，确保只影响该视图
        }
    }
}

// MARK: - Preview Provider
// 对应 Android 的 @Preview
struct MatchaBrewingScreen_Previews: PreviewProvider {
    static var previews: some View {
        MatchaBrewingScreen()
    }
}