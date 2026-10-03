@Entry
@Component
struct LumenAppScreen {
  @State selectedIso: string = "400"
  @State apertureValue: number = 2.8
  @State selectedSpeedIndex: number = 4

  private shutterSpeeds: string[] = ["1/1000", "1/500", "1/250", "1/125", "1/60", "1/30", "1/15", "1/8"]

  build() {
    Column() {
      // Header
      Row() {
        Column() {
          Text("LUMEN LOG")
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)
            .fontColor('#999999')
          Text("Roll #034")
            .fontSize(24)
            .fontWeight(FontWeight.Bolder)
            .fontColor('#000000')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Row() {
          Button() {
            Image($r('app.media.startIcon'))
              .width(22)
              .height(22)
              .fillColor('#000000')
          }
          .width(44)
          .height(44)
          .backgroundColor(Color.Transparent)

          Button() {
            Image($r('app.media.startIcon'))
              .width(22)
              .height(22)
              .fillColor('#000000')
          }
          .width(44)
          .height(44)
          .backgroundColor(Color.Transparent)
        }
      }
      .width('100%')
      .padding({ bottom: 16 })

      // Main Display Card
      Row() {
        Column() {
          Text(`f/${this.apertureValue.toFixed(1)}`)
            .fontSize(56)
            .fontWeight(FontWeight.Lighter)
            .letterSpacing(-2)
            .fontColor('#000000')
          Text("APERTURE")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#999999')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1.5)
        .padding({ left: 24 })

        Divider()
          .vertical(true)
          .color('#E0E0E0')
          .height(80)

        Column() {
          Column() {
            Text(this.selectedIso)
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
            Text("ISO")
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor('#999999')
          }
          .alignItems(HorizontalAlign.Start)

          Blank().height(16)

          Column() {
            Text(this.shutterSpeeds[this.selectedSpeedIndex])
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
            Text("SHUTTER")
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor('#999999')
          }
          .alignItems(HorizontalAlign.Start)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .padding({ left: 24 })
      }
      .width('100%')
      .height(160)
      .backgroundColor('#F8F8F8')
      .borderRadius(16)
      .border({ width: 1, color: '#EEEEEE' })

      Blank()

      // ISO Selector
      Column() {
        Text("Film Stock ISO")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .margin({ bottom: 12 })

        Scroll() {
          Row() {
            ForEach(["100", "200", "400", "800", "1600", "3200"], (iso: string) => {
              Button(iso)
                .onClick(() => {
                  this.selectedIso = iso
                })
                .fontSize(13)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedIso === iso ? Color.White : Color.Black)
                .backgroundColor(this.selectedIso === iso ? Color.Black : Color.Transparent)
                .border({
                  width: 1,
                  color: this.selectedIso === iso ? Color.Black : '#E0E0E0',
                  radius: 50
                })
                .borderRadius(50)
                .width(60)
                .height(36)
                .margin({ right: 12 })
            })
          }
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .margin({ top: 32 })

      // Aperture Control
      Column() {
        Row() {
          Text("Aperture Control")
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
          Blank()
          Image($r('app.media.startIcon'))
            .width(16)
            .height(16)
            .fillColor('#999999')
        }
        .width('100%')

        Slider({ value: this.apertureValue, min: 1.4, max: 16.0, step: 0.73 })
          .width('100%')
          .trackThickness(2)
          .selectedColor(Color.Black)
          .blockColor(Color.Black)
          .trackColor('#E0E0E0')
          .margin({ top: 8 })

        Row() {
          Text("f/1.4").fontSize(12).fontColor('#999999')
          Blank()
          Text("f/16").fontSize(12).fontColor('#999999')
        }
        .width('100%')
      }
      .width('100%')
      .margin({ top: 32 })

      // Shutter Speed
      Column() {
        Text("Shutter Speed")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .margin({ bottom: 12 })

        Row() {
          if (this.selectedSpeedIndex - 1 >= 0) {
            Button(this.shutterSpeeds[this.selectedSpeedIndex - 1])
              .onClick(() => {
                this.selectedSpeedIndex = this.selectedSpeedIndex - 1
              })
              .fontSize(16)
              .fontWeight(FontWeight.Normal)
              .fontColor('#E0E0E0')
              .backgroundColor(Color.Transparent)
              .borderRadius(12)
              .width(100)
              .height(50)
              .margin({ right: 12 })
          } else {
            Text("-")
              .fontSize(16)
              .fontColor('#E0E0E0')
              .width(100)
              .height(50)
              .textAlign(TextAlign.Center)
              .margin({ right: 12 })
          }

          // Current
          Text(this.shutterSpeeds[this.selectedSpeedIndex])
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .backgroundColor('#F0F0F0')
            .borderRadius(12)
            .width(100)
            .height(50)
            .textAlign(TextAlign.Center)
            .margin({ right: 12 })

          // Next
          if (this.selectedSpeedIndex + 1 < this.shutterSpeeds.length) {
            Button(this.shutterSpeeds[this.selectedSpeedIndex + 1])
              .onClick(() => {
                this.selectedSpeedIndex = this.selectedSpeedIndex + 1
              })
              .fontSize(16)
              .fontWeight(FontWeight.Normal)
              .fontColor('#E0E0E0')
              .backgroundColor(Color.Transparent)
              .borderRadius(12)
              .width(100)
              .height(50)
          } else {
            Text("-")
              .fontSize(16)
              .fontColor('#E0E0E0')
              .width(100)
              .height(50)
              .textAlign(TextAlign.Center)
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .margin({ top: 32 })

      Blank()

      // Log Shot Button
      Button() {
        Row() {
          Circle()
            .width(24)
            .height(24)
            .fill(Color.White)
            .margin({ right: 12 })
          
          Text("LOG EXPOSURE")
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1)
            .fontColor(Color.White)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(56)
      .backgroundColor(Color.Black)
      .borderRadius(12)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
  }
}