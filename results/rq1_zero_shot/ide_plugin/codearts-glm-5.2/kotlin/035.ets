const NAME = '046StockKLineen'
const UI_TYPE = 'Finance'
const STYLE_THEME = 'Modern Blue'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
    primary: '#2563EB',
    secondary: '#60A5FA',
    tertiary: '#93C5FD',
    background: '#F8FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#E2E8F0',
    outline: '#CBD5E1',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E3A8A',
    onTertiary: '#1E40AF',
    onBackground: '#0F172A',
    onSurface: '#0F172A',
  }

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  }

  static Shapes = {
    small: 4,
    medium: 8,
    large: 16,
  }

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28,
  }

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 },
  }
}

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.5
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  aboutToAppear() {
    this.drawChart()
  }

  drawChart() {
    const ctx = this.canvasContext
    const width = 320
    const height = 230
    const step = width / 50
    let prevY = height / 2
    ctx.strokeStyle = AppTokens.Colors.primary
    ctx.lineWidth = 4
    ctx.beginPath()
    for (let i = 0; i <= 50; i++) {
      const x = i * step
      const y = height / 2 + Math.sin(i * Math.PI / 8 + this.progress * Math.PI) * (height / 3)
      if (i === 0) {
        ctx.moveTo(x, y)
      } else {
        ctx.lineTo(x, y)
      }
      prevY = y
    }
    ctx.stroke()
  }

  build() {
    Column() {
      Row() {
        Text('Stock K-Line')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      Column() {
        Column() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawChart()
            })
        }
        .width('100%')
        .height(260)
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetY: AppTokens.ElevationMapping.level2.dy })

        Text('Market Trend')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: AppTokens.Spacing.lg })

        Slider({
          value: this.progress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet,
        })
          .blockColor(AppTokens.Colors.primary)
          .selectedColor(AppTokens.Colors.secondary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .width('100%')
          .onChange((value: number, mode: SliderChangeMode) => {
            this.progress = value
            this.drawChart()
          })

        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .style({ strokeWidth: 8 })
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [['#2660A5FA', 0.0], [AppTokens.Colors.background, 0.5], ['#262563EB', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}