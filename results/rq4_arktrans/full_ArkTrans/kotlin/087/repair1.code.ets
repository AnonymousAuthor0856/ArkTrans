@Entry
@Component
struct Index {
  @State step: string = '1'
  @State text: string = 'Boil fresh water to 95°C'

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // Header Section
        Row() {
          Column() {
            Text('Good Morning,')
              .fontSize(16)
              .fontColor('#888888')
              .margin({ bottom: 4 })
            Text('Tea Master')
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
          }
          
          Blank()

          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#000000')
          }
          .backgroundColor('#F5F5F5')
          .borderRadius(24)
          .width(48)
          .height(48)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 24, bottom: 24 })

        // Tea Card
        Row() {
          Stack({ alignContent: Alignment.Center }) {
            Circle({ width: 72, height: 72 }).fill('#EADDFF').opacity(0.2)
            Image($r('app.media.startIcon'))
              .width(32)
              .height(32)
              .fillColor('#6D4C41')
          }
          .width(72)
          .height(72)
          .margin({ right: 16 })

          Column() {
            Text('Earl Grey Reserve')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            Text('Black Tea • 95°C')
              .fontSize(14)
              .fontColor('#8D6E63')
              .margin({ top: 4 })
          }

          Blank()

          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor('#FFCDD2')
        }
        .width('100%')
        .padding(24)
        .backgroundColor('#FAFAFA')
        .borderRadius(24)
        .margin({ left: 24, right: 24, bottom: 32 })

        // Timer Section
        Stack({ alignContent: Alignment.Center }) {
          // Background Ring (Simulated with thick border circle)
          Circle({ width: 280, height: 280 })
            .stroke('#F5F5F5')
            .strokeWidth(16)
            .fill('transparent')
          
          // Progress Ring (Simulated)
          Circle({ width: 280, height: 280 })
            .stroke('#6D4C41')
            .strokeWidth(16)
            .fill('transparent')
            .linearGradient({
              angle: 225,
              colors: [['#6D4C41', 0], ['#6D4C41', 0.75], ['transparent', 0.75]]
            })

          Column() {
            Text('Steeping')
              .fontSize(16)
              .fontColor('#888888')
              .letterSpacing(2)
              .margin({ bottom: 8 })
            Text('02:00')
              .fontSize(64)
              .fontWeight(FontWeight.Normal)
              .fontColor('#000000')
          }
        }
        .width(280)
        .height(280)
        .margin({ bottom: 40 })

        // Controls
        Row() {
          Column() {
            Button() {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .fillColor('#888888')
            }
            .backgroundColor('#FFFFFF')
            .borderRadius(32)
            .width(64)
            .height(64)
            .border({ width: 1, color: '#EEEEEE' })
            
            Text('PREPARATION')
              .fontSize(12)
              .fontColor('#CCCCCC')
              .margin({ top: 8 })
          }

          Blank()

          Button() {
            Row() {
              Image($r('app.media.startIcon'))
                .width(20)
                .height(20)
                .fillColor('#FFFFFF')
                .margin({ right: 8 })
              Text('Start')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
            }
          }
          .backgroundColor('#6D4C41')
          .borderRadius(32)
          .width(160)
          .height(64)

          Blank()

          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#888888')
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(32)
          .width(64)
          .height(64)
          .border({ width: 1, color: '#EEEEEE' })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ bottom: 32 })

        // Step Item (From Skeleton)
        Row() {
          Stack({ alignContent: Alignment.Center }) {
            Text(this.step)
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
          }
          .width(24)
          .height(24)
          .backgroundColor('#F5F5F5')
          .borderRadius(12)

          Blank().width(12)

          Text(this.text)
            .fontSize(16)
            .fontColor('#333333')

          Blank().layoutWeight(1)

          Image($r('app.media.startIcon'))
            .width(16)
            .height(16)
            .fillColor('#EEEEEE')
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .padding({ left: 24, right: 24, top: 8, bottom: 8 })
        
        Divider()
          .color('#FAFAFA')
          .margin({ left: 24, right: 24 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
  }
}