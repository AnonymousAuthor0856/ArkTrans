import SwiftUI

@main
struct VideoPlayerApp: App {
    var body: some Scene {
        WindowGroup {
            VideoPlayerRoot()
                .ignoresSafeArea()
                .statusBar(hidden: true)
        }
    }
}

private struct VP {
    // 一处改比值即可（0.48~0.55 都可按需微调）
    static let VIDEO_SURFACE_RATIO: CGFloat = 0.50

    struct Colors {
        static let primary = Color(hex: 0x1E3A8A)          // 深蓝（主色）
        static let background = Color(hex: 0x0F172A)       // 背景
        static let surface = Color(hex: 0x1E293B)          // 深色块
        static let surfaceVariant = Color(hex: 0x334155)   // 次级深色块
        static let outline = Color(hex: 0x475569)          // 轮廓描边
        static let onSurface = Color(hex: 0xE2E8F0)        // 文本
        static let chip = Color(hex: 0xE8DEF8)             // 浅紫色按钮底
    }
}

struct VideoPlayerRoot: View {
    var body: some View {
        GeometryReader { geo in
            let sw = geo.size.width
            let sh = geo.size.height
            // 原标定 720×1280，保留 scale 用于圆角/字号等
            let scale = min(sw/720.0, sh/1280.0)
            let padX = 24.0 * scale
            let titleH = 56.0 * scale
            // —— 关键：视频容器高度按“屏幕高度比例”设定 —— //
            let videoH = max(sh * VP.VIDEO_SURFACE_RATIO, 360 * scale)

            VStack(spacing: 10) {
                // 顶部标题
                Text("Video Player")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color(hex:0xe2e8f0))
                    .frame(height: titleH)
                    .padding(.vertical, 12)

                // Video Surface（占近半屏）
                RoundedRectangle(cornerRadius: 24*scale, style: .continuous)
                    .fill(VP.Colors.surfaceVariant)
                    .overlay(
                        Text("Video Surface")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(VP.Colors.onSurface.opacity(0.9))
                    )
                    .frame(height: 300)
                    .padding(.trailing, 10)
                // 片名
                Text("Journey through the Skies")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color(hex:0xe0e8f0))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)

                // ===== 进度区域（上：左胶囊 + 竖条 + 右轨 + 蓝点）=====
                VStack(alignment: .leading, spacing: 10*scale) {
                    let contentW = sw - 2*padX
                    let leftW  = contentW * 0.40
                    let rightW = contentW * 0.47

                    HStack(spacing: 18*scale) {
                        Spacer()
                        Capsule()
                            .fill(VP.Colors.primary)
                            .frame(width: leftW, height: 32*scale)
                        
                        RoundedRectangle(cornerRadius: 3*scale, style: .continuous)
                            .fill(VP.Colors.primary)
                            .frame(width: 6*scale, height: 72*scale)
                        
                        ZStack(alignment: .trailing) {
                            Capsule()
                                .fill(Color(hex:0x475569))
                                .frame(width: rightW, height: 32*scale)
                            Circle()
                                .fill(VP.Colors.primary)
                                .frame(width: 12*scale, height: 12*scale)
                                .offset(x: -10*scale)
                            
                        }
                        Spacer()
                    }

                    HStack {
                        Text("1:35")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Color(hex: 0xa3aab5))
                            .padding(.leading, 10)
                        Spacer()
                        Text("4:00")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Color(hex: 0xa3aab5))
                            .padding(.trailing, 10)
                    }
                }
                .padding(.horizontal, padX)
                .padding(.top, 8*scale)   // 控件之间加纵向 padding
                .padding(.bottom, 6*scale)

                // ===== 控制区：-10s / Play / +30s =====
                HStack(spacing: 24*scale) {
                    tonalButton("−10s", scale: scale)
                        .foregroundColor(.black)
                    ZStack {
                        Circle().fill(VP.Colors.primary)
                        Image(systemName: "play.fill")
                            .font(.system(size: 40*scale, weight: .bold))
                            .foregroundStyle(Color(hex: 0xffffff))
                    }
                    .frame(width: 120*scale, height: 120*scale)

                    tonalButton("+30s", scale: scale)
                }
                .padding(.top, 10*scale)  // 控件之间再加一点纵向 padding
                .padding(.bottom, 10)
                // Fullscreen Ghost（描边）
                Button(action: {}) {
                    Text("Fullscreen")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color(hex: 0x47434e))
                        .frame(maxWidth: 220*scale)
                        .frame(height: 64*scale)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12*scale, style: .continuous)
                                .stroke(VP.Colors.outline, lineWidth: 1)
                        )
                }
                .padding(.top, 12*scale)  // 与控制区之间留白
                .frame(height: 30)
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(VP.Colors.background)
        }
    }

    // 浅紫色胶囊按钮
    private func tonalButton(_ title: String, scale: CGFloat) -> some View {
        Text(title)
            .font(.system(size: 18, weight: .semibold))
            .foregroundColor(Color(hex: 0x1d192b))
            .frame(width: 180*scale, height: 96*scale)
            .background(
                RoundedRectangle(cornerRadius: 18*scale, style: .continuous)
                    .fill(VP.Colors.chip)
            )
    }
}

private extension Color {
    init(hex: UInt32) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0
        )
    }
}
