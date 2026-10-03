class LmColors {
  static readonly white: string = '#FFFFFFFF'
  static readonly black: string = '#FF000000'
  static readonly gray: string = '#FF808080'
  static readonly cardBg: string = '#FFF8F8F8'
  static readonly cardBorder: string = '#FFEEEEEE'
  static readonly divider: string = '#FFE0E0E0'
  static readonly speedBg: string = '#FFF0F0F0'
  static readonly speedInactive: string = '#FFE0E0E0'
}

@Entry
@Component
struct Index {
  @State selectedIso: string = '400'
  @State apertureValue: number = 2.8
  @State selectedSpeedIndex: number = 4

  private shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8']
  private isoValues: string[] = ['100', '200', '400', '800', '1600', '3200']

  build() {
    Stack() {
      Column() {
        Row() {
          Column() {
            Text('LUMEN LOG')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor(LmColors.gray)
            Text('Roll #034')
              .fontSize(24)
              .fontWeight(FontWeight.Black)
              .fontColor(LmColors.black)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Row() {
            Text('☰')
              .fontSize(22)
              .fontColor(LmColors.black)
              .width(44)
              .height(44)
              .textAlign(TextAlign.Center)

            Text('⚙')
              .fontSize(22)
              .fontColor(LmColors.black)
              .width(44)
              .height(44)
              .textAlign(TextAlign.Center)
          }
        }
        .margin({ bottom: 16 })

        Row() {
          Column() {
            Text(`f/${this.apertureValue.toFixed(1)}`)
              .fontSize(56)
              .fontWeight(FontWeight.Lighter)
              .fontColor(LmColors.black)

            Text('APERTURE')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(LmColors.gray)
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1.5)

          Column() {
            Blank()
          }
          .width(1)
          .height(80)
          .backgroundColor(LmColors.divider)

          Column() {
            Column() {
              Text(this.selectedIso)
                .fontSize(20)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(LmColors.black)
              Text('ISO')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor(LmColors.gray)
            }
            .alignItems(HorizontalAlign.Start)

            Column() {
              Text(this.shutterSpeeds[this.selectedSpeedIndex])
                .fontSize(20)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(LmColors.black)
              Text('SHUTTER')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor(LmColors.gray)
            }
            .alignItems(HorizontalAlign.Start)
            .margin({ top: 16 })
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)
          .margin({ left: 24 })
        }
        .height(160)
        .backgroundColor(LmColors.cardBg)
        .borderRadius(16)
        .border({ width: 1, color: LmColors.cardBorder })
        .padding({ left: 24 })

        Blank()

        Column() {
          Column() {
            Text('Film Stock ISO')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(LmColors.black)
              .margin({ bottom: 12 })

            Scroll() {
              Row() {
                ForEach(this.isoValues, (iso: string) => {
                  Text(iso)
                    .fontSize(13)
                    .fontWeight(FontWeight.SemiBold)
                    .fontColor(this.selectedIso === iso ? LmColors.white : LmColors.black)
                    .width(60)
                    .height(36)
                    .textAlign(TextAlign.Center)
                    .backgroundColor(this.selectedIso === iso ? LmColors.black : '#00000000')
                    .borderRadius(50)
                    .border({ width: 1, color: this.selectedIso === iso ? LmColors.black : LmColors.divider })
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
          .alignItems(HorizontalAlign.Start)

          Column() {
            Row() {
              Text('Aperture Control')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(LmColors.black)
              Blank()
              Text('⚙')
                .fontSize(16)
                .fontColor(LmColors.gray)
            }

            Slider({
              value: this.apertureValue,
              min: 1.4,
              max: 16.0,
              step: 0.73,
            })
              .blockColor(LmColors.black)
              .trackColor(LmColors.divider)
              .selectedColor(LmColors.black)
              .margin({ top: 8 })

            Row() {
              Text('f/1.4')
                .fontSize(12)
                .fontColor(LmColors.gray)
              Blank()
              Text('f/16')
                .fontSize(12)
                .fontColor(LmColors.gray)
            }
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ top: 32 })

          Column() {
            Text('Shutter Speed')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(LmColors.black)
              .margin({ bottom: 12 })

            Row() {
              Text(this.selectedSpeedIndex > 0 ? this.shutterSpeeds[this.selectedSpeedIndex - 1] : '-')
                .fontSize(16)
                .fontColor(LmColors.speedInactive)
                .width(100)
                .height(50)
                .textAlign(TextAlign.Center)
                .onClick(() => {
                  if (this.selectedSpeedIndex > 0) {
                    this.selectedSpeedIndex -= 1
                  }
                })

              Text(this.shutterSpeeds[this.selectedSpeedIndex])
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(LmColors.black)
                .width(100)
                .height(50)
                .textAlign(TextAlign.Center)
                .backgroundColor(LmColors.speedBg)
                .borderRadius(12)

              Text(this.selectedSpeedIndex < this.shutterSpeeds.length - 1 ? this.shutterSpeeds[this.selectedSpeedIndex + 1] : '-')
                .fontSize(16)
                .fontColor(LmColors.speedInactive)
                .width(100)
                .height(50)
                .textAlign(TextAlign.Center)
                .onClick(() => {
                  if (this.selectedSpeedIndex < this.shutterSpeeds.length - 1) {
                    this.selectedSpeedIndex += 1
                  }
                })
            }
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ top: 32 })
        }

        Blank()

        Row() {
          Stack() {
            Circle({ width: 24, height: 24 })
              .fill(LmColors.white)
            Text('+')
              .fontSize(16)
              .fontColor(LmColors.black)
          }

          Text('LOG EXPOSURE')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(LmColors.white)
            .margin({ left: 12 })
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(LmColors.black)
        .borderRadius(12)
      }
      .padding(24)
    }
    .backgroundColor(LmColors.white)
    .width('100%')
    .height('100%')
  }
}