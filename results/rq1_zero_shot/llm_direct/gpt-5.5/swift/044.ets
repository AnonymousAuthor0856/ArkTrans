class AppTokens {
  static readonly Colors = {
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
  }

  static readonly TypographyTokens = {
    displaySize: 28,
    displayWeight: FontWeight.Bold,
    titleSize: 18,
    titleWeight: FontWeight.Medium,
    bodySize: 14,
    bodyWeight: FontWeight.Regular,
    labelSize: 12,
    labelWeight: FontWeight.Medium
  }

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 16
  }

  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24
  }
}

function clamp(value: number, min: number, max: number): number {
  return Math.min(Math.max(value, min), max)
}

@Component
struct ProgressBar {
  @Prop value: number
  @State private barWidth: number = 0

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(10)
        .borderRadius(5)
        .backgroundColor(AppTokens.Colors.surfaceVariant)

      Row()
        .width(this.barWidth * clamp(this.value, 0, 1))
        .height(10)
        .borderRadius(5)
        .backgroundColor(AppTokens.Colors.primary)
    }
    .width('100%')
    .height(10)
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.barWidth = Number(newValue.width)
    })
  }
}

@Component
struct CustomSlider {
  @Link value: number

  private activeColor: ResourceColor = AppTokens.Colors.primary
  private inactiveColor: ResourceColor = AppTokens.Colors.surfaceVariant
  private thumbColor: ResourceColor = AppTokens.Colors.primary
  private trackHeight: number = 10
  private thumbDiameter: number = 20

  @State private trackWidth: number = 0

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(this.trackHeight)
        .borderRadius(this.trackHeight / 2)
        .backgroundColor(this.inactiveColor)

      Row()
        .width(this.trackWidth * clamp(this.value, 0, 1))
        .height(this.trackHeight)
        .borderRadius(this.trackHeight / 2)
        .backgroundColor(this.activeColor)

      Circle()
        .width(this.thumbDiameter)
        .height(this.thumbDiameter)
        .fill(this.thumbColor)
        .translate({
          x: this.trackWidth * clamp(this.value, 0, 1) - this.thumbDiameter / 2
        })
    }
    .width('100%')
    .height(this.thumbDiameter)
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.trackWidth = Number(newValue.width)
    })
    .onTouch((event: TouchEvent) => {
      if ((event.type === TouchType.Down || event.type === TouchType.Move) &&
        this.trackWidth > 0 &&
        event.touches.length > 0) {
        this.value = clamp(event.touches[0].x / this.trackWidth, 0, 1)
      }
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State private progress: number = 0.42

  build() {
    Stack() {
      Column({ space: AppTokens.Spacing.lg }) {
        Text('Order Tracking')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(AppTokens.TypographyTokens.displayWeight)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        Column({ space: AppTokens.Spacing.md }) {
          Text('Order #25491')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)

          Text('Estimated Delivery: 2 days')
            .fontSize(AppTokens.TypographyTokens.bodySize)
            .fontWeight(AppTokens.TypographyTokens.bodyWeight)
            .fontColor(AppTokens.Colors.secondary)
            .width('100%')
            .textAlign(TextAlign.Start)

          ProgressBar({ value: this.progress })

          Row() {
            Text('Processing')
              .fontSize(AppTokens.TypographyTokens.labelSize)
              .fontWeight(AppTokens.TypographyTokens.labelWeight)
              .fontColor(AppTokens.Colors.secondary)

            Blank()

            Text(`${Math.floor(this.progress * 100)}%`)
              .fontSize(AppTokens.TypographyTokens.labelSize)
              .fontWeight(AppTokens.TypographyTokens.labelWeight)
              .fontColor(AppTokens.Colors.primary)
          }
          .width('100%')
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: 8,
          color: '#26000000',
          offsetX: 0,
          offsetY: 4
        })

        Column({ space: AppTokens.Spacing.md }) {
          Text('Adjust Progress')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Center)

          CustomSlider({
            value: this.$progress,
            activeColor: AppTokens.Colors.primary,
            inactiveColor: AppTokens.Colors.surfaceVariant,
            thumbColor: AppTokens.Colors.primary
          })

          Button() {
            Text('Mark as Delivered')
              .fontSize(AppTokens.TypographyTokens.labelSize)
              .fontWeight(AppTokens.TypographyTokens.labelWeight)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .type(ButtonType.Normal)
          .width('100%')
          .padding({
            top: AppTokens.Spacing.md,
            bottom: AppTokens.Spacing.md
          })
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {
            this.progress = 1.0
          })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}