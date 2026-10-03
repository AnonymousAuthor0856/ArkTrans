@Entry
@Component
struct RootScreen {
  @State spending: number = 500;
  goal: number = 1000;

  // Color tokens
  colorPrimary: string = '#06B6D4';
  colorSecondary: string = '#3B82F6';
  colorTertiary: string = '#8B5CF6';
  colorBackground: string = '#F0F9FF';
  colorSurface: string = '#FFFFFF';
  colorSurfaceVariant: string = '#E0F2FE';
  colorOutline: string = '#BAE6FD';
  colorSuccess: string = '#22C55E';
  colorWarning: string = '#FACC15';
  colorError: string = '#EF4444';
  colorOnPrimary: string = '#FFFFFF';
  colorOnSecondary: string = '#FFFFFF';
  colorOnTertiary: string = '#FFFFFF';
  colorOnBackground: string = '#0F172A';
  colorOnSurface: string = '#0F172A';

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Bill Calendar')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colorOnSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(this.colorBackground)

      // Main content area
      Scroll() {
        Column({ space: 16 }) {
          // Surface Card
          Column() {
            Column({ space: 0 }) {
              Text('Current Spending')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colorPrimary)

              Blank()

              Text('$' + Math.floor(this.spending) + ' / $' + Math.floor(this.goal))
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.colorOnSurface)

              Blank()

              // Progress bar
              Stack({ alignContent: Alignment.Start }) {
                // Track
                Row()
                  .width('100%')
                  .height(8)
                  .borderRadius(4)
                  .backgroundColor(this.colorSurfaceVariant)

                // Progress
                Row()
                  .width((this.spending / this.goal * 100) + '%')
                  .height(8)
                  .borderRadius(4)
                  .backgroundColor(this.colorPrimary)
              }
              .width('100%')
              .height(8)
            }
            .width('100%')
            .height('100%')
            .padding(16)
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('100%')
          .height(160)
          .borderRadius(20)
          .backgroundColor('#E6FFFFFF')
          .shadow({
            radius: 8,
            color: '#2E000000',
            offsetX: 0,
            offsetY: 4
          })

          // Adjust Spending label
          Text('Adjust Spending')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colorOnSurface)

          // Slider
          Column() {
            Slider({
              value: this.spending,
              min: 0,
              max: 2000,
              style: SliderStyle.OutSet
            })
              .trackColor(this.colorSurfaceVariant)
              .selectedColor(this.colorPrimary)
              .blockColor('#FFFFFF')
              .width('100%')
              .onChange((value: number) => {
                this.spending = value;
              })
          }
          .width('100%')

          // Reset Button
          Button('Reset')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colorOnTertiary)
            .width('100%')
            .height(48)
            .backgroundColor(this.colorTertiary)
            .borderRadius(12)
            .onClick(() => {
              this.spending = 0;
            })
        }
        .padding(16)
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#4D3B82F6', 0.0],
          ['#F0F9FF', 0.5],
          ['#3306B6D4', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colorBackground)
  }
}