// Translated from SwiftUI (Swift) to ArkTS (ArkUI)
// Source: V60GuideApp

@Entry
@Component
struct Index {
  build() {
    ContentView()
  }
}

// MARK: - Main Content View
@Component
struct ContentView {
  build() {
    Column() {
      // MARK: Header Section
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
        .onClick(() => {})
      }
      .alignItems(VerticalAlign.Top)
      .padding({ left: 24, right: 24, top: 30, bottom: 30 })

      Blank()

      // MARK: Timer Section
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

      Blank()

      // MARK: Parameters Grid
      Row() {
        ParameterItem({ icon: '+', value: '1:15', label: 'Ratio' })
        Blank()
        ParameterItem({ icon: '❤', value: '20g', label: 'Beans' })
        Blank()
        ParameterItem({ icon: '🔄', value: '93°C', label: 'Temp' })
      }
      .padding({ left: 30, right: 30 })

      Blank()

      // Divider Line
      Divider()
        .margin({ left: 24, right: 24, bottom: 20 })

      // MARK: Brewing Steps Section
      Column({ space: 15 }) {
        Text('Brewing Steps')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .padding({ left: 24, right: 24 })

        Row({ space: 16 }) {
          Stack() {
            Circle()
              .fill('#000000')
              .width(28)
              .height(28)
            Text('✓')
              .fontSize(18)
              .fontColor('#FFFFFF')
          }
          .width(28)
          .height(28)

          Column()
            .height(52)
            .layoutWeight(1)
            .backgroundColor('#F2F2F7')
            .borderRadius(10)
        }
        .padding({ left: 24, right: 24 })
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      // MARK: Start Button
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
      .onClick(() => {})
      .width('100%')
      .height(60)
      .backgroundColor('#000000')
      .borderRadius(18)
      .margin({ left: 24, right: 24, bottom: 30 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

// MARK: - Component: Parameter Item
@Component
struct ParameterItem {
  icon: string = ''
  value: string = ''
  label: string = ''

  build() {
    Column({ space: 12 }) {
      Stack() {
        Circle()
          .fill('#00000000')
          .width(64)
          .height(64)
          .border({ width: 1.5, color: '#E5E5EA' })

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
          .fontColor('#000000')

        Text(this.label)
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .fontColor('#8E8E93')
      }
    }
    .width(80)
  }
}
