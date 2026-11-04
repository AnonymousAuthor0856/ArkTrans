@Entry
@Component
struct Index {
  @State selectedChip: string = 'BTC'
  @State progress: number = 0.6
  @State isAutoUpdate: boolean = true

  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA']
  private waveHeight(index: number): number {
    return 94 + Math.sin(index * Math.PI / 6 + this.progress * Math.PI) * 72
  }

  @Builder
  FilterChip(text: string) {
    Button(text)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor('#1E1E1E')
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor(this.selectedChip === text ? '#FFA8A8' : '#F7F7F7')
      .borderRadius(6)
      .onClick(() => {
        this.selectedChip = text
      })
  }

  @Builder
  ChartSurface() {
    Stack() {
      Rect()
        .width('100%')
        .height('100%')
        .radius(20)
        .fill('#FFFFFF')

      Row() {
        ForEach([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], (index: number) => {
          Column() {
            Blank()
              .height(this.waveHeight(index))
            Circle()
              .width(9)
              .height(9)
              .fill('#FFA8A8')
            Rect()
              .width(5)
              .height(Math.max(18, 184 - this.waveHeight(index)))
              .radius(3)
              .fill('#FFE1A8')
          }
          .height(212)
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
        }, (index: number) => index.toString())
      }
      .width('100%')
      .height(212)
      .padding({ left: 10, right: 10 })
    }
    .width('100%')
    .height(260)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 8, color: '#2E000000', offsetY: 4 })
  }

  @Builder
  LinearProgress() {
    Stack({ alignContent: Alignment.Start }) {
      Rect()
        .width('100%')
        .height(8)
        .radius(4)
        .fill('#F7F7F7')
      Rect()
        .width(`${Math.max(0, Math.min(100, this.progress * 100))}%`)
        .height(8)
        .radius(4)
        .fill('#FFA8A8')
    }
    .width('100%')
    .height(8)
  }

  build() {
    Stack() {
      Column() {
        Text('Crypto Market')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 16, bottom: 16 })
          .backgroundColor('#FFFCF5')

        Column() {
          Row() {
            ForEach(this.chips, (chip: string) => {
              Column() {
                this.FilterChip(chip)
              }
              .margin({ right: chip === 'ADA' ? 0 : 12 })
            }, (chip: string) => chip)
          }
          .justifyContent(FlexAlign.Center)

          Column() {
            this.ChartSurface()
          }
          .margin({ top: 16 })

          Text('Price Variation')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFA8A8')
            .margin({ top: 16 })

          Column() {
            this.LinearProgress()
          }
          .width('100%')
          .margin({ top: 16 })

          Row() {
            Text('Auto Update')
              .fontSize(14)
              .fontColor('#1E1E1E')
            Blank()
            Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
              .selectedColor('#FFA8A8')
              .onChange((value: boolean) => {
                this.isAutoUpdate = value
              })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .margin({ top: 16 })
        }
        .layoutWeight(1)
        .width('100%')
        .padding(16)
        .linearGradient({
          angle: 180,
          colors: [['#4DFFE1A8', 0.0], ['#FFFCF5', 0.5], ['#4DA8FFE1', 1.0]]
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFCF5')
  }
}
