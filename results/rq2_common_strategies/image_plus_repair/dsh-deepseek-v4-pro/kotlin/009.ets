@Entry
@Component
struct VideoPlayerPage {
  // AppTokens.Colors
  private readonly primary: string = '#1E3A8A'
  private readonly secondary: string = '#3B82F6'
  private readonly colorBackground: string = '#0F172A'
  private readonly surface: string = '#1E293B'
  private readonly surfaceVariant: string = '#334155'
  private readonly colorOutline: string = '#475569'
  private readonly onPrimary: string = '#FFFFFF'
  private readonly onBackground: string = '#F8FAFC'
  private readonly onSurface: string = '#E2E8F0'
  private readonly onSurfaceDim: string = '#A3A9B5'
  private readonly chipSelected: string = '#182C53'

  @State title: string = 'Journey through the Skies'
  @State currentTime: number = 95
  @State totalTime: number = 240
  @State playing: boolean = false
  @State fullscreen: boolean = false

  private formatTime(sec: number): string {
    const total = Math.max(0, Math.floor(sec))
    const m = Math.floor(total / 60)
    const s = total % 60
    return m.toString() + ':' + (s < 10 ? '0' : '') + s.toString()
  }

  build() {
    Column() {
      // Top app bar (hidden in fullscreen)
      if (!this.fullscreen) {
        Row() {
          Text('Video Player')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurface)
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(this.colorBackground)
      }

      Column() {
        // Video surface
        Stack() {
          Text('Video Surface')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurface)
        }
        .width('100%')
        .layoutWeight(1)
        .borderRadius(12)
        .backgroundColor(this.surfaceVariant)

        // Controls
        Column() {
          Text(this.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurface)
            .margin({ bottom: 12 })

          Slider({ value: this.currentTime / this.totalTime, min: 0, max: 1, style: SliderStyle.OutSet })
            .width('100%')
            .selectedColor(this.primary)
            .trackColor(this.colorOutline)
            .blockColor(this.primary)
            .margin({ bottom: 12 })
            .onChange((value: number) => {
              this.currentTime = value * this.totalTime
            })

          Row() {
            Text(this.formatTime(this.currentTime))
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.onSurfaceDim)
            Text(this.formatTime(this.totalTime))
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.onSurfaceDim)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({ bottom: 12 })

          Row() {
            Button('−10s', { type: ButtonType.Normal })
              .borderRadius(12)
              .backgroundColor(this.surfaceVariant)
              .fontColor(this.onSurface)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .onClick(() => {
                this.currentTime = Math.max(0, this.currentTime - 10)
              })

            Button() {
              Text(this.playing ? 'II' : '▶')
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.onPrimary)
            }
            .type(ButtonType.Circle)
            .width(72)
            .height(72)
            .backgroundColor(this.primary)
            .onClick(() => {
              this.playing = !this.playing
            })

            Button('+30s', { type: ButtonType.Normal })
              .borderRadius(12)
              .backgroundColor(this.surfaceVariant)
              .fontColor(this.onSurface)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .onClick(() => {
                this.currentTime = Math.min(this.totalTime, this.currentTime + 30)
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .alignItems(VerticalAlign.Center)
          .margin({ bottom: 12 })

          Row() {
            Text(this.fullscreen ? 'Exit Fullscreen' : 'Fullscreen')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.onSurface)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .borderRadius(12)
              .border({ width: 1, color: this.colorOutline })
              .backgroundColor(this.fullscreen ? this.chipSelected : 'transparent')
              .onClick(() => {
                this.fullscreen = !this.fullscreen
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
        }
        .width('100%')
        .padding(24)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colorBackground)
  }
}
