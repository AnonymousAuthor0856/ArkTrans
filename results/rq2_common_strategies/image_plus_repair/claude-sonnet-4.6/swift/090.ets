@Entry
@Component
struct LumenAppScreen {
  @State selectedIso: string = '400';
  @State apertureValue: number = 2.8;
  @State selectedSpeedIndex: number = 4;

  shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8'];

  build() {
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
            .fontWeight(700)
            .fontColor('#000000')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Row() {
          Button() {
            Text('≡')
              .fontSize(24)
              .fontColor('#000000')
          }
          .width(44)
          .height(44)
          .backgroundColor(Color.Transparent)
          .borderRadius(22)

          Button() {
            Text('⚙')
              .fontSize(22)
              .fontColor('#000000')
          }
          .width(44)
          .height(44)
          .backgroundColor(Color.Transparent)
          .borderRadius(22)
        }
      }
      .width('100%')
      .margin({ bottom: 16 })

      // Current Settings Display Card
      Stack() {
        Row() {
          // Aperture section
          Column() {
            Text(`f/${this.apertureValue.toFixed(1)}`)
              .fontSize(56)
              .fontWeight(FontWeight.Lighter)
              .fontColor('#000000')
              .letterSpacing(-2)
            Text('APERTURE')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor('#999999')
          }
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.Center)
          .padding({ left: 24 })
          .layoutWeight(1.5)
          .height('100%')

          // Divider
          Divider()
            .vertical(true)
            .height(80)
            .color('#E0E0E0')
            .strokeWidth(1)

          // ISO and Shutter section
          Column() {
            Column() {
              Text(this.selectedIso)
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor('#000000')
              Text('ISO')
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
              Text('SHUTTER')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor('#999999')
            }
            .alignItems(HorizontalAlign.Start)
          }
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.Center)
          .padding({ left: 24 })
          .layoutWeight(1)
          .height('100%')
        }
        .width('100%')
        .height('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(160)
      .backgroundColor('#F8F8F8')
      .borderRadius(16)
      .border({ width: 1, color: '#EEEEEE' })

      Blank()

      // Controls
      Column({ space: 32 }) {
        // ISO Selector
        Column() {
          Text('Film Stock ISO')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .margin({ bottom: 12 })

          Scroll() {
            Row({ space: 12 }) {
              ForEach(['100', '200', '400', '800', '1600', '3200'], (iso: string) => {
                Text(iso)
                  .fontSize(13)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedIso === iso ? '#FFFFFF' : '#000000')
                  .width(60)
                  .height(36)
                  .textAlign(TextAlign.Center)
                  .backgroundColor(this.selectedIso === iso ? '#000000' : Color.Transparent)
                  .borderRadius(50)
                  .border({
                    width: 1,
                    color: this.selectedIso === iso ? '#000000' : '#E0E0E0'
                  })
                  .onClick(() => {
                    this.selectedIso = iso;
                  })
              })
            }
            .padding({ left: 2, right: 2 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')

        // Aperture Control
        Column() {
          Row() {
            Text('Aperture Control')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
            Blank()
            Text('⚙')
              .fontSize(16)
              .fontColor('#999999')
          }
          .width('100%')
          .margin({ bottom: 8 })

          Slider({
            value: this.apertureValue,
            min: 1.4,
            max: 16.0,
            step: (16.0 - 1.4) / 20.0,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .trackThickness(2)
            .selectedColor('#000000')
            .trackColor('#E0E0E0')
            .blockColor('#000000')
            .onChange((value: number) => {
              this.apertureValue = value;
            })

          Row() {
            Text('f/1.4')
              .fontSize(12)
              .fontColor('#999999')
            Blank()
            Text('f/16')
              .fontSize(12)
              .fontColor('#999999')
          }
          .width('100%')
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')

        // Shutter Speed Control
        Column() {
          Text('Shutter Speed')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .margin({ bottom: 12 })

          Row({ space: 12 }) {
            // Previous
            Text(this.selectedSpeedIndex > 0 ? this.shutterSpeeds[this.selectedSpeedIndex - 1] : '-')
              .fontSize(16)
              .fontWeight(FontWeight.Normal)
              .fontColor('#E0E0E0')
              .width(100)
              .height(50)
              .textAlign(TextAlign.Center)
              .backgroundColor(Color.Transparent)
              .borderRadius(12)
              .onClick(() => {
                if (this.selectedSpeedIndex > 0) {
                  this.selectedSpeedIndex = this.selectedSpeedIndex - 1;
                }
              })

            // Current (selected)
            Text(this.shutterSpeeds[this.selectedSpeedIndex])
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .width(100)
              .height(50)
              .textAlign(TextAlign.Center)
              .backgroundColor('#F0F0F0')
              .borderRadius(12)

            // Next
            Text(this.selectedSpeedIndex < this.shutterSpeeds.length - 1 ? this.shutterSpeeds[this.selectedSpeedIndex + 1] : '-')
              .fontSize(16)
              .fontWeight(FontWeight.Normal)
              .fontColor('#E0E0E0')
              .width(100)
              .height(50)
              .textAlign(TextAlign.Center)
              .backgroundColor(Color.Transparent)
              .borderRadius(12)
              .onClick(() => {
                if (this.selectedSpeedIndex < this.shutterSpeeds.length - 1) {
                  this.selectedSpeedIndex = this.selectedSpeedIndex + 1;
                }
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
      }
      .width('100%')

      Blank()

      // Log Shot Button
      Button() {
        Row({ space: 12 }) {
          Stack() {
            Circle()
              .fill('#FFFFFF')
              .width(24)
              .height(24)
            Text('+')
              .fontSize(18)
              .fontColor('#000000')
              .fontWeight(FontWeight.Bold)
          }
          .width(24)
          .height(24)

          Text('LOG EXPOSURE')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .letterSpacing(1)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .backgroundColor('#000000')
      .borderRadius(12)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .padding(24)
    .alignItems(HorizontalAlign.Start)
  }
}