const Colors = {
  primary: '#1E3A8A',
  secondary: '#3B82F6',
  background: '#0F172A',
  surface: '#1E293B',
  surfaceVariant: '#334155',
  outline: '#475569',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onBackground: '#F8FAFC',
  onSurface: '#E2E8F0'
}

const Spacing = {
  sm: 8, md: 12, lg: 16, xl: 24, xxl: 32
}

@Entry
@Component
struct Index {
  @State title: string = 'Journey through the Skies'
  @State currentTime: number = 95
  @State totalTime: number = 240
  @State playing: boolean = false
  @State fullscreen: boolean = false

  formatTime(sec: number): string {
    let total: number = Math.floor(sec)
    if (total < 0) {
      total = 0
    }
    const m: number = Math.floor(total / 60)
    const s: number = total % 60
    let ss: string = s.toString()
    if (s < 10) {
      ss = '0' + ss
    }
    return m + ':' + ss
  }

  build() {
    Column() {
      if (!this.fullscreen) {
        Row() {
          Text('Video Player')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .height(56)
        .backgroundColor(Colors.background)
        .justifyContent(FlexAlign.Center)
      }

      Stack() {
        Text('Video Surface')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(Colors.surfaceVariant)
      .borderRadius(12)

      Column({ space: Spacing.md }) {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        Slider({ value: this.currentTime / this.totalTime, min: 0, max: 1 })
          .width('100%')
          .selectedColor(Colors.primary)
          .trackColor(Colors.outline)
          .blockColor(Colors.primary)
          .onChange((value: number) => {
            this.currentTime = value * this.totalTime
          })
        Row() {
          Text(this.formatTime(this.currentTime))
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
            .opacity(0.7)
          Text(this.formatTime(this.totalTime))
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
            .opacity(0.7)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Row() {
          Button('−10s')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onBackground)
            .backgroundColor(Colors.surfaceVariant)
            .borderRadius(12)
            .height(40)
            .onClick(() => {
              const next: number = this.currentTime - 10
              this.currentTime = next < 0 ? 0 : next
            })
          Button(this.playing ? 'II' : '▶')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onPrimary)
            .backgroundColor(Colors.primary)
            .borderRadius(72)
            .width(72)
            .height(72)
            .onClick(() => { this.playing = !this.playing })
          Button('+30s')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onBackground)
            .backgroundColor(Colors.surfaceVariant)
            .borderRadius(12)
            .height(40)
            .onClick(() => {
              const next: number = this.currentTime + 30
              this.currentTime = next > this.totalTime ? this.totalTime : next
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)

        Row() {
          Button(this.fullscreen ? 'Exit Fullscreen' : 'Fullscreen')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
            .backgroundColor(this.fullscreen ? '#333B82F6' : Colors.surface)
            .borderRadius(12)
            .height(32)
            .onClick(() => { this.fullscreen = !this.fullscreen })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width('100%')
      .padding(Spacing.xl)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
