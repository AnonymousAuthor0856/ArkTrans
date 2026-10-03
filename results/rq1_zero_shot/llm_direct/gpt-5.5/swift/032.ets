class AppColors {
  static readonly primary: string = '#FFA500'
  static readonly secondary: string = '#FFC300'
  static readonly tertiary: string = '#FFE066'
  static readonly background: string = '#FFFBF2'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#FFEED6'
  static readonly outline: string = '#F1C27D'
  static readonly success: string = '#22C55E'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#1E1E1E'
  static readonly onTertiary: string = '#1E1E1E'
  static readonly onBackground: string = '#1E1E1E'
  static readonly onSurface: string = '#1E1E1E'

  static readonly primary20: string = '#33FFA500'
  static readonly secondary20: string = '#33FFC300'
}

class AppTypography {
  static readonly displaySize: number = 28
  static readonly displayWeight: FontWeight = FontWeight.Bold

  static readonly titleSize: number = 18
  static readonly titleWeight: FontWeight = FontWeight.Medium

  static readonly bodySize: number = 14
  static readonly bodyWeight: FontWeight = FontWeight.Regular

  static readonly labelSize: number = 12
  static readonly labelWeight: FontWeight = FontWeight.Medium
}

class AppSpacing {
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
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

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.16)
}

@Entry
@Component
struct RootScreen {
  @State private markerX: number = 200
  @State private markerY: number = 400
  @State private progress: number = 0.4

  private canvasSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.canvasSettings)

  private drawCanvas(): void {
    const width: number = this.canvasContext.width
    const height: number = this.canvasContext.height

    if (width <= 0 || height <= 0) {
      return
    }

    const centerX: number = width / 2
    const centerY: number = height / 2

    this.canvasContext.clearRect(0, 0, width, height)

    this.canvasContext.beginPath()
    this.canvasContext.fillStyle = AppColors.surfaceVariant
    this.canvasContext.arc(centerX, centerY, 260, 0, Math.PI * 2)
    this.canvasContext.fill()

    this.canvasContext.beginPath()
    this.canvasContext.fillStyle = AppColors.primary
    this.canvasContext.arc(this.markerX, this.markerY, 20, 0, Math.PI * 2)
    this.canvasContext.fill()
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        Stack({ alignContent: Alignment.Center }) {
          Text('Transfer Wizard')
            .fontSize(AppTypography.displaySize)
            .fontWeight(AppTypography.displayWeight)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(56)
        .backgroundColor(AppColors.background)

        Stack({ alignContent: Alignment.Center }) {
          Stack() {
            Canvas(this.canvasContext)
              .width('100%')
              .height('100%')
              .onReady(() => {
                this.drawCanvas()
              })
              .onAreaChange(() => {
                this.drawCanvas()
              })
          }
          .width('100%')
          .height('100%')
          .padding(AppSpacing.xl)

          Column({ space: AppSpacing.lg }) {
            Text('Transfer Progress')
              .fontSize(AppTypography.titleSize)
              .fontWeight(AppTypography.titleWeight)
              .fontColor(AppColors.onSurface)

            Stack({ alignContent: Alignment.Start }) {
              Blank()
                .width('100%')
                .height(8)
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(4)

              Blank()
                .width(`${this.progress * 100}%`)
                .height(8)
                .backgroundColor(AppColors.primary)
                .borderRadius(4)
            }
            .width('80%')
            .height(8)

            Row({ space: AppSpacing.md }) {
              Button('+', { type: ButtonType.Circle, stateEffect: true })
                .width(64)
                .height(64)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppColors.onPrimary)
                .backgroundColor(AppColors.primary)
                .onClick(() => {
                  this.progress = Math.min(this.progress + 0.1, 1.0)
                })

              Button('-', { type: ButtonType.Circle, stateEffect: true })
                .width(64)
                .height(64)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppColors.onSecondary)
                .backgroundColor(AppColors.secondary)
                .onClick(() => {
                  this.progress = Math.max(this.progress - 0.1, 0.0)
                })
            }
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
          .padding({ bottom: AppSpacing.xxl })
          .align(Alignment.Bottom)
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppColors.secondary20, 0.0],
        [AppColors.background, 0.5],
        [AppColors.primary20, 1.0]
      ]
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}