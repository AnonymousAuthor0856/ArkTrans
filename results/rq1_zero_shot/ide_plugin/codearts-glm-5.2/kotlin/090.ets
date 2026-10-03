class AppTokens {
  static readonly Colors = {
    black: '#FF000000',
    white: '#FFFFFFFF',
    gray: '#FF888888',
    lightGray: '#FFBDBDBD',
    cardBg: '#FFF8F8F8',
    cardBorder: '#FFEEEEEE',
    optionBorder: '#FFE0E0E0',
    speedBg: '#FFF0F0F0',
    transparent: '#00000000'
  }
}

@Entry
@Component
struct LumenAppScreen {
  @State selectedIso: string = '400'
  @State apertureValue: number = 2.8
  @State selectedSpeedIndex: number = 4

  private shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8']
  private isoValues: string[] = ['100', '200', '400', '800', '1600', '3200']

  build() {
    Column() {
      Row() {
        Column() {
          Text('LUMEN LOG')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)
            .fontColor(AppTokens.Colors.gray)
          Text('Roll #034')
            .fontSize(24)
            .fontWeight(FontWeight.Bolder)
            .fontColor(AppTokens.Colors.black)
        }
        .alignItems(HorizontalAlign.Start)

        Row() {
          Text('☰')
            .fontSize(24)
            .fontColor(AppTokens.Colors.black)
            .width(40)
            .height(40)
            .textAlign(TextAlign.Center)
          Text('⚙')
            .fontSize(24)
            .fontColor(AppTokens.Colors.black)
            .width(40)
            .height(40)
            .textAlign(TextAlign.Center)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ bottom: 16 })

      Row() {
        Column() {
          Text(`f/${this.apertureValue.toFixed(1)}`)
            .fontSize(56)
            .fontWeight(FontWeight.Light)
            .fontColor(AppTokens.Colors.black)
            .letterSpacing(-2)
          Text('APERTURE')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.gray)
            .margin({ top: 4 })
        }
        .layoutWeight(1.5)
        .padding({ left: 24 })
        .justifyContent(FlexAlign.Center)

        Divider()
          .vertical(true)
          .height(80)
          .strokeWidth(1)
          .color(AppTokens.Colors.lightGray)

        Column() {
          SettingItemSmall({ label: 'ISO', value: this.selectedIso })
          SettingItemSmall({ label: 'SHUTTER', value: this.shutterSpeeds[this.selectedSpeedIndex] })
            .margin({ top: 16 })
        }
        .layoutWeight(1)
        .padding({ left: 24 })
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(160)
      .borderRadius(16)
      .backgroundColor(AppTokens.Colors.cardBg)
      .border({ width: 1, color: AppTokens.Colors.cardBorder })
      .alignItems(VerticalAlign.Center)

      Column() {
        Column() {
          Text('Film Stock ISO')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.black)
            .margin({ bottom: 12 })

          Scroll() {
            Row() {
              ForEach(this.isoValues, (iso: string) => {
                Text(iso)
                  .fontSize(13)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedIso === iso ? AppTokens.Colors.white : AppTokens.Colors.black)
                  .width(60)
                  .height(36)
                  .borderRadius(50)
                  .backgroundColor(this.selectedIso === iso ? AppTokens.Colors.black : AppTokens.Colors.transparent)
                  .border({ width: 1, color: this.selectedIso === iso ? AppTokens.Colors.black : AppTokens.Colors.optionBorder })
                  .textAlign(TextAlign.Center)
                  .margin({ right: 12 })
                  .onClick(() => {
                    this.selectedIso = iso
                  })
              })
            }
          }
          .scrollDirection(Axis.Horizontal)
          .scrollBar(BarState.Off)
        }

        Column() {
          Row() {
            Text('Aperture Control')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.black)
            Text('⚙')
              .fontSize(16)
              .fontColor(AppTokens.Colors.gray)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          Slider({
            value: this.apertureValue,
            min: 1.4,
            max: 16,
            style: SliderStyle.OutSet
          })
            .blockColor(AppTokens.Colors.black)
            .trackColor(AppTokens.Colors.optionBorder)
            .selectedColor(AppTokens.Colors.black)
            .margin({ top: 8 })
            .onChange((value: number) => {
              this.apertureValue = value
            })

          Row() {
            Text('f/1.4')
              .fontSize(12)
              .fontColor(AppTokens.Colors.gray)
            Text('f/16')
              .fontSize(12)
              .fontColor(AppTokens.Colors.gray)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .margin({ top: 32 })

        Column() {
          Text('Shutter Speed')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.black)
            .margin({ bottom: 12 })

          Row() {
            SpeedOption({
              text: this.selectedSpeedIndex > 0 ? this.shutterSpeeds[this.selectedSpeedIndex - 1] : '-',
              isSelected: false,
              onClick: () => {
                if (this.selectedSpeedIndex > 0) {
                  this.selectedSpeedIndex -= 1
                }
              }
            })
            SpeedOption({
              text: this.shutterSpeeds[this.selectedSpeedIndex],
              isSelected: true,
              onClick: () => {}
            })
            SpeedOption({
              text: this.selectedSpeedIndex < this.shutterSpeeds.length - 1 ? this.shutterSpeeds[this.selectedSpeedIndex + 1] : '-',
              isSelected: false,
              onClick: () => {
                if (this.selectedSpeedIndex < this.shutterSpeeds.length - 1) {
                  this.selectedSpeedIndex += 1
                }
              }
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .margin({ top: 32 })
      }

      Row() {
        Row() {
          Text('+')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.black)
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(AppTokens.Colors.white)
        .justifyContent(FlexAlign.Center)

        Text('LOG EXPOSURE')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.white)
          .letterSpacing(1)
          .margin({ left: 12 })
      }
      .width('100%')
      .height(56)
      .borderRadius(12)
      .backgroundColor(AppTokens.Colors.black)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(AppTokens.Colors.white)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct SettingItemSmall {
  @Prop label: string
  @Prop value: string

  build() {
    Column() {
      Text(this.value)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.black)
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.gray)
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SpeedOption {
  @Prop text: string
  @Prop isSelected: boolean
  onClick: () => void = () => {}

  build() {
    Text(this.text)
      .fontSize(this.isSelected ? 22 : 16)
      .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.isSelected ? AppTokens.Colors.black : AppTokens.Colors.lightGray)
      .width(100)
      .height(50)
      .borderRadius(12)
      .backgroundColor(this.isSelected ? AppTokens.Colors.speedBg : AppTokens.Colors.transparent)
      .textAlign(TextAlign.Center)
      .onClick(() => {
        if (!this.isSelected && this.text !== '-') {
          this.onClick()
        }
      })
  }
}