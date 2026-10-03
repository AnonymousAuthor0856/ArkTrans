@Entry
@Component
struct LumenAppScreen {
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
        IsoSelector({
          currentIso: this.selectedIso,
          onIsoSelected: (iso: string) => {
            this.selectedIso = iso
          }
        })

        ApertureControl({
          value: this.apertureValue,
          onValueChange: (value: number) => {
            this.apertureValue = value
          }
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
      .gap(32)

      LogShotButton()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.SpaceBetween)
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

      Row() {
        Button() {
          Text('☰')
            .fontSize(24)
            .fontColor(Color.Black)
        }
        .width(48)
        .height(48)
        .backgroundColor(Color.Transparent)

        Button() {
          Text('⚙')
            .fontSize(22)
            .fontColor(Color.Black)
        }
        .width(48)
        .height(48)
        .backgroundColor(Color.Transparent)
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
  iso: string = ''
  aperture: string = ''
  shutter: string = ''

  build() {
    Row() {
      Column() {
        Text(`f/${this.aperture}`)
          .fontSize(56)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
          .letterSpacing(-2)

        Text('APERTURE')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
      }
      .layoutWeight(1.5)
      .padding({ left: 24 })
      .justifyContent(FlexAlign.Center)

      Divider()
        .vertical(true)
        .height(80)
        .strokeWidth(1)
        .color('#D3D3D3')

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
      .layoutWeight(1)
      .padding({ left: 24 })
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(160)
    .backgroundColor('#F8F8F8')
    .borderRadius(16)
    .border({
      width: 1,
      color: '#EEEEEE',
      radius: 16
    })
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
  }
}

@Component
struct IsoSelector {
  currentIso: string = ''
  onIsoSelected: (iso: string) => void = () => {}

  private isoValues: string[] = ['100', '200', '400', '800', '1600', '3200']

  build() {
    Column() {
      Text('Film Stock ISO')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .padding({ bottom: 12 })

      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.isoValues, (iso: string) => {
            IsoChip({
              iso: iso,
              isSelected: this.currentIso === iso,
              onClick: () => {
                this.onIsoSelected(iso)
              }
            })
          }, (iso: string) => iso)
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .width('100%')
  }
}

@Component
struct IsoChip {
  iso: string = ''
  isSelected: boolean = false
  onClick: () => void = () => {}

  build() {
    Stack() {
      Text(this.iso)
        .fontSize(13)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? Color.White : Color.Black)
    }
    .width(60)
    .height(36)
    .borderRadius(50)
    .backgroundColor(this.isSelected ? Color.Black : Color.Transparent)
    .border({
      width: 1,
      color: this.isSelected ? Color.Black : '#E0E0E0',
      radius: 50
    })
    .onClick(() => {
      this.onClick()
    })
  }
}

@Component
struct ApertureControl {
  value: number = 2.8
  onValueChange: (value: number) => void = () => {}

  build() {
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
      .alignItems(VerticalAlign.Center)

      Blank()
        .height(8)

      Slider({
        value: this.value,
        min: 1.4,
        max: 16,
        step: (16 - 1.4) / 21,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .blockColor(Color.Black)
        .selectedColor(Color.Black)
        .trackColor('#E0E0E0')
        .onChange((value: number) => {
          this.onValueChange(value)
        })

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
  }
}

@Component
struct ShutterSpeedControl {
  speeds: string[] = []
  selectedIndex: number = 0
  onSelect: (index: number) => void = () => {}

  build() {
    Column() {
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .padding({ bottom: 12 })

      Row() {
        SpeedOption({
          text: this.selectedIndex > 0 ? this.speeds[this.selectedIndex - 1] : '-',
          isSelected: false,
          onClick: () => {
            if (this.selectedIndex > 0) {
              this.onSelect(this.selectedIndex - 1)
            }
          }
        })

        SpeedOption({
          text: this.speeds[this.selectedIndex],
          isSelected: true,
          onClick: () => {}
        })

        SpeedOption({
          text: this.selectedIndex < this.speeds.length - 1 ? this.speeds[this.selectedIndex + 1] : '-',
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
  }
}

@Component
struct SpeedOption {
  text: string = ''
  isSelected: boolean = false
  onClick: () => void = () => {}

  build() {
    Stack() {
      Text(this.text)
        .fontSize(this.isSelected ? 22 : 16)
        .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(this.isSelected ? Color.Black : '#D3D3D3')
    }
    .width(100)
    .height(50)
    .borderRadius(12)
    .backgroundColor(this.isSelected ? '#F0F0F0' : Color.Transparent)
    .enabled(!this.isSelected && this.text !== '-')
    .onClick(() => {
      this.onClick()
    })
  }
}

@Component
struct LogShotButton {
  build() {
    Button() {
      Row() {
        Stack() {
          Text('+')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .margin({ bottom: 2 })
        }
        .width(24)
        .height(24)
        .backgroundColor(Color.White)
        .borderRadius(12)

        Blank()
          .width(12)

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
  }
}