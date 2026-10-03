const NAME = '068*MetroPlanner*en'
const UI_TYPE = 'Travel'
const STYLE_THEME = 'Dark Neon'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
    primary: '#00FFFF',
    secondary: '#00B4FF',
    tertiary: '#8A2BE2',
    background: '#0A0A1A',
    surface: '#141436',
    surfaceVariant: '#1E1E4A',
    outline: '#2E2E5C',
    success: '#00FFAA',
    warning: '#FFCC00',
    error: '#FF4444',
    onPrimary: '#0A0A1A',
    onSecondary: '#FFFFFF',
    onBackground: '#FFFFFF',
    onSurface: '#FFFFFF',
  }

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  }

  static Shapes = {
    small: 8,
    medium: 14,
    large: 22,
  }

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36,
  }

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.1 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.15 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 },
  }
}

@Entry
@Component
struct RootScreen {
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F']
  private departures: string[] = ['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3']
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  aboutToAppear() {
    this.drawCanvas()
  }

  drawCanvas() {
    const ctx = this.canvasContext
    const w = 320
    const h = 230
    ctx.clearRect(0, 0, w, h)

    const step = w / (this.stations.length - 1)
    const points: number[][] = []
    for (let i = 0; i < this.stations.length; i++) {
      const x = i * step
      const y = i % 2 === 0 ? h / 4 : (h * 3) / 4
      points.push([x, y])
    }

    const grad = ctx.createLinearGradient(0, 0, w, 0)
    grad.addColorStop(0, AppTokens.Colors.secondary)
    grad.addColorStop(1, AppTokens.Colors.primary)
    ctx.strokeStyle = grad
    ctx.lineWidth = 6
    ctx.beginPath()
    for (let i = 0; i < points.length; i++) {
      if (i === 0) {
        ctx.moveTo(points[i][0], points[i][1])
      } else {
        ctx.lineTo(points[i][0], points[i][1])
      }
    }
    ctx.stroke()

    for (let i = 0; i < points.length; i++) {
      ctx.fillStyle = AppTokens.Colors.primary
      ctx.beginPath()
      ctx.arc(points[i][0], points[i][1], 16, 0, 2 * Math.PI)
      ctx.fill()

      ctx.fillStyle = AppTokens.Colors.background
      ctx.beginPath()
      ctx.arc(points[i][0], points[i][1], 6, 0, 2 * Math.PI)
      ctx.fill()
    }
  }

  build() {
    Column() {
      Text('Metro Planner')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.primary)

      Column() {
        Canvas(this.canvasContext)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawCanvas()
          })
      }
      .width('100%')
      .height(260)
      .padding(AppTokens.Spacing.md)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.large)
      .margin({ top: AppTokens.Spacing.lg })

      Column() {
        Text('Next Departures')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.secondary)

        ForEach(this.departures, (dep: string, index: number) => {
          Row() {
            Text(dep)
              .fontSize(AppTokens.TypographyTokens.body.fontSize)
              .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)

            Blank()

            Text('On Time')
              .fontSize(AppTokens.TypographyTokens.label.fontSize)
              .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
              .fontColor(AppTokens.Colors.success)
          }
          .width('100%')
          .margin({ top: AppTokens.Spacing.sm })
        }, (dep: string, index: number) => index.toString())
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetY: AppTokens.ElevationMapping.level2.dy })
      .margin({ top: AppTokens.Spacing.lg })

      Blank()

      Stack() {
        Row() {
          Text('Routes')
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.secondary)
          Blank()
          Text('Planner')
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
          Text('Tickets')
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
          Text('Profile')
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(56)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppTokens.Colors.surface)

        Button('+')
          .type(ButtonType.Normal)
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .position({ x: '50%', y: -28 })
          .markAnchor({ x: '50%', y: 0 })
      }
      .width('100%')
      .height(56)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .linearGradient({
      angle: 180,
      colors: [[AppTokens.Colors.background, 0.0], [AppTokens.Colors.surfaceVariant, 0.5], [AppTokens.Colors.background, 1.0]]
    })
  }
}