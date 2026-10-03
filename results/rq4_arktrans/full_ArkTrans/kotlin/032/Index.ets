@Entry
@Component
struct Index {
  @State syncProgress: number = 0.3

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Scaffold Content (Background & Main UI) ===
      Stack({ alignContent: Alignment.Center }) {
        // Background Gradient
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            angle: 90,
            colors: [['#FFF8E7', 0], ['#FFE4B5', 0.5], ['#FFDAB9', 1]]
          })

        // Decorative Canvas Elements (Simulated with Shapes)
        Stack() {
          // Large faint circle
          Circle()
            .width(260)
            .height(260)
            .fill('#FFE4C4')
            .opacity(0.4)
          
          // Small orange dot top-left
          Circle()
            .width(24)
            .height(24)
            .fill('#FFA500')
            .position({ x: -60, y: -80 })
            
          // Small orange dot bottom-right
          Circle()
            .width(6)
            .height(6)
            .fill('#FFA500')
            .position({ x: 120, y: 100 })
        }

        // Main Content Column
        Column({ space: 16 }) {
          Text('Transfer Progress')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E1E1E')

          // Linear Progress Indicator
          Progress({ value: this.syncProgress, total: 1, type: ProgressType.Linear })
            .width('80%')
            .height(8)
            .color('#FFA500')
            .backgroundColor('#FFEED6')
            .borderRadius(4)

          // Control Buttons Row
          Row({ space: 12 }) {
            Button() {
              Text('+')
                .fontSize(24)
                .fontColor('#FFFFFF')
            }
            .width(64)
            .height(64)
            .backgroundColor('#FFA500')
            .borderRadius(32)
            .onClick(() => {
              if (this.syncProgress < 1) {
                this.syncProgress += 0.1
              }
            })

            Button() {
              Text('-')
                .fontSize(24)
                .fontColor('#FFFFFF')
            }
            .width(64)
            .height(64)
            .backgroundColor('#FFC107')
            .borderRadius(32)
            .onClick(() => {
              if (this.syncProgress > 0) {
                this.syncProgress -= 0.1
              }
            })
          }
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.End)
        .padding({ bottom: 32 })
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')

      // === Top App Bar ===
      Row() {
        Text('Transfer Wizard')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(80)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFBF2')
    }
    .width('100%')
    .height('100%')
  }
}