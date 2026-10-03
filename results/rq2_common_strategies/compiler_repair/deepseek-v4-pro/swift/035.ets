@Entry
@Component
struct RootScreen {
  @State progress: number = 0.5

  build() {
    Stack() {
      Column({ space: 0 }) {
        // Top bar
        Row({ space: 0 }) {
          Blank().layoutWeight(1)
          Text('Stock K-Line')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .foregroundColor('#FF0F172A')
          Blank().layoutWeight(1)
        }
        .width('100%')
        .height(56)
        .backgroundColor('#FFF8FAFC')
        .justifyContent(FlexAlign.Center)

        // Main content with gradient
        Column({ space: 14 }) {
          // Chart surface (placeholder)
          Stack() {
            Column() {
              Text('Chart Area')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#FF0F172A')
                .textAlign(TextAlign.Center)
            }
            .width('100%')
            .height(260)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          }
          .width('100%')
          .height(260)
          .backgroundColor('#FFFFFFFF')
          .borderRadius(16)
          .shadow({
            radius: 8,
            color: 'rgba(15,23,42,0.18)',
            offsetX: 0,
            offsetY: 4
          })

          // Title
          Text('Market Trend')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FF2563EB')

          // Slider
          Slider({ value: this.progress, min: 0, max: 1, step: 0.01 })
            .width('100%')
            .height(44)
            .onChange((value: number) => {
              this.progress = value
            })

          // Linear progress indicator
          Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color('#FF2563EB')
            .backgroundColor('#FFE2E8F0')
            .borderRadius(4)
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 14, right: 14, top: 14, bottom: 14 })
        .linearGradient({
          colors: [['rgba(96,165,250,0.15)', 0], ['#FFF8FAFC', 0.5], ['rgba(37,99,235,0.15)', 1]],
          direction: GradientDirection.Bottom
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFF8FAFC')
    }
    .width('100%')
    .height('100%')
  }
}