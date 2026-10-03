@Entry
@Component
struct LumenAppScreen {
  @State selectedIso: string = "400";
  @State apertureValue: number = 2.8;
  @State selectedSpeedIndex: number = 4;
  private shutterSpeeds: string[] = ["1/1000", "1/500", "1/250", "1/125", "1/60", "1/30", "1/15", "1/8"];
  private isoValues: string[] = ["100", "200", "400", "800", "1600", "3200"];

  build() {
    Column() {
      this.HeaderSection()

      this.CurrentSettingsDisplay(
        this.selectedIso,
        this.apertureValue.toFixed(1),
        this.shutterSpeeds[this.selectedSpeedIndex]
      )

      Column() {
        this.IsoSelector(this.selectedIso, (iso: string) => {
          this.selectedIso = iso;
        })

        this.ApertureControl(this.apertureValue, (val: number) => {
          this.apertureValue = val;
        })

        this.ShutterSpeedControl(
          this.shutterSpeeds,
          this.selectedSpeedIndex,
          (idx: number) => {
            this.selectedSpeedIndex = idx;
          }
        )
      }
      .margin({ top: 24, bottom: 24 })

      this.LogShotButton()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(Color.White)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text("LUMEN LOG")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)

        Text("Roll #034")
          .fontSize(24)
          .fontWeight(FontWeight.ExtraBold)
          .fontColor(Color.Black)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Row() {
        Image($r('sys.media.ohos_ic_public_arrow_left'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
          .margin({ right: 8 })

        Image($r('sys.media.ohos_ic_public_settings'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 16 })
  }

  @Builder
  CurrentSettingsDisplay(iso: string, aperture: string, shutter: string) {
    Row() {
      Column() {
        Text(`f/${aperture}`)
          .fontSize(56)
          .fontWeight(FontWeight.Light)
          .fontColor(Color.Black)

        Text("APERTURE")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .margin({ top: 4 })
      }
      .layoutWeight(1.5)
      .padding({ left: 24 })
      .justifyContent(FlexAlign.Center)
      .height('100%')

      Divider()
        .vertical(true)
        .width(1)
        .height(80)
        .color('#E0E0E0')

      Column() {
        this.SettingItemSmall("ISO", iso)
        this.SettingItemSmall("SHUTTER", shutter)
      }
      .layoutWeight(1)
      .padding({ left: 24 })
      .justifyContent(FlexAlign.SpaceEvenly)
      .height('100%')
    }
    .width('100%')
    .height(160)
    .backgroundColor('#F8F8F8')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
  }

  @Builder
  SettingItemSmall(label: string, value: string) {
    Column() {
      Text(value)
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color.Black)

      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)
        .margin({ top: 2 })
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  IsoSelector(currentIso: string, onIsoSelected: (iso: string) => void) {
    Column() {
      Text("Film Stock ISO")
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 12 })

      Scroll() {
        Row() {
          ForEach(this.isoValues, (iso: string) => {
            Text(iso)
              .fontSize(13)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(currentIso === iso ? Color.White : Color.Black)
              .width(60)
              .height(36)
              .textAlign(TextAlign.Center)
              .backgroundColor(currentIso === iso ? Color.Black : Color.Transparent)
              .borderRadius(18)
              .border({
                width: 1,
                color: currentIso === iso ? Color.Black : '#E0E0E0'
              })
              .onClick(() => {
                onIsoSelected(iso);
              })
          }, (iso: string) => iso)
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  ApertureControl(value: number, onValueChange: (val: number) => void) {
    Column() {
      Row() {
        Text("Aperture Control")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)

        Image($r('sys.media.ohos_ic_public_settings'))
          .width(16)
          .height(16)
          .fillColor(Color.Gray)
      }
      .width('100%')

      Slider({
        value: value,
        min: 1.4,
        max: 16,
        step: 0.1
      })
        .blockColor(Color.Black)
        .trackColor('#E0E0E0')
        .selectedColor(Color.Black)
        .onChange((val: number) => {
          onValueChange(val);
        })
        .margin({ top: 8, bottom: 4 })

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
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  ShutterSpeedControl(speeds: string[], selectedIndex: number, onSelect: (idx: number) => void) {
    Column() {
      Text("Shutter Speed")
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 12 })

      Row() {
        this.SpeedOption(
          selectedIndex > 0 ? speeds[selectedIndex - 1] : "-",
          false,
          () => {
            if (selectedIndex > 0) {
              onSelect(selectedIndex - 1);
            }
          }
        )

        this.SpeedOption(
          speeds[selectedIndex],
          true,
          () => {}
        )

        this.SpeedOption(
          selectedIndex < speeds.length - 1 ? speeds[selectedIndex + 1] : "-",
          false,
          () => {
            if (selectedIndex < speeds.length - 1) {
              onSelect(selectedIndex + 1);
            }
          }
        )
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  SpeedOption(text: string, isSelected: boolean, onClick: () => void) {
    Text(text)
      .fontSize(isSelected ? 22 : 16)
      .fontWeight(isSelected ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(isSelected ? Color.Black : Color.LightGray)
      .width(100)
      .height(50)
      .textAlign(TextAlign.Center)
      .backgroundColor(isSelected ? '#F0F0F0' : Color.Transparent)
      .borderRadius(12)
      .onClick(() => {
        if (!isSelected && text !== "-") {
          onClick();
        }
      })
  }

  @Builder
  LogShotButton() {
    Button() {
      Row() {
        Row() {
          Image($r('sys.media.ohos_ic_public_add'))
            .width(16)
            .height(16)
            .fillColor(Color.Black)
        }
        .width(24)
        .height(24)
        .backgroundColor(Color.White)
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)

        Text("LOG EXPOSURE")
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ left: 12 })
      }
      .height('100%')
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
