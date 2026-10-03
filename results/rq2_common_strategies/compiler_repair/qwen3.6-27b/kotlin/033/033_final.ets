import { window } from '@kit.ArkUI'

// --- App Tokens & Constants ---
const NAME = "034BillCalendaren"
const UI_TYPE = "Finance"
const STYLE_THEME = "Gradient Flow"
const LANG = "en"
const BASELINE_SIZE = "720x1280"

interface ColorToken {
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
  fontSize: number;
  fontWeight: FontWeight;
}

interface ShapeToken {
  small: number;
  medium: number;
  large: number;
}

interface SpacingToken {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

class AppTokens {
  static Colors: ColorToken = {
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
    onSurface: '#0F172A'
  }

  static TypographyTokens: Record<string, TypographyToken> = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  }

  static Shapes: ShapeToken = {
    small: 6,
    medium: 12,
    large: 20
  }

  static Spacing: SpacingToken = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }
}

// --- Main Entry Component ---
@Entry
@Component
struct RootScreen {
  @State spending: number = 500
  private goal: number = 1000

  build() {
    Column() {
      // Top Bar Area
      Row() {
        Text('Bill Calendar')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main Content Area with Gradient Background
      Column() {
        // Spending Card
        Column() {
          Text('Current Spending')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.primary)
          
          Text(`$${this.spending.toFixed(0)} / $${this.goal.toFixed(0)}`)
            .fontSize(AppTokens.TypographyTokens.display.fontSize)
            .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: 8 })

          // Progress Indicator
          Row() {
            Row()
              .width(`${Math.min((this.spending / this.goal) * 100, 100)}%`)
              .height(8)
              .borderRadius(4)
              .backgroundColor(AppTokens.Colors.primary)
          }
          .width('100%')
          .height(8)
          .borderRadius(4)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .margin({ top: 16 })
        }
        .width('100%')
        .height(160)
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(Color.White.withAlpha(0.9))
        .borderRadius(AppTokens.Shapes.large)
        .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.18)', offsetY: 4 })

        // Slider Section
        Column() {
          Text('Adjust Spending')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .alignSelf(ItemAlign.Start)
            .margin({ bottom: 12 })

          Slider({
            value: this.spending,
            min: 0,
            max: 2000,
            step: 1,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .trackThickness(6)
            .selectedColor(AppTokens.Colors.primary)
            .blockColor(AppTokens.Colors.secondary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .onChange((value: number) => {
              this.spending = value
            })
        }
        .width('100%')
        .margin({ top: AppTokens.Spacing.lg })

        // Reset Button
        Button('Reset')
          .type(ButtonType.Normal)
          .width('100%')
          .height(48)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onTertiary)
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {
            this.spending = 0
          })
          .margin({ top: AppTokens.Spacing.lg })
      }
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.secondary, 0.3],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.primary, 0.2]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}