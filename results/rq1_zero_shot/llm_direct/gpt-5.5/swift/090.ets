@Entry
@Component
struct LumenAppScreen {
  @State private selectedIso: string = '400'
  @State private apertureValue: number = 2.8
  @State private selectedSpeedIndex: number = 4

  private shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8']

  build() {
    Column() {
      HeaderSection()
        .margin({ bottom: 16 })

      CurrentSettingsDisplay({
        iso: this.selectedIso,
        aperture: this.apertureValue.toFixed(1),
        shutter: this.shutterSpeeds[this.selectedSpeedIndex]
      })

      Blank()
        .layoutWeight(1)

      Column({ space: 32 }) {
        IsoSelector({
          currentIso: this.selectedIso,
          onIsoSelected: (iso: string) => {
            this.selectedIso = iso
          }
        })

        ApertureControl({
          value: $apertureValue
        })

        ShutterSpeedControl({
          speeds: this.shutterSpeeds,
          selectedIndex: this.selectedSpeedIndex,
          onSelect: (index: number) => {
            this.selectedSpeedIndex = index
          }
        })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Stretch)

      Blank()
        .layoutWeight(1)

      LogShotButton()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Stretch)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
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
          .fontColor(Color.Gray)

        Text('Roll #034')
          .fontSize(24)
          .fontWeight(FontWeight.Bolder)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Text('☰')
            .fontSize(24)
            .fontColor(Color.Black)
        }
        .width(44)
        .height(44)
        .onClick(() => {
        })

        Stack({ alignContent: Alignment.Center }) {
          Text('⚙')
            .fontSize(22)
            .fontColor(Color.Black)
        }
        .width(44)
        .height(44)
        .onClick(() => {
        })
      }
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct CurrentSettingsDisplay {
  iso: string = ''
  aperture: string = ''
  shutter: string = ''

  build() {
    Row() {
      Column() {
        Text('f/' + this.aperture)
          .fontSize(56)
          .fontWeight(FontWeight.Lighter)
          .letterSpacing(-2)
          .fontColor(Color.Black)

        Text('APERTURE')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
      }
      .height('100%')
      .padding({ left: 24 })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(3)

      Divider()
        .vertical(true)
        .strokeWidth(1)
        .color(0xFFE0E0E0)
        .height(80)

      Column() {
        SettingItemSmall({
          label: 'ISO',
          value: this.iso
        })

        Blank()
          .height(16)

        SettingItemSmall({
          label: 'SHUTTER',
          value: this.shutter
        })
      }
      .height('100%')
      .padding({ left: 24 })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(2)
    }
    .width('100%')
    .height(160)
    .backgroundColor(0xFFF8F8F8)
    .border({
      width: 1,
      color: 0xFFEEEEEE,
      radius: 16
    })
    .borderRadius(16)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct SettingItemSmall {
  label: string = ''
  value: string = ''

  build() {
    Column() {
      Text(this.value)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)

      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct IsoSelector {
  currentIso: string = ''
  onIsoSelected: (iso: string) => void = () => {
  }

  private isoValues: string[] = ['100', '200', '400', '800', '1600', '3200']

  build() {
    Column() {
      Text('Film Stock ISO')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ bottom: 12 })

      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.isoValues, (iso: string) => {
            Stack({ alignContent: Alignment.Center }) {
              Text(iso)
                .fontSize(13)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.currentIso === iso ? Color.White : Color.Black)
            }
            .width(60)
            .height(36)
            .backgroundColor(this.currentIso === iso ? Color.Black : Color.Transparent)
            .border({
              width: 1,
              color: this.currentIso === iso ? Color.Black : 0xFFE0E0E0,
              radius: 50
            })
            .borderRadius(50)
            .onClick(() => {
              this.onIsoSelected(iso)
            })
          }, (iso: string) => iso)
        }
      }
      .width('100%')
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ApertureControl {
  @Link value: number

  private sliderStep: number = (16.0 - 1.4) / 20.0

  build() {
    Column() {
      Row() {
        Text('Aperture Control')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)

        Blank()
          .layoutWeight(1)

        Text('⚙')
          .fontSize(16)
          .fontColor(Color.Gray)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Blank()
        .height(8)

      Slider({
        value: this.value,
        min: 1.4,
        max: 16.0,
        step: this.sliderStep,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .height(28)
        .trackColor(0xFFE0E0E0)
        .selectedColor(Color.Black)
        .blockColor(Color.Black)
        .showTips(false)
        .onChange((value: number) => {
          this.value = value
        })

      Row() {
        Text('f/1.4')
          .fontSize(12)
          .fontColor(Color.Gray)

        Blank()
          .layoutWeight(1)

        Text('f/16')
          .fontSize(12)
          .fontColor(Color.Gray)
      }
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ShutterSpeedControl {
  speeds: string[] = []
  selectedIndex: number = 0
  onSelect: (index: number) => void = () => {
  }

  private prevSpeed(): string {
    return this.selectedIndex > 0 ? this.speeds[this.selectedIndex - 1] : '-'
  }

  private currSpeed(): string {
    return this.speeds[this.selectedIndex]
  }

  private nextSpeed(): string {
    return this.selectedIndex < this.speeds.length - 1 ? this.speeds[this.selectedIndex + 1] : '-'
  }

  build() {
    Column() {
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ bottom: 12 })

      Row({ space: 12 }) {
        SpeedOption({
          text: this.prevSpeed(),
          isSelected: false,
          onClick: () => {
            if (this.selectedIndex > 0) {
              this.onSelect(this.selectedIndex - 1)
            }
          }
        })

        SpeedOption({
          text: this.currSpeed(),
          isSelected: true,
          onClick: () => {
          }
        })

        SpeedOption({
          text: this.nextSpeed(),
          isSelected: false,
          onClick: () => {
            if (this.selectedIndex < this.speeds.length - 1) {
              this.onSelect(this.selectedIndex + 1)
            }
          }
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SpeedOption {
  text: string = ''
  isSelected: boolean = false
  onClick: () => void = () => {
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text(this.text)
        .fontSize(this.isSelected ? 22 : 16)
        .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Regular)
        .fontColor(this.isSelected ? Color.Black : 0xFFE0E0E0)
    }
    .width(100)
    .height(50)
    .backgroundColor(this.isSelected ? 0xFFF0F0F0 : Color.Transparent)
    .borderRadius(12)
    .onClick(() => {
      if (!this.isSelected && this.text !== '-') {
        this.onClick()
      }
    })
  }
}

@Component
struct LogShotButton {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Row({ space: 12 }) {
        Stack({ alignContent: Alignment.Center }) {
          Text('+')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
        .width(24)
        .height(24)
        .backgroundColor(Color.White)
        .borderRadius(12)

        Text('LOG EXPOSURE')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(1)
          .fontColor(Color.White)
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(56)
    .backgroundColor(Color.Black)
    .borderRadius(12)
    .onClick(() => {
    })
  }
}