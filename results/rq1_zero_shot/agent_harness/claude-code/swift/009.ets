@Entry
@Component
struct VideoPlayerRoot {
  private videoSurfaceRatio: number = 0.50

  @State scale: number = 1.0
  @State sw: number = 720
  @State sh: number = 1280

  aboutToAppear() {
    try {
      let display = display.getDefaultDisplaySync()
      this.sw = display.width
      this.sh = display.height
      this.scale = Math.min(this.sw / 720.0, this.sh / 1280.0)
    } catch (e) {
      this.scale = 1.0
    }
  }

  build() {
    Column() {
      Text('Video Player')
        .fontSize(18 * this.scale)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#E2E8F0')
        .height(56 * this.scale)
        .padding({ top: 12 * this.scale, bottom: 12 * this.scale })

      // Video Surface
      Row() {
        Column() {
          Text('Video Surface')
            .fontSize(16 * this.scale)
            .fontWeight(FontWeight.Medium)
            .fontColor('rgba(226, 232, 240, 0.9)')
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .height(Math.max(this.sh * this.videoSurfaceRatio, 360 * this.scale))
      .width('100%')
      .backgroundColor('#334155')
      .borderRadius(24 * this.scale)
      .padding({ right: 10 })

      // Title
      Text('Journey through the Skies')
        .fontSize(18 * this.scale)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#E0E8F0')
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })

      // Progress area
      Column() {
        let padX: number = 24 * this.scale
        let contentW: number = this.sw - 2 * padX
        let leftW: number = contentW * 0.40
        let rightW: number = contentW * 0.47

        Row() {
          Blank()
          // Left capsule
          Row()
            .width(leftW)
            .height(32 * this.scale)
            .backgroundColor('#1E3A8A')
            .borderRadius(16 * this.scale)

          // Vertical bar
          Row()
            .width(6 * this.scale)
            .height(72 * this.scale)
            .backgroundColor('#1E3A8A')
            .borderRadius(3 * this.scale)
            .margin({ left: 18 * this.scale, right: 18 * this.scale })

          // Right track with blue dot
          Stack({ alignContent: Alignment.End }) {
            Row()
              .width(rightW)
              .height(32 * this.scale)
              .backgroundColor('#475569')
              .borderRadius(16 * this.scale)

            Circle()
              .width(12 * this.scale)
              .height(12 * this.scale)
              .fill('#1E3A8A')
              .margin({ right: 10 * this.scale })
          }
          .width(rightW)
          .height(32 * this.scale)

          Blank()
        }
        .width('100%')

        // Time labels
        Row() {
          Text('1:35')
            .fontSize(12 * this.scale)
            .fontWeight(FontWeight.Medium)
            .fontColor('#A3AAB5')
            .padding({ left: 10 })

          Blank()

          Text('4:00')
            .fontSize(12 * this.scale)
            .fontWeight(FontWeight.Medium)
            .fontColor('#A3AAB5')
            .padding({ right: 10 })
        }
        .width('100%')
        .margin({ top: 10 * this.scale })
      }
      .width('100%')
      .padding({ left: 24 * this.scale, right: 24 * this.scale })
      .padding({ top: 8 * this.scale, bottom: 6 * this.scale })

      // Control buttons: -10s / Play / +30s
      Row() {
        this.TonalButton('−10s')

        // Play button (large circle)
        Stack() {
          Circle()
            .width(120 * this.scale)
            .height(120 * this.scale)
            .fill('#1E3A8A')

          Text('\u{25B6}')
            .fontSize(40 * this.scale)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .margin({ left: 6 * this.scale })
        }
        .width(120 * this.scale)
        .height(120 * this.scale)

        this.TonalButton('+30s')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: 10 * this.scale, bottom: 10 })

      // Fullscreen button (outlined)
      Button('Fullscreen')
        .fontSize(18 * this.scale)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#47434E')
        .width(220 * this.scale)
        .height(64 * this.scale)
        .backgroundColor(Color.Transparent)
        .borderRadius(12 * this.scale)
        .border({ width: 1, color: '#475569' })
        .padding({ top: 12 * this.scale })
        .onClick(() => {})

      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0F172A')
  }

  @Builder
  TonalButton(title: string) {
    Text(title)
      .fontSize(18 * this.scale)
      .fontWeight(FontWeight.SemiBold)
      .fontColor('#1D192B')
      .width(180 * this.scale)
      .height(96 * this.scale)
      .textAlign(TextAlign.Center)
      .backgroundColor('#E8DEF8')
      .borderRadius(18 * this.scale)
  }
}
