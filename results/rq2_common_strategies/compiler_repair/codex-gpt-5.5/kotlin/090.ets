class OptionItem {
  value: string

  constructor(value: string) {
    this.value = value
  }
}

@Entry
@Component
struct Index {
  @State selectedIso: string = '400'
  @State apertureValue: number = 2.8
  @State selectedSpeedIndex: number = 4

  private isoValues: OptionItem[] = [
    new OptionItem('100'),
    new OptionItem('200'),
    new OptionItem('400'),
    new OptionItem('800'),
    new OptionItem('1600'),
    new OptionItem('3200')
  ]

  private shutterSpeeds: OptionItem[] = [
    new OptionItem('1/1000'),
    new OptionItem('1/500'),
    new OptionItem('1/250'),
    new OptionItem('1/125'),
    new OptionItem('1/60'),
    new OptionItem('1/30'),
    new OptionItem('1/15'),
    new OptionItem('1/8')
  ]

  build() {
    Column() {
      this.HeaderSection()
      this.CurrentSettingsDisplay()
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
          .fontColor(Color.Gray)
        Text('Roll #034')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Row() {
        Button('☰')
          .fontSize(22)
          .fontColor(Color.Black)
          .backgroundColor(Color.Transparent)
          .width(40)
          .height(40)
          .padding(0)
        Button('⚙')
          .fontSize(22)
          .fontColor(Color.Black)
          .backgroundColor(Color.Transparent)
          .width(40)
          .height(40)
          .padding(0)
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ bottom: 16 })
  }

  @Builder
  CurrentSettingsDisplay() {
    Row() {
      Column() {
        Text('f/' + this.formatAperture())
          .fontSize(56)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
        Text('APERTURE')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
      }
      .layoutWeight(1.5)
      .padding({ left: 24 })
      .alignItems(HorizontalAlign.Start)

      Divider()
        .vertical(true)
        .height(80)
        .color('#D3D3D3')

      Column() {
        this.SettingItemSmall('ISO', this.selectedIso)
        Column().height(16)
        this.SettingItemSmall('SHUTTER', this.shutterSpeeds[this.selectedSpeedIndex].value)
      }
      .layoutWeight(1)
      .padding({ left: 24 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(160)
    .border({ width: 1, color: '#EEEEEE', radius: 16 })
    .backgroundColor('#F8F8F8')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SettingItemSmall(label: string, value: string) {
    Column() {
      Text(value)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)
        .margin({ top: 2 })
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  IsoSelector() {
    Column() {
      Text('Film Stock ISO')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ bottom: 12 })
      Scroll() {
        Row() {
          ForEach(this.isoValues, (iso: OptionItem) => {
            Text(iso.value)
              .fontSize(13)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.selectedIso === iso.value ? Color.White : Color.Black)
              .width(60)
              .height(36)
              .textAlign(TextAlign.Center)
              .border({ width: 1, color: this.selectedIso === iso.value ? Color.Black : '#E0E0E0', radius: 50 })
              .backgroundColor(this.selectedIso === iso.value ? Color.Black : Color.Transparent)
              .margin({ right: 12 })
              .onClick(() => {
                this.selectedIso = iso.value
              })
          })
        }
      }
      .width('100%')
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
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
          .fontColor(Color.Black)
        Text('⚙')
          .fontSize(16)
          .fontColor(Color.Gray)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Slider({ value: this.apertureValue, min: 1.4, max: 16, step: 0.1 })
        .selectedColor(Color.Black)
        .trackColor('#E0E0E0')
        .onChange((value: number) => {
          this.apertureValue = value
        })
        .margin({ top: 8 })

      Row() {
        Text('f/1.4')
          .fontSize(12)
          .fontColor(Color.Gray)
        Text('f/16')
          .fontSize(12)
          .fontColor(Color.Gray)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .margin({ top: 32 })
  }

  @Builder
  ShutterSpeedControl() {
    Column() {
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ bottom: 12 })
      Row() {
        this.SpeedOption(this.previousSpeed(), false, -1)
        this.SpeedOption(this.shutterSpeeds[this.selectedSpeedIndex].value, true, 0)
        this.SpeedOption(this.nextSpeed(), false, 1)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .margin({ top: 32 })
  }

  @Builder
  SpeedOption(text: string, selected: boolean, delta: number) {
    Text(text)
      .fontSize(selected ? 22 : 16)
      .fontWeight(selected ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(selected ? Color.Black : '#D3D3D3')
      .width(100)
      .height(50)
      .textAlign(TextAlign.Center)
      .borderRadius(12)
      .backgroundColor(selected ? '#F0F0F0' : Color.Transparent)
      .onClick(() => {
        if (!selected && text !== '-') {
          this.selectedSpeedIndex += delta
        }
      })
  }

  @Builder
  LogShotButton() {
    Button() {
      Row() {
        Stack() {
          Circle()
            .width(24)
            .height(24)
            .fill(Color.White)
          Text('+')
            .fontSize(16)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
        }
        Text('LOG EXPOSURE')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ left: 12 })
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(56)
    .borderRadius(12)
    .backgroundColor(Color.Black)
  }

  formatAperture(): string {
    return (Math.round(this.apertureValue * 10) / 10).toFixed(1)
  }

  previousSpeed(): string {
    if (this.selectedSpeedIndex <= 0) {
      return '-'
    }
    return this.shutterSpeeds[this.selectedSpeedIndex - 1].value
  }

  nextSpeed(): string {
    if (this.selectedSpeedIndex >= this.shutterSpeeds.length - 1) {
      return '-'
    }
    return this.shutterSpeeds[this.selectedSpeedIndex + 1].value
  }
}
