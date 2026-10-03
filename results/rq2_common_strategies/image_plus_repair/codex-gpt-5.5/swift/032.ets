@Entry
@Component
struct TransferWizard {
  @State progress: number = 0.4

  private readonly backgroundColorValue: string = '#FFFBF2'
  private readonly surfaceVariant: string = '#FFEED6'
  private readonly primary: string = '#FFA500'
  private readonly secondary: string = '#FFC300'
  private readonly textColor: string = '#1E1E1E'

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Text('Transfer Wizard')
          .fontSize(56)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)
      }
      .width('100%')
      .height(112)
      .backgroundColor(this.backgroundColorValue)

      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(1040)
          .height(1040)
          .fill(this.surfaceVariant)
          .clip(true)

        Circle()
          .width(80)
          .height(80)
          .fill(this.primary)
          .position({ x: '50%', y: '68%' })

        Column({ space: 32 }) {
          Text('Transfer Progress')
            .fontSize(36)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.textColor)

          Stack({ alignContent: Alignment.Start }) {
            Row()
              .width('80%')
              .height(16)
              .borderRadius(8)
              .backgroundColor(this.surfaceVariant)

            Row()
              .width(`${this.progress * 80}%`)
              .height(16)
              .borderRadius(8)
              .backgroundColor(this.primary)
          }
          .width('100%')
          .height(16)

          Row({ space: 24 }) {
            Button('+')
              .width(128)
              .height(128)
              .fontSize(48)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
              .backgroundColor(this.primary)
              .borderRadius(64)
              .onClick(() => {
                this.progress = Math.min(this.progress + 0.1, 1.0)
              })

            Button('-')
              .width(128)
              .height(128)
              .fontSize(48)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.textColor)
              .backgroundColor(this.secondary)
              .borderRadius(64)
              .onClick(() => {
                this.progress = Math.max(this.progress - 0.1, 0.0)
              })
          }
          .justifyContent(FlexAlign.Center)
          .width('100%')
        }
        .width('100%')
        .padding({ left: 48, right: 48, bottom: 64 })
        .position({ x: 0, y: '100%' })
        .translate({ y: -448 })
      }
      .width('100%')
      .layoutWeight(1)
      .clip(true)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [
        [0x33FFC300, 0.0],
        [0xFFFFFBF2, 0.48],
        [0x33FFA500, 1.0]
      ]
    })
  }
}
