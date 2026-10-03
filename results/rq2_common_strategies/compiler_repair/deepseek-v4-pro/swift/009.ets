@Entry
@Component
struct VideoPlayerRoot {
  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#0F172A')

      // Main content
      Column({ space: 10 }) {
        // Top title
        Text('Video Player')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E2E8F0')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 12, bottom: 12 })

        // Video surface (placeholder)
        Column() {
          Text('Video Surface')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')
            .opacity(0.9)
        }
        .width('100%')
        .height(300)
        .backgroundColor('#334155')
        .borderRadius(24)

        // Video title
        Text('Journey through the Skies')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E0E8F0')
          .width('100%')
          .textAlign(TextAlign.Start)
          .padding({ left: 20, right: 20, top: 10, bottom: 10 })

        // Progress area
        Column({ space: 10 }) {
          // Left capsule + vertical bar + right capsule + blue dot
          Row({ space: 18 }) {
            Blank()
            // Left capsule (progress indicator)
            Column()
              .width(120) // approximate 40% of some width
              .height(32)
              .backgroundColor('#1E3A8A')
              .borderRadius(16)

            // Vertical bar
            Column()
              .width(6)
              .height(72)
              .backgroundColor('#1E3A8A')
              .borderRadius(3)

            // Right capsule with trailing circle
            Stack({ alignContent: Alignment.End }) {
              Column()
                .width(140) // approximate 47% of some width
                .height(32)
                .backgroundColor('#475569')
                .borderRadius(16)
              // Blue dot circle
              Image('')
                .width(12)
                .height(12)
                .borderRadius(6)
                .backgroundColor('#1E3A8A')
                .margin({ left: 10 })
            }
            Blank()
          }

          // Time labels
          Row() {
            Text('1:35')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#A3AAB5')
              .padding({ left: 10 })
            Blank()
            Text('4:00')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#A3AAB5')
              .padding({ right: 10 })
          }
        }
        .padding({ left: 24, right: 24, top: 8, bottom: 6 })

        // Control buttons: -10s, Play, +30s
        Row({ space: 24 }) {
          Blank()
          // -10s button
          Button({ type: ButtonType.Normal }) {
            Text('-10s')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1D192B')
          }
          .width(100)
          .height(50)
          .backgroundColor('#E8DEF8')
          .borderRadius(18)

          // Play circle button
          Button({ type: ButtonType.Normal }) {
            Image('')
              .width(40)
              .height(40)
              // Use a play icon representation (since no SVG, just use a colored square)
              .backgroundColor('#FFFFFF')
              .borderRadius(20)
          }
          .width(64)
          .height(64)
          .backgroundColor('#1E3A8A')
          .borderRadius(32)

          // +30s button
          Button({ type: ButtonType.Normal }) {
            Text('+30s')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1D192B')
          }
          .width(100)
          .height(50)
          .backgroundColor('#E8DEF8')
          .borderRadius(18)

          Blank()
        }
        .padding({ top: 10, bottom: 10 })

        // Fullscreen ghost button
        Button({ type: ButtonType.Normal }) {
          Text('Fullscreen')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#47434E')
        }
        .width(180)
        .height(36)
        .border({ width: 1, color: '#475569' })
        .borderRadius(12)

        Blank()
      }
      .width('100%')
      .padding({ top: 20 })
    }
    .width('100%')
    .height('100%')
  }
}