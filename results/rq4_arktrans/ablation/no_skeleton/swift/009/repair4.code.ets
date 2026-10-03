@Entry
@Component
struct VideoPlayerRoot {
  @State scaleValue: number = 1.0

  build() {
    Column() {
      // === Header ===
      Text('Video Player')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#E2E8F0')
        .width('100%')
        .textAlign(TextAlign.Center)
        .height(56)

      // === Video Surface ===
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
      .margin({ right: 10 })

      // === Title ===
      Text('Journey through the Skies')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#E0E8F0')
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })

      // === Progress Area ===
      Column() {
        // Row with Capsule, Vertical Bar, and Track
        Row() {
          Blank()
          
          // Left Capsule (Played)
          Capsule()
            .width('40%')
            .height(32)
            .fillColor('#1E3A8A')
          
          // Vertical Scrubber
          Rect()
            .width(6)
            .height(72)
            .fillColor('#1E3A8A')
            .borderRadius(3)
          
          // Right Track (Remaining)
          Stack({ alignContent: Alignment.End }) {
            Capsule()
              .width('47%')
              .height(32)
              .fillColor('#475569')
            
            Circle()
              .width(12)
              .height(12)
              .fillColor('#1E3A8A')
              .margin({ right: 10 })
          }
          
          Blank()
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // Time Labels
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

      // === Controls ===
      Row() {
        // -10s Button
        Button() {
          Text('−10s')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1D192B')
        }
        .width(180)
        .height(96)
        .backgroundColor('#E8DEF8')
        .borderRadius(18)

        // Play Button
        Button() {
          Image($r('app.media.startIcon'))
            .width(40)
            .height(40)
            .fillColor('#FFFFFF')
        }
        .width(120)
        .height(120)
        .backgroundColor('#1E3A8A')
        .borderRadius(60)

        // +30s Button
        Button() {
          Text('+30s')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1D192B')
        }
        .width(180)
        .height(96)
        .backgroundColor('#E8DEF8')
        .borderRadius(18)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding({ top: 10, bottom: 10 })

      // === Fullscreen Button ===
      Button() {
        Text('Fullscreen')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#47434E')
      }
      .width(220)
      .height(64)
      .backgroundColor(Color.Transparent)
      .border({ width: 1, color: '#475569', radius: 12 })
      .margin({ top: 12 })

      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0F172A')
  }
}