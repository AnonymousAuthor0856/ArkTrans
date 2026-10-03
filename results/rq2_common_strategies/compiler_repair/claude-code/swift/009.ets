import display from '@ohos.display'

@Entry
@Component
struct VideoPlayerRoot {
  private videoSurfaceRatio: number = 0.50

  @State scaleFactor: number = 1.0
  @State screenWidth: number = 720
  @State screenHeight: number = 1280

  private get padX(): number {
    return 24 * this.scaleFactor
  }

  private get contentWidth(): number {
    return this.screenWidth - 2 * this.padX
  }

  private get leftCapsuleWidth(): number {
    return this.contentWidth * 0.40
  }

  private get rightTrackWidth(): number {
    return this.contentWidth * 0.47
  }

  aboutToAppear() {
    try {
      let disp = display.getDefaultDisplaySync()
      this.screenWidth = disp.width
      this.screenHeight = disp.height
      this.scaleFactor = Math.min(this.screenWidth / 720.0, this.screenHeight / 1280.0)
    } catch (e) {
      this.scaleFactor = 1.0
    }
  }

  build() {
    Column() {
      Text('Video Player')
        .fontSize(18 * this.scaleFactor)
        .fontWeight(FontWeight.Medium)
        .fontColor('#E2E8F0')
        .height(56 * this.scaleFactor)
        .padding({ top: 12 * this.scaleFactor, bottom: 12 * this.scaleFactor })

      // Video Surface
      Row() {
        Column() {
          Text('Video Surface')
            .fontSize(16 * this.scaleFactor)
            .fontWeight(FontWeight.Medium)
            .fontColor('rgba(226, 232, 240, 0.9)')
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .height(Math.max(this.screenHeight * this.videoSurfaceRatio, 360 * this.scaleFactor))
      .width('100%')
      .backgroundColor('#334155')
      .borderRadius(24 * this.scaleFactor)
      .padding({ right: 10 })

      // Title
      Text('Journey through the Skies')
        .fontSize(18 * this.scaleFactor)
        .fontWeight(FontWeight.Medium)
        .fontColor('#E0E8F0')
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })

      // Progress area
      Column() {
        Row() {
          Blank()
          // Left capsule
          Row()
            .width(this.leftCapsuleWidth)
            .height(32 * this.scaleFactor)
            .backgroundColor('#1E3A8A')
            .borderRadius(16 * this.scaleFactor)

          // Vertical bar
          Row()
            .width(6 * this.scaleFactor)
            .height(72 * this.scaleFactor)
            .backgroundColor('#1E3A8A')
            .borderRadius(3 * this.scaleFactor)
            .margin({ left: 18 * this.scaleFactor, right: 18 * this.scaleFactor })

          // Right track with blue dot
          Stack({ alignContent: Alignment.End }) {
            Row()
              .width(this.rightTrackWidth)
              .height(32 * this.scaleFactor)
              .backgroundColor('#475569')
              .borderRadius(16 * this.scaleFactor)

            Circle()
              .width(12 * this.scaleFactor)
              .height(12 * this.scaleFactor)
              .fill('#1E3A8A')
              .margin({ right: 10 * this.scaleFactor })
          }
          .width(this.rightTrackWidth)
          .height(32 * this.scaleFactor)

          Blank()
        }
        .width('100%')

        // Time labels
        Row() {
          Text('1:35')
            .fontSize(12 * this.scaleFactor)
            .fontWeight(FontWeight.Medium)
            .fontColor('#A3AAB5')
            .padding({ left: 10 })

          Blank()

          Text('4:00')
            .fontSize(12 * this.scaleFactor)
            .fontWeight(FontWeight.Medium)
            .fontColor('#A3AAB5')
            .padding({ right: 10 })
        }
        .width('100%')
        .margin({ top: 10 * this.scaleFactor })
      }
      .width('100%')
      .padding({ left: this.padX, right: this.padX })
      .padding({ top: 8 * this.scaleFactor, bottom: 6 * this.scaleFactor })

      // Control buttons: -10s / Play / +30s
      Row() {
        this.TonalButton('−10s')

        // Play button (large circle)
        Stack() {
          Circle()
            .width(120 * this.scaleFactor)
            .height(120 * this.scaleFactor)
            .fill('#1E3A8A')

          Text('\u{25B6}')
            .fontSize(40 * this.scaleFactor)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .margin({ left: 6 * this.scaleFactor })
        }
        .width(120 * this.scaleFactor)
        .height(120 * this.scaleFactor)

        this.TonalButton('+30s')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: 10 * this.scaleFactor, bottom: 10 })

      // Fullscreen button (outlined)
      Button('Fullscreen')
        .fontSize(18 * this.scaleFactor)
        .fontWeight(FontWeight.Medium)
        .fontColor('#47434E')
        .width(220 * this.scaleFactor)
        .height(64 * this.scaleFactor)
        .backgroundColor('#00000000')
        .borderRadius(12 * this.scaleFactor)
        .border({ width: 1, color: '#475569' })
        .margin({ top: 12 * this.scaleFactor })
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
      .fontSize(18 * this.scaleFactor)
      .fontWeight(FontWeight.Medium)
      .fontColor('#1D192B')
      .width(180 * this.scaleFactor)
      .height(96 * this.scaleFactor)
      .textAlign(TextAlign.Center)
      .backgroundColor('#E8DEF8')
      .borderRadius(18 * this.scaleFactor)
  }
}
