// File 033 - Bill Calendar (Finance)
const Colors = {
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

const Spacing = {
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32
}

@Entry
@Component
struct Index {
  @State spending: number = 500
  private goal: number = 1000

  build() {
    Column() {
      Row() {
        Text('Bill Calendar')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      Column({ space: Spacing.lg }) {
        Column() {
          Text('Current Spending')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.primary)
          Text('$' + Math.floor(this.spending) + ' / $' + this.goal)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)
          Progress({ value: Math.min(Math.max(this.spending / this.goal, 0), 1), total: 1, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color(Colors.primary)
            .backgroundColor(Colors.surfaceVariant)
        }
        .width('100%')
        .height(160)
        .padding(Spacing.lg)
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor('#E6FFFFFF')
        .borderRadius(20)

        Text('Adjust Spending')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)

        Slider({ value: this.spending, min: 0, max: 2000 })
          .selectedColor(Colors.primary)
          .trackColor(Colors.surfaceVariant)
          .blockColor(Colors.secondary)
          .onChange((value: number) => { this.spending = value })

        Button('Reset', { type: ButtonType.Normal })
          .width('100%')
          .height(48)
          .backgroundColor(Colors.tertiary)
          .fontColor(Colors.onTertiary)
          .fontSize(18)
          .borderRadius(12)
          .onClick(() => { this.spending = 0 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(Spacing.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [['#4D3B82F6', 0.0], ['#F0F9FF', 0.5], ['#3306B6D4', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
