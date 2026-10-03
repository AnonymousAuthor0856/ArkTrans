const AppColors = {
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

const AppSpacing = {
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32
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
    const total = Math.max(0, Math.floor(sec))
    const m = Math.floor(total / 60)
    const s = total % 60
    return `${m}:${s < 10 ? '0' + s : s}`
  }

  build() {
    Column() {
      if (!this.fullscreen) {
        Text('Video Player')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 16, bottom: 16 })
          .backgroundColor(AppColors.background)
      }

      Column() {
        Text('Video Surface')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(12)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .margin({ left: 12, right: 12, top: 12, bottom: 12 })

      Column({ space: AppSpacing.md }) {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Slider({
          value: this.currentTime / this.totalTime,
          min: 0,
          max: 1,
          style: SliderStyle.OutSet
        })
          .blockColor(AppColors.primary)
          .trackColor(AppColors.outline)
          .selectedColor(AppColors.primary)
          .width('100%')
          .onChange((value: number) => {
            this.currentTime = value * this.totalTime
          })

        Row() {
          Text(this.formatTime(this.currentTime))
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B3E2E8F0')
          Text(this.formatTime(this.totalTime))
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B3E2E8F0')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Row() {
          Button('−10s')
            .type(ButtonType.Normal)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(12)
            .height(40)
            .onClick(() => {
              this.currentTime = Math.max(0, this.currentTime - 10)
            })

          Button(this.playing ? 'II' : '▶')
            .type(ButtonType.Normal)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(36)
            .width(72)
            .height(72)
            .onClick(() => {
              this.playing = !this.playing
            })

          Button('+30s')
            .type(ButtonType.Normal)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(12)
            .height(40)
            .onClick(() => {
              this.currentTime = Math.min(this.totalTime, this.currentTime + 30)
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)

        Row() {
          Text(this.fullscreen ? 'Exit Fullscreen' : 'Fullscreen')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.fullscreen ? AppColors.onSurface : AppColors.onSurface)
            .backgroundColor(this.fullscreen ? '#333B82F6' : AppColors.surface)
            .border({ width: 1, color: AppColors.outline, radius: 16 })
            .padding({ left: 12, right: 12, top: 6, bottom: 6 })
            .onClick(() => {
              this.fullscreen = !this.fullscreen
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .padding(AppSpacing.xl)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}