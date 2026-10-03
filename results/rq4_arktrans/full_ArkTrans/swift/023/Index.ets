@Entry
@Component
struct Index {
  @State isRunning: boolean = false

  build() {
    Stack() {
      Column({ space: 0 }) {
        Blank().height(12)

        Row() {
          Text('Pomodoro Timer')
            .fontColor('#1E1E1E')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)

        Column({ space: 24 }) {
          // Circular Timer Graphic
          Stack() {
            Circle()
              .width(280)
              .height(280)
              .fill('#FDE2E4')
              .shadow({ radius: 20, color: '#1F000000', offsetY: 5 })

            Circle()
              .width(180)
              .height(180)
              .fill('#B4E3D0')
              .opacity(0.4)

            Circle()
              .width(60)
              .height(60)
              .fill('#FF8FAB')
          }
          .width(280)
          .height(280)

          // Status Text
          Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
            .fontColor(this.isRunning ? '#4CAF50' : '#FF8FAB')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)

          // Control Buttons
          Row({ space: 24 }) {
            Button() {
              Text('Start')
                .fontColor('#FFFFFF')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
            }
            .width(90)
            .height(90)
            .backgroundColor('#FF8FAB')
            .borderRadius(45)
            .onClick(() => {
              this.isRunning = true
            })

            Button() {
              Text('Stop')
                .fontColor('#1E1E1E')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
            }
            .width(90)
            .height(90)
            .backgroundColor('#FFD6A5')
            .borderRadius(45)
            .onClick(() => {
              this.isRunning = false
            })
          }

          // Progress Bar
          Stack({ alignContent: Alignment.Start }) {
            Rect()
              .width('100%')
              .height(8)
              .fill('#FDE2E4')
              .borderRadius(4)

            Rect()
              .width('40%')
              .height(8)
              .fill('#FF8FAB')
              .borderRadius(4)
          }
          .width('100%')
          .padding({ left: 16, right: 16 })
        }
        .alignItems(HorizontalAlign.Center)
        .padding({ top: 16 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFDF7')
    }.width('100%').height('100%')
  }
}