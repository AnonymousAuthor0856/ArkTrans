@Entry
@Component
struct RootScreen {
  @State private spending: number = 500.0
  private goal: number = 1000.0

  // AppTokens - Colors
  private primary: string = '#06B6D4'
  private secondary: string = '#3B82F6'
  private tertiary: string = '#8B5CF6'
  private background: string = '#F0F9FF'
  private surface: string = '#FFFFFF'
  private surfaceVariant: string = '#E0F2FE'
  private onPrimary: string = '#FFFFFF'
  private onSecondary: string = '#FFFFFF'
  private onTertiary: string = '#FFFFFF'
  private onBackground: string = '#0F172A'
  private onSurface: string = '#0F172A'

  // AppTokens - Shapes
  private shapeSmall: number = 6
  private shapeMedium: number = 12
  private shapeLarge: number = 20

  // AppTokens - Spacing
  private spacingSm: number = 8
  private spacingMd: number = 12
  private spacingLg: number = 16
  private spacingXl: number = 24
  private spacingXxl: number = 32

  // AppTokens - Typography
  private displayFontSize: number = 28
  private titleFontSize: number = 18
  private bodyFontSize: number = 14
  private labelFontSize: number = 12

  // Elevation Mapping
  private elevationLevel2Radius: number = 8
  private elevationLevel2Dy: number = 4
  private elevationLevel2Opacity: number = 0.18

  build() {
    Column() {
      // Top Bar
      Column() {
        Text('Bill Calendar')
          .fontSize(this.displayFontSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(this.background)

      // Main content area
      Scroll() {
        Column({ space: this.spacingLg }) {
          // Surface Card
          Column() {
            Column({ space: 0 }) {
              Text('Current Spending')
                .fontSize(this.titleFontSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.primary)

              Blank()
                .height(this.spacingLg)

              Text(`$${Math.floor(this.spending)} / $${Math.floor(this.goal)}`)
                .fontSize(this.displayFontSize)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.onSurface)

              Blank()
                .height(this.spacingLg)

              // LinearProgressIndicator
              Stack({ alignContent: Alignment.Start }) {
                Row()
                  .width('100%')
                  .height(8)
                  .backgroundColor(this.surfaceVariant)
                  .borderRadius(4)

                Row()
                  .width(`${(this.spending / this.goal) * 100}%`)
                  .height(8)
                  .backgroundColor(this.primary)
                  .borderRadius(4)
              }
              .width('100%')
              .height(8)
            }
            .width('100%')
            .padding(this.spacingLg)
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('100%')
          .height(160)
          .backgroundColor('#E6FFFFFF')
          .borderRadius(this.shapeLarge)
          .shadow({
            radius: this.elevationLevel2Radius,
            color: `rgba(0, 0, 0, ${this.elevationLevel2Opacity})`,
            offsetY: this.elevationLevel2Dy
          })

          Text('Adjust Spending')
            .fontSize(this.titleFontSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurface)

          // Slider
          Slider({
            value: this.spending,
            min: 0,
            max: 2000,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .selectedColor(this.primary)
            .trackColor(this.surfaceVariant)
            .blockColor(this.secondary)
            .onChange((value: number) => {
              this.spending = value
            })

          // Button
          Button('Reset')
            .width('100%')
            .height(48)
            .fontSize(this.titleFontSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onTertiary)
            .backgroundColor(this.tertiary)
            .borderRadius(this.shapeMedium)
            .onClick(() => {
              this.spending = 0.0
            })
        }
        .width('100%')
        .padding(this.spacingLg)
      }
      .width('100%')
      .layoutWeight(1)
      .align(Alignment.Top)
      .linearGradient({
        angle: 180,
        colors: [[this.secondary, 0.3], [this.background, 1.0], [this.primary, 0.2]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
  }
}