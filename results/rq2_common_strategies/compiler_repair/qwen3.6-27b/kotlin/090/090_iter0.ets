import { Color, FontSize, FontWeight, Image, LayoutWeight, LengthUnit, Spacing } from '@kit.ArkUI'

@Entry
@Component
struct LumenAppScreen {
  @State selectedIso: string = "400"
  @State apertureValue: number = 2.8
  @State selectedSpeedIndex: number = 4

  private shutterSpeeds: string[] = ["1/1000", "1/500", "1/250", "1/125", "1/60", "1/30", "1/15", "1/8"]
  private isoValues: string[] = ["100", "200", "400", "800", "1600", "3200"]

  build() {
    Column() {
      HeaderSection()

      CurrentSettingsDisplay(
        this.selectedIso,
        this.apertureValue.toFixed(1),
        this.shutterSpeeds[this.selectedSpeedIndex]
      )

      Column() {
        IsoSelector(this.selectedIso, (iso: string) => {
          this.selectedIso = iso
        })

        ApertureControl(this.apertureValue, (val: number) => {
          this.apertureValue = val
        })

        ShutterSpeedControl(
          this.shutterSpeeds,
          this.selectedSpeedIndex,
          (index: number) => {
            this.selectedSpeedIndex = index
          }
        )
      }.margin({ top: 32 })

      LogShotButton()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(Color.White)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text("LUMEN LOG")
          .fontSize(FontSize.FontSize_14)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
          .fontColor(Color.Gray)

        Text("Roll #034")
          .fontSize(FontSize.FontSize_24)
          .fontWeight(FontWeight.ExtraBold)
          .fontColor(Color.Black)
      }

      Row() {
        Button("", { type: ButtonType.Circle, stateEffect: false })
          .width(40)
          .height(40)
          .backgroundColor(Color.Transparent)
          .onClick(() => {})
          .build() {
            Image($r('app.media.ic_menu')) // Placeholder for Menu Icon
              .width(24)
              .height(24)
              .fillColor(Color.Black)
          }

        Button("", { type: ButtonType.Circle, stateEffect: false })
          .width(40)
          .height(40)
          .backgroundColor(Color.Transparent)
          .onClick(() => {})
          .build() {
            Image($r('app.media.ic_settings')) // Placeholder for Settings Icon
              .width(24)
              .height(24)
              .fillColor(Color.Black)
          }
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 16 })
  }
}

@Component
struct CurrentSettingsDisplay {
  @Prop iso: string
  @Prop aperture: string
  @Prop shutter: string

  build() {
    Column() {
      Row() {
        Column() {
          Text(`f/${this.aperture}`)
            .fontSize(56)
            .fontWeight(FontWeight.Light)
            .letterSpacing(-2)
            .fontColor(Color.Black)

          Text("APERTURE")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Gray)
        }
        .layoutWeight(1.5)
        .margin({ left: 24 })
        .justifyContent(FlexAlign.Center)

        Divider()
          .vertical(true)
          .width(1)
          .height(80)
          .color('#EEEEEE')

        Column() {
          SettingItemSmall("ISO", this.iso)
          SettingItemSmall("SHUTTER", this.shutter)
        }
        .layoutWeight(1)
        .margin({ left: 24 })
        .justifyContent(FlexAlign.Center)
        .itemSpacing(16)
      }
      .width('100%')
      .height(160)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
    .backgroundColor('#F8F8F8')
  }
}

@Component
struct SettingItemSmall {
  @Prop label: string
  @Prop value: string

  build() {
    Column() {
      Text(this.value)
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
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
  @Prop currentIso: string
  @Prop onIsoSelected: (iso: string) => void

  build() {
    Column() {
      Text("Film Stock ISO")
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 12 })

      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.isoValues, (iso: string) => {
          let isSelected = this.currentIso === iso
          Button(iso, { type: ButtonType.Capsule, stateEffect: false })
            .width(60)
            .height(36)
            .fontSize(13)
            .fontWeight(FontWeight.SemiBold)
            .backgroundColor(isSelected ? Color.Black : Color.Transparent)
            .fontColor(isSelected ? Color.White : Color.Black)
            .border({
              width: 1,
              color: isSelected ? Color.Black : '#E0E0E0',
              radius: 50
            })
            .onClick(() => {
              this.onIsoSelected(iso)
            })
            .margin({ right: 12 })
        })
      }
    }
  }
}

@Component
struct ApertureControl {
  @Prop value: number
  @Prop onValueChange: (val: number) => void

  build() {
    Column() {
      Row() {
        Text("Aperture Control")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)

        Image($r('app.media.ic_settings')) // Placeholder
          .width(16)
          .height(16)
          .fillColor(Color.Gray)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Slider({
        min: 1.4,
        max: 16,
        step: 0.7,
        value: this.value
      })
        .width('100%')
        .trackThickness(4)
        .selectedColor(Color.Black)
        .trackColor('#E0E0E0')
        .onChange((value: number) => {
          this.onValueChange(value)
        })
        .margin({ top: 8 })

      Row() {
        Text("f/1.4")
          .fontSize(12)
          .fontColor(Color.Gray)

        Text("f/16")
          .fontSize(12)
          .fontColor(Color.Gray)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }
}

@Component
struct ShutterSpeedControl {
  @Prop speeds: string[]
  @Prop selectedIndex: number
  @Prop onSelect: (index: number) => void

  build() {
    Column() {
      Text("Shutter Speed")
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 12 })

      Row() {
        SpeedOption(
          this.speeds[this.selectedIndex - 1] || "-",
          false,
          () => {
            if (this.selectedIndex > 0) {
              this.onSelect(this.selectedIndex - 1)
            }
          }
        )

        SpeedOption(
          this.speeds[this.selectedIndex],
          true,
          () => {}
        )

        SpeedOption(
          this.speeds[this.selectedIndex + 1] || "-",
          false,
          () => {
            if (this.selectedIndex < this.speeds.length - 1) {
              this.onSelect(this.selectedIndex + 1)
            }
          }
        )
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }
}

@Component
struct SpeedOption {
  @Prop text: string
  @Prop isSelected: boolean
  @Prop onClick: () => void

  build() {
    Column() {
      Text(this.text)
        .fontSize(this.isSelected ? 22 : 16)
        .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(this.isSelected ? Color.Black : Color.Gray)
    }
    .width(100)
    .height(50)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .borderRadius(12)
    .backgroundColor(this.isSelected ? '#F0F0F0' : Color.Transparent)
    .onClick(() => {
      if (!this.isSelected && this.text !== "-") {
        this.onClick()
      }
    })
  }
}

@Component
struct LogShotButton {
  build() {
    Button() {
      Row() {
        Circle({ width: 24, height: 24 })
          .fill(Color.White)
          .margin({ right: 12 })
          .build() {
            Image($r('app.media.ic_add')) // Placeholder for Add Icon
              .width(16)
              .height(16)
              .fillColor(Color.Black)
          }

        Text("LOG EXPOSURE")
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(1)
          .fontColor(Color.White)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(56)
    .backgroundColor(Color.Black)
    .borderRadius(12)
    .onClick(() => {})
  }
}