import { router } from '@kit.ArkUI';

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
            .fontColor(Color.Black)

          Text('Ethiopia Yirgacheffe')
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
        .backgroundColor(Color.Transparent)
        .padding(0)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 30, bottom: 30 })
      .alignItems(VerticalAlign.Top)

      Blank()

      // Timer Section
      Column({ space: 10 }) {
        Text('00:45')
          .fontSize(90)
          .fontWeight(FontWeight.Normal)
          .fontColor(Color.Black)
          .maxLines(1)

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

      // Divider
      Divider()
        .margin({ left: 24, right: 24, bottom: 20 })
        .color('#E5E5EA')

      // Brewing Steps Section
      Column({ space: 15 }) {
        Text('Brewing Steps')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .width('100%')
          .padding({ left: 24, right: 24 })

        Row({ space: 16 }) {
          Text('✓')
            .fontSize(28)
            .fontColor(Color.Black)
            .width(28)
            .height(28)
            .textAlign(TextAlign.Center)
            .borderRadius(14)
            .backgroundColor(Color.White)

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
            .fontColor(Color.White)
          Text('Start Brewing')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(60)
      .backgroundColor(Color.Black)
      .borderRadius(18)
      .margin({ left: 24, right: 24, bottom: 30 })
      .padding({ left: 24, right: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct ParameterItem {
  icon: string = '';
  value: string = '';
  label: string = '';

  build() {
    Column({ space: 12 }) {
      Stack() {
        Circle()
          .width(64)
          .height(64)
          .fill(Color.Transparent)
          .stroke('#D1D1D6')
          .strokeWidth(1.5)

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
      .alignItems(HorizontalAlign.Center)
    }
    .width(80)
    .alignItems(HorizontalAlign.Center)
  }
}