@Entry
@Component
struct Index {
  @State selectedIso: number = 400
  @State apertureValue: number = 2.8
  @State shutterSpeed: string = '1/60'

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // Header
        Row() {
          Column() {
            Text('LUMEN LOG')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#999999')
              .letterSpacing(2)
            Text('Roll #034')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
          }
          Blank()
          Row() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .objectFit(ImageFit.Contain)
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .objectFit(ImageFit.Contain)
          }.margin({ left: 16 })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 20 })

        // Main Card
        Column() {
          Row() {
            Column() {
              Text(`f/${this.apertureValue.toFixed(1)}`)
                .fontSize(56)
                .fontWeight(FontWeight.Normal)
                .fontColor('#000000')
                .letterSpacing(-2)
              Text('APERTURE')
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .fontColor('#999999')
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1.5)

            Divider()
              .vertical(true)
              .color('#E0E0E0')
              .height('80%')

            Column() {
              Row() {
                Text('ISO').fontSize(12).fontColor('#999999')
                Blank()
                Text(`${this.selectedIso}`).fontSize(12).fontColor('#000000')
              }
              .width('100%')
              .margin({ bottom: 16 })

              Row() {
                Text('SHUTTER').fontSize(12).fontColor('#999999')
                Blank()
                Text(this.shutterSpeed).fontSize(12).fontColor('#000000')
              }
              .width('100%')
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
            .padding({ left: 16 })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width('100%')
        .padding(24)
        .backgroundColor('#F8F8F8')
        .borderRadius(24)
        .border({ width: 1, color: '#EEEEEE' })
        .margin({ left: 20, right: 20, top: 20 })

        // ISO Section
        Column() {
          Text('Film Stock ISO')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .margin({ bottom: 16 })

          Scroll() {
            Row() {
              ForEach([100, 200, 400, 800, 1600], (iso: number) => {
                Button(iso.toString())
                  .type(ButtonType.Normal)
                  .backgroundColor(this.selectedIso === iso ? '#000000' : '#FFFFFF')
                  .fontColor(this.selectedIso === iso ? '#FFFFFF' : '#000000')
                  .borderRadius(20)
                  .border({ width: 1, color: '#CCCCCC' })
                  .width(80)
                  .height(48)
                  .margin({ right: 12 })
                  .onClick(() => {
                    this.selectedIso = iso
                  })
              })
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 24 })

        // Aperture Control Section
        Column() {
          Row() {
            Text('Aperture Control')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
            Blank()
            Image($r('app.media.startIcon'))
              .width(20)
              .height(20)
              .objectFit(ImageFit.Contain)
              .fillColor(Color.Gray)
          }
          .width('100%')
          .margin({ bottom: 16 })

          Slider({ value: this.apertureValue, min: 1.4, max: 16.0, step: 0.1 })
            .trackColor('#E0E0E0')
            .selectedColor('#000000')
            .blockColor('#000000')
            .width('100%')
            .height(40)

          Row() {
            Text('f/1.4').fontSize(12).fontColor('#999999')
            Blank()
            Text('f/16').fontSize(12).fontColor('#999999')
          }
          .width('100%')
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 24 })

        // Shutter Speed Section
        Column() {
          Text('Shutter Speed')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .margin({ bottom: 16 })

          Row() {
            ForEach(['1/125', '1/60', '1/30'], (speed: string) => {
              Button(speed)
                .type(ButtonType.Normal)
                .backgroundColor(this.shutterSpeed === speed ? '#F0F0F0' : '#FFFFFF')
                .fontColor(this.shutterSpeed === speed ? '#000000' : '#CCCCCC')
                .fontWeight(this.shutterSpeed === speed ? FontWeight.Bold : FontWeight.Normal)
                .borderRadius(16)
                .border({ width: 1, color: '#EEEEEE' })
                .width(100)
                .height(56)
                .margin({ left: 10, right: 10 })
                .onClick(() => {
                  this.shutterSpeed = speed
                })
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 24 })

        Blank()

        // Bottom Button
        Button() {
          Row() {
            Stack() {
              Circle().width(24).height(24).fill('#FFFFFF')
              Image($r('app.media.startIcon'))
                .width(16)
                .height(16)
                .objectFit(ImageFit.Contain)
                .fillColor(Color.Black)
            }
            Text('LOG EXPOSURE')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
              .letterSpacing(1)
              .margin({ left: 12 })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .type(ButtonType.Normal)
        .backgroundColor('#000000')
        .borderRadius(16)
        .width('100%')
        .height(60)
        .margin({ left: 20, right: 20, bottom: 20 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
  }
}