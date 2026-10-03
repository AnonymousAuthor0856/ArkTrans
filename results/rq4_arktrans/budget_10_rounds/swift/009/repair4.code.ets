@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Text('Video Player')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#E2E8F0')
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 12, bottom: 12 })

        // Video Surface
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
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .margin({ right: 10 })

        // Title
        Text('Journey through the Skies')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#E2E8F0')
          .width('100%')
          .textAlign(TextAlign.Start)
          .padding({ left: 20, right: 20, top: 10, bottom: 10 })

        // Progress Bar Section
        Column() {
          Row() {
            Blank()
            
            // Left filled bar
            Capsule()
              .fill('#1E3A8A')
              .height(32)
              .layoutWeight(1)
            
            // Scrubber line
            Rect()
              .width(6)
              .height(72)
              .fill('#1E3A8A')
              .borderRadius(3)
            
            // Right empty bar with thumb
            Stack() {
              Capsule()
                .fill('#475569')
                .height(32)
                .layoutWeight(1)
              
              Circle()
                .width(12)
                .height(12)
                .fill('#1E3A8A')
                .position({ x: '100%', y: '50%' })
                .margin({ right: -6 })
            }
            .layoutWeight(1)
            
            Blank()
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .spacing(18)

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
          .width('100%')
        }
        .padding({ left: 20, right: 20, top: 8, bottom: 6 })

        // Controls Row
        Row() {
          Button('-10s')
            .backgroundColor('#EADDFF')
            .fontColor('#1C1B1F')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .borderRadius(12)
            .height(64)
            .layoutWeight(1)
            .margin({ right: 10 })

          Button() {
            Image($r('app.media.startIcon'))
              .width(40)
              .height(40)
              .fillColor(Color.White)
          }
          .backgroundColor('#1E3A8A')
          .borderRadius(60)
          .width(120)
          .height(120)
          .margin({ left: 10, right: 10 })

          Button('+30s')
            .backgroundColor('#EADDFF')
            .fontColor('#1C1B1F')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .borderRadius(12)
            .height(64)
            .layoutWeight(1)
            .margin({ left: 10 })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: 10, bottom: 10 })
        .spacing(24)

        // Fullscreen Button
        Button('Fullscreen')
          .backgroundColor(Color.Transparent)
          .borderWidth(1)
          .borderColor('#475569')
          .borderRadius(12)
          .fontColor('#475569')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .width(220)
          .height(64)
          .margin({ top: 12 })

        Blank()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#0F172A')
    }.width('100%').height('100%')
  }
}