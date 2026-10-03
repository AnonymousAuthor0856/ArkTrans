@Entry
@Component
struct OrderTrackingPage {
  @State private progress: number = 0.45;
  private primaryColor: string = '#FF7043';
  private secondaryColor: string = '#FFB74D';
  private tertiaryColor: string = '#FFD180';
  private backgroundColor: string = '#FFF3E0';
  private surfaceColor: string = '#FFFFFF';
  private surfaceVariantColor: string = '#FFE0B2';
  private outlineColor: string = '#D7CCC8';
  private successColor: string = '#66BB6A';
  private warningColor: string = '#FFCA28';
  private errorColor: string = '#D32F2F';
  private onPrimaryColor: string = '#FFFFFF';
  private onSecondaryColor: string = '#3E2723';
  private onBackgroundColor: string = '#3E2723';
  private onSurfaceColor: string = '#3E2723';

  build() {
    Column() {
      Column() {
        Text('Order Tracking')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onBackgroundColor)
          .margin({ bottom: 16 })

        Column() {
          Text('Order #25491')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurfaceColor)
            .margin({ bottom: 10 })

          Text('Estimated Delivery: 2 days')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(this.secondaryColor)
            .margin({ bottom: 10 })

          Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
            .width('100%')
            .height(10)
            .color(this.primaryColor)
            .backgroundColor(this.surfaceVariantColor)
            .borderRadius(5)
            .margin({ bottom: 10 })

          Row() {
            Text('Processing')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.secondaryColor)
            Blank()
            Text(`${Math.round(this.progress * 100)}%`)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.primaryColor)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width('100%')
        .padding(16)
        .backgroundColor(this.surfaceColor)
        .borderRadius(16)
        .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.15)', offsetY: 4 })
        .margin({ bottom: 16 })

        Column() {
          Text('Adjust Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurfaceColor)
            .margin({ bottom: 10 })

          Slider({ value: this.progress, min: 0, max: 1, style: SliderStyle.OutSet })
            .width('100%')
            .blockColor(this.primaryColor)
            .selectedColor(this.primaryColor)
            .trackColor(this.surfaceVariantColor)
            .onChange((value: number) => {
              this.progress = value;
            })
            .margin({ bottom: 10 })

          Button('Mark as Delivered')
            .width('100%')
            .height(40)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onPrimaryColor)
            .backgroundColor(this.primaryColor)
            .borderRadius(10)
            .onClick(() => {
              this.progress = 1;
            })
        }
        .width('100%')
        .padding(16)
        .backgroundColor(this.surfaceColor)
        .borderRadius(16)
        .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.15)', offsetY: 4 })
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor(this.backgroundColor)
    }
    .width('100%')
    .height('100%')
  }
}