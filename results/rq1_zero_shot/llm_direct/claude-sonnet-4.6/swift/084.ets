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

        Button({ type: ButtonType.Normal }) {
          Image($r('sys.media.ohos_ic_public_settings'))
            .width(24)
            .height(24)
            .fillColor(Color.Black)
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
          .fontFamily('monospace')

        Text('Target: 300g')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#8E8E93')
      }

      Blank()

      // Parameters Grid
      Row() {
        ParameterItem({ icon: $r('sys.media.ohos_ic_public_add'), value: '1:15', label: 'Ratio' })

        Blank()

        ParameterItem({ icon: $r('sys.media.ohos_ic_public_highlight'), value: '20g', label: 'Beans' })

        Blank()

        ParameterItem({ icon: $r('sys.media.ohos_ic_public_refresh'), value: '93°C', label: 'Temp' })
      }
      .width('100%')
      .padding({ left: 30, right: 30 })

      Blank()

      // Divider Line
      Divider()
        .margin({ left: 24, right: 24, bottom: 20 })

      // Brewing Steps Section
      Column({ space: 15 }) {
        Text('Brewing Steps')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .width('100%')
          .padding({ left: 24, right: 24 })

        // Step Item Row
        Row({ space: 16 }) {
          Image($r('sys.media.ohos_ic_public_ok'))
            .width(28)
            .height(28)
            .fillColor(Color.Black)
            .borderRadius(14)
            .backgroundColor(Color.White)

          Row() {
            Blank()
          }
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
      Button({ type: ButtonType.Normal }) {
        Row({ space: 8 }) {
          Image($r('sys.media.ohos_ic_public_play'))
            .width(18)
            .height(18)
            .fillColor(Color.White)

          Text('Start Brewing')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .justifyContent(FlexAlign.Center)
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
  icon: Resource = $r('sys.media.ohos_ic_public_add');
  value: string = '';
  label: string = '';

  build() {
    Column({ space: 12 }) {
      // Circular Icon Button
      Stack() {
        Circle()
          .width(64)
          .height(64)
          .fill(Color.Transparent)
          .stroke('#D1D1D6')
          .strokeWidth(1.5)

        Image(this.icon)
          .width(24)
          .height(24)
          .fillColor('#8E8E93')
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
    .alignItems(HorizontalAlign.Center)
  }
}