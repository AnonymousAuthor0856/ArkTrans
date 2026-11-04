class StockColors {
  static primary: string = '#2563EB';
  static secondary: string = '#60A5FA';
  static tertiary: string = '#93C5FD';
  static background: string = '#F8FAFC';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E2E8F0';
  static outline: string = '#CBD5E1';
  static onPrimary: string = '#FFFFFF';
  static onSurface: string = '#0F172A';
}

@Entry
@Component
struct Index {
  @State progress: number = 50;

  @Builder
  TrendSegment(width: number, height: number, offsetY: number) {
    Text('')
      .width(width)
      .height(height)
      .backgroundColor(StockColors.primary)
      .borderRadius(2)
      .translate({ y: offsetY })
  }

  @Builder
  ChartView() {
    Column() {
      Row() {
        this.TrendSegment(22, 4, 24 - this.progress * 0.10)
        this.TrendSegment(22, 4, 4 - this.progress * 0.05)
        this.TrendSegment(22, 4, -18 + this.progress * 0.03)
        this.TrendSegment(22, 4, 12 + this.progress * 0.06)
        this.TrendSegment(22, 4, 28 - this.progress * 0.08)
        this.TrendSegment(22, 4, -4 - this.progress * 0.05)
        this.TrendSegment(22, 4, -22 + this.progress * 0.04)
        this.TrendSegment(22, 4, 8 + this.progress * 0.02)
        this.TrendSegment(22, 4, 24 - this.progress * 0.06)
        this.TrendSegment(22, 4, -10 + this.progress * 0.04)
      }
      .width('100%')
      .height(180)
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center)

      Row() {
        ForEach(['09', '10', '11', '12', '13'], (label: string) => {
          Text(label)
            .fontSize(12)
            .fontColor(StockColors.tertiary)
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
        }, (label: string) => label)
      }
      .width('100%')
    }
    .width('100%')
    .height(260)
    .padding(14)
    .backgroundColor(StockColors.surface)
    .borderRadius(16)
    .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })
  }

  build() {
    Column() {
      Text('Stock K-Line')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(StockColors.onSurface)
        .lineHeight(34)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 12, bottom: 12 })

      Column() {
        this.ChartView()

        Text('Market Trend')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(StockColors.primary)
          .lineHeight(24)
          .margin({ top: 14 })

        Slider({ value: this.progress, min: 0, max: 100, step: 1 })
          .width('100%')
          .selectedColor(StockColors.secondary)
          .trackColor(StockColors.surfaceVariant)
          .blockColor(StockColors.primary)
          .onChange((value: number) => {
            this.progress = value;
          })

        Progress({ value: this.progress, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(StockColors.primary)
          .backgroundColor(StockColors.surfaceVariant)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(14)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#2660A5FA', 0.0], [StockColors.background, 0.5], ['#262563EB', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(StockColors.background)
  }
}
