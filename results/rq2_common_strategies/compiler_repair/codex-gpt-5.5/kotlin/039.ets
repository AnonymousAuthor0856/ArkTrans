class InstallmentColors {
  static primary: string = '#FFA500';
  static secondary: string = '#FFC107';
  static tertiary: string = '#FFE066';
  static background: string = '#FFFBF2';
  static surface: string = '#FFFFFF';
  static translucentSurface: string = '#E6FFFFFF';
  static surfaceVariant: string = '#FFEED6';
  static outline: string = '#F1C27D';
  static onPrimary: string = '#FFFFFF';
  static onTertiary: string = '#1E1E1E';
  static onSurface: string = '#1E1E1E';
}

@Entry
@Component
struct Index {
  @State paymentProgress: number = 30;

  @Builder
  TrendSegment(width: number, height: number, offsetY: number) {
    Text('')
      .width(width)
      .height(height)
      .backgroundColor(InstallmentColors.primary)
      .borderRadius(3)
      .translate({ y: offsetY })
  }

  @Builder
  ChartPanel() {
    Row() {
      this.TrendSegment(24, 5, 20 - this.paymentProgress * 0.10)
      this.TrendSegment(24, 5, 4 - this.paymentProgress * 0.06)
      this.TrendSegment(24, 5, -16 + this.paymentProgress * 0.04)
      this.TrendSegment(24, 5, 18 + this.paymentProgress * 0.03)
      this.TrendSegment(24, 5, 28 - this.paymentProgress * 0.09)
      this.TrendSegment(24, 5, -8 - this.paymentProgress * 0.04)
      this.TrendSegment(24, 5, -22 + this.paymentProgress * 0.05)
    }
    .width('100%')
    .height(240)
    .padding(16)
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(InstallmentColors.translucentSurface)
    .borderRadius(20)
    .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })
  }

  build() {
    Column() {
      Text('Installment Plan')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(InstallmentColors.onSurface)
        .lineHeight(34)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 12, bottom: 12 })

      Column() {
        this.ChartPanel()

        Text('Payment Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(InstallmentColors.primary)
          .lineHeight(24)
          .margin({ top: 16 })

        Progress({ value: this.paymentProgress, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(InstallmentColors.primary)
          .backgroundColor(InstallmentColors.surfaceVariant)

        Slider({ value: this.paymentProgress, min: 0, max: 100, step: 1 })
          .width('100%')
          .selectedColor(InstallmentColors.primary)
          .trackColor(InstallmentColors.surfaceVariant)
          .blockColor(InstallmentColors.secondary)
          .onChange((value: number) => {
            this.paymentProgress = value;
          })

        Button('Reset Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(InstallmentColors.onTertiary)
          .width('100%')
          .height(48)
          .backgroundColor(InstallmentColors.tertiary)
          .borderRadius(12)
          .onClick(() => {
            this.paymentProgress = 0;
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#40FFC107', 0.0], [InstallmentColors.background, 0.5], ['#40FFA500', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(InstallmentColors.background)
  }
}
