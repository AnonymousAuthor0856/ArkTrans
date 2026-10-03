// entry/src/main/ets/pages/Index.ets

@Entry
@Component
struct BillCalendarPage {
  @State spending: number = 500;
  private readonly goal: number = 1000;

  // AppTokens Colors
  private readonly primaryColor: string = '#06B6D4';
  private readonly secondaryColor: string = '#3B82F6';
  private readonly tertiaryColor: string = '#8B5CF6';
  private readonly backgroundColor: string = '#F0F9FF';
  private readonly surfaceColor: string = '#FFFFFF';
  private readonly surfaceVariantColor: string = '#E0F2FE';
  private readonly onSurfaceColor: string = '#0F172A';
  private readonly onTertiaryColor: string = '#FFFFFF';

  build() {
    Column() {
      // Top Bar Area (Simulated)
      Row() {
        Text('Bill Calendar')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onSurfaceColor)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Color(this.backgroundColor))

      // Main Content Area with Gradient Background
      Column() {
        // Spending Card
        Column() {
          Text('Current Spending')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.primaryColor)
            .alignSelf(ItemAlign.Start)

          Text(`$${this.spending} / $${this.goal}`)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.onSurfaceColor)
            .margin({ top: 10 })

          // Progress Indicator
          Row() {
            // Active Track
            Row()
              .width(`${(this.spending / this.goal) * 100}%`)
              .height(8)
              .borderRadius(4)
              .backgroundColor(this.primaryColor)

            // Inactive Track
            Row()
              .width(`${100 - (this.spending / this.goal) * 100}%`)
              .height(8)
              .borderRadius(4)
              .backgroundColor(this.surfaceVariantColor)
          }
          .width('100%')
          .margin({ top: 20 })
        }
        .width('100%')
        .padding(16)
        .borderRadius(20)
        .backgroundColor(Color.White)
        .shadow({ radius: 10, color: 'rgba(0, 0, 0, 0.1)', offsetY: 4 })
        .height(160)

        // Slider Section
        Column() {
          Text('Adjust Spending')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurfaceColor)
            .textAlign(TextAlign.Center)
            .margin({ bottom: 16 })

          Slider({
            value: this.spending,
            min: 0,
            max: 2000,
            step: 1,
            style: SliderStyle.OutSet
          })
            .trackColor({ active: Color(this.primaryColor), inactive: Color(this.surfaceVariantColor) })
            .selectedColor(this.secondaryColor)
            .blockColor(this.secondaryColor)
            .width('100%')
        }
        .width('100%')
        .margin({ top: 24 })

        // Reset Button
        Button('Reset')
          .type(ButtonType.Capsule)
          .backgroundColor(this.tertiaryColor)
          .fontColor(this.onTertiaryColor)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .height(48)
          .margin({ top: 24 })
          .onClick(() => {
            this.spending = 0;
          })
      }
      .width('100%')
      .padding(16)
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#3B82F6', 0.3],
          ['#F0F9FF', 0.5],
          ['#06B6D4', 0.2]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color(this.backgroundColor))
  }
}