@Entry
@Component
struct VideoPlayerRoot {
  build() {
    Column({ space: 10 }) {
      // Title
      Text('Video Player')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#E2E8F0')
        .height(56)
        .padding({ top: 12, bottom: 12 })

      // Video Surface
      Stack() {
        Column()
          .width('100%')
          .height(300)
          .backgroundColor('#334155')
          .borderRadius(24)

        Text('Video Surface')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('rgba(226,232,240,0.9)')
      }
      .width('95%')
      .height(300)
      .alignContent(Alignment.Center)

      // Title text
      Text('Journey through the Skies')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#E0E8F0')
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })

      // Progress area
      Column({ space: 10 }) {
        Row({ space: 18 }) {
          Blank()
          // Left capsule (played)
          Column()
            .width('38%')
            .height(32)
            .backgroundColor('#1E3A8A')
            .borderRadius(16)

          // Vertical bar
          Column()
            .width(6)
            .height(72)
            .backgroundColor('#1E3A8A')
            .borderRadius(3)

          // Right track with dot
          Stack({ alignContent: Alignment.End }) {
            Column()
              .width('100%')
              .height(32)
              .backgroundColor('#475569')
              .borderRadius(16)

            Column()
              .width(12)
              .height(12)
              .backgroundColor('#1E3A8A')
              .borderRadius(6)
              .margin({ right: 10 })
          }
          .width('45%')
          .height(32)

          Blank()
        }
        .width('100%')

        // Time labels
        Row() {
          Text('1:35')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#A3AAB5')
            .margin({ left: 10 })

          Blank()

          Text('4:00')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#A3AAB5')
            .margin({ right: 10 })
        }
        .width('100%')
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 8, bottom: 6 })
      .alignItems(HorizontalAlign.Start)

      // Controls: -10s / Play / +30s
      Row({ space: 24 }) {
        // -10s button
        Text('−10s')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1D192B')
          .width(100)
          .height(56)
          .textAlign(TextAlign.Center)
          .backgroundColor('#E8DEF8')
          .borderRadius(18)

        // Play button
        Stack() {
          Circle()
            .fill('#1E3A8A')
            .width(80)
            .height(80)

          Text('▶')
            .fontSize(28)
            .fontColor('#FFFFFF')
        }
        .width(80)
        .height(80)
        .alignContent(Alignment.Center)

        // +30s button
        Text('+30s')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1D192B')
          .width(100)
          .height(56)
          .textAlign(TextAlign.Center)
          .backgroundColor('#E8DEF8')
          .borderRadius(18)
      }
      .padding({ top: 10, bottom: 10 })

      // Fullscreen button
      Text('Fullscreen')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#47434E')
        .width(220)
        .height(56)
        .textAlign(TextAlign.Center)
        .border({
          width: 1,
          color: '#475569',
          radius: 12
        })
        .margin({ top: 12 })

      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0F172A')
    .alignItems(HorizontalAlign.Center)
  }
}