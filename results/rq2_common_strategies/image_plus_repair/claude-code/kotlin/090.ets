@Entry
@Component
struct LumenAppScreen {
  @State selectedIso: string = '400'
  @State apertureValue: number = 2.8
  @State selectedSpeedIndex: number = 4
  private isoValues: string[] = ['100', '200', '400', '800', '1600', '3200']
  private shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8']
  private apertureDots: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

  build() {
    Column() {
      this.HeaderSection()

      this.CurrentSettingsDisplay(
        this.selectedIso,
        this.apertureValue.toFixed(1),
        this.shutterSpeeds[this.selectedSpeedIndex]
      )

      Column() {
        this.IsoSelector()

        this.ApertureControl()

        this.ShutterSpeedControl()
      }
      .width('100%')

      this.LogShotButton()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(Color.White)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('LUMEN LOG')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#999999')
          .letterSpacing(2)
        Text('Roll #034')
          .fontSize(42)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Row() {
        Text('☰')
          .fontSize(32)
          .fontColor(Color.Black)
          .width(40)
          .height(40)
          .textAlign(TextAlign.Center)
        Text('⚙')
          .fontSize(28)
          .fontColor(Color.Black)
          .width(40)
          .height(40)
          .textAlign(TextAlign.Center)
          .margin({ left: 8 })
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  CurrentSettingsDisplay(iso: string, aperture: string, shutter: string) {
    Row() {
      Column() {
        Text(`f/${aperture}`)
          .fontSize(100)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
        Text('APERTURE')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#999999')
          .margin({ top: 8 })
      }
      .width('55%')
      .padding({ left: 24 })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Start)

      Divider()
        .vertical(true)
        .height(80)
        .color('#DDDDDD')
        .width(1)

      Column() {
        this.SettingItemSmall('ISO', iso)
        Column() {
          this.SettingItemSmall('SHUTTER', shutter)
        }
        .margin({ top: 16 })
      }
      .layoutWeight(1)
      .padding({ left: 24 })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(200)
    .backgroundColor('#F8F8F8')
    .borderRadius(28)
    .border({ width: 1, color: '#EEEEEE' })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SettingItemSmall(label: string, value: string) {
    Column() {
      Text(value)
        .fontSize(34)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#999999')
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  IsoSelector() {
    Column() {
      Text('Film Stock ISO')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ bottom: 12 })

      Row() {
        ForEach(this.isoValues, (iso: string) => {
          Text(iso)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedIso === iso ? Color.White : Color.Black)
            .width(80)
            .height(48)
            .textAlign(TextAlign.Center)
            .borderRadius(24)
            .backgroundColor(this.selectedIso === iso ? Color.Black : Color.Transparent)
            .border({
              width: 1,
              color: this.selectedIso === iso ? Color.Black : '#E0E0E0'
            })
            .margin({ right: 12 })
            .onClick(() => {
              this.selectedIso = iso
            })
        }, (iso: string) => iso)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  ApertureControl() {
    Column() {
      Row() {
        Text('Aperture Control')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
        Text('⚙')
          .fontSize(20)
          .fontColor('#999999')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Stack() {
        Row() {
          ForEach(this.apertureDots, (_: number) => {
            Circle({ width: 6, height: 6 })
              .fill('#333333')
          }, (item: number) => item.toString())
        }
        .width('100%')
        .height(28)
        .backgroundColor('#E0E0E0')
        .borderRadius(14)
        .justifyContent(FlexAlign.SpaceAround)
        .padding({ left: 10, right: 10 })

        Row() {
          Circle({ width: 20, height: 20 })
            .fill(Color.Black)
          Stack() {
            Circle({ width: 4, height: 4 })
              .fill('#9370DB')
          }
          .width(20)
          .height(20)
          .position({ x: -20, y: 0 })
        }
        .position({
          x: this.apertureToX(this.apertureValue),
          y: '50%'
        })
        .translate({ y: -10 })

        Column() {
        }
        .width(2)
        .height(40)
        .backgroundColor(Color.Black)
        .borderRadius(1)
        .position({
          x: this.apertureToX(this.apertureValue) + 10,
          y: '50%'
        })
        .translate({ y: -20 })
      }
      .width('100%')
      .height(56)
      .margin({ top: 12, bottom: 8 })

      Slider({
        value: this.apertureValue,
        min: 1.4,
        max: 16,
        step: 0.1,
        style: SliderStyle.OutSet
      })
        .blockColor(Color.Transparent)
        .trackColor(Color.Transparent)
        .selectedColor(Color.Transparent)
        .width('100%')
        .height(56)
        .position({ y: -56 })
        .margin({ bottom: -56 })
        .onChange((value: number) => {
          this.apertureValue = value
        })

      Row() {
        Text('f/1.4')
          .fontSize(14)
          .fontColor('#999999')
        Text('f/16')
          .fontSize(14)
          .fontColor('#999999')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  private apertureToX(value: number): number {
    const min: number = 1.4
    const max: number = 16
    const ratio: number = (value - min) / (max - min)
    const thumbWidth: number = 40
    const trackPadding: number = 0
    const trackWidth: number = 300
    return ratio * (trackWidth - thumbWidth) + trackPadding
  }

  @Builder
  ShutterSpeedControl() {
    Column() {
      Text('Shutter Speed')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ bottom: 12 })

      Row() {
        this.SpeedOption(
          this.selectedSpeedIndex > 0 ? this.shutterSpeeds[this.selectedSpeedIndex - 1] : '-',
          false,
          () => {
            if (this.selectedSpeedIndex > 0) {
              this.selectedSpeedIndex--
            }
          }
        )

        this.SpeedOption(this.shutterSpeeds[this.selectedSpeedIndex], true, () => {})

        this.SpeedOption(
          this.selectedSpeedIndex < this.shutterSpeeds.length - 1
            ? this.shutterSpeeds[this.selectedSpeedIndex + 1]
            : '-',
          false,
          () => {
            if (this.selectedSpeedIndex < this.shutterSpeeds.length - 1) {
              this.selectedSpeedIndex++
            }
          }
        )
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  SpeedOption(text: string, isSelected: boolean, onClick: () => void) {
    Text(text)
      .fontSize(isSelected ? 34 : 22)
      .fontWeight(isSelected ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(isSelected ? Color.Black : '#D0D0D0')
      .width(120)
      .height(64)
      .textAlign(TextAlign.Center)
      .borderRadius(16)
      .backgroundColor(isSelected ? '#F0F0F0' : Color.Transparent)
      .onClick(() => {
        if (!isSelected && text !== '-') {
          onClick()
        }
      })
  }

  @Builder
  LogShotButton() {
    Row() {
      Stack() {
        Circle({ width: 36, height: 36 })
          .fill(Color.White)
        Text('+')
          .fontSize(28)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
      }

      Text('LOG EXPOSURE')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .letterSpacing(1)
        .margin({ left: 12 })
    }
    .width('100%')
    .height(64)
    .backgroundColor(Color.Black)
    .borderRadius(20)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .onClick(() => {})
  }
}
