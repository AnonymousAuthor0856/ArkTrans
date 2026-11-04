class CryptoColors {
  static primary: string = '#FFA8A8';
  static secondary: string = '#FFE1A8';
  static tertiary: string = '#A8FFE1';
  static background: string = '#FFFCF5';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#F7F7F7';
  static outline: string = '#E2E2E2';
  static onPrimary: string = '#1E1E1E';
  static onSurface: string = '#1E1E1E';
}

@Entry
@Component
struct Index {
  @State selectedChip: string = 'BTC';
  @State progress: number = 60;
  @State isAutoUpdate: boolean = true;

  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA'];

  @Builder
  CoinChip(label: string) {
    Text(label)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(CryptoColors.onPrimary)
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor(this.selectedChip === label ? CryptoColors.primary : CryptoColors.surfaceVariant)
      .borderRadius(16)
      .onClick(() => {
        this.selectedChip = label;
      })
  }

  @Builder
  TrendSegment(width: number, height: number, offsetY: number) {
    Text('')
      .width(width)
      .height(height)
      .backgroundColor(CryptoColors.primary)
      .borderRadius(3)
      .translate({ y: offsetY })
  }

  @Builder
  MarketChart() {
    Row() {
      this.TrendSegment(24, 5, 20 - this.progress * 0.08)
      this.TrendSegment(24, 5, 2 - this.progress * 0.04)
      this.TrendSegment(24, 5, -18 + this.progress * 0.02)
      this.TrendSegment(24, 5, 16 + this.progress * 0.03)
      this.TrendSegment(24, 5, 28 - this.progress * 0.08)
      this.TrendSegment(24, 5, -8 - this.progress * 0.04)
      this.TrendSegment(24, 5, -24 + this.progress * 0.04)
      this.TrendSegment(24, 5, 10 + this.progress * 0.02)
    }
    .width('100%')
    .height(260)
    .padding(16)
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(CryptoColors.surface)
    .borderRadius(20)
    .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })
  }

  build() {
    Column() {
      Text('Crypto Market')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(CryptoColors.onSurface)
        .lineHeight(34)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 12, bottom: 12 })

      Column() {
        Row({ space: 12 }) {
          ForEach(this.chips, (chip: string) => {
            this.CoinChip(chip)
          }, (chip: string) => chip)
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')

        Column() {
          this.MarketChart()
        }
        .width('100%')
        .margin({ top: 16 })

        Text('Price Variation')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(CryptoColors.primary)
          .lineHeight(24)
          .margin({ top: 16 })

        Progress({ value: this.progress, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(CryptoColors.primary)
          .backgroundColor(CryptoColors.surfaceVariant)

        Row() {
          Text('Auto Update')
            .fontSize(14)
            .fontColor(CryptoColors.onSurface)
            .lineHeight(20)
          Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
            .selectedColor(CryptoColors.secondary)
            .onChange((isOn: boolean) => {
              this.isAutoUpdate = isOn;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 16 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#4DFFE1A8', 0.0], [CryptoColors.background, 0.5], ['#4DA8FFE1', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(CryptoColors.background)
  }
}
