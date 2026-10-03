import { Font, FontWeight } from '@kit.ArkUI'

// MARK: - AppTokens Definition

const Dp = 1 // Density-independent pixel equivalent (ArkTS uses vp/vp, but we keep the structure)

class AppTokens {
  static Colors = {
    primary: '#FFA8A8',
    secondary: '#FFE1A8',
    tertiary: '#A8FFE1',
    background: '#FFFDF5',
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
    onSurface: '#1E1E1E'
  }

  static TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static Shapes = {
    small: 6,
    medium: 12,
    large: 20
  }

  static Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  static ElevationMapping = {
    level2: { opacity: 0.18, radius: 8, dy: 4 }
  }
}

// MARK: - Custom Components

@Component
struct FilterChipView {
  @Prop text: string
  @Prop isSelected: boolean
  action: () => void = () => {}

  build() {
    Button(this.text) {
      Text(this.text)
        .font({ size: AppTokens.TypographyTokens.label.size, weight: AppTokens.TypographyTokens.label.weight })
        .fontColor(AppTokens.Colors.onPrimary)
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)
    }
    .type(ButtonType.Normal)
    .onClick(() => {
      this.action()
    })
  }
}

@Component
struct LinearProgressIndicator {
  progress: number = 0

  build() {
    Row() {
      Progress({ value: this.progress * 100, total: 100 })
        .width('100%')
        .height(8)
        .linearGradient({
          angle: 0,
          colors: [
            [AppTokens.Colors.primary, this.progress],
            [AppTokens.Colors.surfaceVariant, this.progress]
          ]
        })
        .borderRadius(4)
    }
    .width('100%')
    .height(8)
  }
}

@Component
struct CustomSwitchToggle {
  @Link isOn: boolean
  checkedThumbColor: string = AppTokens.Colors.secondary
  uncheckedThumbColor: string = AppTokens.Colors.outline

  build() {
    Column() {
      Toggle({ type: ToggleType.Switch, isOn: $isOn })
        .width(51)
        .height(31)
        .selectedColor(this.isOn ? this.checkedThumbColor : this.uncheckedThumbColor)
        .onChange((isOn: boolean) => {
          this.isOn = isOn
        })
    }
  }
}

// MARK: - RootScreen View

@Entry
@Component
struct RootScreen {
  @State selectedChip: string = 'BTC'
  @State progress: number = 0.6
  @State isAutoUpdate: boolean = true

  build() {
    Stack() {
      // Base background color
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column() {
        // Top Bar
        Text('Crypto Market')
          .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
          .textAlign(TextAlign.Center)
          .width('100%')
          .backgroundColor(AppTokens.Colors.background)

        // Content area
        Column({ space: AppTokens.Spacing.lg }) {
          // Filter Chips Row
          Row({ space: AppTokens.Spacing.md }) {
            ForEach(['BTC', 'ETH', 'SOL', 'ADA'], (chipText: string) => {
              FilterChipView({
                text: chipText,
                isSelected: this.selectedChip === chipText,
                action: () => {
                  this.selectedChip = chipText
                }
              })
            })
          }

          // Chart Surface
          Column() {
            // Canvas for drawing the waveform
            CanvasRenderingContext2D()
              .draw((context: CanvasRenderingContext2D, rect: Rect) => {
                const w = rect.width
                const h = rect.height
                const step = w / 30
                const initialPrevY = h / 2

                context.beginPath()
                context.moveTo(-step, initialPrevY)

                for (let i = 0; i <= 30; i++) {
                  const x = i * step
                  const y = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3)
                  context.lineTo(x, y)
                }

                context.strokeStyle = '#FFA8A8' // AppTokens.Colors.primary hex
                context.lineWidth = 5
                context.stroke()
              })
              .width('100%')
              .height('100%')
          }
          .width('100%')
          .height(260)
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ElevationMapping.level2.radius,
            color: 'rgba(0, 0, 0, 0.18)',
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level2.dy
          })

          // Price Variation Text
          Text('Price Variation')
            .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
            .fontColor(AppTokens.Colors.primary)

          // Linear Progress Indicator
          LinearProgressIndicator({ progress: this.progress })

          // Auto Update Row
          Row() {
            Text('Auto Update')
              .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
              .fontColor(AppTokens.Colors.onSurface)

            Blank()

            CustomSwitchToggle({ isOn: $isAutoUpdate })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .layoutWeight(1)
        .linearGradient({
          angle: 90,
          colors: [
            ['rgba(255, 225, 168, 0.3)', 0], // Secondary with opacity
            ['#FFFDF5', 0.5], // Background
            ['rgba(168, 255, 225, 0.3)', 1] // Tertiary with opacity
          ]
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}