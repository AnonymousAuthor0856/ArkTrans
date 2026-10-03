@Entry
@Component
struct V60GuideApp {
  build() {
    Column({ space: 0 }) {
      // Header Section
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
          .layoutWeight(1)

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('⚙')
            .fontSize(28)
            .fontColor(Color.Black)
        }
        .width(44)
        .height(44)
        .backgroundColor(Color.Transparent)
        .borderRadius(22)
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)
      .padding({
        left: 24,
        right: 24,
        top: 30,
        bottom: 30
      })

      Blank()
        .layoutWeight(1)

      // Timer Section
      Column({ space: 10 }) {
        Text('00:45')
          .fontSize(90)
          .fontWeight(FontWeight.Regular)
          .fontColor(Color.Black)
          .fontFamily('monospace')
          .maxLines(1)

        Text('Target: 300g')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#8E8E93')
      }

      Blank()
        .layoutWeight(1)

      // Parameters Grid
      Row() {
        ParameterItem({
          icon: '+',
          value: '1:15',
          label: 'Ratio'
        })

        Blank()
          .layoutWeight(1)

        ParameterItem({
          icon: '♥',
          value: '20g',
          label: 'Beans'
        })

        Blank()
          .layoutWeight(1)

        ParameterItem({
          icon: '↻',
          value: '93°C',
          label: 'Temp'
        })
      }
      .width('100%')
      .padding({
        left: 30,
        right: 30
      })

      Blank()
        .layoutWeight(1)

      // Divider Line
      Divider()
        .strokeWidth(1)
        .color('#E5E5EA')
        .margin({
          left: 24,
          right: 24,
          bottom: 20
        })

      // Brewing Steps Section
      Column({ space: 15 }) {
        Text('Brewing Steps')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .padding({
            left: 24,
            right: 24
          })

        Row({ space: 16 }) {
          Stack() {
            Text('')
              .width(28)
              .height(28)
              .backgroundColor(Color.Black)
              .borderRadius(14)

            Text('✓')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
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
        .padding({
          left: 24,
          right: 24
        })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      // Start Button
      Row() {
        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Row({ space: 8 }) {
            Text('▶')
              .fontSize(18)
              .fontColor(Color.White)

            Text('Start Brewing')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
          }
          .width('100%')
          .height(60)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .height(60)
        .layoutWeight(1)
        .backgroundColor(Color.Black)
        .borderRadius(18)
      }
      .width('100%')
      .padding({
        left: 24,
        right: 24,
        bottom: 30
      })
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

  build() {
    Column({ space: 12 }) {
      Stack() {
        Text('')
          .width(64)
          .height(64)
          .border({
            width: 1.5,
            color: '#E5E5EA'
          })
          .borderRadius(32)

        Text(this.icon)
          .fontSize(24)
          .fontColor('#8E8E93')
      }
      .width(64)
      .height(64)

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