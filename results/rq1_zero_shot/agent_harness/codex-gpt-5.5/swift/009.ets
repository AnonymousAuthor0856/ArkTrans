@Entry
@Component
struct VideoPlayerRoot {
  @Builder
  TonalButton(title: string) {
    Text(title)
      .fontSize(18)
      .fontWeight(FontWeight.SemiBold)
      .fontColor('#1D192B')
      .textAlign(TextAlign.Center)
      .width(90)
      .height(48)
      .backgroundColor('#E8DEF8')
      .borderRadius(18)
  }

  @Builder
  ProgressArea() {
    Column() {
      Row() {
        Blank()
        Capsule()
          .width('40%')
          .height(32)
          .fill('#1E3A8A')
        Rect()
          .width(6)
          .height(72)
          .radius(3)
          .fill('#1E3A8A')
          .margin({ left: 18, right: 18 })
        Stack({ alignContent: Alignment.End }) {
          Capsule()
            .width('100%')
            .height(32)
            .fill('#475569')
          Circle()
            .width(12)
            .height(12)
            .fill('#1E3A8A')
            .margin({ right: 10 })
        }
        .width('47%')
        .height(32)
        Blank()
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

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
      .margin({ top: 10 })
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 8, bottom: 6 })
  }

  build() {
    Column() {
      Text('Video Player')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#E2E8F0')
        .height(56)
        .padding({ top: 12, bottom: 12 })

      Stack() {
        Rect()
          .width('100%')
          .height(300)
          .fill('#334155')
          .radius(24)
        Text('Video Surface')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E6E2E8F0')
      }
      .width('100%')
      .height(300)
      .padding({ right: 10 })

      Text('Journey through the Skies')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#E0E8F0')
        .width('100%')
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })

      this.ProgressArea()

      Row() {
        this.TonalButton('−10s')
        Stack() {
          Circle()
            .width(120)
            .height(120)
            .fill('#1E3A8A')
          Text('▶')
            .fontSize(40)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
        }
        .width(120)
        .height(120)
        .margin({ left: 24, right: 24 })
        this.TonalButton('+30s')
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .padding({ top: 10, bottom: 10 })

      Button('Fullscreen')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#47434E')
        .backgroundColor(Color.Transparent)
        .width(220)
        .height(64)
        .border({ width: 1, color: '#475569', radius: 12 })
        .borderRadius(12)
        .margin({ top: 12 })

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding({ left: 0, right: 0 })
    .backgroundColor('#0F172A')
    .alignItems(HorizontalAlign.Center)
  }
}
