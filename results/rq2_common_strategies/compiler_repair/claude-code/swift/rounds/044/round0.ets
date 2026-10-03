import promptAction from '@ohos.promptAction'

const AppTokens = {
  Colors: {
    primary: '#FF7042',
    secondary: '#FFB84D',
    tertiary: '#FFD180',
    background: '#FFF2E0',
    surface: '#FFFFFF',
    surfaceVariant: '#FFE0B3',
    outline: '#D6CCC7',
    success: '#66BA6B',
    warning: '#FFC929',
    error: '#D42E2E',
    onPrimary: '#FFFFFF',
    onSecondary: '#3D2624',
    onBackground: '#3D2624',
    onSurface: '#3D2624'
  },
  Shapes: {
    small: 6,
    medium: 10,
    large: 16
  },
  Spacing: {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24
  }
}

@Component
struct CustomSlider {
  @Link value: number
  activeColor: ResourceColor = '#FF7042'
  inactiveColor: ResourceColor = '#FFE0B3'
  thumbColor: ResourceColor = '#FF7042'

  private trackHeight: number = 10
  private thumbDiameter: number = 20
  @State trackWidth: number = 0
  @State startValue: number = 0

  build() {
    Stack({ alignContent: Alignment.CenterStart }) {
      Column()
        .width('100%')
        .height(this.trackHeight)
        .backgroundColor(this.inactiveColor)
        .borderRadius(this.trackHeight / 2)

      Column()
        .width(this.value * 100 + '%')
        .height(this.trackHeight)
        .backgroundColor(this.activeColor)
        .borderRadius(this.trackHeight / 2)

      Column()
        .width(this.thumbDiameter)
        .height(this.thumbDiameter)
        .backgroundColor(this.thumbColor)
        .borderRadius(this.thumbDiameter / 2)
        .translate({
          x: this.value * this.trackWidth - this.thumbDiameter / 2,
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
      this.trackWidth = newValue.width
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.42

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column({ space: AppTokens.Spacing.lg }) {
        Text('Order Tracking')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        Column({ space: AppTokens.Spacing.md }) {
          Text('Order #25491')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)

          Text('Estimated Delivery: 2 days')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppTokens.Colors.secondary)
            .width('100%')
            .textAlign(TextAlign.Start)

          Stack({ alignContent: Alignment.CenterStart }) {
            Column()
              .width('100%')
              .height(10)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(5)

            Column()
              .width(this.progress * 100 + '%')
              .height(10)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(5)
          }
          .width('100%')
          .height(10)

          Row() {
            Text('Processing')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.secondary)

            Blank()

            Text(Math.floor(this.progress * 100).toString() + '%')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.primary)
          }
          .width('100%')
        }
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: 8,
          color: 'rgba(0, 0, 0, 0.15)',
          offsetX: 0,
          offsetY: 4
        })

        Column({ space: AppTokens.Spacing.md }) {
          Text('Adjust Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Center)

          CustomSlider({
            value: $progress,
            activeColor: AppTokens.Colors.primary,
            inactiveColor: AppTokens.Colors.surfaceVariant,
            thumbColor: AppTokens.Colors.primary
          })

          Button('Mark as Delivered')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .width('100%')
            .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
            .onClick(() => {
              this.progress = 1.0
            })
        }
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .margin({ top: 56 })
    }
    .width('100%')
    .height('100%')
  }
}
