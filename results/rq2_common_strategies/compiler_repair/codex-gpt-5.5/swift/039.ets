@Entry
@Component
struct Index {
  @State paymentProgress: number = 0.3

  private waveHeight(index: number): number {
    return 88 + Math.sin(index * Math.PI / 5 + this.paymentProgress * Math.PI) * 62
  }

  @Builder
  WaveSurface() {
    Stack() {
      Rect()
        .width('100%')
        .height('100%')
        .radius(20)
        .fill('#E6FFFFFF')

      Row() {
        ForEach([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], (index: number) => {
          Column() {
            Blank()
              .height(this.waveHeight(index))
            Circle()
              .width(10)
              .height(10)
              .fill('#FFA500')
            Rect()
              .width(5)
              .height(Math.max(16, 164 - this.waveHeight(index)))
              .radius(3)
              .fill('#FFE066')
          }
          .height(190)
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
        }, (index: number) => index.toString())
      }
      .width('100%')
      .height(190)
      .padding({ left: 12, right: 12 })
    }
    .width('100%')
    .height(240)
    .padding(16)
    .backgroundColor('#E6FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 8, color: '#2E000000', offsetY: 4 })
  }

  @Builder
  ProgressBar() {
    Stack({ alignContent: Alignment.Start }) {
      Rect()
        .width('100%')
        .height(8)
        .radius(4)
        .fill('#FFEED6')
      Rect()
        .width(`${Math.max(0, Math.min(100, this.paymentProgress * 100))}%`)
        .height(8)
        .radius(4)
        .fill('#FFA500')
    }
    .width('100%')
    .height(8)
  }

  build() {
    Column() {
      Text('Installment Plan')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(64)
        .backgroundColor('#FFFBF2')

      Column() {
        this.WaveSurface()

        Text('Payment Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFA500')
          .margin({ top: 16 })

        Column() {
          this.ProgressBar()
        }
        .width('100%')
        .margin({ top: 16 })

        Slider({ value: this.paymentProgress, min: 0, max: 1, step: 0.01 })
          .blockColor('#FFC107')
          .selectedColor('#FFA500')
          .trackColor('#FFEED6')
          .width('100%')
          .margin({ top: 16 })
          .onChange((value: number) => {
            this.paymentProgress = value
          })

        Button('Reset Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E1E1E')
          .width('100%')
          .height(48)
          .backgroundColor('#FFE066')
          .borderRadius(12)
          .margin({ top: 16 })
          .onClick(() => {
            this.paymentProgress = 0
          })
      }
      .layoutWeight(1)
      .width('100%')
      .padding(16)
      .linearGradient({
        angle: 180,
        colors: [['#40FFC107', 0.0], ['#FFFBF2', 0.5], ['#40FFA500', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFBF2')
  }
}
