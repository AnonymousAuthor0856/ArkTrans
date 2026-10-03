@Entry
@Component
struct ChargingProgress {
  @State progress: number = 0.45

  private readonly Colors = {
    primary: '#3B82F6',
    secondary: '#22C55E',
    background: '#F5F5F4',
    surface: '#FFFFFF',
    outline: '#D4D4D8',
    onPrimary: '#FFFFFF',
    onBackground: '#111827',
    onSurface: '#1F2937',
    accent: '#F59E0B'
  }

  build() {
    Column() {
      // Top bar
      Row() {
        Text('🚗')
          .fontSize(24)
          .fontColor(this.Colors.primary)
          .margin({ left: 16 })

        Text('Charging Progress')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.Colors.onBackground)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('⚙')
          .fontSize(22)
          .fontColor(this.Colors.accent)
          .margin({ right: 16 })
      }
      .width('100%')
      .height(56)
      .backgroundColor(this.Colors.surface)
      .alignItems(VerticalAlign.Center)

      // Main content
      Column() {
        // Battery icon
        Text('🔋')
          .fontSize(72)
          .fontColor(this.Colors.primary)

        // Percentage text
        Text(`${Math.round(this.progress * 100)}%`)
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.Colors.onBackground)
          .margin({ top: 8 })

        // Progress bar
        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .width('80%')
          .height(14)
          .color(this.Colors.primary)
          .backgroundColor(this.Colors.surface)
          .border({ width: 1, color: this.Colors.outline, radius: 7 })
          .margin({ top: 16 })

        // Simulate Charge button
        Button('Simulate Charge')
          .fontColor(this.Colors.onPrimary)
          .backgroundColor(this.Colors.secondary)
          .borderRadius(20)
          .height(40)
          .padding({ left: 24, right: 24 })
          .margin({ top: 20 })
          .onClick(() => {
            this.progress += 0.1
            if (this.progress > 1) {
              this.progress = 0
            }
          })

        // Status text
        Text(this.progress < 1 ? 'Charging...' : 'Fully Charged!')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.progress < 1 ? this.Colors.primary : this.Colors.secondary)
          .margin({ top: 16 })
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .padding(14)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.Colors.background)
  }
}
