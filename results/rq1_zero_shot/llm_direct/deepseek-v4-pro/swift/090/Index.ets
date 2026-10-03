@Entry
@Component
struct LumenApp {
  @State selectedIso: string = '400'
  @State apertureValue: number = 2.8
  @State selectedSpeedIndex: number = 4

  private shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8']

  private screenPadding: number = 24
  private verticalSpacingLarge: number = 32
  private verticalSpacingMedium: number = 16
  private horizontalSpacingSmall: number = 12

  build() {
    Column() {
      Column() {
        HeaderSection()

        CurrentSettingsDisplay({
          iso: this.selectedIso,
          aperture: this.apertureValue.toFixed(1),
          shutter: this.shutterSpeeds[this.selectedSpeedIndex]
        })

        Blank()
          .height(32)
          .layoutWeight(1)

        Column({ space: this.verticalSpacingLarge }) {
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

        Blank()
          .height(32)
          .layoutWeight(1)

        LogShotButton()
      }
      .padding(this.screenPadding)
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

@Component
struct HeaderSection {
  private bottomPadding: number = 16
  private letterSpacingHeader: number = 2
  private iconButtonSize: number = 44

  build() {
    Row() {
      Column({ space: 0 }) {
        Text('LUMEN LOG')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')
          .letterSpacing(this.letterSpacingHeader)
        Text('Roll #034')
          .fontSize(24)
          .fontWeight(FontWeight.Bolder)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Row({ space: 0 }) {
        Button() {
        }
        .width(this.iconButtonSize)
        .height(this.iconButtonSize)
        .backgroundColor(Color.Transparent)

        Button() {
        }
        .width(this.iconButtonSize)
        .height(this.iconButtonSize)
        .backgroundColor(Color.Transparent)
      }
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct CurrentSettingsDisplay {
  @Prop iso: string
  @Prop aperture: string
  @Prop shutter: string

  private cardHeight: number = 160
  private cornerRadius: number = 16
  private horizontalPadding: number = 24
  private dividerHeight: number = 80
  private detailSpacing: number = 16

  build() {
    Row({ space: 0 }) {
      Column({ space: 0 }) {
        Text(`f/${this.aperture}`)
          .fontSize(56)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#000000')
          .letterSpacing(-2)
        Text('APERTURE')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')
      }
      .alignItems(HorizontalAlign.Start)
      .padding({ left: this.horizontalPadding })
      .layoutWeight(1.5)
      .justifyContent(FlexAlign.Center)

      Divider()
        .vertical(true)
        .height(this.dividerHeight)
        .width(1)
        .color('#E0E0E0')

      Column({ space: 0 }) {
        SettingItemSmall({ label: 'ISO', value: this.iso })

        Blank()
          .height(this.detailSpacing)

        SettingItemSmall({ label: 'SHUTTER', value: this.shutter })
      }
      .alignItems(HorizontalAlign.Start)
      .padding({ left: this.horizontalPadding })
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(this.cardHeight)
    .backgroundColor('#F8F8F8')
    .borderRadius(this.cornerRadius)
    .border({
      width: 1,
      color: '#EEEEEE',
      radius: this.cornerRadius
    })
  }
}

@Component
struct SettingItemSmall {
  @Prop label: string
  @Prop value: string

  build() {
    Column({ space: 0 }) {
      Text(this.value)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#808080')
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct IsoSelector {
  @Prop currentIso: string
  onIsoSelected: (iso: string) => void = () => {}

  private isoValues: string[] = ['100', '200', '400', '800', '1600', '3200']
  private bottomPadding: number = 12
  private itemWidth: number = 60
  private itemHeight: number = 36
  private cornerRadius: number = 50
  private horizontalSpacing: number = 12

  build() {
    Column({ space: 0 }) {
      Text('Film Stock ISO')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ bottom: this.bottomPadding })

      Scroll() {
        Row({ space: this.horizontalSpacing }) {
          ForEach(this.isoValues, (iso: string) => {
            Text(iso)
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.currentIso === iso ? '#FFFFFF' : '#000000')
              .width(this.itemWidth)
              .height(this.itemHeight)
              .textAlign(TextAlign.Center)
              .backgroundColor(this.currentIso === iso ? '#000000' : Color.Transparent)
              .borderRadius(this.cornerRadius)
              .border({
                width: 1,
                color: this.currentIso === iso ? '#000000' : '#E0E0E0',
                radius: this.cornerRadius
              })
              .onClick(() => {
                this.onIsoSelected(iso)
              })
          })
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct ApertureControl {
  @Prop value: number
  onValueChange: (value: number) => void = () => {}

  private sliderTopSpacing: number = 8
  private iconSize: number = 16
  private sliderStep: number = (16.0 - 1.4) / 20.0
  private trackHeight: number = 2
  private thumbDiameter: number = 28

  build() {
    Column({ space: 0 }) {
      Row() {
        Text('Aperture Control')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
        Blank()
          .layoutWeight(1)
        Text('⚙')
          .fontSize(this.iconSize)
          .fontColor('#808080')
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Blank()
        .height(this.sliderTopSpacing)

      Slider({
        value: this.value,
        min: 1.4,
        max: 16.0,
        step: this.sliderStep,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .height(this.thumbDiameter)
        .trackColor('#E0E0E0')
        .selectedColor('#000000')
        .blockColor('#000000')
        .trackThickness(this.trackHeight)
        .onChange((value: number) => {
          this.onValueChange(value)
        })

      Row() {
        Text('f/1.4')
          .fontSize(12)
          .fontColor('#808080')
        Blank()
          .layoutWeight(1)
        Text('f/16')
          .fontSize(12)
          .fontColor('#808080')
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct ShutterSpeedControl {
  @Prop speeds: string[]
  @Prop selectedIndex: number
  onSelect: (index: number) => void = () => {}

  private bottomPadding: number = 12
  private horizontalSpacing: number = 12

  build() {
    Column({ space: 0 }) {
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ bottom: this.bottomPadding })

      Row({ space: this.horizontalSpacing }) {
        if (this.selectedIndex > 0) {
          SpeedOption({
            text: this.speeds[this.selectedIndex - 1],
            isSelected: false,
            onClick: () => {
              this.onSelect(this.selectedIndex - 1)
            }
          })
        } else {
          SpeedOption({
            text: '-',
            isSelected: false,
            onClick: () => {}
          })
        }

        SpeedOption({
          text: this.speeds[this.selectedIndex],
          isSelected: true,
          onClick: () => {}
        })

        if (this.selectedIndex < this.speeds.length - 1) {
          SpeedOption({
            text: this.speeds[this.selectedIndex + 1],
            isSelected: false,
            onClick: () => {
              this.onSelect(this.selectedIndex + 1)
            }
          })
        } else {
          SpeedOption({
            text: '-',
            isSelected: false,
            onClick: () => {}
          })
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct SpeedOption {
  @Prop text: string
  @Prop isSelected: boolean
  onClick: () => void = () => {}

  private itemWidth: number = 100
  private itemHeight: number = 50
  private cornerRadius: number = 12

  build() {
    Text(this.text)
      .fontSize(this.isSelected ? 22 : 16)
      .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.isSelected ? '#000000' : '#E0E0E0')
      .width(this.itemWidth)
      .height(this.itemHeight)
      .textAlign(TextAlign.Center)
      .backgroundColor(this.isSelected ? '#F0F0F0' : Color.Transparent)
      .borderRadius(this.cornerRadius)
      .onClick(() => {
        if (!this.isSelected && this.text !== '-') {
          this.onClick()
        }
      })
  }
}

@Component
struct LogShotButton {
  private buttonHeight: number = 56
  private cornerRadius: number = 12
  private iconBoxSize: number = 24
  private iconSize: number = 16
  private iconTextSpacing: number = 12
  private letterSpacingButton: number = 1

  build() {
    Button() {
      Row({ space: this.iconTextSpacing }) {
        Stack() {
          Text('+')
            .fontSize(this.iconSize)
            .fontColor('#000000')
            .width(this.iconBoxSize)
            .height(this.iconBoxSize)
            .textAlign(TextAlign.Center)
            .backgroundColor('#FFFFFF')
            .borderRadius(this.iconBoxSize / 2)
        }
        .width(this.iconBoxSize)
        .height(this.iconBoxSize)

        Text('LOG EXPOSURE')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .letterSpacing(this.letterSpacingButton)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(this.buttonHeight)
    .backgroundColor('#000000')
    .borderRadius(this.cornerRadius)
  }
}