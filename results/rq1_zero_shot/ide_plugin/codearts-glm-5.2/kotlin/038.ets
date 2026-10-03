const NAME = '049*InvoiceScanner*en'
const UI_TYPE = 'Finance'
const STYLE_THEME = 'Gradient Flow'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
    primary: '#06B6D4',
    secondary: '#3B82F6',
    tertiary: '#8B5CF6',
    background: '#F0F9FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E0F2FE',
    outline: '#BAE6FD',
    success: '#22C55E',
    warning: '#FACC15',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
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
    small: 6,
    medium: 12,
    large: 20,
  }

  static Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  }

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 },
  }
}

interface Marker {
  x: number
  y: number
  label: string
}

@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    { x: 120, y: 200, label: 'A1' },
    { x: 300, y: 400, label: 'B2' },
    { x: 520, y: 600, label: 'C3' },
  ]
  @State scanning: boolean = false
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  aboutToAppear() {
    this.drawCanvas()
  }

  drawCanvas() {
    const ctx = this.canvasContext
    const w = 320
    const h = 380
    const cx = w / 2
    const cy = h / 2
    const radius = Math.min(w, h) / 2.5

    ctx.clearRect(0, 0, w, h)

    ctx.fillStyle = AppTokens.Colors.surfaceVariant
    ctx.beginPath()
    ctx.arc(cx, cy, radius, 0, 2 * Math.PI)
    ctx.fill()

    ctx.fillStyle = AppTokens.Colors.primary
    for (const marker of this.markers) {
      ctx.beginPath()
      ctx.arc(marker.x, marker.y, 12, 0, 2 * Math.PI)
      ctx.fill()
    }
  }

  build() {
    Column() {
      Row() {
        Text('Invoice Scanner')
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
              this.drawCanvas()
            })
        }
        .width('100%')
        .height(400)
        .padding(AppTokens.Spacing.md)
        .backgroundColor('#E6FFFFFF')
        .borderRadius(AppTokens.Shapes.large)
        .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetY: AppTokens.ElevationMapping.level2.dy })

        Row() {
          Text('Scanning Active')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .selectedColor(AppTokens.Colors.secondary)
            .onChange((isOn: boolean) => {
              this.scanning = isOn
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: AppTokens.Spacing.lg })

        Button('Add Marker')
          .type(ButtonType.Normal)
          .width('100%')
          .height(48)
          .borderRadius(AppTokens.Shapes.medium)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .onClick(() => {
            if (this.scanning) {
              const newX = Math.floor(Math.random() * 500) + 80
              const newY = Math.floor(Math.random() * 500) + 150
              const newLabel = `N${this.markers.length + 1}`
              this.markers.push({ x: newX, y: newY, label: newLabel })
              this.drawCanvas()
            }
          })
      }
      .layoutWeight(1)
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [['#4D3B82F6', 0.0], [AppTokens.Colors.background, 0.5], ['#4D06B6D4', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}