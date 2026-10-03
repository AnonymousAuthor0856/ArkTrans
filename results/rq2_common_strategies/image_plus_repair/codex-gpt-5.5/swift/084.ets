@Entry
@Component
struct ContentView {
  build() {
    Column() {
      this.HeaderSection()

      Blank()

      this.TimerSection()

      Blank()

      Row() {
        this.ParameterItem('+', '1:15', 'Ratio')
        Blank()
        this.ParameterItem('♥', '20g', 'Beans')
        Blank()
        this.ParameterItem('↻', '93°C', 'Temp')
      }
      .width('100%')
      .padding({ left: 30, right: 30 })

      Blank()

      Divider()
        .color('#C7C7CC')
        .strokeWidth(0.5)
        .margin({ left: 24, right: 24, bottom: 20 })

      this.BrewingStepsSection()

      Blank()

      Button() {
        Row({ space: 8 }) {
          Text('▶')
            .fontSize(18)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)

          Text('Start Brewing')
            .fontSize(18)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
      }
      .height(60)
      .width('100%')
      .backgroundColor(Color.Black)
      .borderRadius(18)
      .padding(0)
      .margin({ left: 24, right: 24, bottom: 30 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  private HeaderSection() {
    Row() {
      Column({ space: 4 }) {
        Text('V60 Guide')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Text('Ethiopia Yirgacheffe')
          .fontSize(16)
          .fontColor('#8E8E93')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('⚙')
        .fontSize(34)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Bold)
        .lineHeight(34)
        .margin({ top: 2 })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .padding({ left: 24, right: 24, top: 30, bottom: 30 })
  }

  @Builder
  private TimerSection() {
    Column({ space: 10 }) {
      Text('00:45')
        .fontSize(90)
        .fontWeight(FontWeight.Regular)
        .fontColor(Color.Black)
        .fontFamily('monospace')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Clip })

      Text('Target: 300g')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#8E8E93')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  private ParameterItem(icon: string, value: string, label: string) {
    Column({ space: 12 }) {
      Stack() {
        Circle()
          .width(64)
          .height(64)
          .fill(Color.Transparent)
          .stroke('#E5E5EA')
          .strokeWidth(1.5)

        Text(icon)
          .fontSize(icon === '+' ? 36 : 30)
          .fontWeight(icon === '♥' ? FontWeight.Bold : FontWeight.Regular)
          .fontColor('#8E8E93')
          .lineHeight(40)
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
          .fontColor('#8E8E93')
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(80)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  private BrewingStepsSection() {
    Column({ space: 15 }) {
      Text('Brewing Steps')
        .fontSize(19)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .width('100%')
        .padding({ left: 24, right: 24 })

      Row({ space: 16 }) {
        Stack() {
          Circle()
            .width(28)
            .height(28)
            .fill(Color.Black)

          Text('✓')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .lineHeight(24)
        }
        .width(28)
        .height(28)

        Row()
          .height(52)
          .layoutWeight(1)
          .backgroundColor('#F2F2F7')
          .borderRadius(10)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .padding({ left: 24, right: 24 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}
