class AppColors {
  primary: string = '#3B82F6'
  secondary: string = '#22C55E'
  background: string = '#F5F5F4'
  surface: string = '#FFFFFF'
  outline: string = '#D4D4D8'
  onPrimary: string = '#FFFFFF'
  onBackground: string = '#111827'
  onSurface: string = '#1F2937'
  accent: string = '#F59E0B'
}

@Entry
@Component
struct ChargingProgress {
  @State progress: number = 0.45
  private colors: AppColors = new AppColors()

  build() {
    Column() {
      Row() {
        Text('🚗')
          .fontSize(24)
          .fontColor(this.colors.primary)
          .margin({ left: 16 })

        Text('Charging Progress')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colors.onBackground)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('⚙')
          .fontSize(22)
          .fontColor(this.colors.accent)
          .margin({ right: 16 })
      }
      .width('100%')
      .height(56)
      .backgroundColor(this.colors.surface)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text('🔋')
          .fontSize(72)
          .fontColor(this.colors.primary)

        Text(`${Math.round(this.progress * 100)}%`)
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colors.onBackground)
          .margin({ top: 8 })

        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .width('80%')
          .height(14)
          .color(this.colors.primary)
          .backgroundColor(this.colors.surface)
          .border({ width: 1, color: this.colors.outline, radius: 7 })
          .margin({ top: 16 })

        Button('Simulate Charge')
          .fontColor(this.colors.onPrimary)
          .backgroundColor(this.colors.secondary)
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

        Text(this.progress < 1 ? 'Charging...' : 'Fully Charged!')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.progress < 1 ? this.colors.primary : this.colors.secondary)
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
    .backgroundColor(this.colors.background)
  }
}
