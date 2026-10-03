class AppColors {
  static readonly primary: string = '#00FFFF'
  static readonly secondary: string = '#00B4FF'
  static readonly tertiary: string = '#8A2BE2'
  static readonly background: string = '#0A0A1A'
  static readonly surface: string = '#141436'
  static readonly surfaceVariant: string = '#1E1E4A'
  static readonly outline: string = '#2E2E5C'
  static readonly success: string = '#00FFAA'
  static readonly warning: string = '#FFCC00'
  static readonly error: string = '#FF4444'
  static readonly onPrimary: string = '#0A0A1A'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onBackground: string = '#FFFFFF'
  static readonly onSurface: string = '#FFFFFF'
}

class AppTypographyTokens {
  static readonly displaySize: number = 28
  static readonly titleSize: number = 18
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
}

class AppShapes {
  static readonly smallCornerRadius: number = 8
  static readonly mediumCornerRadius: number = 14
  static readonly largeCornerRadius: number = 22
}

class AppSpacing {
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 36
}

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

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.1)
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.15)
  static readonly level3: ShadowSpec = new ShadowSpec(10, 12, 6, 0.18)
}

@Component
struct MetroLineCanvas {
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F']
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawMetroLine(): void {
    const width = this.context.width
    const height = this.context.height

    if (width <= 0 || height <= 0) {
      return
    }

    this.context.clearRect(0, 0, width, height)

    const step = width / (this.stations.length - 1)

    this.context.beginPath()

    for (let i = 0; i < this.stations.length; i++) {
      const x = i * step
      const y = i % 2 === 0 ? height / 4 : height * 3 / 4

      if (i === 0) {
        this.context.moveTo(x, y)
      } else {
        this.context.lineTo(x, y)
      }
    }

    const gradient = this.context.createLinearGradient(0, 0, width, 0)
    gradient.addColorStop(0, AppColors.secondary)
    gradient.addColorStop(1, AppColors.primary)

    this.context.strokeStyle = gradient
    this.context.lineWidth = 6
    this.context.lineCap = 'round'
    this.context.lineJoin = 'round'
    this.context.stroke()

    for (let i = 0; i < this.stations.length; i++) {
      const x = i * step
      const y = i % 2 === 0 ? height / 4 : height * 3 / 4

      this.context.beginPath()
      this.context.arc(x, y, 16, 0, Math.PI * 2)
      this.context.fillStyle = AppColors.primary
      this.context.fill()

      this.context.beginPath()
      this.context.arc(x, y, 6, 0, Math.PI * 2)
      this.context.fillStyle = AppColors.background
      this.context.fill()
    }
  }

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.drawMetroLine()
      })
      .onAreaChange(() => {
        this.drawMetroLine()
      })
  }
}

@Entry
@Component
struct RootScreen {
  private readonly bottomBarHeight: number = 56
  private readonly fabSize: number = 56
  private readonly departures: string[] = ['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3']

  build() {
    Stack() {
      Column({ space: AppSpacing.lg }) {
        Text('Metro Planner')
          .fontSize(AppTypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .width('100%')
          .textAlign(TextAlign.Start)

        Column() {
          MetroLineCanvas()
            .width('100%')
            .layoutWeight(1)
        }
        .padding(AppSpacing.md)
        .height(260)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.largeCornerRadius)
        .alignSelf(ItemAlign.Stretch)
        .margin({ left: AppSpacing.lg, right: AppSpacing.lg })

        Column({ space: AppSpacing.sm }) {
          Text('Next Departures')
            .fontSize(AppTypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.secondary)

          ForEach(this.departures, (departure: string) => {
            Row() {
              Text(departure)
                .fontSize(AppTypographyTokens.bodySize)
                .fontWeight(FontWeight.Regular)
                .fontColor(AppColors.onSurface)

              Blank()
                .layoutWeight(1)

              Text('On Time')
                .fontSize(AppTypographyTokens.labelSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.success)
            }
            .width('100%')
          }, (departure: string) => departure)
        }
        .alignItems(HorizontalAlign.Start)
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.largeCornerRadius)
        .shadow({
          radius: AppElevationMapping.level2.radius,
          color: 'rgba(46, 46, 92, 0.15)',
          offsetX: 0,
          offsetY: AppElevationMapping.level2.dy
        })
        .alignSelf(ItemAlign.Stretch)
        .margin({ left: AppSpacing.lg, right: AppSpacing.lg })

        Blank()
          .layoutWeight(1)
      }
      .alignItems(HorizontalAlign.Start)
      .padding({
        top: AppSpacing.lg,
        bottom: this.bottomBarHeight
      })
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppColors.background, 0.0],
          [AppColors.surfaceVariant, 0.5],
          [AppColors.background, 1.0]
        ]
      })

      Column() {
        Blank()
          .layoutWeight(1)

        Row() {
          Blank()
            .layoutWeight(1)

          Button({ type: ButtonType.Circle, stateEffect: true }) {
            Text('+')
              .fontSize(AppTypographyTokens.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onPrimary)
          }
          .width(this.fabSize)
          .height(this.fabSize)
          .backgroundColor(AppColors.primary)
          .borderRadius(this.fabSize / 2)
          .onClick(() => {
          })
        }
        .width('100%')
        .padding({
          right: AppSpacing.lg,
          bottom: this.bottomBarHeight + AppSpacing.lg
        })
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
          .layoutWeight(1)

        Row() {
          Text('Routes')
            .fontSize(AppTypographyTokens.bodySize)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.secondary)

          Blank()
            .layoutWeight(1)

          Text('Planner')
            .fontSize(AppTypographyTokens.bodySize)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.onSurface)

          Blank()
            .layoutWeight(1)

          Text('Tickets')
            .fontSize(AppTypographyTokens.bodySize)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.onSurface)

          Blank()
            .layoutWeight(1)

          Text('Profile')
            .fontSize(AppTypographyTokens.bodySize)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.onSurface)
        }
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
        .width('100%')
        .height(this.bottomBarHeight)
        .backgroundColor(AppColors.surface)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}