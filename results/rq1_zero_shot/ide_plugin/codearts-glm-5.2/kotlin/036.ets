const NAME = '047CryptoMarketen'
const UI_TYPE = 'Finance'
const STYLE_THEME = 'Soft Pastel'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
    primary: '#FFA8A8',
    secondary: '#FFE1A8',
    tertiary: '#A8FFE1',
    background: '#FFFCF5',
    surface: '#FFFFFF',
    surfaceVariant: '#F7F7F7',
    outline: '#E2E2E2',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#1E1E1E',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E',
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

@Entry
@Component
struct RootScreen {
  @State selectedChip: string = 'BTC'
  @State progress: number = 0.6
  @State isAutoUpdate: boolean = true
  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA']
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  aboutToAppear() {
    this.drawChart()
  }

  drawChart() {
    const ctx = this.canvasContext
    const w = 320
    const h = 230
    const step = w / 30
    let prevY = h / 2
    ctx.strokeStyle = AppTokens.Colors.primary
    ctx.lineWidth = 5
    ctx.beginPath()
    for (let i = 0; i <= 30; i++) {
      const x = i * step
      const y = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3)
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
        Text('Crypto Market')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      Column() {
        Row() {
          ForEach(this.chips, (chip: string) => {
            Text(chip)
              .fontSize(AppTokens.TypographyTokens.label.fontSize)
              .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
              .fontColor(AppTokens.Colors.onPrimary)
              .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
              .backgroundColor(this.selectedChip === chip ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.small)
              .margin({ right: AppTokens.Spacing.md })
              .onClick(() => {
                this.selectedChip = chip
              })
          }, (chip: string) => chip)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

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
        .margin({ top: AppTokens.Spacing.lg })

        Text('Price Variation')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: AppTokens.Spacing.lg })

        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .style({ strokeWidth: 8 })
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .width('100%')

        Row() {
          Text('Auto Update')
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
            .selectedColor(AppTokens.Colors.secondary)
            .onChange((isOn: boolean) => {
              this.isAutoUpdate = isOn
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [['#4DFFE1A8', 0.0], [AppTokens.Colors.background, 0.5], ['#4DA8FFE1', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}