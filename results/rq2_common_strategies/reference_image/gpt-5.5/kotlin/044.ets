@Entry
@Component
struct OrderTrackingPage {
  @State private progress: number = 0.42;

  private readonly primary: ResourceColor = '#FF7043';
  private readonly secondary: ResourceColor = '#FFB74D';
  private readonly background: ResourceColor = '#FFF3E0';
  private readonly surface: ResourceColor = '#FFFFFF';
  private readonly surfaceVariant: ResourceColor = '#FFE0B2';
  private readonly onPrimary: ResourceColor = '#FFFFFF';
  private readonly onSurface: ResourceColor = '#3E2723';

  @Builder
  private ProgressBar() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(10)
        .borderRadius(5)
        .backgroundColor(this.surfaceVariant)

      Row()
        .width(`${this.progress * 100}%`)
        .height(10)
        .borderRadius(5)
        .backgroundColor(this.primary)
    }
    .width('100%')
    .height(10)
  }

  @Builder
  private OrderCard() {
    Column({ space: 12 }) {
      Text('Order #25491')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.onSurface)

      Text('Estimated Delivery: 2 days')
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(this.secondary)

      this.ProgressBar()

      Row() {
        Text('Processing')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.secondary)

        Text(`${Math.floor(this.progress * 100)}%`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .padding(16)
    .borderRadius(16)
    .backgroundColor(this.surface)
    .shadow({
      radius: 8,
      color: '#26000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  private ProgressSlider() {
    Slider({
      value: this.progress,
      min: 0,
      max: 1,
      step: 0.01,
      style: SliderStyle.OutSet
    })
      .width('100%')
      .selectedColor(this.primary)
      .trackColor(this.surfaceVariant)
      .blockColor(this.primary)
      .onChange((value: number) => {
        this.progress = value;
      })
  }

  @Builder
  private AdjustProgressCard() {
    Column({ space: 16 }) {
      Text('Adjust Progress')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.onSurface)
        .textAlign(TextAlign.Center)
        .width('100%')

      this.ProgressSlider()

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Mark as Delivered')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onPrimary)
      }
      .width('100%')
      .height(50)
      .borderRadius(10)
      .backgroundColor(this.primary)
      .onClick(() => {
        this.progress = 1;
      })
    }
    .width('100%')
    .padding(16)
    .borderRadius(16)
    .backgroundColor(this.surface)
  }

  build() {
    Column({ space: 16 }) {
      Text('Order Tracking')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onSurface)
        .width('100%')

      this.OrderCard()

      this.AdjustProgressCard()
    }
    .width('100%')
    .height('100%')
    .padding({
      left: 16,
      right: 16,
      top: 36,
      bottom: 16
    })
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.background)
  }
}