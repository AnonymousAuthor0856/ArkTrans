const Colors = {
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
}

const Shapes = {
  small: 6,
  medium: 10,
  large: 16
}

const Spacing = {
  sm: 6,
  md: 10,
  lg: 16,
  xl: 24
}

@Entry
@Component
struct Index {
  @State progress: number = 0.45

  build() {
    Scroll() {
      Column({ space: Spacing.lg }) {
        Text('Order Tracking')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground)

        Column({ space: Spacing.md }) {
          Text('Order #25491')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text('Estimated Delivery: 2 days')
            .fontSize(14)
            .fontColor(Colors.secondary)
          Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
            .width('100%')
            .height(10)
            .color(Colors.primary)
            .backgroundColor(Colors.surfaceVariant)
          Row() {
            Text('Processing')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.secondary)
            Text(Math.round(this.progress * 100) + '%')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.primary)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width('100%')
        .padding(Spacing.lg)
        .backgroundColor(Colors.surface)
        .borderRadius(Shapes.large)
        .shadow({ radius: 8, color: '#26000000', offsetY: 4 })

        Column({ space: Spacing.md }) {
          Text('Adjust Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Slider({ value: this.progress, min: 0, max: 1, style: SliderStyle.OutSet })
            .width('100%')
            .selectedColor(Colors.primary)
            .trackColor(Colors.surfaceVariant)
            .blockColor(Colors.primary)
            .onChange((value: number) => {
              this.progress = value
            })
          Button('Mark as Delivered', { type: ButtonType.Normal })
            .width('100%')
            .borderRadius(Shapes.medium)
            .backgroundColor(Colors.primary)
            .fontColor(Colors.onPrimary)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.progress = 1
            })
        }
        .width('100%')
        .padding(Spacing.lg)
        .backgroundColor(Colors.surface)
        .borderRadius(Shapes.large)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .padding(Spacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
