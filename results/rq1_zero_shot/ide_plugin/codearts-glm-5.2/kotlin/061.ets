const NAME = '096_ParcelTracker_en'
const UI_TYPE = 'Tools Dashboard'
const STYLE_THEME = 'Monochrome'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
    primary: '#111827',
    secondary: '#374151',
    tertiary: '#6B7280',
    background: '#F9FAFB',
    surface: '#FFFFFF',
    surfaceVariant: '#E5E7EB',
    outline: '#D1D5DB',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onBackground: '#111827',
    onSurface: '#1F2937',
  }

  static TypographyTokens = {
    display: { fontSize: 26, fontWeight: FontWeight.Bold },
    headline: { fontSize: 18, fontWeight: FontWeight.Medium },
    title: { fontSize: 14, fontWeight: FontWeight.Medium },
    body: { fontSize: 12, fontWeight: FontWeight.Normal },
  }

  static Shapes = {
    small: 6,
    medium: 10,
    large: 16,
  }

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 22,
  }
}

@Entry
@Component
struct RootScreen {
  @State dragX: number = 0
  @State dragY: number = 0
  private parcelPoints: number[][] = []
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  aboutToAppear() {
    for (let i = 0; i < 25; i++) {
      this.parcelPoints.push([Math.random() * 400, Math.random() * 300])
    }
    this.drawCanvas()
  }

  drawCanvas() {
    const ctx = this.canvasContext
    const w = 320
    const h = 280
    ctx.clearRect(0, 0, w, h)

    ctx.fillStyle = AppTokens.Colors.secondary
    for (const point of this.parcelPoints) {
      ctx.beginPath()
      ctx.arc(point[0], point[1], 4, 0, 2 * Math.PI)
      ctx.fill()
    }

    ctx.strokeStyle = AppTokens.Colors.primary
    ctx.lineWidth = 3
    ctx.beginPath()
    ctx.arc(this.dragX, this.dragY, 20, 0, 2 * Math.PI)
    ctx.stroke()
  }

  build() {
    Column() {
      Text('Parcel Tracker')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)

      Stack() {
        Canvas(this.canvasContext)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawCanvas()
          })
          .gesture(
            PanGesture()
              .onActionUpdate((event: GestureEvent) => {
                this.dragX = Math.max(0, Math.min(320, event.fingerList[0].localX))
                this.dragY = Math.max(0, Math.min(280, event.fingerList[0].localY))
                this.drawCanvas()
              })
          )

        Text('Drag to locate parcel')
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(300)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .alignContent(Alignment.Center)
      .margin({ top: AppTokens.Spacing.xl })

      Text('Visualize parcel movements and positions.')
        .fontSize(AppTokens.TypographyTokens.body.fontSize)
        .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)
        .margin({ top: AppTokens.Spacing.xl })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      angle: 180,
      colors: [[AppTokens.Colors.surfaceVariant, 0.0], [AppTokens.Colors.background, 1.0]]
    })
  }
}