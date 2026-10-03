@Entry
@Component
struct Index {
  @State progress: number = 0.5

  build() {
    Stack() {
      Column() {
        Stack() {
          Text('Stock K-Line')
            .fontColor('#0F172A')
            .fontSize(28)
        }
        .layoutWeight(1)

        Column() {
          Stack() {
            Rect()
              .shadow({ color: '#0F172A', radius: 4, offsetY: 2 }) // Approximated ElevationMapping.level2
              .fill('#FFFFFF')
            
            Canvas(this.getUIContext())
              .padding(12)
          }
          .borderRadius(16) // Approximated AppTokens.Shapes.large
          .height(260)
          .width('100%')

          Text('Market Trend')
            .fontColor('#2563EB')
            .fontSize(18)

          Slider({ value: this.progress, min: 0, max: 1 })
            .height(44)
            .width('100%')
            .trackColor(Color.Gray)
            .selectedColor('#2563EB')

          Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
            .height(8)
            .width('100%')
            .color('#2563EB')
            .backgroundColor('#E2E8F0')

          Row()
            .width('100%')
            .height(100)
            .linearGradient({
              angle: 90,
              colors: [
                ['#2563EB', 0.15],
                ['#FFFFFF', 0.5],
                ['#0F172A', 1]
              ]
            })
        }
        .linearGradient({
          angle: 90,
          colors: [
            ['#2563EB', 0.15],
            ['#FFFFFF', 0.5],
            ['#0F172A', 1]
          ]
        })
        .width('100%')
        .height('100%')
        .padding(12) // Approximated AppTokens.Spacing.lg
      }
      .backgroundColor('#FFFFFF') // Approximated AppTokens.Colors.background
    }
    .width('100%')
    .height('100%')
  }
}