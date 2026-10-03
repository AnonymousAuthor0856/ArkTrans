@Entry
@Component
struct Index {
  @State it: string = ''
  @State prevY: number = 0
  @State y: number = 0
  @State PriceVariation: number = 0
  @State syncProgress: number = 0.3
  @State AutoUpdate: number = 0
  @State isAutoUpdate: boolean = false
  @State isOn: boolean = false
  @State CryptoMarket: string = 'Crypto Market'
  @State selectedChip: string = 'BTC'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        Row({ space: 12 }) {
          ForEach(['BTC', 'ETH', 'SOL', 'ADA'], (item: string) => {
            Button({ type: ButtonType.Capsule }) {
              Text(item).fontColor(this.selectedChip === item ? '#FFFFFF' : '#1E1E1E')
            }
            .backgroundColor(this.selectedChip === item ? '#6750A4' : '#E7E0EC')
            .onClick(() => {
              this.selectedChip = item
            })
          })
        }

        Column() {
          Canvas().width('100%').height('100%')
        }
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 4, color: '#1A000000' })
        .width('100%')
        .height(260)
        .borderRadius(16)

        Text('Price Variation')
          .fontColor('#FFA8A8')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)

        Progress({ value: this.syncProgress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color('#FFA8A8')
          .linearGradient({
            direction: GradientDirection.Right,
            colors: [['#F7F7F7', 0], ['#F7F7F7', 1]]
          })

        Row() {
          Text('Auto Update')
            .fontColor('#1E1E1E')
            .fontSize(14)
          
          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
            .onChange((isOn: boolean) => {
              this.isAutoUpdate = isOn
            })
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#D0BCFF', 0], ['#FFFCF5', 0.5], ['#FFD8E4', 1]]
      })

      Row() {
        Text(this.CryptoMarket)
          .fontColor('#1E1E1E')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFCF5')
    }
    .width('100%')
    .height('100%')
  }
}