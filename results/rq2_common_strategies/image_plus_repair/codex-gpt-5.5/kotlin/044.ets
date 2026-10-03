class AppColors {
  static readonly primary: string = '#FFFF7043'
  static readonly secondary: string = '#FFFFB74D'
  static readonly background: string = '#FFFFF3E0'
  static readonly surface: string = '#FFFFFFFF'
  static readonly surfaceVariant: string = '#FFFFE0B2'
  static readonly onPrimary: string = '#FFFFFFFF'
  static readonly onBackground: string = '#FF3E2723'
  static readonly onSurface: string = '#FF3E2723'
}

@Entry
@Component
struct RootScreen {
  @State private progress: number = 0.42
  @State private sliderWidth: number = 0

  private progressLabel(): string {
    return `${Math.floor(this.progress * 100)}%`
  }

  private toNumber(value: string | number): number {
    if (typeof value === 'number') {
      return value
    }
    const parsed = Number.parseFloat(value)
    return Number.isNaN(parsed) ? 0 : parsed
  }

  private updateProgressFromX(x: number): void {
    const width = this.sliderWidth > 0 ? this.sliderWidth : 592
    this.progress = Math.max(0, Math.min(1, x / width))
  }

  @Builder
  private ProgressTrack() {
    Row() {
      Row()
        .height(20)
        .width(`${this.progress * 100}%`)
        .backgroundColor(AppColors.primary)
        .borderRadius(10)

      Row() {
        Circle()
          .width(8)
          .height(8)
          .fill(AppColors.primary)
      }
      .height(20)
      .layoutWeight(1)
      .justifyContent(FlexAlign.End)
      .alignItems(VerticalAlign.Center)
      .padding({ right: 6 })
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(10)
      .margin({ left: 8 })
    }
    .width('100%')
    .height(20)
    .clip(true)
  }

  @Builder
  private ProgressSlider() {
    Stack() {
      Row() {
        Row()
          .height(32)
          .width(`${Math.max(0, this.progress * 100 - 3)}%`)
          .backgroundColor(AppColors.primary)
          .borderRadius(16)

        Blank()
          .layoutWeight(1)
      }
      .width('100%')
      .height(32)
      .position({ x: 0, y: 28 })

      Row() {
        Blank()
          .layoutWeight(1)

        Row() {
          Circle()
            .width(8)
            .height(8)
            .fill(AppColors.primary)
        }
        .height(32)
        .width(`${Math.max(0, 100 - this.progress * 100 - 3)}%`)
        .justifyContent(FlexAlign.End)
        .alignItems(VerticalAlign.Center)
        .padding({ right: 14 })
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(16)
      }
      .width('100%')
      .height(32)
      .position({ x: 0, y: 28 })

      Row()
        .width(8)
        .height(88)
        .backgroundColor(AppColors.primary)
        .borderRadius(4)
        .position({ x: `${this.progress * 100}%`, y: 0 })
    }
    .width('100%')
    .height(88)
    .onAreaChange((_oldArea: Area, newArea: Area) => {
      this.sliderWidth = this.toNumber(newArea.width as string | number)
    })
    .gesture(
      PanGesture()
        .onActionStart((event: GestureEvent) => {
          const finger = event.fingerList[0]
          if (finger !== undefined) {
            this.updateProgressFromX(finger.localX)
          }
        })
        .onActionUpdate((event: GestureEvent) => {
          const finger = event.fingerList[0]
          if (finger !== undefined) {
            this.updateProgressFromX(finger.localX)
          }
        })
    )
  }

  build() {
    Column({ space: 32 }) {
      Text('Order Tracking')
        .fontSize(56)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .width('100%')
        .height(66)
        .lineHeight(66)
        .margin({ top: 10 })

      Column({ space: 20 }) {
        Text('Order #25491')
          .fontSize(36)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .height(48)
          .lineHeight(48)

        Text('Estimated Delivery: 2 days')
          .fontSize(28)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.secondary)
          .width('100%')
          .height(36)
          .lineHeight(36)

        this.ProgressTrack()

        Row() {
          Text('Processing')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.secondary)

          Text(this.progressLabel())
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)
        }
        .width('100%')
        .height(32)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding({ left: 32, right: 32, top: 32, bottom: 28 })
      .backgroundColor(AppColors.surface)
      .borderRadius(32)
      .shadow({
        radius: 16,
        color: '#26000000',
        offsetX: 0,
        offsetY: 8
      })

      Column({ space: 38 }) {
        Text('Adjust Progress')
          .fontSize(36)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .height(52)
          .lineHeight(52)
          .textAlign(TextAlign.Center)

        this.ProgressSlider()

        Button('Mark as Delivered', { type: ButtonType.Normal, stateEffect: true })
          .width('100%')
          .height(80)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(20)
          .onClick(() => {
            this.progress = 1
          })
      }
      .width('100%')
      .padding({ left: 32, right: 32, top: 32, bottom: 40 })
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppColors.surface)
      .borderRadius(32)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 32, right: 32, top: 32, bottom: 32 })
    .backgroundColor(AppColors.background)
    .alignItems(HorizontalAlign.Start)
  }
}
