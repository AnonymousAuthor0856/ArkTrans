const NAME: string = '033TransferWizarden'
const UI_TYPE: string = 'Finance'
const STYLE_THEME: string = 'Warm Gradient'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

interface Offset {
  x: number
  y: number
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

class AppTokens {
  static readonly Colors = {
    primary: '#FFA500',
    secondary: '#FFC300',
    tertiary: '#FFE066',
    background: '#FFFBF2',
    surface: '#FFFFFF',
    surfaceVariant: '#FFEED6',
    outline: '#F1C27D',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  }

  static readonly TypographyTokens = {
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

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  static readonly ElevationMapping = {
    level1: new ShadowSpec(2, 4, 2, 0.12),
    level2: new ShadowSpec(6, 8, 4, 0.16)
  }
}

@Entry
@Component
struct RootScreen {
  @State private markerPosition: Offset = { x: 200, y: 400 }
  @State private progress: number = 0.4
  @State private canvasWidth: number = 720
  @State private canvasHeight: number = 1080

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawCanvas(): void {
    const width: number = this.canvasWidth
    const height: number = this.canvasHeight

    this.canvasContext.clearRect(0, 0, width, height)

    this.canvasContext.fillStyle = AppTokens.Colors.surfaceVariant
    this.canvasContext.beginPath()
    this.canvasContext.arc(width / 2, height / 2, 260, 0, Math.PI * 2)
    this.canvasContext.fill()

    this.canvasContext.fillStyle = AppTokens.Colors.primary
    this.canvasContext.beginPath()
    this.canvasContext.arc(this.markerPosition.x, this.markerPosition.y, 20, 0, Math.PI * 2)
    this.canvasContext.fill()
  }

  private increaseProgress(): void {
    this.progress = Math.min(this.progress + 0.1, 1)
  }

  private decreaseProgress(): void {
    this.progress = Math.max(this.progress - 0.1, 0)
  }

  build() {
    Column() {
      Row() {
        Text('Transfer Wizard')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(88)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      Stack({ alignContent: Alignment.Center }) {
        Canvas(this.canvasContext)
          .width('100%')
          .height('100%')
          .padding(AppTokens.Spacing.xl)
          .onReady(() => {
            this.drawCanvas()
          })
          .onAreaChange((oldValue: Area, newValue: Area) => {
            this.canvasWidth = Number.parseFloat(newValue.width.toString())
            this.canvasHeight = Number.parseFloat(newValue.height.toString())
            this.drawCanvas()
          })

        Column({ space: AppTokens.Spacing.lg }) {
          Text('Transfer Progress')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)

          Progress({
            value: this.progress * 100,
            total: 100,
            type: ProgressType.Linear
          })
            .width('80%')
            .height(8)
            .color(AppTokens.Colors.primary)
            .backgroundColor(AppTokens.Colors.surfaceVariant)

          Row({ space: AppTokens.Spacing.md }) {
            Button('+', { type: ButtonType.Circle, stateEffect: true })
              .width(48)
              .height(48)
              .fontSize(20)
              .fontColor(AppTokens.Colors.onPrimary)
              .backgroundColor(AppTokens.Colors.primary)
              .onClick(() => {
                this.increaseProgress()
              })

            Button('-', { type: ButtonType.Circle, stateEffect: true })
              .width(48)
              .height(48)
              .fontSize(20)
              .fontColor(AppTokens.Colors.onSecondary)
              .backgroundColor(AppTokens.Colors.secondary)
              .onClick(() => {
                this.decreaseProgress()
              })
          }
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .align(Alignment.Bottom)
        .padding({ bottom: AppTokens.Spacing.xxl })
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        angle: 180,
        colors: [
          ['rgba(255, 195, 0, 0.20)', 0.0],
          [AppTokens.Colors.background, 0.5],
          ['rgba(255, 165, 0, 0.20)', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}