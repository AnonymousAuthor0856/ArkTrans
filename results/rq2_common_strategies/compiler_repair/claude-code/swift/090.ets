@Entry
@Component
struct LumenAppScreen {
  @State selectedIso: string = "400"
  @State apertureValue: number = 2.8
  @State selectedSpeedIndex: number = 4
  private shutterSpeeds: string[] = ["1/1000", "1/500", "1/250", "1/125", "1/60", "1/30", "1/15", "1/8"]
  private screenPadding: Length = 24
  private verticalSpacingLarge: Length = 32
  private verticalSpacingMedium: Length = 16

  build() {
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
        IsoSelector({
          currentIso: this.selectedIso,
          onIsoSelected: (iso: string) => { this.selectedIso = iso }
        })

        ApertureControl({
          value: this.apertureValue,
          onValueChange: (val: number) => { this.apertureValue = val }
        })

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
    .backgroundColor(Color.White)
  }
}

@Component
struct HeaderSection {
  private letterSpacingHeader: number = 2
  private iconButtonSize: Length = 44

  build() {
    Row() {
      Column() {
        Text("LUMEN LOG")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(this.letterSpacingHeader)
          .fontColor('#888888')
        Text("Roll #034")
          .fontSize(24)
          .fontWeight(FontWeight.Bolder)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        Text("☰")
          .fontSize(22)
          .fontColor(Color.Black)
          .width(this.iconButtonSize)
          .height(this.iconButtonSize)
          .textAlign(TextAlign.Center)

        Text("⚙")
          .fontSize(22)
          .fontColor(Color.Black)
          .width(this.iconButtonSize)
          .height(this.iconButtonSize)
          .textAlign(TextAlign.Center)
      }
    }
    .width('100%')
  }
}

@Component
struct CurrentSettingsDisplay {
  @Prop iso: string = ""
  @Prop aperture: string = ""
  @Prop shutter: string = ""
  private cardHeight: Length = 160
  private cornerRadius: Length = 16
  private horizontalPadding: Length = 24
  private dividerHeight: Length = 80
  private detailSpacing: Length = 16

  build() {
    Stack() {
      Row() {
        Column() {
          Text(`f/${this.aperture}`)
            .fontSize(56)
            .fontWeight(FontWeight.Lighter)
            .fontColor(Color.Black)
            .letterSpacing(-2)
          Text("APERTURE")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#888888')
        }
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)
        .padding({ left: this.horizontalPadding })
        .layoutWeight(1.5)

        Divider()
          .vertical(true)
          .color('#E0E0E0')
          .strokeWidth(1)
          .height(this.dividerHeight)

        Column({ space: this.detailSpacing }) {
          SettingItemSmall({ label: "ISO", value: this.iso })
          SettingItemSmall({ label: "SHUTTER", value: this.shutter })
        }
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)
        .padding({ left: this.horizontalPadding })
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
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
  @Prop label: string = ""
  @Prop value: string = ""

  build() {
    Column() {
      Text(this.value)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#888888')
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct IsoSelector {
  @Prop currentIso: string = "400"
  onIsoSelected: (iso: string) => void = () => {}
  private isoValues: string[] = ["100", "200", "400", "800", "1600", "3200"]
  private bottomPadding: Length = 12
  private itemWidth: Length = 60
  private itemHeight: Length = 36
  private cornerRadius: Length = 50
  private horizontalSpacing: Length = 12
  private scroller: Scroller = new Scroller()

  build() {
    Column() {
      Text("Film Stock ISO")
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: this.bottomPadding })

      Scroll(this.scroller) {
        Row({ space: this.horizontalSpacing }) {
          ForEach(this.isoValues, (iso: string) => {
            Text(iso)
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.currentIso === iso ? Color.White : Color.Black)
              .width(this.itemWidth)
              .height(this.itemHeight)
              .textAlign(TextAlign.Center)
              .backgroundColor(this.currentIso === iso ? Color.Black : Color.Transparent)
              .borderRadius(this.cornerRadius)
              .border({
                width: 1,
                color: this.currentIso === iso ? Color.Black : '#E0E0E0'
              })
              .onClick(() => { this.onIsoSelected(iso) })
          }, (iso: string) => iso)
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ApertureControl {
  @Prop value: number = 2.8
  onValueChange: (val: number) => void = () => {}
  private sliderTopSpacing: Length = 8
  private iconSize: Length = 16
  private trackHeight: Length = 2
  private thumbDiameter: Length = 28
  private minValue: number = 1.4
  private maxValue: number = 16.0
  private stepValue: number = (16.0 - 1.4) / 20.0

  build() {
    Column() {
      Row() {
        Text("Aperture Control")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
        Blank()
        Text("⚙")
          .fontSize(16)
          .fontColor('#888888')
      }
      .width('100%')
      .margin({ bottom: this.sliderTopSpacing })

      Slider({
        value: this.value,
        min: this.minValue,
        max: this.maxValue,
        step: this.stepValue,
        style: SliderStyle.OutSet
      })
        .blockColor(Color.Black)
        .trackColor('#E0E0E0')
        .selectedColor(Color.Black)
        .width('100%')
        .onChange((value: number) => { this.onValueChange(value) })

      Row() {
        Text("f/1.4")
          .fontSize(12)
          .fontColor('#888888')
        Blank()
        Text("f/16")
          .fontSize(12)
          .fontColor('#888888')
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ShutterSpeedControl {
  @Prop speeds: string[] = []
  @Prop selectedIndex: number = 0
  onSelect: (index: number) => void = () => {}
  private bottomPadding: Length = 12
  private horizontalSpacing: Length = 12

  build() {
    Column() {
      Text("Shutter Speed")
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: this.bottomPadding })

      Row({ space: this.horizontalSpacing }) {
        SpeedOption({
          text: this.selectedIndex > 0 ? this.speeds[this.selectedIndex - 1] : "-",
          isSelected: false,
          onItemClick: () => {
            if (this.selectedIndex > 0) {
              this.onSelect(this.selectedIndex - 1)
            }
          }
        })

        SpeedOption({
          text: this.speeds[this.selectedIndex],
          isSelected: true,
          onItemClick: () => {}
        })

        SpeedOption({
          text: this.selectedIndex < this.speeds.length - 1 ? this.speeds[this.selectedIndex + 1] : "-",
          isSelected: false,
          onItemClick: () => {
            if (this.selectedIndex < this.speeds.length - 1) {
              this.onSelect(this.selectedIndex + 1)
            }
          }
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SpeedOption {
  @Prop text: string = ""
  @Prop isSelected: boolean = false
  onItemClick: () => void = () => {}
  private itemWidth: Length = 100
  private itemHeight: Length = 50
  private cornerRadius: Length = 12

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
        if (!this.isSelected && this.text !== "-") {
          this.onItemClick()
        }
      })
  }
}

@Component
struct LogShotButton {
  private buttonHeight: Length = 56
  private cornerRadius: Length = 12
  private iconBoxSize: Length = 24
  private iconSize: Length = 16
  private iconTextSpacing: Length = 12
  private letterSpacingButton: number = 1

  build() {
    Button() {
      Row({ space: this.iconTextSpacing }) {
        Stack() {
          Circle()
            .width(this.iconBoxSize)
            .height(this.iconBoxSize)
            .fill(Color.White)
          Text("+")
            .fontSize(16)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
        }
        .width(this.iconBoxSize)
        .height(this.iconBoxSize)

        Text("LOG EXPOSURE")
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(this.letterSpacingButton)
          .fontColor(Color.White)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(this.buttonHeight)
    .backgroundColor(Color.Black)
    .borderRadius(this.cornerRadius)
    .type(ButtonType.Normal)
    .onClick(() => {})
  }
}
