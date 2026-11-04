class OrderColors {
  static primary: string = '#FF7043';
  static secondary: string = '#FFB74D';
  static tertiary: string = '#FFD180';
  static background: string = '#FFF3E0';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#FFE0B2';
  static outline: string = '#D7CCC8';
  static onPrimary: string = '#FFFFFF';
  static onSurface: string = '#3E2723';
}

@Entry
@Component
struct Index {
  @State progress: number = 45;

  @Builder
  OrderCard() {
    Column() {
      Text('Order #25491')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(OrderColors.onSurface)
        .lineHeight(24)
        .width('100%')
      Text('Estimated Delivery: 2 days')
        .fontSize(14)
        .fontColor(OrderColors.secondary)
        .lineHeight(20)
        .width('100%')
        .margin({ top: 10 })
      Progress({ value: this.progress, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(10)
        .color(OrderColors.primary)
        .backgroundColor(OrderColors.surfaceVariant)
        .margin({ top: 10 })
      Row() {
        Text('Processing')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(OrderColors.secondary)
        Text(Math.floor(this.progress).toString() + '%')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(OrderColors.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 10 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(OrderColors.surface)
    .borderRadius(16)
    .shadow({ radius: 8, color: '#26000000', offsetX: 0, offsetY: 4 })
  }

  @Builder
  AdjustCard() {
    Column() {
      Text('Adjust Progress')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(OrderColors.onSurface)
        .lineHeight(24)
      Slider({ value: this.progress, min: 0, max: 100, step: 1 })
        .width('100%')
        .selectedColor(OrderColors.primary)
        .trackColor(OrderColors.surfaceVariant)
        .blockColor(OrderColors.primary)
        .onChange((value: number) => {
          this.progress = value;
        })
      Button('Mark as Delivered')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(OrderColors.onPrimary)
        .width('100%')
        .height(44)
        .backgroundColor(OrderColors.primary)
        .borderRadius(10)
        .onClick(() => {
          this.progress = 100;
        })
    }
    .width('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(OrderColors.surface)
    .borderRadius(16)
  }

  build() {
    Column() {
      Text('Order Tracking')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(OrderColors.onSurface)
        .lineHeight(34)
        .width('100%')

      Column() {
        this.OrderCard()
      }
      .width('100%')
      .margin({ top: 16 })

      Column() {
        this.AdjustCard()
      }
      .width('100%')
      .margin({ top: 16 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor(OrderColors.background)
  }
}
