@Entry
@Component
struct LumenAppScreen {
  @State selectedIso: string = '400'
  @State apertureValue: number = 2.8
  @State selectedSpeedIndex: number = 4
  private shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8']

  private readonly screenPadding: number = 24
  private readonly verticalSpacingLarge: number = 32
  private readonly verticalSpacingMedium: number = 16

  build() {
    Column() {
      Column() {
        HeaderSection()
          .margin({ bottom: this.verticalSpacingMedium })

        CurrentSettingsDisplay({
          iso: this.selectedIso,
          aperture: this.apertureValue.toFixed(1),
          shutter: this.shutterSpeeds[this.selectedSpeedIndex]
        })

        Blank()

        Column({ space: this.verticalSpacingLarge }) {
          IsoSelector({ selectedIso: $selectedIso })

          ApertureControl({ apertureValue: $apertureValue })

          ShutterSpeedControl({
            speeds: this.shutterSpeeds,
            selectedIndex: $selectedSpeedIndex
          })
        }

        Blank()

        LogShotButton()
      }
      .width('100%')
      .height('100%')
      .padding(this.screenPadding)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct HeaderSection {
  private readonly letterSpacingHeader: number = 2
  private readonly iconButtonSize: number = 44

  build() {
    Row() {
      Column() {
        Text('LUMEN LOG')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#999999')
          .letterSpacing(this.letterSpacingHeader)
        Text('Roll #034')
          .fontSize(24)
          .fontWeight(FontWeight.Bolder)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        Column() {
          Column() {
            Rect({ width: 18, height: 2 })
              .fill(Color.Black)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
        }
        .width(22)
        .height(22)
        .margin({ left: 11, right: 11 })

        Column() {
          // Gear icon drawn as text
          Text('⚙')
            .fontSize(22)
            .fontColor(Color.Black)
        }
        .width(this.iconButtonSize)
        .height(this.iconButtonSize)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
    }
    .width('100%')
  }
}

@Component
struct CurrentSettingsDisplay {
  @Prop iso: string = ''
  @Prop aperture: string = ''
  @Prop shutter: string = ''

  private readonly cardHeight: number = 160
  private readonly cornerRadius: number = 16
  private readonly horizontalPadding: number = 24
  private readonly dividerHeight: number = 80

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
          .fontColor('#999999')
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
      .padding({ left: this.horizontalPadding })
      .layoutWeight(1.5)

      Divider()
        .vertical(true)
        .height(this.dividerHeight)
        .color('#E0E0E0')
        .width(1)

      Column() {
        SettingItemSmall({ label: 'ISO', value: this.iso })
        Blank()
          .height(16)
        SettingItemSmall({ label: 'SHUTTER', value: this.shutter })
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
      .padding({ left: this.horizontalPadding })
      .layoutWeight(1)
    }
    .width('100%')
    .height(this.cardHeight)
    .backgroundColor('#F8F8F8')
    .borderRadius(this.cornerRadius)
    .border({ width: 1, color: '#EEEEEE' })
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
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#999999')
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct IsoSelector {
  @Link selectedIso: string
  private isoValues: string[] = ['100', '200', '400', '800', '1600', '3200']
  private readonly bottomPadding: number = 12
  private readonly itemWidth: number = 60
  private readonly itemHeight: number = 36
  private readonly cornerRadius: number = 50
  private readonly horizontalSpacing: number = 12

  build() {
    Column() {
      Text('Film Stock ISO')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: this.bottomPadding })

      Scroll() {
        Row({ space: this.horizontalSpacing }) {
          ForEach(this.isoValues, (iso: string) => {
            Text(iso)
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedIso === iso ? Color.White : Color.Black)
              .width(this.itemWidth)
              .height(this.itemHeight)
              .textAlign(TextAlign.Center)
              .backgroundColor(this.selectedIso === iso ? Color.Black : Color.Transparent)
              .borderRadius(this.cornerRadius)
              .border({
                width: 1,
                color: this.selectedIso === iso ? Color.Black : '#E0E0E0'
              })
              .onClick(() => {
                this.selectedIso = iso
              })
          }, (iso: string) => iso)
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
  @Link apertureValue: number

  private readonly sliderTopSpacing: number = 8
  private readonly iconSize: number = 16
  private readonly minValue: number = 1.4
  private readonly maxValue: number = 16.0
  private readonly step: number = 0.1

  build() {
    Column() {
      Row() {
        Text('Aperture Control')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
        Blank()
        Text('⚙')
          .fontSize(16)
          .fontColor('#999999')
      }
      .width('100%')

      Blank()
        .height(this.sliderTopSpacing)

      Slider({
        value: this.apertureValue,
        min: this.minValue,
        max: this.maxValue,
        step: this.step,
        style: SliderStyle.OutSet
      })
        .blockColor(Color.Black)
        .trackColor('#E0E0E0')
        .selectedColor(Color.Black)
        .width('100%')
        .onChange((value: number) => {
          this.apertureValue = value
        })

      Row() {
        Text('f/1.4')
          .fontSize(12)
          .fontColor('#999999')
        Blank()
        Text('f/16')
          .fontSize(12)
          .fontColor('#999999')
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct ShutterSpeedControl {
  @Prop speeds: string[] = []
  @Link selectedIndex: number

  private readonly bottomPadding: number = 12

  build() {
    Column() {
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: this.bottomPadding })

      Row() {
        // Previous (faded)
        if (this.selectedIndex > 0) {
          SpeedOption({
            text: this.speeds[this.selectedIndex - 1],
            isSelected: false,
            clickAction: () => {
              this.selectedIndex = this.selectedIndex - 1
            }
          })
          .opacity(0.3)
        } else {
          SpeedOption({ text: '', isSelected: false, clickAction: () => {} })
            .opacity(0)
        }

        Blank()

        // Current (selected)
        SpeedOption({
          text: this.speeds[this.selectedIndex],
          isSelected: true,
          clickAction: () => {}
        })

        Blank()

        // Next (faded)
        if (this.selectedIndex < this.speeds.length - 1) {
          SpeedOption({
            text: this.speeds[this.selectedIndex + 1],
            isSelected: false,
            clickAction: () => {
              this.selectedIndex = this.selectedIndex + 1
            }
          })
          .opacity(0.3)
        } else {
          SpeedOption({ text: '', isSelected: false, clickAction: () => {} })
            .opacity(0)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct SpeedOption {
  @Prop text: string = ''
  @Prop isSelected: boolean = false
  @Prop clickAction: () => void = () => {}

  private readonly itemWidth: number = 100
  private readonly itemHeight: number = 50
  private readonly cornerRadius: number = 12

  build() {
    Text(this.text)
      .fontSize(this.isSelected ? 22 : 16)
      .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.isSelected ? Color.Black : '#E0E0E0')
      .width(this.itemWidth)
      .height(this.itemHeight)
      .textAlign(TextAlign.Center)
      .backgroundColor(this.isSelected ? '#F0F0F0' : Color.Transparent)
      .borderRadius(this.cornerRadius)
      .onClick(() => {
        if (!this.isSelected && this.text !== '') {
          this.clickAction()
        }
      })
  }
}

@Component
struct LogShotButton {
  private readonly buttonHeight: number = 56
  private readonly cornerRadius: number = 12
  private readonly iconBoxSize: number = 24
  private readonly iconSize: number = 16
  private readonly iconTextSpacing: number = 12
  private readonly letterSpacingButton: number = 1

  build() {
    Button() {
      Row({ space: this.iconTextSpacing }) {
        Stack() {
          Circle({ width: this.iconBoxSize, height: this.iconBoxSize })
            .fill(Color.White)
          Text('+')
            .fontSize(18)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
        }
        .width(this.iconBoxSize)
        .height(this.iconBoxSize)

        Text('LOG EXPOSURE')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .letterSpacing(this.letterSpacingButton)
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height(this.buttonHeight)
    .type(ButtonType.Normal)
    .backgroundColor(Color.Black)
    .borderRadius(this.cornerRadius)
    .onClick(() => {})
  }
}
