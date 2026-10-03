@Entry
@Component
struct Index {
  @State selectedChip: string = 'BTC'
  @State isAutoUpdate: boolean = true

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        Row({ space: 12 }) {
          ForEach(['BTC', 'ETH', 'SOL', 'ADA'], (it: string) => {
            Button(it) {
              Text(it).fontColor('#1E1E1E').fontSize(16)
            }
            .backgroundColor(this.selectedChip === it ? '#FFA8A8' : '#F0F0F0')
            .borderWidth(0)
            .borderRadius(8)
            .width('25%')
            .height(40)
            .onClick(() => { this.selectedChip = it })
          })
        }.width('100%')

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
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Progress({ value: 75, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color('#FFA8A8')
          .backgroundColor('#F7F7F7')

        Row() {
          Text('Auto Update')
            .fontColor('#1E1E1E')
            .fontSize(16)
          Blank()
          Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
            .onChange((isOn: boolean) => { this.isAutoUpdate = isOn })
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#FFF9C4', 0], ['#FFFFFF', 0.5], ['#E0F2F1', 1]]
      })

      Row() {
        Text('Crypto Market')
          .fontColor('#1E1E1E')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height(56)
    }
    .width('100%')
    .height('100%')
  }
}