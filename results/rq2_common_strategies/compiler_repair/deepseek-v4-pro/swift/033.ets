@Entry
@Component
struct RootScreen {
  @State spending: number = 500
  private goal: number = 1000

  build() {
    Column({ space: 0 }) {
      // Top App Bar
      Row({ space: 0 }) {
        Blank().layoutWeight(1)
        Text('Bill Calendar')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#FF0F172A')
        Blank().layoutWeight(1)
      }
      .width('100%')
      .height(56)
      .backgroundColor('#FFF0F9FF')

      // Main content
      Column({ space: 16 }) {
        // Surface Card for Current Spending
        Column({ space: 0 }) {
          Text('Current Spending')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FF06B6D4')

          Blank().layoutWeight(1)

          Text('$' + this.spending.toFixed(0) + ' / $' + this.goal.toFixed(0))
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .foregroundColor('#FF0F172A')

          Blank().layoutWeight(1)

          // Progress bar
          Progress({ value: this.spending, total: this.goal, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color('#FF06B6D4')
            .backgroundColor('#FFE0F2FE')
            .borderRadius(4)
        }
        .width('100%')
        .height(160)
        .padding(16)
        .backgroundColor('rgba(255,255,255,0.9)')
        .borderRadius(20)
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.18)', offsetX: 0, offsetY: 4 })

        // Adjust Spending label
        Text('Adjust Spending')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#FF0F172A')

        // Slider
        Slider({ value: this.spending, min: 0, max: 2000, step: 1 })
          .width('100%')
          .height(8)
          .backgroundColor('#FFE0F2FE')
          .borderRadius(4)
          .onChange((value: number) => {
            this.spending = value
          })

        // Reset Button
        Button() {
          Text('Reset')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FFFFFFFF')
        }
        .width('100%')
        .height(48)
        .backgroundColor('#FF8B5CF6')
        .borderRadius(12)
        .onClick(() => {
          this.spending = 0
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .backgroundColor('#FFF0F9FF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF0F9FF')
  }
}