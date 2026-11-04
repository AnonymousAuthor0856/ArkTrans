class BillColors {
  static primary: string = '#06B6D4';
  static secondary: string = '#3B82F6';
  static tertiary: string = '#8B5CF6';
  static background: string = '#F0F9FF';
  static surface: string = '#FFFFFF';
  static translucentSurface: string = '#E6FFFFFF';
  static surfaceVariant: string = '#E0F2FE';
  static outline: string = '#BAE6FD';
  static onPrimary: string = '#FFFFFF';
  static onTertiary: string = '#FFFFFF';
  static onSurface: string = '#0F172A';
}

@Entry
@Component
struct Index {
  @State spending: number = 500;
  private goal: number = 1000;

  private spendingProgress(): number {
    let value: number = this.spending / this.goal * 100;
    if (value > 100) {
      value = 100;
    }
    if (value < 0) {
      value = 0;
    }
    return value;
  }

  @Builder
  SpendingCard() {
    Column() {
      Text('Current Spending')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(BillColors.primary)
        .lineHeight(24)
      Text('$' + Math.floor(this.spending).toString() + ' / $' + Math.floor(this.goal).toString())
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(BillColors.onSurface)
        .lineHeight(34)
      Progress({ value: this.spendingProgress(), total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(8)
        .color(BillColors.primary)
        .backgroundColor(BillColors.surfaceVariant)
    }
    .width('100%')
    .height(160)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(BillColors.translucentSurface)
    .borderRadius(20)
    .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })
  }

  build() {
    Column() {
      Text('Bill Calendar')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(BillColors.onSurface)
        .lineHeight(34)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 12, bottom: 12 })

      Column() {
        this.SpendingCard()

        Text('Adjust Spending')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(BillColors.onSurface)
          .lineHeight(24)
          .margin({ top: 16 })

        Slider({ value: this.spending, min: 0, max: 2000, step: 1 })
          .width('100%')
          .selectedColor(BillColors.primary)
          .trackColor(BillColors.surfaceVariant)
          .blockColor(BillColors.secondary)
          .onChange((value: number) => {
            this.spending = value;
          })

        Button('Reset')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(BillColors.onTertiary)
          .width('100%')
          .height(48)
          .backgroundColor(BillColors.tertiary)
          .borderRadius(12)
          .margin({ top: 16 })
          .onClick(() => {
            this.spending = 0;
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#4D3B82F6', 0.0], [BillColors.background, 0.5], ['#3306B6D4', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BillColors.background)
  }
}
