@Entry
@Component
struct TransferWizard {
  @State progress: number = 0.4

  build() {
    Column() {
      // Top Bar
      Text('Transfer Wizard')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 50, bottom: 16 })

      // Main Content Area
      Stack() {
        // Background Gradient Simulation (using a large colored box to match screenshot style)
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('#FFF8E1') // Approximation of the warm gradient base

        // Canvas Layer
        Canvas(this.getContext())
          .width('100%')
          .height('100%')

        // Bottom Controls
        Column({ space: 16 }) {
          Text('Transfer Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E1E1E')

          // Progress Bar
          Row() {
            Row()
              .width(`${this.progress * 100}%`)
              .height(8)
              .borderRadius(4)
              .backgroundColor('#FFA500')
          }
          .width('80%')
          .height(8)
          .borderRadius(4)
          .backgroundColor('#FFEED6')

          // Buttons
          Row({ space: 12 }) {
            Button('+')
              .type(ButtonType.Capsule)
              .backgroundColor('#FFA500')
              .fontColor('#FFFFFF')
              .fontSize(24)
              .width(60)
              .height(60)
              .onClick(() => {
                this.progress = Math.min(this.progress + 0.1, 1.0)
              })

            Button('-')
              .type(ButtonType.Capsule)
              .backgroundColor('#FFC300')
              .fontColor('#1E1E1E')
              .fontSize(24)
              .width(60)
              .height(60)
              .onClick(() => {
                this.progress = Math.max(this.progress - 0.1, 0.0)
              })
          }
        }
        .alignSelf(ItemAlign.End)
        .margin({ bottom: 32 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFBF2')
  }

  getContext(): CanvasRenderingContext2D {
    const context = new CanvasRenderingContext2D();
    return context;
  }
}