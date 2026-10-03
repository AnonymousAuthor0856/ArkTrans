@Entry
@Component
struct Index {
  @State targetTemp: number = 20
  @State mode: string = 'Heat'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 26 }) {
        Text('Target Temperature')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3B82F6')

        Row({ space: 12 }) {
          Button() {
            Text('–')
              .fontColor('#FFFFFF')
              .fontSize(20)
          }
          .backgroundColor('#3B82F6')
          .borderRadius(8)
          .width(48)
          .height(48)
          .onClick(() => {
            if (this.targetTemp > 10) {
              this.targetTemp--
            }
          })

          Button() {
            Text('+')
              .fontColor('#FFFFFF')
              .fontSize(20)
          }
          .backgroundColor('#3B82F6')
          .borderRadius(8)
          .width(48)
          .height(48)
          .onClick(() => {
            if (this.targetTemp < 35) {
              this.targetTemp++
            }
          })
        }.alignItems(VerticalAlign.Center)

        Divider()
          .vertical(false)
          .color('#CBD5E1')
          .width('80%')
          .height(1)

        Text('Mode')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')

        Row({ space: 18 }) {
          // Mode Button 1: Heat
          Button() {
            Column({ space: 0 }) {
              Image($r('app.media.startIcon'))
                .width(32)
                .height(32)
                .objectFit(ImageFit.Contain)
              Text('Heat')
                .fontSize(14)
                .fontColor(this.mode === 'Heat' ? '#FFFFFF' : '#64748B')
            }.alignItems(HorizontalAlign.Center)
          }
          .backgroundColor(this.mode === 'Heat' ? '#3B82F6' : '#E2E8F0')
          .borderRadius(50)
          .width(100)
          .height(100)
          .onClick(() => {
            this.mode = 'Heat'
          })

          // Mode Button 2: Cool
          Button() {
            Column({ space: 0 }) {
              Image($r('app.media.startIcon'))
                .width(32)
                .height(32)
                .objectFit(ImageFit.Contain)
              Text('Cool')
                .fontSize(14)
                .fontColor(this.mode === 'Cool' ? '#FFFFFF' : '#64748B')
            }.alignItems(HorizontalAlign.Center)
          }
          .backgroundColor(this.mode === 'Cool' ? '#3B82F6' : '#E2E8F0')
          .borderRadius(50)
          .width(100)
          .height(100)
          .onClick(() => {
            this.mode = 'Cool'
          })
        }

        Text(`Current Mode: ${this.mode}`)
          .fontSize(16)
          .fontColor('#1E293B')
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding(18)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#3B82F6', 0.15], ['#3B82F6', 0.2]]
      })

      // Top App Bar Simulation
      Row() {
        Text('ThermoCurve')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E293B')
        
        Blank()

        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor('#3B82F6')
          .margin({ start: 12 })

        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor('#06B6D4')
        }
        .backgroundColor('transparent')
        .onClick(() => {
          this.targetTemp++
        })
      }
      .width('100%')
      .height(56)
      .padding(16)
      .backgroundColor('#F1F5F9')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}