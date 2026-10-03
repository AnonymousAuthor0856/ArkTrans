@Entry
@Component
struct V60GuidePage {
  build() {
    Column() {
      // Header Section
      Row() {
        Column({ space: 4 }) {
          Text("V60 Guide")
            .fontSize(34)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)

          Text("Ethiopia Yirgacheffe")
            .fontSize(16)
            .fontColor('#8E8E93')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button() {
          Text('⚙')
            .fontSize(24)
            .fontColor(Color.Black)
        }
        .type(ButtonType.Circle)
        .backgroundColor(Color.Transparent)
        .width(40)
        .height(40)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 30, bottom: 30 })
      .alignItems(VerticalAlign.Top)

      Blank()

      // Timer Section
      Column({ space: 10 }) {
        Text("00:45")
          .fontSize(90)
          .fontWeight(FontWeight.Regular)
          .fontColor(Color.Black)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .fontFamily('sans-serif')

        Text("Target: 300g")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#8E8E93')
      }

      Blank()

      // Parameters Grid
      Row() {
        ParameterItem({ icon: 'plus', value: '1:15', label: 'Ratio' })

        Blank()

        ParameterItem({ icon: 'heart', value: '20g', label: 'Beans' })

        Blank()

        ParameterItem({ icon: 'refresh', value: '93°C', label: 'Temp' })
      }
      .width('100%')
      .padding({ left: 30, right: 30 })

      Blank()

      // Divider Line
      Divider()
        .color('#E5E5EA')
        .padding({ left: 24, right: 24, bottom: 20 })

      // Brewing Steps Section
      Column({ space: 15 }) {
        Text("Brewing Steps")
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .padding({ left: 24, right: 24 })

        // Step Item Row
        Row({ space: 16 }) {
          // Checkmark Icon
          Stack() {
            Circle()
              .width(28)
              .height(28)
              .fill(Color.Black)
            Text('✓')
              .fontSize(16)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
          }
          .width(28)
          .height(28)

          // Step Content Background
          Row() {
            Blank()
          }
          .width('100%')
          .height(52)
          .borderRadius(10)
          .backgroundColor('#F2F2F7')
          .layoutWeight(1)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Blank()

      // Start Button
      Button() {
        Row({ space: 8 }) {
          Text('▶')
            .fontSize(14)
            .fontColor(Color.White)

          Text("Start Brewing")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
      }
      .width('100%')
      .height(60)
      .backgroundColor(Color.Black)
      .borderRadius(18)
      .padding({ left: 24, right: 24, bottom: 30 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct ParameterItem {
  icon: string = ''
  value: string = ''
  label: string = ''

  @Builder
  iconBuilder(iconName: string) {
    if (iconName === 'plus') {
      Text('+')
        .fontSize(24)
        .fontColor('#8E8E93')
    } else if (iconName === 'heart') {
      Text('♥')
        .fontSize(24)
        .fontColor('#8E8E93')
    } else if (iconName === 'refresh') {
      Text('↻')
        .fontSize(24)
        .fontColor('#8E8E93')
    } else {
      Text('')
    }
  }

  build() {
    Column({ space: 12 }) {
      // Circular Icon
      Stack() {
        Circle()
          .width(64)
          .height(64)
          .fill(Color.White)
          .stroke('#E5E5EA', 1.5)
        this.iconBuilder(this.icon)
      }
      .width(64)
      .height(64)

      // Text Values
      Column({ space: 4 }) {
        Text(this.value)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Text(this.label)
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .fontColor('#8E8E93')
      }
    }
    .width(80)
  }
}
