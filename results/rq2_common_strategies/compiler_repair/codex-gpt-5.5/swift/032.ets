@Entry
@Component
struct Index {
  @State progress: number = 0.4

  @Builder
  ProgressBar() {
    Stack({ alignContent: Alignment.Start }) {
      Rect()
        .width('80%')
        .height(8)
        .radius(4)
        .fill('#FFEED6')
      Rect()
        .width(`${Math.max(0, Math.min(80, this.progress * 80))}%`)
        .height(8)
        .radius(4)
        .fill('#FFA500')
    }
    .width('100%')
    .height(8)
  }

  @Builder
  RoundButton(label: string, bgColor: string, textColor: string, delta: number) {
    Button(label)
      .fontSize(24)
      .fontWeight(FontWeight.Bold)
      .fontColor(textColor)
      .width(64)
      .height(64)
      .backgroundColor(bgColor)
      .borderRadius(32)
      .onClick(() => {
        const nextValue = this.progress + delta
        this.progress = Math.max(0, Math.min(1, nextValue))
      })
  }

  build() {
    Stack() {
      Column() {
        Blank()
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 180,
        colors: [['#33FFC300', 0.0], ['#FFFBF2', 0.5], ['#33FFA500', 1.0]]
      })

      Column() {
        Stack() {
          Text('Transfer Wizard')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E1E1E')
        }
        .width('100%')
        .height(56)
        .backgroundColor('#FFFBF2')

        Stack() {
          Circle()
            .width(520)
            .height(520)
            .fill('#FFEED6')
            .opacity(0.95)

          Circle()
            .width(40)
            .height(40)
            .fill('#FFA500')
            .translate({ x: -20, y: 90 })

          Column() {
            Blank()

            Text('Transfer Progress')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1E1E1E')
              .margin({ bottom: 16 })

            Column() {
              this.ProgressBar()
            }
            .width('100%')
            .alignItems(HorizontalAlign.Center)
            .margin({ bottom: 16 })

            Row() {
              this.RoundButton('+', '#FFA500', '#FFFFFF', 0.1)
              Blank()
                .width(12)
              this.RoundButton('-', '#FFC300', '#1E1E1E', -0.1)
            }
            .justifyContent(FlexAlign.Center)
          }
          .width('100%')
          .height('100%')
          .padding({ bottom: 32 })
        }
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFBF2')
  }
}
