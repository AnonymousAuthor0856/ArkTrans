@Entry
@Component
struct ContentView {
  @Builder
  private ParameterItem(icon: string, value: string, label: string) {
    Column({ space: 12 }) {
      Stack() {
        Circle()
          .width(64)
          .height(64)
          .fill(Color.Transparent)
          .stroke('#E0E0E0')
          .strokeWidth(1.5)
        Text(icon)
          .fontSize(24)
          .fontColor('#808080')
      }
      .width(64)
      .height(64)

      Column({ space: 4 }) {
        Text(value)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text(label)
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .fontColor('#808080')
      }
    }
    .width(80)
  }

  build() {
    Column({ space: 0 }) {
      Row() {
        Column({ space: 4 }) {
          Text('V60 Guide')
            .fontSize(34)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
          Text('Ethiopia Yirgacheffe')
            .fontSize(16)
            .fontColor('#808080')
        }
        .alignItems(HorizontalAlign.Start)
        Blank()
        Button('⚙')
          .fontSize(24)
          .fontColor(Color.Black)
          .backgroundColor(Color.Transparent)
      }
      .alignItems(VerticalAlign.Top)
      .padding({ left: 24, right: 24, top: 30, bottom: 30 })
      .width('100%')

      Blank()

      Column({ space: 10 }) {
        Text('00:45')
          .fontSize(90)
          .fontWeight(FontWeight.Regular)
          .fontColor(Color.Black)
          .maxLines(1)
        Text('Target: 300g')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#808080')
      }

      Blank()

      Row({ space: 0 }) {
        this.ParameterItem('+', '1:15', 'Ratio')
        Blank()
        this.ParameterItem('♥', '20g', 'Beans')
        Blank()
        this.ParameterItem('↻', '93°C', 'Temp')
      }
      .padding({ left: 30, right: 30 })
      .width('100%')

      Blank()

      Divider()
        .padding({ left: 24, right: 24, bottom: 20 })

      Column({ space: 15 }) {
        Text('Brewing Steps')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .padding({ left: 24, right: 24 })
          .width('100%')
          .textAlign(TextAlign.Start)

        Row({ space: 16 }) {
          Text('✓')
            .fontSize(28)
            .fontColor(Color.Black)
            .backgroundColor(Color.White)
            .borderRadius(14)
          Rect()
            .height(52)
            .layoutWeight(1)
            .fill('#F2F2F7')
            .radius(10)
        }
        .padding({ left: 24, right: 24 })
        .width('100%')
      }
      .width('100%')

      Blank()

      Button('▶  Start Brewing')
        .height(60)
        .width('100%')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .backgroundColor(Color.Black)
        .borderRadius(18)
        .margin({ left: 24, right: 24, bottom: 30 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
