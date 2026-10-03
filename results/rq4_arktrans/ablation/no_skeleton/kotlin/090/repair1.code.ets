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
      // Header
      Row() {
        Column() {
          Text('LUMEN LOG')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)
            .fontColor('#999999')
          Text('Roll #034')
            .fontSize(24)
            .fontWeight(FontWeight.ExtraBold)
            .fontColor('#000000')
        }

        Row() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .margin({ right: 16 })
          
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ bottom: 16 })

      // Main Display Card
      Row() {
        // Aperture Section
        Column() {
          Text(`f/${this.apertureValue.toFixed(1)}`)
            .fontSize(56)
            .fontWeight(FontWeight.Lighter)
            .letterSpacing(-2)
            .fontColor('#000000')
          Text('APERTURE')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#999999')
        }
        .layoutWeight(1.5)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)
        .padding({ left: 24 })

        Divider()
          .height(80)
          .color('#D3D3D3')

        // Details Section
        Column() {
          this.SettingItemSmall('ISO', this.selectedIso)
          Blank().height(16)
          this.SettingItemSmall('SHUTTER', this.shutterSpeeds[this.selectedSpeedIndex])
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)
        .padding({ left: 24 })
      }
      .width('100%')
      .height(160)
      .backgroundColor('#F8F8F8')
      .borderRadius(16)
      .border({ width: 1, color: '#EEEEEE' })
      .margin({ top: 16 })

      // Controls Container
      Column() {
        // ISO Selector
        Column() {
          Text('Film Stock ISO')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 12 })
          
          Flex({ wrap: FlexWrap.Wrap }) {
            ForEach(this.isoValues, (iso: string) => {
              Button(iso)
                .type(ButtonType.Normal)
                .backgroundColor(this.selectedIso === iso ? '#000000' : '#FFFFFF')
                .fontColor(this.selectedIso === iso ? '#FFFFFF' : '#000000')
                .borderWidth(1)
                .borderColor(this.selectedIso === iso ? '#000000' : '#E0E0E0')
                .borderRadius(50)
                .width(60)
                .height(36)
                .margin({ right: 12, bottom: 8 })
                .onClick(() => {
                  this.selectedIso = iso
                })
            })
          }
        }
        .margin({ bottom: 32 })

        // Aperture Control
        Column() {
          Row() {
            Text('Aperture Control')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
            
            Blank()
            
            Image($r('app.media.startIcon'))
              .width(16)
              .height(16)
              .objectFit(ImageFit.Contain)
          }
          .width('100%')
          
          Slider({ value: this.apertureValue, min: 1.4, max: 16 })
            .width('100%')
            .blockColor('#000000')
            .selectedColor('#000000')
            .trackColor('#E0E0E0')
            .showTips(false)
            .onChange((value: number) => {
              this.apertureValue = value
            })

          Row() {
            Text('f/1.4').fontSize(12).fontColor('#999999')
            Blank()
            Text('f/16').fontSize(12).fontColor('#999999')
          }.width('100%')
        }
        .margin({ bottom: 32 })

        // Shutter Speed
        Column() {
          Text('Shutter Speed')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 12 })

          Row() {
            // Previous
            Button(this.selectedSpeedIndex > 0 ? this.shutterSpeeds[this.selectedSpeedIndex - 1] : '-')
              .type(ButtonType.Normal)
              .backgroundColor('#FFFFFF')
              .fontColor('#CCCCCC')
              .fontSize(16)
              .fontWeight(FontWeight.Normal)
              .borderRadius(12)
              .width(100)
              .height(50)
              .margin({ right: 8 })
              .onClick(() => {
                if (this.selectedSpeedIndex > 0) this.selectedSpeedIndex--
              })

            // Current
            Button(this.shutterSpeeds[this.selectedSpeedIndex])
              .type(ButtonType.Normal)
              .backgroundColor('#F0F0F0')
              .fontColor('#000000')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .borderRadius(12)
              .width(100)
              .height(50)
              .margin({ right: 8 })

            // Next
            Button(this.selectedSpeedIndex < this.shutterSpeeds.length - 1 ? this.shutterSpeeds[this.selectedSpeedIndex + 1] : '-')
              .type(ButtonType.Normal)
              .backgroundColor('#FFFFFF')
              .fontColor('#CCCCCC')
              .fontSize(16)
              .fontWeight(FontWeight.Normal)
              .borderRadius(12)
              .width(100)
              .height(50)
              .onClick(() => {
                if (this.selectedSpeedIndex < this.shutterSpeeds.length - 1) this.selectedSpeedIndex++
              })
          }
        }
      }
      .layoutWeight(1)

      // Bottom Action
      Button() {
        Row() {
          Stack() {
            Circle({ width: 24, height: 24 }).fill('#FFFFFF')
            Image($r('app.media.startIcon'))
              .width(16)
              .height(16)
              .objectFit(ImageFit.Contain)
          }
          .margin({ right: 12 })
          
          Text('LOG EXPOSURE')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1)
            .fontColor('#FFFFFF')
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .backgroundColor('#000000')
      .borderRadius(12)
      .margin({ top: 16 })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
  }

  @Builder
  SettingItemSmall(label: string, value: string) {
    Column() {
      Text(value)
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#000000')
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#999999')
    }
  }
}