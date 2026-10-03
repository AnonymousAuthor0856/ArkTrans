@Entry
@Component
struct Index {
  @State selectedIso: string = '400'
  @State apertureValue: number = 2.8
  @State selectedSpeedIndex: number = 4
  private shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8']

  build() {
    Column() {
      HeaderSection()

      CurrentSettingsDisplay({
        iso: this.selectedIso,
        aperture: this.apertureValue.toFixed(1),
        shutter: this.shutterSpeeds[this.selectedSpeedIndex]
      })

      Column() {
        IsoSelector({ currentIso: this.selectedIso, onSelect: (iso: string) => { this.selectedIso = iso } })
        ApertureControl({ value: this.apertureValue, onValueChange: (value: number) => { this.apertureValue = value } })
        ShutterSpeedControl({ selectedIndex: this.selectedSpeedIndex, onSelect: (index: number) => { this.selectedSpeedIndex = index } })
      }
      .space(32)

      LogShotButton()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct HeaderSection {
  build() {
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
        Button({ type: ButtonType.Circle }) {
          Text('≡').fontSize(24).fontColor('#000000')
        }
        .width(48).height(48)
        .backgroundColor('#00000000')

        Button({ type: ButtonType.Circle }) {
          Text('⚙').fontSize(24).fontColor('#000000')
        }
        .width(48).height(48)
        .backgroundColor('#00000000')
      }
    }
    .width('100%')
    .padding({ bottom: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct CurrentSettingsDisplay {
  @Prop iso: string = ''
  @Prop aperture: string = ''
  @Prop shutter: string = ''

  build() {
    Row() {
      Column() {
        Text('f/' + this.aperture)
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
      .padding({ left: 24 })
      .justifyContent(FlexAlign.Center)

      Divider().vertical(true).width(1).height(80).color('#CCCCCC')

      Column() {
        SettingItemSmall({ label: 'ISO', value: this.iso })
        Blank().height(16)
        SettingItemSmall({ label: 'SHUTTER', value: this.shutter })
      }
      .layoutWeight(1)
      .padding({ left: 24 })
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(160)
    .backgroundColor('#F8F8F8')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct SettingItemSmall {
  @Prop label: string = ''
  @Prop value: string = ''

  build() {
    Column() {
      Text(this.value)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#888888')
    }
  }
}

@Component
struct IsoSelector {
  @Prop currentIso: string = '400'
  onSelect: (iso: string) => void = () => {}
  private isoValues: string[] = ['100', '200', '400', '800', '1600', '3200']

  build() {
    Column() {
      Text('Film Stock ISO')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ bottom: 12 })

      Scroll() {
        Row() {
          ForEach(this.isoValues, (iso: string) => {
            Stack() {
              Text(iso)
                .fontSize(13)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.currentIso == iso ? '#FFFFFF' : '#000000')
            }
            .width(60).height(36)
            .backgroundColor(this.currentIso == iso ? '#000000' : '#00000000')
            .borderRadius(25)
            .border({ width: 1, color: this.currentIso == iso ? '#000000' : '#E0E0E0' })
            .alignContent(Alignment.Center)
            .onClick(() => { this.onSelect(iso) })
          }, (iso: string) => iso)
        }
        .space(12)
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
  }
}

@Component
struct ApertureControl {
  @Prop value: number = 2.8
  onValueChange: (value: number) => void = () => {}

  build() {
    Column() {
      Row() {
        Text('Aperture Control')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
        Text('⚙').fontSize(16).fontColor('#888888')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Blank().height(8)

      Slider({ value: this.value, min: 1.4, max: 16, style: SliderStyle.OutSet })
        .blockColor('#000000')
        .selectedColor('#000000')
        .trackColor('#E0E0E0')
        .onChange((value: number) => { this.onValueChange(value) })

      Row() {
        Text('f/1.4').fontSize(12).fontColor('#888888')
        Text('f/16').fontSize(12).fontColor('#888888')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }
}

@Component
struct ShutterSpeedControl {
  @Prop selectedIndex: number = 4
  onSelect: (index: number) => void = () => {}
  private speeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8']

  build() {
    Column() {
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ bottom: 12 })

      Row() {
        SpeedOption({
          text: this.selectedIndex > 0 ? this.speeds[this.selectedIndex - 1] : '-',
          isSelected: false,
          onClick: () => { if (this.selectedIndex > 0) { this.onSelect(this.selectedIndex - 1) } }
        })
        SpeedOption({ text: this.speeds[this.selectedIndex], isSelected: true, onClick: () => {} })
        SpeedOption({
          text: this.selectedIndex < this.speeds.length - 1 ? this.speeds[this.selectedIndex + 1] : '-',
          isSelected: false,
          onClick: () => { if (this.selectedIndex < this.speeds.length - 1) { this.onSelect(this.selectedIndex + 1) } }
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }
}

@Component
struct SpeedOption {
  @Prop text: string = ''
  @Prop isSelected: boolean = false
  onClick: () => void = () => {}

  build() {
    Stack() {
      Text(this.text)
        .fontSize(this.isSelected ? 22 : 16)
        .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(this.isSelected ? '#000000' : '#CCCCCC')
    }
    .width(100).height(50)
    .backgroundColor(this.isSelected ? '#F0F0F0' : '#00000000')
    .borderRadius(12)
    .alignContent(Alignment.Center)
    .onClick(() => { this.onClick() })
  }
}

@Component
struct LogShotButton {
  build() {
    Button({ type: ButtonType.Normal }) {
      Row() {
        Stack() {
          Text('+').fontSize(16).fontColor('#000000')
        }
        .width(24).height(24)
        .borderRadius(12)
        .backgroundColor('#FFFFFF')
        .alignContent(Alignment.Center)

        Blank().width(12)

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
  }
}
