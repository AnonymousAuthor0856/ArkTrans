@Entry
@Component
struct Index {
  @State selectedIso: string = '400'
  @State apertureValue: number = 2.8
  @State selectedSpeedIndex: number = 4

  private readonly shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8']
  private readonly isoValues: string[] = ['100', '200', '400', '800', '1600', '3200']

  private apertureText(): string {
    return this.apertureValue.toFixed(1)
  }

  build() {
    Column() {
      this.HeaderSection()
      this.CurrentSettingsDisplay()
      Blank()
      Column() {
        this.IsoSelector()
        Blank().height(32)
        this.ApertureControl()
        Blank().height(32)
        this.ShutterSpeedControl()
      }
      .width('100%')
      Blank()
      this.LogShotButton()
    }
    .width('100%')
    .height('100%')
    .padding(24)
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
          .letterSpacing(2)
        Text('Roll #034')
          .fontSize(24)
          .fontWeight(FontWeight.Bolder)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      Row() {
        Button() {
          Text('☰')
            .fontSize(22)
            .fontColor(Color.Black)
        }
        .width(44)
        .height(44)
        .backgroundColor(Color.Transparent)
        Button() {
          Text('⚙')
            .fontSize(22)
            .fontColor(Color.Black)
        }
        .width(44)
        .height(44)
        .backgroundColor(Color.Transparent)
      }
    }
    .width('100%')
    .margin({ bottom: 16 })
  }

  @Builder
  CurrentSettingsDisplay() {
    Row() {
      Column() {
        Text('f/' + this.apertureText())
          .fontSize(56)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
          .letterSpacing(-2)
        Text('APERTURE')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(3)
      .padding({ left: 24 })
      Rect()
        .width(1)
        .height(80)
        .fill('#E0E0E0')
      Column() {
        this.SettingItemSmall('ISO', this.selectedIso)
        Blank().height(16)
        this.SettingItemSmall('SHUTTER', this.shutterSpeeds[this.selectedSpeedIndex])
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(2)
      .padding({ left: 24 })
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
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  IsoSelector() {
    Column() {
      Text('Film Stock ISO')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 12 })
      Scroll() {
        Row() {
          ForEach(this.isoValues, (iso: string) => {
            Text(iso)
              .fontSize(13)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.selectedIso === iso ? Color.White : Color.Black)
              .textAlign(TextAlign.Center)
              .width(60)
              .height(36)
              .backgroundColor(this.selectedIso === iso ? Color.Black : Color.Transparent)
              .borderRadius(50)
              .border({ width: 1, color: this.selectedIso === iso ? Color.Black : '#E0E0E0' })
              .margin({ right: 12 })
              .onClick(() => {
                this.selectedIso = iso
              })
          }, (iso: string) => iso)
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  ApertureControl() {
    Column() {
      Row() {
        Text('Aperture Control')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
        Blank()
        Text('⚙')
          .fontSize(16)
          .fontColor(Color.Gray)
      }
      .width('100%')
      Blank().height(8)
      Slider({ value: this.apertureValue, min: 1.4, max: 16.0, step: 0.73 })
        .blockColor(Color.Black)
        .selectedColor(Color.Black)
        .trackColor('#E0E0E0')
        .onChange((value: number) => {
          this.apertureValue = value
        })
      Row() {
        Text('f/1.4')
          .fontSize(12)
          .fontColor(Color.Gray)
        Blank()
        Text('f/16')
          .fontSize(12)
          .fontColor(Color.Gray)
      }
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  ShutterSpeedControl() {
    Column() {
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 12 })
      Row() {
        this.SpeedOption(this.selectedSpeedIndex > 0 ? this.shutterSpeeds[this.selectedSpeedIndex - 1] : '-', false, -1)
        this.SpeedOption(this.shutterSpeeds[this.selectedSpeedIndex], true, 0)
        this.SpeedOption(this.selectedSpeedIndex < this.shutterSpeeds.length - 1 ? this.shutterSpeeds[this.selectedSpeedIndex + 1] : '-', false, 1)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  SpeedOption(text: string, isSelected: boolean, delta: number) {
    Text(text)
      .fontSize(isSelected ? 22 : 16)
      .fontWeight(isSelected ? FontWeight.Bold : FontWeight.Regular)
      .fontColor(isSelected ? Color.Black : '#E0E0E0')
      .textAlign(TextAlign.Center)
      .width(100)
      .height(50)
      .backgroundColor(isSelected ? '#F0F0F0' : Color.Transparent)
      .borderRadius(12)
      .onClick(() => {
        if (!isSelected && text !== '-') {
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
        }
        .width(24)
        .height(24)
        Text('LOG EXPOSURE')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .letterSpacing(1)
          .margin({ left: 12 })
      }
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(56)
    .borderRadius(12)
    .backgroundColor(Color.Black)
  }
}