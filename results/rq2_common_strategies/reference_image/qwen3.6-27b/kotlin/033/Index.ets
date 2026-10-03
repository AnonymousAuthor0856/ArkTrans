// entry/src/main/ets/pages/Index.ets

@Entry
@Component
struct BillCalendarPage {
  @State spending: number = 500;
  private readonly goal: number = 1000;

  // Color Tokens
  private readonly primaryColor = '#06B6D4';
  private readonly secondaryColor = '#3B82F6';
  private readonly tertiaryColor = '#8B5CF6';
  private readonly backgroundColor = '#F0F9FF';
  private readonly surfaceColor = '#FFFFFF';
  private readonly surfaceVariantColor = '#E0F2FE';
  private readonly onSurfaceColor = '#0F172A';
  private readonly onTertiaryColor = '#FFFFFF';

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
      .backgroundColor(this.backgroundColor)

      // Main Content Area with Gradient Background
      Column() {
        // Spending Card
        Column({ space: 16 }) {
          Text('Current Spending')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.primaryColor)
            .alignSelf(ItemAlign.Start)

          Text(`$${this.spending} / $${this.goal}`)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.onSurfaceColor)
            .alignSelf(ItemAlign.Start)

          // Progress Bar
          Row() {
            Stack() {
              // Track
              Rect()
                .fill(this.surfaceVariantColor)
                .borderRadius(4)

              // Progress Fill
              Rect()
                .fill(this.primaryColor)
                .borderRadius(4)
                .width(`${Math.min((this.spending / this.goal) * 100, 100)}%`)
            }
            .clip(true)
          }
          .width('100%')
          .height(8)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 16, bottom: 16 })
        .backgroundColor(Color.White)
        .borderRadius(20)
        .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.18)', offsetY: 4 })
        .margin({ top: 16, bottom: 16 })

        // Slider Section
        Column({ space: 16 }) {
          Text('Adjust Spending')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurfaceColor)
            .textAlign(TextAlign.Center)

          Slider({ value: this.spending, min: 0, max: 2000, step: 1 }) {
            .trackColor(this.surfaceVariantColor)
            .selectedColor(this.primaryColor)
            .blockColor(this.secondaryColor)
            .width('100%')
            .onChange((value: number) => {
              this.spending = Math.round(value);
            })
          }
        }
        .width('100%')
        .margin({ top: 16, bottom: 16 })

        // Reset Button
        Button('Reset')
          .type(ButtonType.Capsule)
          .backgroundColor(this.tertiaryColor)
          .fontColor(this.onTertiaryColor)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .height(48)
          .onClick(() => {
            this.spending = 0;
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#06B6D4', 0.2],
          ['#F0F9FF', 0.5],
          ['#3B82F6', 0.3]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
}