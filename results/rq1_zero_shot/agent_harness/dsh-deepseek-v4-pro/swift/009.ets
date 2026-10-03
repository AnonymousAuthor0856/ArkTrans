// Video Player UI (SwiftUI -> ArkTS).

class VP {
  // 一处改比值即可（0.48~0.55 都可按需微调）
  static readonly VIDEO_SURFACE_RATIO: number = 0.50;

  static readonly Colors = {
    primary: '#1E3A8A',        // 深蓝（主色）
    background: '#0F172A',     // 背景
    surface: '#1E293B',        // 深色块
    surfaceVariant: '#334155', // 次级深色块
    outline: '#475569',        // 轮廓描边
    onSurface: '#E2E8F0',      // 文本
    chip: '#E8DEF8'            // 浅紫色按钮底
  };
}

@Entry
@Component
struct VideoPlayerRoot {
  @State sw: number = 720;
  @State sh: number = 1280;

  @Builder
  tonalButton(title: string, scale: number, textColor: string) {
    Text(title)
      .fontSize(18)
      .fontWeight(FontWeight.Semibold)
      .fontColor(textColor)
      .width(180 * scale)
      .height(96 * scale)
      .backgroundColor(VP.Colors.chip)
      .borderRadius(18 * scale)
  }

  build() {
    const sw: number = this.sw;
    const sh: number = this.sh;
    // 原标定 720×1280，保留 scale 用于圆角/字号等
    const scale: number = Math.min(sw / 720.0, sh / 1280.0);
    const padX: number = 24.0 * scale;
    const titleH: number = 56.0 * scale;
    // —— 关键：视频容器高度按“屏幕高度比例”设定 —— //
    // const videoH = Math.max(sh * VP.VIDEO_SURFACE_RATIO, 360 * scale)
    const contentW: number = sw - 2 * padX;
    const leftW: number = contentW * 0.40;
    const rightW: number = contentW * 0.47;

    Stack() {
      Column({ space: 10 }) {
        // 顶部标题
        Text('Video Player')
          .fontSize(18)
          .fontWeight(FontWeight.Semibold)
          .fontColor('#E2E8F0')
          .height(titleH)
          .padding({ top: 12, bottom: 12 })

        // Video Surface（占近半屏）
        Stack() {
          Text('Video Surface')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(VP.Colors.onSurface)
            .opacity(0.9)
        }
        .height(300)
        .padding({ right: 10 })
        .backgroundColor(VP.Colors.surfaceVariant)
        .borderRadius(24 * scale)

        // 片名
        Text('Journey through the Skies')
          .fontSize(18)
          .fontWeight(FontWeight.Semibold)
          .fontColor('#E0E8F0')
          .width('100%')
          .textAlign(TextAlign.Start)
          .padding({ left: 20, right: 20, top: 10, bottom: 10 })

        // ===== 进度区域（上：左胶囊 + 竖条 + 右轨 + 蓝点）=====
        Column({ space: 10 * scale }) {
          Row({ space: 18 * scale }) {
            Blank()
            Row()
              .width(leftW)
              .height(32 * scale)
              .backgroundColor(VP.Colors.primary)
              .borderRadius(16 * scale)

            Row()
              .width(6 * scale)
              .height(72 * scale)
              .backgroundColor(VP.Colors.primary)
              .borderRadius(3 * scale)

            Stack({ alignContent: Alignment.End }) {
              Row()
                .width(rightW)
                .height(32 * scale)
                .backgroundColor('#475569')
                .borderRadius(16 * scale)
              Circle()
                .width(12 * scale)
                .height(12 * scale)
                .fill(VP.Colors.primary)
                .margin({ right: 10 * scale })
            }
            Blank()
          }

          Row() {
            Text('1:35')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#A3AAB5')
              .padding({ left: 10 })
            Blank()
            Text('4:00')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#A3AAB5')
              .padding({ right: 10 })
          }
        }
        .alignItems(HorizontalAlign.Start)
        .padding({ left: padX, right: padX, top: 8 * scale, bottom: 6 * scale })

        // ===== 控制区：-10s / Play / +30s =====
        Row({ space: 24 * scale }) {
          this.tonalButton('−10s', scale, '#000000')

          Stack() {
            Circle().fill(VP.Colors.primary)
            Text('▶')
              .fontSize(40 * scale)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
          }
          .width(120 * scale)
          .height(120 * scale)

          this.tonalButton('+30s', scale, '#1D192B')
        }
        .padding({ top: 10 * scale, bottom: 10 })

        // Fullscreen Ghost（描边）
        Button('Fullscreen')
          .fontSize(18)
          .fontWeight(FontWeight.Semibold)
          .fontColor('#47434E')
          .width(220 * scale)
          .height(64 * scale)
          .border({ width: 1, color: VP.Colors.outline })
          .borderRadius(12 * scale)
          .onClick(() => {})
        .padding({ top: 12 * scale })

        Blank()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(VP.Colors.background)
    }
    .width('100%')
    .height('100%')
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.sw = newValue.width as number;
      this.sh = newValue.height as number;
    })
  }
}
