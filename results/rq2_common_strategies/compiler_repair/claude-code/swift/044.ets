import promptAction from '@ohos.promptAction'

class ColorTokens {
  static primary: string = '#FF7042'
  static secondary: string = '#FFB84D'
  static tertiary: string = '#FFD180'
  static background: string = '#FFF2E0'
  static surface: string = '#FFFFFF'
  static surfaceVariant: string = '#FFE0B3'
  static outline: string = '#D6CCC7'
  static success: string = '#66BA6B'
  static warning: string = '#FFC929'
  static error: string = '#D42E2E'
  static onPrimary: string = '#FFFFFF'
  static onSecondary: string = '#3D2624'
  static onBackground: string = '#3D2624'
  static onSurface: string = '#3D2624'
}

class ShapeTokens {
  static small: number = 6
  static medium: number = 10
  static large: number = 16
}

class SpacingTokens {
  static sm: number = 6
  static md: number = 10
  static lg: number = 16
  static xl: number = 24
}

@Component
struct CustomSlider {
  @Link value: number
  activeColor: string = ColorTokens.primary
  inactiveColor: string = ColorTokens.surfaceVariant
  thumbColor: string = ColorTokens.primary

  private trackHeight: number = 10
  private thumbDiameter: number = 20
  @State trackWidth: number = 0
  @State startValue: number = 0

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Column()
        .width('100%')
        .height(this.trackHeight)
        .backgroundColor(this.inactiveColor)
        .borderRadius(this.trackHeight / 2)

      Column()
        .width(this.trackWidth * this.value)
        .height(this.trackHeight)
        .backgroundColor(this.activeColor)
        .borderRadius(this.trackHeight / 2)

      Column()
        .width(this.thumbDiameter)
        .height(this.thumbDiameter)
        .backgroundColor(this.thumbColor)
        .borderRadius(this.thumbDiameter / 2)
        .translate({
          x: this.trackWidth * this.value - this.thumbDiameter / 2,
          y: 0
        })
        .gesture(
          PanGesture()
            .onActionStart(() => {
              this.startValue = this.value
            })
            .onActionUpdate((event: GestureEvent) => {
              if (this.trackWidth > 0) {
                let delta: number = event.offsetX / this.trackWidth
                let newValue: number = this.startValue + delta
                newValue = Math.min(1, Math.max(0, newValue))
                this.value = newValue
              }
            })
        )
    }
    .width('100%')
    .height(this.thumbDiameter)
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.trackWidth = Number(newValue.width)
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.42
  @State barWidth: number = 0

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(ColorTokens.background)

      Column({ space: SpacingTokens.lg }) {
        Text('Order Tracking')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(ColorTokens.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        Column({ space: SpacingTokens.md }) {
          Text('Order #25491')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(ColorTokens.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)

          Text('Estimated Delivery: 2 days')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(ColorTokens.secondary)
            .width('100%')
            .textAlign(TextAlign.Start)

          Stack({ alignContent: Alignment.Start }) {
            Column()
              .width('100%')
              .height(10)
              .backgroundColor(ColorTokens.surfaceVariant)
              .borderRadius(5)

            Column()
              .width(this.barWidth * this.progress)
              .height(10)
              .backgroundColor(ColorTokens.primary)
              .borderRadius(5)
          }
          .width('100%')
          .height(10)
          .onAreaChange((oldValue: Area, newValue: Area) => {
            this.barWidth = Number(newValue.width)
          })

          Row() {
            Text('Processing')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(ColorTokens.secondary)

            Blank()

            Text(Math.floor(this.progress * 100).toString() + '%')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(ColorTokens.primary)
          }
          .width('100%')
        }
        .padding(SpacingTokens.lg)
        .backgroundColor(ColorTokens.surface)
        .borderRadius(ShapeTokens.large)
        .shadow({
          radius: 8,
          color: 'rgba(0, 0, 0, 0.15)',
          offsetX: 0,
          offsetY: 4
        })

        Column({ space: SpacingTokens.md }) {
          Text('Adjust Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(ColorTokens.onSurface)
            .width('100%')
            .textAlign(TextAlign.Center)

          CustomSlider({
            value: $progress,
            activeColor: ColorTokens.primary,
            inactiveColor: ColorTokens.surfaceVariant,
            thumbColor: ColorTokens.primary
          })

          Button('Mark as Delivered')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(ColorTokens.onPrimary)
            .backgroundColor(ColorTokens.primary)
            .borderRadius(ShapeTokens.medium)
            .width('100%')
            .height(40)
            .onClick(() => {
              this.progress = 1.0
            })
        }
        .padding(SpacingTokens.lg)
        .backgroundColor(ColorTokens.surface)
        .borderRadius(ShapeTokens.large)
      }
      .padding(SpacingTokens.lg)
      .width('100%')
      .margin({ top: 56 })
    }
    .width('100%')
    .height('100%')
  }
}
