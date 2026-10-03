@Entry
@Component
struct V60GuidePage {
  build() {
    Column() {
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

        Text('⚙')
          .fontSize(28)
          .fontColor('#000000')
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 50, bottom: 30 })

      Blank()

      // Timer Section
      Column({ space: 10 }) {
        Text('00:45')
          .fontSize(90)
          .fontWeight(FontWeight.Regular)
          .fontColor('#000000')
          .fontFamily('SF Mono, Menlo, monospace')

        Text('Target: 300g')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#8E8E93')
      }

      Blank()

      // Parameters Grid
      Row() {
        ParameterItem({ icon: '+', value: '1:15', label: 'Ratio' })

        Blank()

        ParameterItem({ icon: '♥', value: '20g', label: 'Beans' })

        Blank()

        ParameterItem({ icon: '↻', value: '93°C', label: 'Temp' })
      }
      .width('100%')
      .padding({ left: 30, right: 30 })

      Blank()

      // Divider Line
      Divider()
        .color('#E5E5EA')
        .strokeWidth(1)
        .padding({ left: 24, right: 24 })
        .margin({ bottom: 20 })

      // Brewing Steps Section
      Column({ space: 15 }) {
        Text('Brewing Steps')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .padding({ left: 24, right: 24 })

        Row({ space: 16 }) {
          // Checkmark Icon
          Stack() {
            Circle()
              .width(36)
              .height(36)
              .fill('#000000')

            Text('✓')
              .fontSize(20)
              .fontColor('#FFFFFF')
              .fontWeight(FontWeight.Bold)
          }
          .width(36)
          .height(36)

          // Step Content Background
          Row() {
            Blank()
          }
          .width('100%')
          .height(52)
          .backgroundColor('#F2F2F7')
          .borderRadius(10)
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
            .fontSize(18)
            .fontColor('#FFFFFF')

          Text('Start Brewing')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
        }
      }
      .width('100%')
      .height(60)
      .backgroundColor('#000000')
      .borderRadius(18)
      .padding({ left: 24, right: 24 })
      .margin({ bottom: 30 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct ParameterItem {
  icon: string = ''
  value: string = ''
  label: string = ''

  build() {
    Column({ space: 12 }) {
      // Circular Icon Button
      Stack() {
        Circle()
          .width(64)
          .height(64)
          .fill('#FFFFFF')
          .stroke('#E5E5EA')
          .strokeWidth(1.5)

        Text(this.icon)
          .fontSize(28)
          .fontColor('#8E8E93')
      }
      .width(64)
      .height(64)

      // Text Values
      Column({ space: 4 }) {
        Text(this.value)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Text(this.label)
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .fontColor('#8E8E93')
      }
    }
    .width(80)
    .alignItems(HorizontalAlign.Center)
  }
}
