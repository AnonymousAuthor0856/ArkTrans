@Entry
@Component
struct RootScreen {
  @State progress: number = 0.4

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Transfer Wizard')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFBF2')

      // Main content area
      Stack({ alignContent: Alignment.Bottom }) {
        // Background gradient
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [
              [0x33FFC300, 0.0],
              [0xFFFFFBF2, 0.5],
              [0x33FFA500, 1.0]
            ]
          })

        // Large circle canvas area
        Stack() {
          // Large background circle
          Circle({ width: 520, height: 520 })
            .fill('#FFEED6')

          // Small orange marker circle
          Circle({ width: 40, height: 40 })
            .fill('#FFA500')
            .position({ x: 80, y: 160 })
        }
        .width('100%')
        .height('100%')
        .alignContent(Alignment.Center)

        // Bottom controls
        Column({ space: 16 }) {
          Text('Transfer Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E1E1E')

          Progress({
            value: this.progress * 100,
            total: 100,
            type: ProgressType.Linear
          })
            .width('80%')
            .height(8)
            .color('#FFA500')
            .backgroundColor('#FFEED6')

          Row({ space: 12 }) {
            Button('+')
              .width(100)
              .height(48)
              .borderRadius(24)
              .backgroundColor('#FFA500')
              .fontColor('#FFFFFF')
              .fontSize(20)
              .onClick(() => {
                this.progress = Math.min(this.progress + 0.1, 1.0)
              })

            Button('-')
              .width(100)
              .height(48)
              .borderRadius(24)
              .backgroundColor('#FFC300')
              .fontColor('#1E1E1E')
              .fontSize(20)
              .onClick(() => {
                this.progress = Math.max(this.progress - 0.1, 0.0)
              })
          }
        }
        .alignItems(HorizontalAlign.Center)
        .padding({ bottom: 32 })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFBF2')
  }
}