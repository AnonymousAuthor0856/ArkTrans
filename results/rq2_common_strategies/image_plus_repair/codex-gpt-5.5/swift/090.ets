@Entry
@Component
struct LumenAppScreen {
  @State selectedIso: string = '400'
  @State apertureValue: number = 2.8
  @State selectedSpeedIndex: number = 4

  shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8']

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

        ApertureControl({ value: $apertureValue })

        ShutterSpeedControl({
          speeds: this.shutterSpeeds,
          selectedIndex: this.selectedSpeedIndex,
          onSelect: (index: number) => {
            this.selectedSpeedIndex = index
          }
        })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)

      Blank()
        .layoutWeight(1)

      LogShotButton()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
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
          .fontColor('#8E8E95')
          .letterSpacing(2)

        Text('Roll #034')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Row() {
        MenuIcon()
        GearTextIcon({ color: '#000000', iconSize: 29 })
      }
      .height(44)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(58)
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct MenuIcon {
  build() {
    Column({ space: 5 }) {
      Blank()
        .width(22)
        .height(2)
        .borderRadius(1)
        .backgroundColor(Color.Black)
      Blank()
        .width(22)
        .height(2)
        .borderRadius(1)
        .backgroundColor(Color.Black)
      Blank()
        .width(22)
        .height(2)
        .borderRadius(1)
        .backgroundColor(Color.Black)
    }
    .width(44)
    .height(44)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct GearTextIcon {
  color: ResourceColor = '#000000'
  iconSize: number = 22

  build() {
    Text('⚙')
      .width(44)
      .height(44)
      .fontSize(this.iconSize)
      .fontWeight(FontWeight.Bold)
      .fontColor(this.color)
      .textAlign(TextAlign.Center)
      .lineHeight(44)
  }
}

@Component
struct CurrentSettingsDisplay {
  iso: string = '400'
  aperture: string = '2.8'
  shutter: string = '1/60'

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row() {
        Column() {
          Text('f/' + this.aperture)
            .fontSize(56)
            .fontWeight(FontWeight.Lighter)
            .fontColor(Color.Black)
            .lineHeight(68)

          Text('APERTURE')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#8E8E95')
            .margin({ top: 2 })
        }
        .width(280)
        .padding({ left: 24 })
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)

        Blank()
          .width(1)
          .height(80)
          .backgroundColor('#E0E0E0')

        Column() {
          SettingItemSmall({ label: 'ISO', value: this.iso })
          SettingItemSmall({ label: 'SHUTTER', value: this.shutter })
            .margin({ top: 16 })
        }
        .padding({ left: 24 })
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)
      }
      .height('100%')
      .width(430)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(160)
    .backgroundColor('#F8F8F8')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
    .clip(true)
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
        .fontColor('#8E8E95')
        .margin({ top: 1 })
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct IsoSelector {
  currentIso: string = '400'
  onIsoSelected: (iso: string) => void = () => {}
  isoValues: string[] = ['100', '200', '400', '800', '1600', '3200']

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
            Text(iso)
              .width(60)
              .height(36)
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.currentIso === iso ? Color.White : Color.Black)
              .textAlign(TextAlign.Center)
              .lineHeight(36)
              .backgroundColor(this.currentIso === iso ? Color.Black : Color.Transparent)
              .borderRadius(50)
              .border({
                width: 1,
                color: this.currentIso === iso ? Color.Black : '#E0E0E0'
              })
              .onClick(() => {
                this.onIsoSelected(iso)
              })
          }, (iso: string) => iso)
        }
      }
      .width('100%')
      .height(40)
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.None)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ApertureControl {
  @Link value: number

  build() {
    Column() {
      Row() {
        Text('Aperture Control')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
          .layoutWeight(1)

        GearTextIcon({ color: '#8E8E95', iconSize: 19 })
          .width(22)
          .height(22)
      }
      .width('100%')
      .height(22)
      .alignItems(VerticalAlign.Center)

      Slider({
        value: this.value,
        min: 1.4,
        max: 16,
        step: 0.73,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .height(28)
        .margin({ top: 8 })
        .trackThickness(2)
        .selectedColor(Color.Black)
        .trackColor('#E0E0E0')
        .blockColor(Color.Black)
        .blockSize({ width: 28, height: 28 })
        .showTips(false)
        .onChange((value: number) => {
          this.value = value
        })

      Row() {
        Text('f/1.4')
          .fontSize(12)
          .fontColor('#8E8E95')
        Blank()
          .layoutWeight(1)
        Text('f/16')
          .fontSize(12)
          .fontColor('#8E8E95')
      }
      .width('100%')
      .height(18)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ShutterSpeedControl {
  speeds: string[] = []
  selectedIndex: number = 0
  onSelect: (index: number) => void = () => {}

  speedAt(index: number): string {
    if (index >= 0 && index < this.speeds.length) {
      return this.speeds[index]
    }
    return '-'
  }

  build() {
    Column() {
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ bottom: 12 })

      Row() {
        SpeedOption({
          text: this.speedAt(this.selectedIndex - 1),
          isSelected: false,
          tapAction: () => {
            if (this.selectedIndex > 0) {
              this.onSelect(this.selectedIndex - 1)
            }
          }
        })

        SpeedOption({
          text: this.speedAt(this.selectedIndex),
          isSelected: true,
          tapAction: () => {}
        })

        SpeedOption({
          text: this.speedAt(this.selectedIndex + 1),
          isSelected: false,
          tapAction: () => {
            if (this.selectedIndex < this.speeds.length - 1) {
              this.onSelect(this.selectedIndex + 1)
            }
          }
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SpeedOption {
  text: string = ''
  isSelected: boolean = false
  tapAction: () => void = () => {}

  build() {
    Text(this.text)
      .width(100)
      .height(50)
      .fontSize(this.isSelected ? 22 : 16)
      .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Regular)
      .fontColor(this.isSelected ? Color.Black : '#E0E0E0')
      .textAlign(TextAlign.Center)
      .lineHeight(50)
      .backgroundColor(this.isSelected ? '#F0F0F0' : Color.Transparent)
      .borderRadius(12)
      .onClick(() => {
        if (!this.isSelected && this.text !== '-') {
          this.tapAction()
        }
      })
  }
}

@Component
struct LogShotButton {
  build() {
    Row({ space: 12 }) {
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(24)
          .height(24)
          .fill(Color.White)

        Text('+')
          .fontSize(30)
          .fontWeight(FontWeight.Regular)
          .fontColor(Color.Black)
          .textAlign(TextAlign.Center)
          .lineHeight(24)
      }
      .width(24)
      .height(24)

      Text('LOG EXPOSURE')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .letterSpacing(1)
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.Black)
    .borderRadius(12)
    .onClick(() => {})
  }
}
