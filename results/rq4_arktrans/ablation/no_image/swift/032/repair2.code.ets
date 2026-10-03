@Entry
@Component
struct Index {
  @State progress: number = 0.5

  build() {
    Stack() {
      // Simulating WindowGroup/Content structure
      Stack({ alignContent: Alignment.Center }) {
        // Background Gradient
        Column() {
          Text('').width('100%').height('100%')
            .linearGradient({
              direction: GradientDirection.Bottom,
              colors: [
                ['#FFA500', 0.2], // Secondary opacity 0.2 approximated
                ['#FFFFFF', 0.5], // Background
                ['#FFA500', 1.0]  // Primary
              ]
            })
        }.width('100%').height('100%')

        // Main Content Column
        Column() {
          // Title Section
          Row() {
            Text('Transfer Wizard')
              .fontSize(28)
              .fontColor('#1E1E1E')
              .fontWeight(FontWeight.Bold)
          }.width('100%').justifyContent(FlexAlign.Center).margin({ top: 60 })

          // Progress Section Container
          Stack() {
            // Bottom aligned content
            Column() {
              Text('Transfer Progress')
                .fontSize(18)
                .fontColor('#1E1E1E')
                .fontWeight(FontWeight.Medium)
                .margin({ bottom: 16 })

              // Progress Bar
              Progress({ value: this.progress, total: 1.0, type: ProgressType.Linear })
                .width('80%')
                .height(8)
                .color('#FFA500')
                .trackColor('#FFEED6')
                .margin({ bottom: 24 })

              // Controls Row
              Row() {
                // Minus Button
                Button() {
                  Text('-')
                    .fontSize(24)
                    .fontColor('#1E1E1E')
                    .fontWeight(FontWeight.Bold)
                }
                .width(64)
                .height(64)
                .backgroundColor('#FFC300')
                .borderRadius(32)
                .onClick(() => {
                  this.progress = Math.max(this.progress - 0.1, 0.0)
                })

                Blank()

                // Plus Button
                Button() {
                  Text('+')
                    .fontSize(24)
                    .fontColor('#FFFFFF')
                    .fontWeight(FontWeight.Bold)
                }
                .width(64)
                .height(64)
                .backgroundColor('#FFA500')
                .borderRadius(32)
                .onClick(() => {
                  this.progress = Math.min(this.progress + 0.1, 1.0)
                })
              }.width('100%').justifyContent(FlexAlign.SpaceEvenly)

            }
            .width('100%')
            .alignItems(HorizontalAlign.Center)
            .padding({ bottom: 40 })
          }
          .layoutWeight(1)
          .width('100%')
        }
        .width('100%')
        .height('100%')
      }
    }.width('100%').height('100%')
  }
}