@Entry
@Component
struct LumenLogApp {
  @State selectedIso: string = '400'
  @State apertureValue: number = 2.8
  @State selectedSpeedIndex: number = 4

  private shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8']
  private isoValues: string[] = ['100', '200', '400', '800', '1600', '3200']

  private apertureText(): string {
    return this.apertureValue.toFixed(1)
  }

  build() {
    Column() {
      Row() {
        Column() {
          Text('LUMEN LOG')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#8B8B8B')
            .letterSpacing(2)
            .margin({ bottom: 10 })
          Text('Roll #034')
            .fontSize(48)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
        .alignItems(HorizontalAlign.Start)

        Row({ space: 24 }) {
          Text('☰')
            .fontSize(34)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
            .onClick(() => {})
          Text('⚙')
            .fontSize(37)
            .fontColor(Color.Black)
            .onClick(() => {})
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: 34 })

      Row() {
        Column() {
          Text(`f/${this.apertureText()}`)
            .fontSize(60)
            .fontWeight(FontWeight.Normal)
            .fontColor(Color.Black)
            .letterSpacing(-2)
          Text('APERTURE')
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
            .fontColor('#8B8B8B')
            .margin({ top: 20 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1.55)

        Divider()
          .vertical(true)
          .height(80)
          .strokeWidth(1)
          .color('#C8C8C8')

        Column() {
          Text(this.selectedIso)
            .fontSize(40)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
          Text('ISO')
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
            .fontColor('#8B8B8B')
            .margin({ top: 14, bottom: 46 })
          Text(this.shutterSpeeds[this.selectedSpeedIndex])
            .fontSize(40)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
          Text('SHUTTER')
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
            .fontColor('#8B8B8B')
            .margin({ top: 14 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        .margin({ left: 24 })
      }
      .width('100%')
      .height(320)
      .padding({ left: 48, right: 24 })
      .borderRadius(30)
      .backgroundColor('#F8F8F8')
      .border({ width: 1, color: '#E9E9E9', radius: 30 })
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: 26 })

      Column() {
        Text('Film Stock ISO')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor('#242329')
          .margin({ bottom: 28 })

        Scroll() {
          Row({ space: 24 }) {
            ForEach(this.isoValues, (iso: string) => {
              Text(iso)
                .fontSize(25)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.selectedIso === iso ? Color.White : Color.Black)
                .textAlign(TextAlign.Center)
                .width(120)
                .height(72)
                .padding({ top: 18 })
                .borderRadius(40)
                .backgroundColor(this.selectedIso === iso ? Color.Black : Color.White)
                .border({
                  width: 2,
                  color: this.selectedIso === iso ? Color.Black : '#E0E0E0',
                  radius: 40
                })
                .onClick(() => {
                  this.selectedIso = iso
                })
            }, (iso: string) => iso)
          }
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ bottom: 68 })

      Column() {
        Row() {
          Text('Aperture Control')
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor('#242329')
          Text('⚙')
            .fontSize(25)
            .fontColor('#8B8B8B')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('●')
            .fontSize(22)
            .fontColor(Color.Black)
            .width(42)
            .height(34)
            .textAlign(TextAlign.Center)
            .backgroundColor(Color.Black)
            .borderRadius(17)
          Divider()
            .vertical(true)
            .height(80)
            .strokeWidth(8)
            .color(Color.Black)
          Slider({
            value: this.apertureValue,
            min: 1.4,
            max: 16,
            step: 0.6,
            style: SliderStyle.OutSet
          })
            .layoutWeight(1)
            .margin({ left: 14 })
            .blockColor(Color.Black)
            .trackColor('#E0E0E0')
            .selectedColor('#E0E0E0')
            .onChange((value: number) => {
              this.apertureValue = value
            })
        }
        .width('100%')
        .height(82)
        .margin({ top: 22, bottom: 6 })

        Row() {
          Text('f/1.4')
            .fontSize(22)
            .fontColor('#8B8B8B')
          Text('f/16')
            .fontSize(22)
            .fontColor('#8B8B8B')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ bottom: 74 })

      Column() {
        Text('Shutter Speed')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor('#242329')
          .margin({ bottom: 28 })

        Row() {
          this.speedOption(this.selectedSpeedIndex - 1, false)
          this.speedOption(this.selectedSpeedIndex, true)
          this.speedOption(this.selectedSpeedIndex + 1, false)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ bottom: 22 })

      Button() {
        Row({ space: 18 }) {
          Stack() {
            Text('+')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor(Color.White)
          .alignContent(Alignment.Center)

          Text('LOG EXPOSURE')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .letterSpacing(1)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(74)
      .backgroundColor(Color.Black)
      .borderRadius(28)
      .margin({ top: 0 })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 48, right: 48, top: 58, bottom: 22 })
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  speedOption(index: number, selected: boolean) {
    if (index >= 0 && index < this.shutterSpeeds.length) {
      Text(this.shutterSpeeds[index])
        .fontSize(selected ? 38 : 28)
        .fontWeight(selected ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(selected ? Color.Black : '#D0D0D0')
        .textAlign(TextAlign.Center)
        .width(selected ? 200 : 150)
        .height(selected ? 100 : 72)
        .padding({ top: selected ? 25 : 20 })
        .borderRadius(24)
        .backgroundColor(selected ? '#F0F0F0' : Color.White)
        .onClick(() => {
          if (!selected) {
            this.selectedSpeedIndex = index
          }
        })
    } else {
      Text('')
        .width(150)
        .height(72)
    }
  }
}
