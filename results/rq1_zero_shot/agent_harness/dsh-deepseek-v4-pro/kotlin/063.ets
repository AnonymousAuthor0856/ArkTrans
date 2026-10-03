const Colors = {
  primary: '#3B82F6',
  secondary: '#22C55E',
  background: '#F5F5F4',
  surface: '#FFFFFF',
  outline: '#D4D4D8',
  onPrimary: '#FFFFFF',
  onBackground: '#111827',
  onSurface: '#1F2937',
  accent: '#F59E0B',
}

const Spacing = {
  sm: 6,
  md: 10,
  lg: 14,
  xl: 20,
}

@Entry
@Component
struct Index {
  @State progress: number = 0.45

  build() {
    Column() {
      Row() {
        Text('🚗')
          .fontSize(24)
          .fontColor(Colors.primary)
          .padding({ left: 8 })
        Text('Charging Progress')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Text('⚙')
          .fontSize(24)
          .fontColor(Colors.accent)
          .padding({ right: 8 })
          .onClick(() => {})
      }
      .width('100%')
      .height(56)
      .backgroundColor(Colors.surface)
      .alignItems(VerticalAlign.Center)

      Column({ space: Spacing.xl }) {
        Text('🔋')
          .fontSize(72)
          .fontColor(Colors.primary)
        Text(Math.floor(this.progress * 100).toString() + '%')
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground)

        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .width('80%')
          .height(14)
          .color(Colors.primary)
          .backgroundColor(Colors.surface)
          .borderRadius(7)
          .border({ width: 1, color: Colors.outline })

        Button('Simulate Charge')
          .fontSize(12)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.secondary)
          .borderRadius(24)
          .onClick(() => {
            this.progress += 0.1
            if (this.progress > 1) {
              this.progress = 0
            }
          })

        Text(this.progress < 1 ? 'Charging...' : 'Fully Charged!')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.progress < 1 ? Colors.primary : Colors.secondary)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(Spacing.lg)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
