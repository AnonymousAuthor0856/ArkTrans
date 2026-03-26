import SwiftUI

struct ContentView: View {
    // 小蓝点实际位置在中心靠左，但坐标显示仍为(200, 400)
    @State private var markerPosition = CGPoint(x: 120, y: 200)
    @State private var displayedCoordinates = "(200, 400)"
    
    var body: some View {
        VStack(spacing: 0) {
            // Top App Bar - 减少标题下方的空白
            VStack {
                Text("Favorite Spots Map")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(Color(hex: 0xFF111827))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10) // 减少标题栏的垂直内边距
            .background(Color(hex: 0xFFF9FAFB))
            
            // 主要内容区域
            ZStack {
                // 背景渐变
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(0.6),
                        Color(hex: 0xFFEFF6FF).opacity(0.5),
                        Color.white.opacity(0.7)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    // 地图容器
                    ZStack {
                        // 径向渐变背景
                        RadialGradient(
                            gradient: Gradient(colors: [
                                Color(hex: 0xFFFFFFFF).opacity(0.8),
                                Color(hex: 0xFFEFF6FF).opacity(0.6)
                            ]),
                            center: .center,
                            startRadius: 0,
                            endRadius: 120
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        
                        // 边框
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color(hex: 0xFFD1D5DB), lineWidth: 1)
                        
                        // 绘制圆圈和标记
                        Canvas { context, size in
                            let center = CGPoint(x: size.width / 2, y: size.height / 2)
                            
                            // 内圈 (radius = 120)
                            var circlePath = Path()
                            circlePath.addArc(center: center, radius: 120, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
                            context.fill(circlePath, with: .color(Color(hex: 0xFF93C5FD).opacity(0.3)))
                            
                            // 外圈 (radius = 180)
                            circlePath = Path()
                            circlePath.addArc(center: center, radius: 180, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
                            context.fill(circlePath, with: .color(Color(hex: 0xFF93C5FD).opacity(0.2)))
                            
                            // 标记点实心圆 (radius = 4) - 进一步减小半径
                            circlePath = Path()
                            circlePath.addArc(center: markerPosition, radius: 4, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
                            context.fill(circlePath, with: .color(Color(hex: 0xFF60A5FA)))
                            
                            // 标记点外圈 (radius = 12, stroke width = 1) - 进一步减小半径和线宽
                            circlePath = Path()
                            circlePath.addArc(center: markerPosition, radius: 12, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
                            context.stroke(circlePath, with: .color(Color(hex: 0xFF60A5FA).opacity(0.3)), lineWidth: 1)
                        }
                    }
                    .frame(height: 400)
                    .padding(.horizontal, 16)
                    
                    // 底部控制区域 - 直接放在地图框下方，没有上方空白
                    VStack(spacing: 16) {
                        Text("Spot Coordinates: \(displayedCoordinates)")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color(hex: 0xFF111827))
                        
                        Button(action: {
                            // 保存标记点操作
                        }) {
                            Text("Save Marker")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                                .background(Color(hex: 0xFF60A5FA))
                                .cornerRadius(16)
                        }
                        
                        // 添加已保存的标记列表
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Saved Markers")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Color(hex: 0xFF111827))
                            
                            VStack(spacing: 8) {
                                HStack {
                                    Circle()
                                        .fill(Color(hex: 0xFF60A5FA))
                                        .frame(width: 8, height: 8)
                                    Text("Saved Marker")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(Color(hex: 0xFF111827))
                                    Spacer()
                                }
                                
                                HStack {
                                    Circle()
                                        .fill(Color(hex: 0xFF60A5FA))
                                        .frame(width: 8, height: 8)
                                    Text("Saved Marker")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(Color(hex: 0xFF111827))
                                    Spacer()
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 8)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 0) // 确保没有上方空白
                    .padding(.bottom, 24)
                }
            }
        }
        .background(Color(hex: 0xFFF9FAFB))
        .ignoresSafeArea()
        .statusBar(hidden: true)
    }
}

// 颜色扩展
extension Color {
    init(hex: UInt) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

@main
struct SingleFileUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}