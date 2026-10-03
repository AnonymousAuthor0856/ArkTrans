@Entry
@Component
struct Index {
  @State targetTemp: number = 22
  @State mode: string = 'Cool'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Column (Main Content) ===
      Column({ space: 26 }) {
        // === Text: Target Temperature ===
        Text('Target Temperature')
          .fontColor('#1E293B')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)

        // === Text: Temp Value ===
        Text(`${this.targetTemp}°C`)
          .fontColor('#3B82F6')
          .fontSize(72)
          .fontWeight(FontWeight.Bold)

        // === Row: Controls (- / +) ===
        Row({ space: 12 }) {
          Button() {
            Text('–')
              .fontColor('#FFFFFF')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
          }
          .backgroundColor('#3B82F6')
          .borderRadius(50)
          .width(64)
          .height(64)
          .onClick(() => {
            if (this.targetTemp > 10) this.targetTemp--
          })

          Button() {
            Text('+')
              .fontColor('#FFFFFF')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
          }
          .backgroundColor('#3B82F6')
          .borderRadius(50)
          .width(64)
          .height(64)
          .onClick(() => {
            if (this.targetTemp < 35) this.targetTemp++
          })
        }.alignItems(VerticalAlign.Center)

        // === Divider ===
        Divider()
          .color('#CBD5E1')
          .strokeWidth(1)
          .margin({ left: 40, right: 40 })

        // === Text: Mode Label ===
        Text('Mode')
          .fontColor('#1E293B')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)

        // === Row: Mode Buttons ===
        Row({ space: 18 }) {
          // Cool Button
          Button() {
            Column({ space: 0 }) {
              Image($r('app.media.startIcon'))
                .width(32)
                .height(32)
                .objectFit(ImageFit.Contain)
                .fillColor(this.mode === 'Cool' ? '#FFFFFF' : '#1E293B')
              Text('Cool')
                .fontColor(this.mode === 'Cool' ? '#FFFFFF' : '#1E293B')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
            }.alignItems(HorizontalAlign.Center)
          }
          .backgroundColor(this.mode === 'Cool' ? '#3B82F6' : '#E2E8F0')
          .borderRadius(100)
          .width(100)
          .height(100)
          .onClick(() => {
            this.mode = 'Cool'
          })

          // Heat Button
          Button() {
            Column({ space: 0 }) {
              Image($r('app.media.startIcon'))
                .width(32)
                .height(32)
                .objectFit(ImageFit.Contain)
                .fillColor(this.mode === 'Heat' ? '#FFFFFF' : '#1E293B')
              Text('Heat')
                .fontColor(this.mode === 'Heat' ? '#FFFFFF' : '#1E293B')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
            }.alignItems(HorizontalAlign.Center)
          }
          .backgroundColor(this.mode === 'Heat' ? '#3B82F6' : '#E2E8F0')
          .borderRadius(100)
          .width(100)
          .height(100)
          .onClick(() => {
            this.mode = 'Heat'
          })
        }

        // === Text: Current Mode Status ===
        Text(`Current Mode: ${this.mode}`)
          .fontColor('#1E293B')
          .fontSize(16)
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding(18)
      .linearGradient({
        angle: 180,
        colors: [['#F0F9FF', 0], ['#BFDBFE', 1]]
      })

      // === Top App Bar Area ===
      Row() {
        // Left Icon
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .fillColor('#3B82F6')
          .margin({ left: 18 })

        Blank()

        // Center Title
        Text('ThermoCurve')
          .fontColor('#1E293B')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)

        Blank()

        // Right Icon
        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .fillColor('#06B6D4')
        }
        .margin({ right: 18 })
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          this.targetTemp++
        })
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}