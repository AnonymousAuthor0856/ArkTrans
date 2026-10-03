const NAME: string = '047CryptoMarketen'
const UI_TYPE: string = 'Finance'
const STYLE_THEME: string = 'Soft Pastel'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class AppColors {
  static readonly primary: string = '#FFA8A8'
  static readonly secondary: string = '#FFE1A8'
  static readonly tertiary: string = '#A8FFE1'
  static readonly background: string = '#FFFCF5'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#F7F7F7'
  static readonly outline: string = '#E2E2E2'
  static readonly success: string = '#22C55E'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#1E1E1E'
  static readonly onSecondary: string = '#1E1E1E'
  static readonly onTertiary: string = '#1E1E1E'
  static readonly onBackground: string = '#1E1E1E'
  static readonly onSurface: string = '#1E1E1E'

  static readonly secondaryAlpha30: string = 'rgba(255, 225, 168, 0.30)'
  static readonly tertiaryAlpha30: string = 'rgba(168, 255, 225, 0.30)'
}

class AppTypography {
  static readonly displaySize: number = 28
  static readonly titleSize: number = 18
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 12
  static readonly large: number = 20
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

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18)
}

@Component
struct MarketChart {
  @Prop progress: number

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  @State private canvasWidth: number = 0
  @State private canvasHeight: number = 0

  private parseLength(value: string | number): number {
    if (typeof value === 'number') {
      return value
    }
    const matched: RegExpMatchArray | null = value.toString().match(/[0-9.]+/)
    return matched ? Number(matched[0]) : 0
  }

  private drawChart(width: number, height: number): void {
    if (width <= 0 || height <= 0) {
      return
    }

    this.context.clearRect(0, 0, width, height)
    this.context.beginPath()
    this.context.strokeStyle = AppColors.primary
    this.context.lineWidth = 5
    this.context.lineCap = 'round'
    this.context.lineJoin = 'round'

    const step: number = width / 30
    let prevY: number = height / 2

    for (let i = 0; i <= 30; i++) {
      const x: number = i * step
      const y: number = height / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (height / 3)
      this.context.moveTo(x - step, prevY)
      this.context.lineTo(x, y)
      prevY = y
    }

    this.context.stroke()
  }

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.drawChart(this.canvasWidth, this.canvasHeight)
      })
      .onAreaChange((oldValue: Area, newValue: Area) => {
        const width: number = this.parseLength(newValue.width as string | number)
        const height: number = this.parseLength(newValue.height as string | number)
        this.canvasWidth = width
        this.canvasHeight = height
        this.drawChart(width, height)
      })
  }
}

@Entry
@Component
struct MainPage {
  @State private selectedChip: string = 'BTC'
  @State private progress: number = 0.6
  @State private isAutoUpdate: boolean = true

  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA']

  build() {
    Column() {
      Row() {
        Text('Crypto Market')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(80)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        Row({ space: AppSpacing.md }) {
          ForEach(this.chips, (item: string) => {
            Button({ type: ButtonType.Normal, stateEffect: true }) {
              Text(item)
                .fontSize(AppTypography.bodySize)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onPrimary)
            }
            .height(36)
            .padding({ left: 16, right: 16 })
            .borderRadius(18)
            .backgroundColor(this.selectedChip === item ? AppColors.primary : AppColors.surfaceVariant)
            .onClick(() => {
              this.selectedChip = item
            })
          }, (item: string) => item)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        Stack() {
          MarketChart({ progress: this.progress })
            .width('100%')
            .height('100%')
        }
        .width('100%')
        .height(260)
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)
        .shadow({
          radius: AppElevationMapping.level2.radius,
          color: 'rgba(0, 0, 0, 0.18)',
          offsetX: 0,
          offsetY: AppElevationMapping.level2.dy
        })

        Text('Price Variation')
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)

        Progress({
          value: this.progress * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(8)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(4)

        Row() {
          Text('Auto Update')
            .fontSize(AppTypography.bodySize)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.onSurface)

          Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
            .selectedColor(AppColors.primary)
            .switchPointColor(this.isAutoUpdate ? AppColors.secondary : AppColors.outline)
            .onChange((isOn: boolean) => {
              this.isAutoUpdate = isOn
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [
          [AppColors.secondaryAlpha30, 0.0],
          [AppColors.background, 0.5],
          [AppColors.tertiaryAlpha30, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}