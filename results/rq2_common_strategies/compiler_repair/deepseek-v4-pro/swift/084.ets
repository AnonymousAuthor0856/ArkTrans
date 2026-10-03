@Entry
@Component
struct V60GuideApp {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')

      // Main VStack
      Column({ space: 0 }) {
        // Spacer
        Blank().height(30)

        // Header
        Row({ space: 0 }) {
          Column({ space: 4 }) {
            Text('V60 Guide')
              .fontSize(34)
              .fontWeight(FontWeight.Bold)
              .foregroundColor('#000000')
            Text('Ethiopia Yirgacheffe')
              .fontSize(16)
              .foregroundColor('#808080')
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button() {
            Text('⚙️')
              .fontSize(24)
              .foregroundColor('#000000')
          }
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 30 })

        // Spacer to push timer to center vertically (approximate)
        Blank().layoutWeight(1)

        // Timer section
        Column({ space: 10 }) {
          Text('00:45')
            .fontSize(90)
            .fontWeight(FontWeight.Regular)
            .foregroundColor('#000000')
            .textAlign(TextAlign.Center)
            .width('100%')
          Text('Target: 300g')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#808080')
            .textAlign(TextAlign.Center)
            .width('100%')
        }
        .width('100%')

        Blank().layoutWeight(1)

        // Parameters Grid
        Row({ space: 0 }) {
          this.buildParameterItem('+', '1:15', 'Ratio')
          Blank()
          this.buildParameterItem('❤️', '20g', 'Beans')
          Blank()
          this.buildParameterItem('🔄', '93°C', 'Temp')
        }
        .width('100%')
        .padding({ left: 30, right: 30 })

        Blank().layoutWeight(1)

        // Divider
        Divider()
          .width('100%')
          .color('#D1D1D1')
          .padding({ left: 24, right: 24 })

        Blank().height(20)

        // Brewing Steps Section
        Column({ space: 15 }) {
          Text('Brewing Steps')
            .fontSize(19)
            .fontWeight(FontWeight.Bold)
            .foregroundColor('#000000')
            .width('100%')
            .padding({ left: 24 })

          // Step Item
          Row({ space: 16 }) {
            // Checkmark icon
            Text('✅')
              .fontSize(28)
              .foregroundColor('#000000')
              .backgroundColor('#FFFFFF')
              .borderRadius(14)

            // Step content placeholder
            Column()
              .height(52)
              .layoutWeight(1)
              .backgroundColor('#F2F2F2')
              .borderRadius(10)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
        }

        Blank().layoutWeight(1)

        // Start Button
        Button() {
          Row({ space: 8 }) {
            Text('▶️')
              .fontSize(18)
            Text('Start Brewing')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .foregroundColor('#FFFFFF')
          }
          .width('100%')
          .height(60)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .height(60)
        .backgroundColor('#000000')
        .borderRadius(18)
        .margin({ left: 24, right: 24, bottom: 30 })

        // Bottom spacer to ensure last element is at bottom
        Blank().height(30)
      }
      .width('100%')
      .height('100%')
      .padding({ left: 0, right: 0 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  buildParameterItem(icon: string, value: string, label: string) {
    Column({ space: 12 }) {
      // Circular icon
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width(64)
          .height(64)
          .border({ width: 1.5, color: '#E0E0E0', radius: 32 })
        Text(icon)
          .fontSize(24)
          .foregroundColor('#808080')
      }
      .width(64)
      .height(64)

      // Text values
      Column({ space: 4 }) {
        Text(value)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#000000')
          .textAlign(TextAlign.Center)
          .width('100%')
        Text(label)
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#808080')
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width(80)
    }
    .width(80)
    .alignItems(HorizontalAlign.Center)
  }
}