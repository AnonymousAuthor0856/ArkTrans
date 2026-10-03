@Entry
@Component
struct MainActivity {
  @State selectedIso: string = '400';
  @State apertureValue: number = 2.8;
  @State selectedSpeedIndex: number = 4;

  private isoValues: string[] = ['100', '200', '400', '800', '1600', '3200'];
  private shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8'];

  private formatAperture(): string {
    return this.apertureValue.toFixed(1);
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('LUMEN LOG')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')
        Text('Roll #034')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      Row() {
        Text('≡').fontSize(24).fontColor('#000000').width(44).textAlign(TextAlign.Center)
        Text('⚙').fontSize(24).fontColor('#000000').width(44).textAlign(TextAlign.Center)
      }
    }
    .width('100%')
    .padding({ bottom: 16 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SettingItem(label: string, value: string) {
    Column() {
      Text(value)
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#000000')
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#808080')
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  CurrentSettingsDisplay() {
    Row() {
      Column() {
        Text(`f/${this.formatAperture()}`)
          .fontSize(56)
          .fontWeight(FontWeight.Light)
          .fontColor('#000000')
        Text('APERTURE')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')
      }
      .layoutWeight(1.5)
      .padding({ left: 24 })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Start)

      Divider().vertical(true).height(80).color('#D3D3D3')

      Column() {
        this.SettingItem('ISO', this.selectedIso)
        Blank().height(16)
        this.SettingItem('SHUTTER', this.shutterSpeeds[this.selectedSpeedIndex])
      }
      .layoutWeight(1)
      .padding({ left: 24 })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(160)
    .backgroundColor('#F8F8F8')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  IsoSelector() {
    Column() {
      Text('Film Stock ISO')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .width('100%')
        .margin({ bottom: 12 })
      Row({ space: 12 }) {
        ForEach(this.isoValues, (iso: string) => {
          Text(iso)
            .fontSize(13)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(this.selectedIso === iso ? '#FFFFFF' : '#000000')
            .textAlign(TextAlign.Center)
            .width(60)
            .height(36)
            .lineHeight(36)
            .backgroundColor(this.selectedIso === iso ? '#000000' : Color.Transparent)
            .border({ width: 1, color: this.selectedIso === iso ? '#000000' : '#E0E0E0' })
            .borderRadius(18)
            .onClick(() => {
              this.selectedIso = iso;
            })
        })
      }
      .width('100%')
    }
    .width('100%')
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
          .fontColor('#808080')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      Slider({ value: this.apertureValue, min: 1.4, max: 16, step: 0.1 })
        .onChange((value: number) => { this.apertureValue = value; })
        .width('100%')
        .margin({ top: 8 })
      Row() {
        Text('f/1.4').fontSize(12).fontColor('#808080')
        Text('f/16').fontSize(12).fontColor('#808080')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
  }

  @Builder
  SpeedOption(text: string, selected: boolean, offset: number) {
    Text(text)
      .fontSize(selected ? 22 : 16)
      .fontWeight(selected ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(selected ? '#000000' : '#D3D3D3')
      .textAlign(TextAlign.Center)
      .width(100)
      .height(50)
      .lineHeight(50)
      .backgroundColor(selected ? '#F0F0F0' : Color.Transparent)
      .borderRadius(12)
      .onClick(() => {
        if (!selected && text !== '-') {
          const nextIndex = this.selectedSpeedIndex + offset;
          if (nextIndex >= 0 && nextIndex < this.shutterSpeeds.length) {
            this.selectedSpeedIndex = nextIndex;
          }
        }
      })
  }

  @Builder
  ShutterSpeedControl() {
    Column() {
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .width('100%')
        .margin({ bottom: 12 })
      Row() {
        this.SpeedOption(this.shutterSpeeds[this.selectedSpeedIndex - 1] || '-', false, -1)
        this.SpeedOption(this.shutterSpeeds[this.selectedSpeedIndex], true, 0)
        this.SpeedOption(this.shutterSpeeds[this.selectedSpeedIndex + 1] || '-', false, 1)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
  }

  @Builder
  LogShotButton() {
    Button('+  LOG EXPOSURE')
      .fontSize(16)
      .fontWeight(FontWeight.Bold)
      .fontColor('#FFFFFF')
      .width('100%')
      .height(56)
      .backgroundColor('#000000')
      .borderRadius(12)
  }

  build() {
    Column() {
      this.HeaderSection()
      this.CurrentSettingsDisplay()
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
}
