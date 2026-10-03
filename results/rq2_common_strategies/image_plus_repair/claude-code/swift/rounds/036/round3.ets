// AppTokens - design system tokens
class AppColors {
  static readonly primary: string = '#FFA8A8'
  static readonly secondary: string = '#FFE1A8'
  static readonly tertiary: string = '#A8FFE1'
  static readonly background: string = '#FFFCF5'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#F7F7F7'
  static readonly outline: string = '#E2E2E2'
  static readonly onSurface: string = '#1E1E1E'
  static readonly onPrimary: string = '#1E1E1E'
}

class AppSpacing {
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 12
  static readonly large: number = 20
}

// FilterChip component
@Component
struct FilterChip {
  text: string = ''
  isSelected: boolean = false
  onSelect: () => void = () => {}

  build() {
    Text(this.text)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(this.isSelected ? AppColors.primary : AppColors.surfaceVariant)
      .borderRadius(AppShapes.small)
      .onClick(() => {
        this.onSelect()
      })
  }
}

// Custom Switch component
@Component
struct CustomSwitch {
  @Link isOn: boolean
  checkedThumbColor: string = AppColors.secondary
  uncheckedThumbColor: string = AppColors.outline

  build() {
    Stack() {
      Ellipse()
        .width(51)
        .height(31)
        .fill(this.isOn ? AppColors.primary : AppColors.surfaceVariant)

      Circle()
        .width(27)
        .height(27)
        .fill(this.isOn ? this.checkedThumbColor : this.uncheckedThumbColor)
        .shadow({
          radius: 2,
          color: 'rgba(0,0,0,0.1)',
          offsetY: 1
        })
        .translate({ x: this.isOn ? 10 : -10 })
        .animation({
          duration: 200,
          curve: Curve.EaseInOut
        })
    }
    .width(51)
    .height(31)
    .onClick(() => {
      this.isOn = !this.isOn
    })
  }
}

// Waveform Chart component
@Component
struct WaveformChart {
  progress: number = 0.6
  @State canvasWidth: number = 0
  @State canvasHeight: number = 0
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawWave() {
    const ctx = this.context
    const w = this.canvasWidth
    const h = this.canvasHeight
    if (w <= 0 || h <= 0) {
      return
    }
    const step = w / 30
    const initialPrevY = h / 2

    ctx.clearRect(0, 0, w, h)
    ctx.beginPath()
    ctx.strokeStyle = AppColors.primary
    ctx.lineWidth = 5
    ctx.lineCap = 'round'
    ctx.lineJoin = 'round'

    ctx.moveTo(-step, initialPrevY)

    for (let i = 0; i <= 30; i++) {
      const x = i * step
      const y = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3)
      ctx.lineTo(x, y)
    }

    ctx.stroke()
  }

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.drawWave()
      })
      .onAreaChange((oldValue: Area, newValue: Area) => {
        this.canvasWidth = newValue.width as number
        this.canvasHeight = newValue.height as number
        this.drawWave()
      })
  }
}

// Main entry
@Entry
@Component
struct CryptoMarketApp {
  @State selectedChip: string = 'BTC'
  @State progress: number = 0.6
  @State isAutoUpdate: boolean = true

  build() {
    Column() {
      // Top bar
      Text('Crypto Market')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(AppColors.background)

      // Content area with gradient background
      Column() {
        // Filter chips row
        Row() {
          ForEach(['BTC', 'ETH', 'SOL', 'ADA'], (chip: string) => {
            FilterChip({
              text: chip,
              isSelected: this.selectedChip === chip,
              onSelect: () => {
                this.selectedChip = chip
              }
            })
          }, (chip: string) => chip)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ bottom: AppSpacing.lg })

        // Chart surface card
        Stack() {
          WaveformChart({ progress: this.progress })
            .padding(AppSpacing.lg)
        }
        .width('100%')
        .height(260)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)
        .shadow({
          radius: 8,
          color: 'rgba(0,0,0,0.18)',
          offsetY: 4
        })
        .margin({ bottom: AppSpacing.lg })

        // Price Variation text
        Text('Price Variation')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .margin({ bottom: AppSpacing.lg })

        // Linear progress indicator
        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .style({
            strokeWidth: 8,
            scaleCount: 0,
            scaleWidth: 0
          })
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .width('100%')
          .height(8)
          .margin({ bottom: AppSpacing.lg })

        // Auto Update row
        Row() {
          Text('Auto Update')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.onSurface)

          Blank()

          CustomSwitch({
            isOn: $isAutoUpdate,
            checkedThumbColor: AppColors.secondary,
            uncheckedThumbColor: AppColors.outline
          })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding(AppSpacing.lg)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppColors.secondary + '4D', 0.0],
          [AppColors.background, 0.5],
          [AppColors.tertiary + '4D', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
