// Translated from SwiftUI (Swift) to ArkTS (ArkUI)
// Source: LumenApp
// Color(hex:) helper replaced with inline hex strings.

@Entry
@Component
struct Index {
  build() {
    LumenAppScreen()
  }
}

// MARK: - Main Screen
@Component
struct LumenAppScreen {
  @State selectedIso: string = '400'
  @State apertureValue: number = 2.8
  @State selectedSpeedIndex: number = 4

  shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8']

  screenPadding: number = 24
  verticalSpacingLarge: number = 32
  verticalSpacingMedium: number = 16
  horizontalSpacingSmall: number = 12

  build() {
    Stack() {
      Column() {
        HeaderSection()
          .padding({ bottom: this.verticalSpacingMedium })

        CurrentSettingsDisplay({
          iso: this.selectedIso,
          aperture: this.apertureValue.toFixed(1),
          shutter: this.shutterSpeeds[this.selectedSpeedIndex]
        })

        Blank()

        Column({ space: this.verticalSpacingLarge }) {
          IsoSelector({
            currentIso: this.selectedIso,
            onIsoSelected: (iso: string) => { this.selectedIso = iso }
          })

          ApertureControl({ value: $apertureValue })

          ShutterSpeedControl({
            speeds: this.shutterSpeeds,
            selectedIndex: this.selectedSpeedIndex,
            onSelect: (index: number) => { this.selectedSpeedIndex = index }
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
    .backgroundColor('#FFFFFF')
  }
}

// MARK: - Sub-Components

@Component
struct HeaderSection {
  bottomPadding: number = 16
  letterSpacingHeader: number = 2
  iconButtonSize: number = 44

  build() {
    Row() {
      Column() {
        Text('LUMEN LOG')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(this.letterSpacingHeader)
          .fontColor('#808080')
        Text('Roll #034')
          .fontSize(24)
          .fontWeight(FontWeight.Bolder)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        Button() {
          Text('☰')
            .fontSize(22)
            .fontColor('#000000')
        }
        .onClick(() => {})
        .width(this.iconButtonSize)
        .height(this.iconButtonSize)

        Button() {
          Text('⚙')
            .fontSize(22)
            .fontColor('#000000')
        }
        .onClick(() => {})
        .width(this.iconButtonSize)
        .height(this.iconButtonSize)
      }
    }
    .width('100%')
  }
}

@Component
struct CurrentSettingsDisplay {
  iso: string = ''
  aperture: string = ''
  shutter: string = ''

  cardHeight: number = 160
  cornerRadius: number = 16
  horizontalPadding: number = 24
  dividerHeight: number = 80
  detailSpacing: number = 16

  build() {
    Column() {
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
            .fontColor('#808080')
        }
        .alignItems(HorizontalAlign.Start)
        .padding({ left: this.horizontalPadding })
        .layoutWeight(1.5)

        Column()
          .width(1)
          .height(this.dividerHeight)
          .backgroundColor('#E0E0E0')

        Column() {
          SettingItemSmall({ label: 'ISO', value: this.iso })
          Blank().height(this.detailSpacing)
          SettingItemSmall({ label: 'SHUTTER', value: this.shutter })
        }
        .alignItems(HorizontalAlign.Start)
        .padding({ left: this.horizontalPadding })
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .alignItems(VerticalAlign.Center)
    }
    .height(this.cardHeight)
    .width('100%')
    .backgroundColor('#F8F8F8')
    .borderRadius(this.cornerRadius)
    .border({ width: 1, color: '#EEEEEE' })
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
        .fontWeight(FontWeight.Semibold)
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
  isoValues: string[] = ['100', '200', '400', '800', '1600', '3200']
  currentIso: string = ''
  onIsoSelected: (iso: string) => void = () => {}

  bottomPadding: number = 12
  itemWidth: number = 60
  itemHeight: number = 36
  cornerRadius: number = 50
  horizontalSpacing: number = 12

  build() {
    Column() {
      Text('Film Stock ISO')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .padding({ bottom: this.bottomPadding })

      Scroll() {
        Row({ space: this.horizontalSpacing }) {
          ForEach(this.isoValues, (iso: string) => {
            Stack() {
              Text(iso)
                .fontSize(13)
                .fontWeight(FontWeight.Semibold)
                .fontColor(this.currentIso === iso ? '#FFFFFF' : '#000000')
            }
            .width(this.itemWidth)
            .height(this.itemHeight)
            .backgroundColor(this.currentIso === iso ? '#000000' : '#00000000')
            .borderRadius(this.cornerRadius)
            .border({ width: 1, color: this.currentIso === iso ? '#000000' : '#E0E0E0' })
            .onClick(() => { this.onIsoSelected(iso) })
          }, (iso: string) => iso)
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ApertureControl {
  @Link value: number

  sliderTopSpacing: number = 8
  iconSize: number = 16
  sliderStep: number = (16.0 - 1.4) / 20.0
  trackHeight: number = 2
  thumbDiameter: number = 28

  build() {
    Column() {
      Row() {
        Text('Aperture Control')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
        Blank()
        Text('⚙')
          .fontSize(16)
          .fontColor('#808080')
          .width(this.iconSize)
          .height(this.iconSize)
      }
      .width('100%')

      Blank().height(this.sliderTopSpacing)

      // Custom track/thumb approximated with a styled Slider
      Slider({ value: this.value, min: 1.4, max: 16.0, step: this.sliderStep })
        .selectedColor('#000000')
        .trackColor('#E0E0E0')
        .blockColor('#000000')
        .trackThickness(this.trackHeight)
        .blockSize({ width: this.thumbDiameter, height: this.thumbDiameter })
        .onChange((v: number) => { this.value = v })
        .width('100%')

      Row() {
        Text('f/1.4')
          .fontSize(12)
          .fontColor('#808080')
        Blank()
        Text('f/16')
          .fontSize(12)
          .fontColor('#808080')
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ShutterSpeedControl {
  speeds: string[] = []
  selectedIndex: number = 0
  onSelect: (index: number) => void = () => {}

  bottomPadding: number = 12
  horizontalSpacing: number = 12

  build() {
    Column() {
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .padding({ bottom: this.bottomPadding })

      Row({ space: this.horizontalSpacing }) {
        SpeedOption({
          text: this.prevText(),
          isSelected: false,
          onClick: () => { if (this.selectedIndex > 0) { this.onSelect(this.selectedIndex - 1) } }
        })

        SpeedOption({ text: this.currText(), isSelected: true, onClick: () => {} })

        SpeedOption({
          text: this.nextText(),
          isSelected: false,
          onClick: () => { if (this.selectedIndex < this.speeds.length - 1) { this.onSelect(this.selectedIndex + 1) } }
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .alignItems(HorizontalAlign.Start)
  }

  prevText(): string {
    return this.selectedIndex - 1 >= 0 ? this.speeds[this.selectedIndex - 1] : '-'
  }

  currText(): string {
    return this.speeds[this.selectedIndex]
  }

  nextText(): string {
    return this.selectedIndex + 1 < this.speeds.length ? this.speeds[this.selectedIndex + 1] : '-'
  }
}

@Component
struct SpeedOption {
  text: string = ''
  isSelected: boolean = false
  onClick: () => void = () => {}

  itemWidth: number = 100
  itemHeight: number = 50
  cornerRadius: number = 12

  build() {
    Stack() {
      Text(this.text)
        .fontSize(this.isSelected ? 22 : 16)
        .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Regular)
        .fontColor(this.isSelected ? '#000000' : '#E0E0E0')
    }
    .width(this.itemWidth)
    .height(this.itemHeight)
    .backgroundColor(this.isSelected ? '#F0F0F0' : '#00000000')
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
  buttonHeight: number = 56
  cornerRadius: number = 12
  iconBoxSize: number = 24
  iconSize: number = 16
  iconTextSpacing: number = 12
  letterSpacingButton: number = 1

  build() {
    Button() {
      Row({ space: this.iconTextSpacing }) {
        Stack() {
          Circle()
            .fill('#FFFFFF')
            .width(this.iconBoxSize)
            .height(this.iconBoxSize)
          Text('+')
            .fontSize(this.iconSize)
            .fontColor('#000000')
            .width(this.iconSize)
            .height(this.iconSize)
        }
        .width(this.iconBoxSize)
        .height(this.iconBoxSize)

        Text('LOG EXPOSURE')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(this.letterSpacingButton)
          .fontColor('#FFFFFF')
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .onClick(() => {})
    .height(this.buttonHeight)
    .width('100%')
    .backgroundColor('#000000')
    .borderRadius(this.cornerRadius)
  }
}
