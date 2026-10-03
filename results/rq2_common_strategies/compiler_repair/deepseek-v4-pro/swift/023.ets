@Entry
@Component
struct RootScreen {
  @State knobX: number = 140
  @State knobY: number = 140
  @State isRunning: boolean = false

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // Background
      Column() {}.width('100%').height('100%').backgroundColor('#FFFCF9')

      // Main vertical layout
      Column({ space: 0 }) {
        // Spacer
        Blank().height(16)

        // Top bar
        Row() {
          Text('Pomodoro Timer')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .foregroundColor('#1E1E1E')
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FFFCF9')

        // Main content
        Column({ space: 24 }) {
          // Timer Circle area
          Stack({ alignContent: Alignment.TopStart }) {
            // Outer circle (background)
            Button() {}
              .width(280)
              .height(280)
              .borderRadius(140)
              .backgroundColor('#FDE2E4')
              .shadow({ radius: 8, color: '#2E000000', offsetY: 4 })

            // Middle circle (secondary) - smaller
            Button() {}
              .width(180)
              .height(180)
              .borderRadius(90)
              .backgroundColor('#B4E3D0')
              .opacity(0.4)

            // Knob (draggable) - static position for now
            Button() {}
              .width(60)
              .height(60)
              .borderRadius(30)
              .backgroundColor('#FF8FAB')
              .position({ x: this.knobX - 30, y: this.knobY - 30 })
          }
          .width(280)
          .height(280)

          // Focus Mode Text
          Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .foregroundColor(this.isRunning ? '#4ADE80' : '#FB7185')

          // Start/Stop Buttons
          Row({ space: 24 }) {
            Button() {
              Text('Start')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#FFFFFF')
            }
            .width(90)
            .height(90)
            .borderRadius(45)
            .backgroundColor('#FF8FAB')
            .onClick(() => { this.isRunning = true })

            Button() {
              Text('Stop')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#1E1E1E')
            }
            .width(90)
            .height(90)
            .borderRadius(45)
            .backgroundColor('#FFD6A5')
            .onClick(() => { this.isRunning = false })
          }

          // Progress Bar
          Progress({ value: 40, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color('#FF8FAB')
            .backgroundColor('#FDE2E4')
            .padding({ left: 16, right: 16 })
        }
        .padding({ top: 16 })
      }
    }
    .width('100%')
    .height('100%')
  }
}