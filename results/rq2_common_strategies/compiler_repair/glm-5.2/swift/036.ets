// AppTokens Definition

interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ElevationToken {
  radius: number;
  dy: number;
  opacity: number;
  color: string;
}

interface ElevationTokens {
  level1: ElevationToken;
  level2: ElevationToken;
}

class AppTokens {
  static readonly Colors: ColorTokens = {
    primary: '#FFFFA8A8',
    secondary: '#FFFFE1A8',
    tertiary: '#FFA8FFE1',
    background: '#FFFFFCF5',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFF7F7F7',
    outline: '#FFE2E2E2',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FF1E1E1E',
    onSecondary: '#FF1E1E1E',
    onTertiary: '#FF1E1E1E',
    onBackground: '#FF1E1E1E',
    onSurface: '#FF1E1E1E'
  }

  static readonly Typography: TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes: ShapeTokens = {
    small: 6,
    medium: 12,
    large: 20
  }

  static readonly Spacing: SpacingTokens = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  static readonly Elevation: ElevationTokens = {
    level1: { radius: 4, dy: 2, opacity: 0.12, color: '#1A000000' },
    level2: { radius: 8, dy: 4, opacity: 0.18, color: '#2E000000' }
  }
}

// Linear Progress Indicator Component
@Component
struct LinearProgressIndicator {
  @Prop progress: number
  private tint: string = AppTokens.Colors.primary
  private track: string = AppTokens.Colors.surfaceVariant

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Column()
        .width('100%')
        .height(8)
        .backgroundColor(this.track)
        .borderRadius(4)

      // Progress
      Column()
        .width(`${this.progress * 100}%`)
        .height(8)
        .backgroundColor(this.tint)
        .borderRadius(4)
    }
    .width('100%')
    .height(8)
  }
}

// Custom Switch Component
@Component
struct CustomSwitch {
  @Prop isOn: boolean
  private checkedThumbColor: string = AppTokens.Colors.secondary
  private uncheckedThumbColor: string = AppTokens.Colors.outline
  onToggle: (isOn: boolean) => void = () => {}

  build() {
    Stack() {
      // Track
      Column()
        .width(51)
        .height(31)
        .backgroundColor(this.isOn ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
        .borderRadius(16)

      // Thumb
      Row()
        .width(27)
        .height(27)
        .backgroundColor(this.isOn ? this.checkedThumbColor : this.uncheckedThumbColor)
        .borderRadius(14)
        .shadow({ radius: 2, color: '#1A000000', offsetX: 0, offsetY: 1 })
        .position({ x: this.isOn ? 22 : 2, y: 2 })
        .animation({ duration: 200, curve: Curve.EaseInOut })
    }
    .width(51)
    .height(31)
    .onClick(() => {
      this.onToggle(!this.isOn)
    })
  }
}

// Filter Chip Component
@Component
struct FilterChip {
  @Prop text: string
  @Prop isSelected: boolean
  onSelect: () => void = () => {}

  build() {
    Text(this.text)
      .fontSize(AppTokens.Typography.label.size)
      .fontWeight(AppTokens.Typography.label.weight)
      .fontColor(AppTokens.Colors.onPrimary)
      .padding({
        left: AppTokens.Spacing.md,
        right: AppTokens.Spacing.md,
        top: AppTokens.Spacing.sm,
        bottom: AppTokens.Spacing.sm
      })
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)
      .onClick(() => {
        this.onSelect()
      })
  }
}

// Main Entry Component
@Entry
@Component
struct CryptoMarketApp {
  @State selectedChip: string = 'BTC'
  @State progress: number = 0.6
  @State isAutoUpdate: boolean = true

  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA']
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Column() {
      // Top Bar
      Text('Crypto Market')
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.background)
        .textAlign(TextAlign.Center)

      // Content Area with Gradient Background
      Column() {
        // Filter Chips Row
        Row({ space: AppTokens.Spacing.md }) {
          ForEach(this.chips, (chip: string) => {
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

        // Chart Surface
        Stack() {
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({
              radius: AppTokens.Elevation.level2.radius,
              color: AppTokens.Elevation.level2.color,
              offsetX: 0,
              offsetY: AppTokens.Elevation.level2.dy
            })

          // Canvas for Waveform
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .padding(AppTokens.Spacing.lg)
            .onReady(() => {
              const w = this.context.width
              const h = this.context.height
              const step = w / 30
              const initialPrevY = h / 2

              this.context.beginPath()
              this.context.moveTo(-step, initialPrevY)

              for (let i = 0; i <= 30; i++) {
                const x = i * step
                const y = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3)
                this.context.lineTo(x, y)
              }

              this.context.strokeStyle = AppTokens.Colors.primary
              this.context.lineWidth = 5
              this.context.stroke()
            })
        }
        .width('100%')
        .height(260)
        .margin({ top: AppTokens.Spacing.lg })

        // Price Variation Text
        Text('Price Variation')
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: AppTokens.Spacing.lg })

        // Linear Progress Indicator
        LinearProgressIndicator({ progress: this.progress })
          .width('100%')
          .margin({ top: AppTokens.Spacing.sm })

        // Auto Update Row
        Row() {
          Text('Auto Update')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .layoutWeight(1)

          CustomSwitch({
            isOn: this.isAutoUpdate,
            checkedThumbColor: AppTokens.Colors.secondary,
            uncheckedThumbColor: AppTokens.Colors.outline,
            onToggle: (isOn: boolean) => {
              this.isAutoUpdate = isOn
            }
          })
        }
        .width('100%')
        .margin({ top: AppTokens.Spacing.lg })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.secondary, 0.3],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.tertiary, 0.3]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}