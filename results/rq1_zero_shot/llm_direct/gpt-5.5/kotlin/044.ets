const NAME: string = '058*OrderTracking*en'
const UI_TYPE: string = 'ECommerce'
const STYLE_THEME: string = 'Retro Flat'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class AppTokens {
  static Colors = {
    primary: '#FF7043',
    secondary: '#FFB74D',
    tertiary: '#FFD180',
    background: '#FFF3E0',
    surface: '#FFFFFF',
    surfaceVariant: '#FFE0B2',
    outline: '#D7CCC8',
    success: '#66BB6A',
    warning: '#FFCA28',
    error: '#D32F2F',
    onPrimary: '#FFFFFF',
    onSecondary: '#3E2723',
    onBackground: '#3E2723',
    onSurface: '#3E2723'
  }

  static TypographyTokens = {
    display: {
      fontSize: 28,
      fontWeight: FontWeight.Bold
    },
    title: {
      fontSize: 18,
      fontWeight: FontWeight.Medium
    },
    body: {
      fontSize: 14,
      fontWeight: FontWeight.Regular
    },
    label: {
      fontSize: 12,
      fontWeight: FontWeight.Medium
    }
  }

  static Shapes = {
    small: 6,
    medium: 10,
    large: 16
  }

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24
  }

  static ElevationMapping = {
    level1: new ShadowSpec(2, 4, 2, 0.1),
    level2: new ShadowSpec(6, 8, 4, 0.15),
    level3: new ShadowSpec(10, 12, 6, 0.18)
  }
}

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.45

  @Builder
  ProgressBar() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(10)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(5)

      Row()
        .width(`${this.progress * 100}%`)
        .height(10)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(5)
    }
    .width('100%')
    .height(10)
  }

  build() {
    Column({ space: AppTokens.Spacing.lg }) {
      Text('Order Tracking')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)
        .width('100%')

      Column({ space: AppTokens.Spacing.md }) {
        Text('Order #25491')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')

        Text('Estimated Delivery: 2 days')
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.secondary)
          .width('100%')

        this.ProgressBar()

        Row() {
          Text('Processing')
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            .fontColor(AppTokens.Colors.secondary)

          Text(`${Math.floor(this.progress * 100)}%`)
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            .fontColor(AppTokens.Colors.primary)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({
        radius: AppTokens.ElevationMapping.level2.radius,
        color: 'rgba(0, 0, 0, 0.15)',
        offsetX: 0,
        offsetY: AppTokens.ElevationMapping.level2.dy
      })

      Column({ space: AppTokens.Spacing.md }) {
        Text('Adjust Progress')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)

        Slider({
          value: this.progress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .blockColor(AppTokens.Colors.primary)
          .selectedColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .onChange((value: number) => {
            this.progress = value
          })

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Mark as Delivered')
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .width('100%')
        .height(40)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .onClick(() => {
          this.progress = 1
        })
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.background)
  }
}