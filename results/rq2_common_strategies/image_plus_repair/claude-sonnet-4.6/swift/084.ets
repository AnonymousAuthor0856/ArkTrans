@Entry
@Component
struct ContentView {
  build() {
    Column({ space: 0 }) {
      // Header Section
      Row() {
        Column({ space: 4 }) {
          Text('V60 Guide')
            .fontSize(34)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')

          Text('Ethiopia Yirgacheffe')
            .fontSize(16)
            .fontColor('#8E8E93')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button() {
          Text('⚙')
            .fontSize(24)
            .fontColor('#000000')
        }
        .backgroundColor(Color.Transparent)
        .width(44)
        .height(44)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 50, bottom: 30 })
      .alignItems(VerticalAlign.Top)

      Blank()

      // Timer Section
      Column({ space: 10 }) {
        Text('00:45')
          .fontSize(90)
          .fontWeight(FontWeight.Regular)
          .fontColor('#000000')
          .maxLines(1)

        Text('Target: 300g')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#8E8E93')
      }
      .alignItems(HorizontalAlign.Center)

      Blank()

      // Parameters Grid
      Row() {
        ParameterItemRatio()
        Blank()
        ParameterItemBeans()
        Blank()
        ParameterItemTemp()
      }
      .width('100%')
      .padding({ left: 30, right: 30 })

      Blank()

      // Divider
      Divider()
        .margin({ left: 24, right: 24, bottom: 20 })
        .color('#E5E5EA')

      // Brewing Steps Section
      Column({ space: 15 }) {
        Text('Brewing Steps')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .width('100%')
          .padding({ left: 24, right: 24 })

        Row({ space: 16 }) {
          // Checkmark Icon
          Stack() {
            Circle()
              .width(28)
              .height(28)
              .fill('#000000')

            Text('✓')
              .fontSize(16)
              .fontColor('#FFFFFF')
              .fontWeight(FontWeight.Bold)
          }
          .width(28)
          .height(28)

          // Step Content Background
          Row()
            .height(52)
            .layoutWeight(1)
            .backgroundColor('#F2F2F7')
            .borderRadius(10)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')

      Blank()

      // Start Button
      Button() {
        Row({ space: 8 }) {
          Text('▶')
            .fontSize(18)
            .fontColor('#FFFFFF')

          Text('Start Brewing')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(60)
      .backgroundColor('#000000')
      .borderRadius(18)
      .margin({ left: 24, right: 24, bottom: 30 })
      .padding({ left: 24, right: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct ParameterItemRatio {
  build() {
    Column({ space: 12 }) {
      Stack() {
        Circle()
          .width(64)
          .height(64)
          .fill(Color.Transparent)
          .strokeWidth(1.5)
          .stroke('#D1D1D6')

        Text('+')
          .fontSize(24)
          .fontColor('#8E8E93')
      }
      .width(64)
      .height(64)

      Column({ space: 4 }) {
        Text('1:15')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Text('Ratio')
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .fontColor('#8E8E93')
      }
      .alignItems(HorizontalAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
    .width(80)
  }
}

@Component
struct ParameterItemBeans {
  build() {
    Column({ space: 12 }) {
      Stack() {
        Circle()
          .width(64)
          .height(64)
          .fill(Color.Transparent)
          .strokeWidth(1.5)
          .stroke('#D1D1D6')

        Text('♥')
          .fontSize(24)
          .fontColor('#8E8E93')
      }
      .width(64)
      .height(64)

      Column({ space: 4 }) {
        Text('20g')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Text('Beans')
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .fontColor('#8E8E93')
      }
      .alignItems(HorizontalAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
    .width(80)
  }
}

@Component
struct ParameterItemTemp {
  build() {
    Column({ space: 12 }) {
      Stack() {
        Circle()
          .width(64)
          .height(64)
          .fill(Color.Transparent)
          .strokeWidth(1.5)
          .stroke('#D1D1D6')

        Text('↻')
          .fontSize(24)
          .fontColor('#8E8E93')
      }
      .width(64)
      .height(64)

      Column({ space: 4 }) {
        Text('93°C')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Text('Temp')
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .fontColor('#8E8E93')
      }
      .alignItems(HorizontalAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
    .width(80)
  }
}