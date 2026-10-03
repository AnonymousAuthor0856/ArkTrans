import { Window } from '@kit.ArkUI'

// Token Definitions matching the Kotlin AppTokens
const COLORS = {
  primary: '#FF7043',
  secondary: '#FFB74D',
  tertiary: '#FFD180',
  background: '#FFF3E0',
  surface: '#FFFFFF',
  surfaceVariant: '#FFE0B2',
  outline: '#D7CCC8',
  success: '#66BB6A',
  warning: '#FFCA28',
  error: '#D32F2F',
  onPrimary: '#FFFFFF',
  onSecondary: '#3E2723',
  onBackground: '#3E2723',
  onSurface: '#3E2723'
} as const;

const TYPOGRAPHY = {
  display: { fontSize: 28, fontWeight: FontWeight.Bold },
  title: { fontSize: 18, fontWeight: FontWeight.Medium },
  body: { fontSize: 14, fontWeight: FontWeight.Normal },
  label: { fontSize: 12, fontWeight: FontWeight.Medium }
} as const;

const SHAPES = {
  small: 6,
  medium: 10,
  large: 16
} as const;

const SPACING = {
  sm: 6,
  md: 10,
  lg: 16,
  xl: 24
} as const;

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.45;

  build() {
    Column() {
      // Header Text
      Text("Order Tracking")
        .fontColor(COLORS.onBackground)
        .fontSize(TYPOGRAPHY.display.fontSize)
        .fontWeight(TYPOGRAPHY.display.fontWeight)
        .margin({ bottom: SPACING.lg })

      // Order Card
      Column() {
        Text("Order #25491")
          .fontColor(COLORS.onSurface)
          .fontSize(TYPOGRAPHY.title.fontSize)
          .fontWeight(TYPOGRAPHY.title.fontWeight)
          .margin({ bottom: SPACING.sm })

        Text("Estimated Delivery: 2 days")
          .fontColor(COLORS.secondary)
          .fontSize(TYPOGRAPHY.body.fontSize)
          .fontWeight(TYPOGRAPHY.body.fontWeight)
          .margin({ bottom: SPACING.md })

        // Linear Progress Indicator
        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(10)
          .backgroundColor(COLORS.surfaceVariant)
          .color(COLORS.primary)
          .margin({ bottom: SPACING.md })

        // Row for labels
        Row() {
          Text("Processing")
            .fontColor(COLORS.secondary)
            .fontSize(TYPOGRAPHY.label.fontSize)
            .fontWeight(TYPOGRAPHY.label.fontWeight)

          Blank()

          Text(`${Math.round(this.progress * 100)}%`)
            .fontColor(COLORS.primary)
            .fontSize(TYPOGRAPHY.label.fontSize)
            .fontWeight(TYPOGRAPHY.label.fontWeight)
        }
        .width('100%')
      }
      .width('100%')
      .padding(SPACING.lg)
      .backgroundColor(COLORS.surface)
      .borderRadius(SHAPES.large)
      .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.15)', offsetY: 4 })
      .margin({ bottom: SPACING.lg })

      // Control Box
      Column() {
        Text("Adjust Progress")
          .fontColor(COLORS.onSurface)
          .fontSize(TYPOGRAPHY.title.fontSize)
          .fontWeight(TYPOGRAPHY.title.fontWeight)
          .textAlign(TextAlign.Center)
          .margin({ bottom: SPACING.md })

        Slider({ value: this.progress * 100, min: 0, max: 100, step: 1 })
          .width('100%')
          .trackThickness(6)
          .selectedColor(COLORS.primary)
          .trackColor(COLORS.surfaceVariant)
          .onChange((value: number) => {
            this.progress = value / 100;
          })
          .margin({ bottom: SPACING.md })

        Button("Mark as Delivered", { type: ButtonType.Capsule })
          .width('100%')
          .backgroundColor(COLORS.primary)
          .fontColor(COLORS.onPrimary)
          .fontSize(TYPOGRAPHY.label.fontSize)
          .fontWeight(TYPOGRAPHY.label.fontWeight)
          .onClick(() => {
            this.progress = 1.0;
          })
      }
      .width('100%')
      .padding(SPACING.lg)
      .backgroundColor(COLORS.surface)
      .borderRadius(SHAPES.large)
    }
    .width('100%')
    .height('100%')
    .padding(SPACING.lg)
    .backgroundColor(COLORS.background)
  }
}