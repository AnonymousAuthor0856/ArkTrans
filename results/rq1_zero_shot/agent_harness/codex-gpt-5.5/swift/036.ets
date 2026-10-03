@Entry
@Component
struct RootScreen {
  @State private selectedChip: string = 'BTC';
  @State private progressValue: number = 0.6;
  @State private isAutoUpdate: boolean = true;

  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA'];

  @Builder
  FilterChip(textValue: string) {
    Button(textValue)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor('#1E1E1E')
      .backgroundColor(this.selectedChip === textValue ? '#FFA8A8' : '#F7F7F7')
      .height(34)
      .padding({ left: 12, right: 12 })
      .borderRadius(6)
      .onClick(() => {
        this.selectedChip = textValue;
      })
  }

  @Builder
  ChartSurface() {
    Stack() {
      Rect()
        .width('100%')
        .height(260)
        .fill('#FFFFFF')
        .radius(20)
      Row() {
        ForEach([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], (i: number) => {
          Rect()
            .width(16)
            .height(36 + Math.abs(Math.sin(i * Math.PI / 6 + this.progressValue * Math.PI)) * 150)
            .fill('#FFA8A8')
            .radius(4)
            .margin({ left: 4, right: 4 })
        }, (i: number) => i.toString())
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(260)
    .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })
  }

  build() {
    Column() {
      Text('Crypto Market')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor('#FFFCF5')

      Column() {
        Row() {
          ForEach(this.chips, (chip: string) => {
            this.FilterChip(chip)
              .margin({ right: 12 })
          }, (chip: string) => chip)
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')

        this.ChartSurface()
          .margin({ top: 16 })

        Text('Price Variation')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFA8A8')
          .margin({ top: 16 })

        Progress({ value: this.progressValue, total: 1, type: ProgressType.Linear })
          .color('#FFA8A8')
          .backgroundColor('#F7F7F7')
          .width('100%')
          .height(8)
          .margin({ top: 16 })

        Row() {
          Text('Auto Update')
            .fontSize(14)
            .fontColor('#1E1E1E')
          Blank()
          Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
            .selectedColor('#FFA8A8')
            .onChange((value: boolean) => {
              this.isAutoUpdate = value;
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 16 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .backgroundColor('#FFFCF5')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFCF5')
  }
}
