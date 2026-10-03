@Entry
@Component
struct Index {
  @State syncProgress: number = 0.3

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Box (Stack) ===
      Stack({ alignContent: Alignment.Center }) {
        // === Canvas ===
        Canvas().width('100%').height('100%')

        // === Column ===
        Column({ space: 16 }) {
          // === Text ===
          Text('Transfer Progress')
            .fontColor('#1E1E1E')
            .fontSize(16) // Approximation of titleMedium

          // === LinearProgressIndicator ===
          Progress({
            value: this.syncProgress,
            total: 1,
            type: ProgressType.Linear
          })
            .width('80%')
            .height(8)
            .color('#FFA500')
            .backgroundColor('#FFEED6')

          // === Row ===
          Row({ space: 12 }) {
            // === Button (+) ===
            Button() {
              Text('+')
            }
            .onClick(() => {
              let newVal = this.syncProgress + 0.1;
              if (newVal > 1) newVal = 1;
              this.syncProgress = newVal;
            })
            .backgroundColor('#6750A4') // Approximation of primary
            .borderRadius(999) // CircleShape
            .width(40)
            .height(40)

            // === Button (-) ===
            Button() {
              Text('-')
            }
            .onClick(() => {
              let newVal = this.syncProgress - 0.1;
              if (newVal < 0) newVal = 0;
              this.syncProgress = newVal;
            })
            .backgroundColor('#9A8266') // Approximation of secondary
            .borderRadius(999) // CircleShape
            .width(40)
            .height(40)
          }
        }
        .alignItems(HorizontalAlign.Center)
        .padding({ bottom: 32 })
        .alignSelf(ItemAlign.End)
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#9A8266', 0.2], // secondary with alpha approx
          ['#FFFBF2', 1.0], // background
          ['#6750A4', 0.2]  // primary with alpha approx
        ]
      })

      // === CenterAlignedTopAppBar (Row) ===
      Row() {
        Text('Transfer Wizard')
          .fontColor('#1E1E1E')
          .fontSize(32) // Approximation of displayLarge
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFBF2')
      .alignSelf(ItemAlign.Start)
    }
    .width('100%')
    .height('100%')
  }
}