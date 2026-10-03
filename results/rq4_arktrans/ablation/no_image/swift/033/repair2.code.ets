@Entry
@Component
struct Index {
  @State spending: number = 1000
  private goal: number = 2000

  build() {
    Stack() {
      Column() {
        Stack() {
          Text('Bill Calendar')
            .fontColor('#0F172A')
            .fontSize(32) // Approximating AppTokens.TypographyTokens.display
        }.height(56).backgroundColor('#FFFFFF')

        Scroll() {
          Column({ space: 24 }) { // Approximating AppTokens.Spacing.lg
            // Surface Card
            Rect()
              .fill(Color.White.withAlpha(0.9))
              .borderRadius(16) // Approximating AppTokens.Shapes.large
              .shadow({ radius: 8, color: '#0000001A', offsetY: 4 }) // Approximating ElevationMapping.level2
              .width('100%')
              .height(160)
              .overlay(
                () => {
                  Column() {
                    Text('Current Spending')
                      .fontColor('#06B6D4')
                      .fontSize(20) // Approximating AppTokens.TypographyTokens.title
                    
                    Blank()

                    Text(`$${Math.floor(this.spending)} / $${this.goal}`)
                      .fontColor('#0F172A')
                      .fontSize(32) // Approximating AppTokens.TypographyTokens.display

                    Blank()

                    Progress({ value: this.spending, total: this.goal, type: ProgressType.Linear })
                      .width('100%')
                      .height(8)
                      .color('#06B6D4')
                      .trackColor('#E0F2FE')
                  }
                  .padding(12)
                  .width('100%')
                  .height('100%')
                  .justifyContent(FlexAlign.SpaceBetween)
                }
              )

            Text('Adjust Spending')
              .fontColor('#0F172A')
              .fontSize(20) // Approximating AppTokens.TypographyTokens.title

            Slider({
              value: this.spending,
              min: 0,
              max: 2000,
              step: 1
            })
              .width('100%')
              .selectedColor('#06B6D4')
              .trackColor('#E0F2FE')
              .trackHeight(4)
              .blockWidth(20)

            Button() {
              Text('Reset')
                .fontColor('#FFFFFF')
                .fontSize(20) // Approximating AppTokens.TypographyTokens.title
                .textAlign(TextAlign.Center)
            }
            .onClick(() => {
              this.spending = 0
            })
            .backgroundColor('#8B5CF6')
            .borderRadius(12) // Approximating AppTokens.Shapes.medium
            .height(48)
            .width('100%')
          }
          .padding(24) // Approximating AppTokens.Spacing.lg
        }
        .linearGradient({
          angle: 90,
          colors: [
            ['#3B82F6', 0.3],
            ['#F0F9FF', 0.5],
            ['#06B6D4', 0.2]
          ]
        })
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
  }
}