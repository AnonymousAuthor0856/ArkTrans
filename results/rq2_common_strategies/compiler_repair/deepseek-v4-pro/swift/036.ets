@Entry
@Component
struct RootScreen {
  @State selectedChip: string = "BTC"
  @State progress: number = 0.6
  @State isAutoUpdate: boolean = true
  private chips: string[] = ["BTC", "ETH", "SOL", "ADA"]

  build() {
    Stack() {
      Column({ space: 0 }) {
        // Top bar
        Text('Crypto Market')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#FF1E1E1E')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 16, bottom: 16 })
          .backgroundColor('#FFFFFCF5')

        // Content area with gradient
        Column({ space: 16 }) {
          // Filter chips row
          Row({ space: 12 }) {
            ForEach(this.chips, (chip: string) => {
              Button() {
                Text(chip)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#FF1E1E1E')
                  .padding({ left: 12, right: 12, top: 8, bottom: 8 })
              }
              .backgroundColor(this.selectedChip === chip ? '#FFFFA8A8' : '#FFF7F7F7')
              .borderRadius(6)
              .onClick(() => {
                this.selectedChip = chip
              })
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)

          // Chart surface
          Stack() {
            Column() {
              Text('Chart')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#FF1E1E1E')
                .textAlign(TextAlign.Center)
            }
            .width('100%')
            .height(260)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          }
          .width('100%')
          .height(260)
          .backgroundColor('#FFFFFFFF')
          .borderRadius(20)
          .shadow({
            radius: 8,
            color: 'rgba(0,0,0,0.18)',
            offsetX: 0,
            offsetY: 4
          })

          // Price Variation text
          Text('Price Variation')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FFFFA8A8')
            .width('100%')

          // Progress indicator
          Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color('#FFFFA8A8')
            .backgroundColor('#FFF7F7F7')
            .borderRadius(4)

          // Auto update row
          Row({ space: 0 }) {
            Text('Auto Update')
              .fontSize(14)
              .fontWeight(FontWeight.Regular)
              .foregroundColor('#FF1E1E1E')
            Blank().layoutWeight(1)
            Button() {
              Text(this.isAutoUpdate ? 'ON' : 'OFF')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#FF1E1E1E')
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            }
            .backgroundColor(this.isAutoUpdate ? '#FFFFA8A8' : '#FFF7F7F7')
            .borderRadius(12)
            .onClick(() => {
              this.isAutoUpdate = !this.isAutoUpdate
            })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, top: 16, bottom: 16 })
        .linearGradient({
          colors: [['rgba(255,225,168,0.3)', 0], ['#FFFFFCF5', 0.5], ['rgba(168,255,225,0.3)', 1]],
          direction: GradientDirection.Bottom
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFCF5')
  }
}