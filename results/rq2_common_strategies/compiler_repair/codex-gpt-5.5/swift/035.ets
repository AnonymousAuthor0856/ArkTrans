@Entry
@Component
struct Index {
  @State progress: number = 0.5

  private waveHeight(index: number): number {
    return 96 + Math.sin(index * Math.PI / 8 + this.progress * Math.PI) * 72
  }

  @Builder
  LinearProgress() {
    Stack({ alignContent: Alignment.Start }) {
      Rect()
        .width('100%')
        .height(8)
        .radius(4)
        .fill('#E2E8F0')
      Rect()
        .width(`${Math.max(0, Math.min(100, this.progress * 100))}%`)
        .height(8)
        .radius(4)
        .fill('#2563EB')
    }
    .width('100%')
    .height(8)
  }

  @Builder
  ChartCard() {
    Stack() {
      Rect()
        .width('100%')
        .height('100%')
        .radius(16)
        .fill('#FFFFFF')

      Row() {
        ForEach([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], (index: number) => {
          Column() {
            Blank()
              .height(this.waveHeight(index))
            Circle()
              .width(8)
              .height(8)
              .fill('#2563EB')
            Rect()
              .width(4)
              .height(Math.max(16, 180 - this.waveHeight(index)))
              .radius(2)
              .fill('#93C5FD')
          }
          .layoutWeight(1)
          .height(210)
          .alignItems(HorizontalAlign.Center)
        }, (index: number) => index.toString())
      }
      .width('100%')
      .height(210)
      .padding({ left: 8, right: 8 })
    }
    .width('100%')
    .height(260)
    .padding(14)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 8, color: '#2E0F172A', offsetY: 4 })
  }

  build() {
    Column() {
      Stack() {
        Text('Stock K-Line')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
      }
      .width('100%')
      .height(56)
      .backgroundColor('#F8FAFC')

      Column() {
        this.ChartCard()

        Text('Market Trend')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2563EB')
          .margin({ top: 14 })

        Slider({ value: this.progress, min: 0, max: 1, step: 0.01 })
          .blockColor('#2563EB')
          .selectedColor('#2563EB')
          .trackColor('#E2E8F0')
          .width('100%')
          .height(44)
          .margin({ top: 14 })
          .onChange((value: number) => {
            this.progress = value
          })

        Column() {
          this.LinearProgress()
        }
        .width('100%')
        .margin({ top: 14 })
      }
      .layoutWeight(1)
      .width('100%')
      .padding(14)
      .linearGradient({
        angle: 180,
        colors: [['#2660A5FA', 0.0], ['#F8FAFC', 0.5], ['#262563EB', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}
