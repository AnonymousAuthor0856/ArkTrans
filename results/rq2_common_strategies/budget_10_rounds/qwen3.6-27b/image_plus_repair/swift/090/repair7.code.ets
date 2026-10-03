// entry/src/main/ets/viewpages/LumenAppScreen.ets

@Entry
@Component
struct LumenAppScreen {
  // State Management
  @State selectedIso: string = "400"
  @State apertureValue: number = 2.8
  @State selectedSpeedIndex: number = 4

  private shutterSpeeds: string[] = ["1/1000", "1/500", "1/250", "1/125", "1/60", "1/30", "1/15", "1/8"]

  build() {
    Column() {
      // 1. Header
      HeaderSection()

      // 2. Main Display (The "Shot")
      CurrentSettingsDisplay({
        iso: this.selectedIso,
        aperture: this.apertureValue.toFixed(1),
        shutter: this.shutterSpeeds[this.selectedSpeedIndex]
      })

      Flex({ justifyContent: FlexAlign.SpaceBetween }) {
        Column() {} // Spacer equivalent to push controls down
        
        // 3. Controls
        Column({ space: 32 }) {
          // ISO Selector
          IsoSelector({
            currentIso: this.selectedIso,
            onIsoSelected: (iso: string) => {
              this.selectedIso = iso
            }
          })

          // Aperture Slider
          ApertureControl({ value: $apertureValue })

          // Shutter Speed Selector
          ShutterSpeedControl({
            speeds: this.shutterSpeeds,
            selectedIndex: this.selectedSpeedIndex,
            onSelect: (index: number) => {
              this.selectedSpeedIndex = index
            }
          })
        }

        Column() {} // Spacer equivalent
      }
      .layoutWeight(1)

      // 4. Bottom Action
      LogShotButton()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
  }
}

// MARK: - Sub-Components

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text("LUMEN LOG")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
          .fontColor('#999999')
        
        Text("Roll #034")
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      
      Row() {
        // Menu Icon
        Image($r('app.media.ic_menu')) // Placeholder for menu icon
          .width(24)
          .height(24)
          .fillColor(Color.Black)
          .margin({ right: 16 })
        
        // Settings Icon
        Image($r('app.media.ic_settings')) // Placeholder for settings icon
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Top)
    .margin({ bottom: 16 })
  }
}

@Component
struct CurrentSettingsDisplay {
  iso: string = ""
  aperture: string = ""
  shutter: string = ""

  build() {
    Row() {
      // Left Side: Aperture
      Column() {
        Text(`f/${this.aperture}`)
          .fontSize(56)
          .fontWeight(FontWeight.Lighter)
          .letterSpacing(-2)
          .fontColor(Color.Black)
        
        Text("APERTURE")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#999999')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1.5)

      // Divider
      Divider()
        .vertical(true)
        .color('#E0E0E0')
        .height(80)
        .margin({ left: 24, right: 24 })

      // Right Side: Details
      Column() {
        SettingItemSmall({ label: "ISO", value: this.iso })
        Blank().height(16)
        SettingItemSmall({ label: "SHUTTER", value: this.shutter })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .height(160)
    .backgroundColor('#F8F8F8')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 32 })
  }
}

@Component
struct SettingItemSmall {
  label: string = ""
  value: string = ""

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
  currentIso: string = ""
  onIsoSelected: (iso: string) => void = () => {}

  private isoValues: string[] = ["100", "200", "400", "800", "1600", "3200"]

  build() {
    Column() {
      Text("Film Stock ISO")
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 12 })

      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.isoValues, (iso: string) => {
            let isSelected: boolean = this.currentIso === iso
            
            Button(iso) {
              // Button content handled by style
            }
            .type(ButtonType.Normal)
            .width(60)
            .height(36)
            .fontSize(13)
            .fontWeight(FontWeight.Medium)
            .fontColor(isSelected ? Color.White : Color.Black)
            .backgroundColor(isSelected ? Color.Black : Color.Transparent)
            .borderRadius(50)
            .border({
              width: 1,
              color: isSelected ? Color.Black : '#E0E0E0',
              radius: 50
            })
            .onClick(() => {
              this.onIsoSelected(iso)
            })
          })
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
  }
}

@Component
struct ApertureControl {
  @Link value: number

  build() {
    Column() {
      Row() {
        Text("Aperture Control")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
        
        Image($r('app.media.ic_settings_small')) // Placeholder
          .width(16)
          .height(16)
          .fillColor('#999999')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ bottom: 8 })

      Slider({
        value: this.value,
        min: 1.4,
        max: 16.0,
        step: 0.73, // Approximate step based on visual
        style: SliderStyle.InSet
      })
      .trackColor({ active: Color.Black, inactive: Color.Gray })
      .selectedColor(Color.Black)
      .blockColor(Color.Black)
      .blockSize({ width: 28, height: 28 })
      .width('100%')
      .height(28)

      Row() {
        Text("f/1.4")
          .fontSize(12)
          .fontColor('#999999')
        Text("f/16")
          .fontSize(12)
          .fontColor('#999999')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }
}

@Component
struct ShutterSpeedControl {
  speeds: string[] = []
  selectedIndex: number = 0
  onSelect: (index: number) => void = () => {}

  build() {
    Column() {
      Text("Shutter Speed")
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 12 })

      Row({ space: 12 }) {
        // Previous Option
        if (this.selectedIndex > 0) {
          SpeedOption({
            text: this.speeds[this.selectedIndex - 1],
            isSelected: false,
            onClick: () => this.onSelect(this.selectedIndex - 1)
          })
        } else {
          // Placeholder to maintain layout if at start
          Text("-").visibility(Visibility.None)
        }

        // Current Option
        SpeedOption({
          text: this.speeds[this.selectedIndex],
          isSelected: true,
          onClick: () => {}
        })

        // Next Option
        if (this.selectedIndex < this.speeds.length - 1) {
          SpeedOption({
            text: this.speeds[this.selectedIndex + 1],
            isSelected: false,
            onClick: () => this.onSelect(this.selectedIndex + 1)
          })
        } else {
          // Placeholder to maintain layout if at end
          Text("-").visibility(Visibility.None)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }
}

@Component
struct SpeedOption {
  text: string = ""
  isSelected: boolean = false
  onClick: () => void = () => {}

  build() {
    Button(this.text) {
      // Content handled by style
    }
    .type(ButtonType.Normal)
    .width(100)
    .height(50)
    .fontSize(this.isSelected ? 22 : 16)
    .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
    .fontColor(this.isSelected ? Color.Black : '#E0E0E0')
    .backgroundColor(this.isSelected ? '#F0F0F0' : Color.Transparent)
    .borderRadius(12)
    .onClick(() => {
      if (!this.isSelected) {
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
        // Plus Icon Circle
        Row() {
          Text("+")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
        .width(24)
        .height(24)
        .backgroundColor(Color.White)
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        
        Text("LOG EXPOSURE")
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(1)
          .fontColor(Color.White)
          .margin({ left: 12 })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .type(ButtonType.Normal)
    .width('100%')
    .height(56)
    .backgroundColor(Color.Black)
    .borderRadius(12)
  }
}