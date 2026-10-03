@Entry
@Component
struct LumenApp {
  @State selectedIso: string = '400';
  @State apertureValue: number = 2.8;
  @State selectedSpeedIndex: number = 4;

  private isoValues: string[] = ['100', '200', '400', '800', '1600', '3200'];
  private shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8'];

  build() {
    Column() {
      this.HeaderSection()
      this.CurrentSettingsDisplay(this.selectedIso, this.apertureValue.toFixed(1), this.shutterSpeeds[this.selectedSpeedIndex])
      Column({ space: 32 }) {
        this.IsoSelector()
        this.ApertureControl()
        this.ShutterSpeedControl()
      }
      this.LogShotButton()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#FFFFFF')
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('LUMEN LOG')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
          .fontColor('#888888')
        Text('Roll #034')
          .fontSize(24)
          .fontWeight(FontWeight.Bolder)
          .fontColor('#000000')
      }

      Row() {
        Text('☰')
          .fontSize(24)
          .fontColor('#000000')
          .padding(8)
          .onClick(() => {})
        Text('⚙')
          .fontSize(24)
          .fontColor('#000000')
          .padding(8)
          .onClick(() => {})
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ bottom: 16 })
  }

  @Builder
  CurrentSettingsDisplay(iso: string, aperture: string, shutter: string) {
    Column() {
      Row() {
        Column() {
          Text('f/' + aperture)
            .fontSize(56)
            .fontWeight(FontWeight.Lighter)
            .fontColor('#000000')
            .letterSpacing(-2)
          Text('APERTURE')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#888888')
        }
        .layoutWeight(1.5)
        .justifyContent(FlexAlign.Center)
        .padding({ left: 24 })

        Divider()
          .vertical(true)
          .width(1)
          .height(80)
          .color('#CCCCCC')

        Column({ space: 16 }) {
          this.SettingItemSmall('ISO', iso)
          this.SettingItemSmall('SHUTTER', shutter)
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .padding({ left: 24 })
      }
      .width('100%')
      .height('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(160)
    .borderRadius(16)
    .backgroundColor('#F8F8F8')
    .border({ width: 1, color: '#EEEEEE' })
  }

  @Builder
  SettingItemSmall(label: string, value: string) {
    Column() {
      Text(value)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#888888')
    }
  }

  @Builder
  IsoSelector() {
    Column() {
      Text('Film Stock ISO')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .padding({ bottom: 12 })

      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.isoValues, (iso: string) => {
            this.IsoChip(iso)
          }, (iso: string) => iso)
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
    }
  }

  @Builder
  IsoChip(iso: string) {
    Stack() {
      Text(iso)
        .fontSize(13)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedIso === iso ? '#FFFFFF' : '#000000')
    }
    .width(60)
    .height(36)
    .borderRadius(18)
    .backgroundColor(this.selectedIso === iso ? '#000000' : '#00000000')
    .border({
      width: 1,
      color: this.selectedIso === iso ? '#000000' : '#E0E0E0',
      radius: 18
    })
    .onClick(() => {
      this.selectedIso = iso
    })
  }

  @Builder
  ApertureControl() {
    Column() {
      Row() {
        Text('Aperture Control')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
        Text('⚙')
          .fontSize(16)
          .fontColor('#888888')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Row().height(8)

      Slider({ value: this.apertureValue, min: 1.4, max: 16, step: 0.1 })
        .blockColor('#000000')
        .selectedColor('#000000')
        .trackColor('#E0E0E0')
        .width('100%')
        .onChange((value: number) => {
          this.apertureValue = value
        })

      Row() {
        Text('f/1.4').fontSize(12).fontColor('#888888')
        Text('f/16').fontSize(12).fontColor('#888888')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }

  @Builder
  ShutterSpeedControl() {
    Column() {
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .padding({ bottom: 12 })

      Row() {
        this.SpeedOption(
          this.selectedSpeedIndex > 0 ? this.shutterSpeeds[this.selectedSpeedIndex - 1] : '-',
          false,
          () => {
            if (this.selectedSpeedIndex > 0) {
              this.selectedSpeedIndex -= 1
            }
          }
        )
        this.SpeedOption(this.shutterSpeeds[this.selectedSpeedIndex], true, () => {})
        this.SpeedOption(
          this.selectedSpeedIndex < this.shutterSpeeds.length - 1 ? this.shutterSpeeds[this.selectedSpeedIndex + 1] : '-',
          false,
          () => {
            if (this.selectedSpeedIndex < this.shutterSpeeds.length - 1) {
              this.selectedSpeedIndex += 1
            }
          }
        )
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }

  @Builder
  SpeedOption(text: string, isSelected: boolean, onTap: () => void) {
    Stack() {
      Text(text)
        .fontSize(isSelected ? 22 : 16)
        .fontWeight(isSelected ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(isSelected ? '#000000' : '#CCCCCC')
    }
    .width(100)
    .height(50)
    .borderRadius(12)
    .backgroundColor(isSelected ? '#F0F0F0' : '#00000000')
    .onClick(() => {
      if (!isSelected && text !== '-') {
        onTap()
      }
    })
  }

  @Builder
  LogShotButton() {
    Button({ type: ButtonType.Normal, stateEffect: false }) {
      Row() {
        Stack() {
          Text('+')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor('#FFFFFF')

        Row().width(12)

        Text('LOG EXPOSURE')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(1)
          .fontColor('#FFFFFF')
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(56)
    .backgroundColor('#000000')
    .borderRadius(12)
    .onClick(() => {})
  }
}
