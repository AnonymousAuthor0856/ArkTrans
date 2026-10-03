@Entry
@Component
struct ContentView {
  build() {
    Column() {
      Row() {
        Column({ space: 4 }) {
          Text('V60 Guide')
            .fontSize(34)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)

          Text('Ethiopia Yirgacheffe')
            .fontSize(16)
            .fontWeight(FontWeight.Regular)
            .fontColor('#8E8E93')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text('⚙')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .lineHeight(36)
          .onClick(() => {
          })
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

      Column({ space: 10 }) {
        Text('00:45')
          .fontSize(90)
          .fontWeight(FontWeight.Regular)
          .fontColor(Color.Black)
          .textAlign(TextAlign.Center)
          .maxLines(1)
          .width('100%')

        Text('Target: 300g')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#8E8E93')
      }
      .width('100%')

      Blank()
        .layoutWeight(1)

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

      Divider()
        .width('100%')
        .strokeWidth(1)
        .color('#D1D1D6')
        .margin({
          left: 24,
          right: 24,
          bottom: 20
        })

      Column({ space: 15 }) {
        Text('Brewing Steps')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .width('100%')
          .padding({
            left: 24,
            right: 24
          })

        Row({ space: 16 }) {
          Stack() {
            Circle()
              .width(30)
              .height(30)
              .fill(Color.Black)

            Text('✓')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .lineHeight(22)
          }
          .width(52)
          .height(52)

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
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Row({ space: 10 }) {
          Text('▶')
            .fontSize(22)
            .fontColor(Color.White)
            .lineHeight(22)

          Text('Start Brewing')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .height(60)
      }
      .width('100%')
      .height(60)
      .backgroundColor(Color.Black)
      .borderRadius(18)
      .margin({
        left: 24,
        right: 24,
        bottom: 30
      })
      .onClick(() => {
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct ParameterItem {
  @Prop icon: string = ''
  @Prop value: string = ''
  @Prop label: string = ''

  build() {
    Column({ space: 12 }) {
      Stack() {
        Circle()
          .width(64)
          .height(64)
          .fill(Color.Transparent)
          .stroke('#E2E3E8')
          .strokeWidth(1.5)

        Text(this.icon)
          .fontSize(32)
          .fontWeight(FontWeight.Regular)
          .fontColor('#8E8E93')
          .lineHeight(32)
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
      .alignItems(HorizontalAlign.Center)
    }
    .width(80)
    .alignItems(HorizontalAlign.Center)
  }
}