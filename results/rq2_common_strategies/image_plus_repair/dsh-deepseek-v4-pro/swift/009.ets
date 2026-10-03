// 源文件：SwiftUI 视频播放器界面（009.swift）
// @main struct VideoPlayerApp: App → ArkTS @Entry 页面入口
// 原 Swift 的 private struct VP / VP.Colors 颜色常量已内联为十六进制字符串，避免命名冲突

@Entry
@Component
struct VideoPlayerApp {
  @State private sw: number = 0;
  @State private sh: number = 0;

  // 浅紫色胶囊按钮（原 private func tonalButton）
  @Builder
  buildTonalButton(title: string, factor: number) {
    Stack() {
      Text(title)
        .fontSize(18)
        .fontWeight(600)
        .fontColor('#1D192B')
    }
    .width(180 * factor)
    .height(96 * factor)
    .backgroundColor('#E8DEF8')  // chip 浅紫色按钮底
    .borderRadius(18 * factor)
  }

  // 原标定 720×1280，保留 scale 用于圆角/字号等
  private scaleFactor(): number {
    return Math.min(this.sw / 720.0, this.sh / 1280.0);
  }

  private padX(): number {
    return 24.0 * this.scaleFactor();
  }

  private titleH(): number {
    return 56.0 * this.scaleFactor();
  }

  private contentW(): number {
    return this.sw - 2 * this.padX();
  }

  private leftW(): number {
    return this.contentW() * 0.40;
  }

  private rightW(): number {
    return this.contentW() * 0.47;
  }

  build() {
    Column({ space: 10 }) {
      // 顶部标题
      Stack() {
        Text('Video Player')
          .fontSize(18)
          .fontWeight(600)
          .fontColor('#E2E8F0')
      }
      .height(this.titleH())
      .padding({ top: 12, bottom: 12 })

      // Video Surface（占近半屏）
      Stack() {
        Text('Video Surface')
          .fontSize(16)
          .fontWeight(500)
          .fontColor('#E2E8F0')   // onSurface
          .opacity(0.9)
      }
      .width('100%')
      .height(300)
      .backgroundColor('#334155')  // surfaceVariant
      .borderRadius(24 * this.scaleFactor())
      .padding({ right: 10 })

      // 片名
      Text('Journey through the Skies')
        .fontSize(18)
        .fontWeight(600)
        .fontColor('#E0E8F0')
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })

      // ===== 进度区域（上：左胶囊 + 竖条 + 右轨 + 蓝点）=====
      Column({ space: 10 * this.scaleFactor() }) {
        Row({ space: 18 * this.scaleFactor() }) {
          // 左胶囊
          Column()
            .width(this.leftW())
            .height(32 * this.scaleFactor())
            .backgroundColor('#1E3A8A')  // primary
            .borderRadius(16 * this.scaleFactor())

          // 竖条
          Column()
            .width(6 * this.scaleFactor())
            .height(72 * this.scaleFactor())
            .backgroundColor('#1E3A8A')  // primary
            .borderRadius(3 * this.scaleFactor())

          // 右轨 + 蓝点
          Stack({ alignContent: Alignment.End }) {
            Column()
              .width(this.rightW())
              .height(32 * this.scaleFactor())
              .backgroundColor('#475569')
              .borderRadius(16 * this.scaleFactor())
            Column()
              .width(12 * this.scaleFactor())
              .height(12 * this.scaleFactor())
              .backgroundColor('#1E3A8A')  // primary
              .borderRadius(6 * this.scaleFactor())
              .offset({ x: -10 * this.scaleFactor() })
          }
          .width(this.rightW())
          .height(32 * this.scaleFactor())
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Row() {
          Text('1:35')
            .fontSize(12)
            .fontWeight(500)
            .fontColor('#A3AAB5')
            .padding({ left: 10 })
          Blank()
          Text('4:00')
            .fontSize(12)
            .fontWeight(500)
            .fontColor('#A3AAB5')
            .padding({ right: 10 })
        }
        .width('100%')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding({
        left: this.padX(),
        right: this.padX(),
        top: 8 * this.scaleFactor(),   // 控件之间加纵向 padding
        bottom: 6 * this.scaleFactor()
      })

      // ===== 控制区：-10s / Play / +30s =====
      Row({ space: 24 * this.scaleFactor() }) {
        this.buildTonalButton('−10s', this.scaleFactor())

        // 播放按钮（原 Image(systemName: "play.fill") → 文本 ▶ 代替）
        Stack() {
          Column()
            .width(120 * this.scaleFactor())
            .height(120 * this.scaleFactor())
            .backgroundColor('#1E3A8A')  // primary
            .borderRadius(60 * this.scaleFactor())
          Text('▶')
            .fontSize(40 * this.scaleFactor())
            .fontWeight(700)
            .fontColor('#FFFFFF')
        }
        .width(120 * this.scaleFactor())
        .height(120 * this.scaleFactor())

        this.buildTonalButton('+30s', this.scaleFactor())
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: 10 * this.scaleFactor(), bottom: 10 })  // 控件之间再加一点纵向 padding

      // Fullscreen Ghost（描边）
      Button({ type: ButtonType.Normal }) {
        Stack() {
          Text('Fullscreen')
            .fontSize(18)
            .fontWeight(600)
            .fontColor('#47434E')
        }
        .constraintSize({ maxWidth: 220 * this.scaleFactor() })
        .height(64 * this.scaleFactor())
        .border({ width: 1, color: '#475569', radius: 12 * this.scaleFactor() })  // outline
      }
      .onClick(() => {})
      .padding({ top: 12 * this.scaleFactor() })  // 与控制区之间留白
      .height(30)

      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0F172A')  // background
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.sw = Number(newValue.width);
      this.sh = Number(newValue.height);
    })
  }
}
