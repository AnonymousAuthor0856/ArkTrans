// Index.ets
@Entry
@Component
struct LumenAppScreen {
  @State selectedIso: string = "400";
  @State apertureValue: number = 2.8;
  @State selectedSpeedIndex: number = 4;

  private shutterSpeeds: string[] = ["1/1000", "1/500", "1/250", "1/125", "1/60", "1/30", "1/15", "1/8"];

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

      // 3. Controls
      Column({ space: 32 }) {
        // ISO Selector
        IsoSelector({
          currentIso: this.selectedIso,
          onIsoSelected: (iso: string) => {
            this.selectedIso = iso;
          }
        })

        // Aperture Slider
        ApertureControl({
          value: this.apertureValue,
          onValueChange: (val: number) => {
            this.apertureValue = val;
          }
        })

        // Shutter Speed Selector
        ShutterSpeedControl({
          speeds: this.shutterSpeeds,
          selectedIndex: this.selectedSpeedIndex,
          onSelect: (index: number) => {
            this.selectedSpeedIndex = index;
          }
        })
      }
      .margin({ top: 32 })

      // 4. Bottom Action
      LogShotButton()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

// --- Sub-Components ---

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text("LUMEN LOG")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .letterSpacing(2)
        Text("Roll #034")
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Row() {
        Image($r('sys.media.ohos_ic_public_more'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
          .margin({ right: 16 })

        Image($r('sys.media.ohos_ic_public_search'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
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
  private iso: string = "";
  private aperture: string = "";
  private shutter: string = "";

  build() {
    Row() {
      // Aperture (Main Focus)
      Column() {
        Text(`f/${this.aperture}`)
          .fontSize(56)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
          .letterSpacing(-2)
        Text("APERTURE")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .margin({ top: 4 })
      }
      .layoutWeight(1.5)
      .padding({ left: 24 })
      .justifyContent(FlexAlign.Center)

      Divider()
        .vertical(true)
        .height(80)
        .color(Color.Gray)

      // Details Column
      Column() {
        SettingItemSmall({ label: "ISO", value: this.iso })
        Blank().height(16)
        SettingItemSmall({ label: "SHUTTER", value: this.shutter })
      }
      .layoutWeight(1)
      .padding({ left: 24 })
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(160)
    .borderRadius(16)
    .backgroundColor('#F8F8F8')
    .border({ width: 1, color: '#EEEEEE' })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct SettingItemSmall {
  private label: string = "";
  private value: string = "";

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
        .margin({ top: 2 })
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct IsoSelector {
  private isoValues: string[] = ["100", "200", "400", "800", "1600", "3200"];
  private currentIso: string = "400";
  private onIsoSelected: (iso: string) => void = () => {};

  build() {
    Column() {
      Text("Film Stock ISO")
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 12 })

      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.isoValues, (iso: string) => {
            Text(iso)
              .width(60)
              .height(36)
              .borderRadius(50)
              .backgroundColor(this.currentIso === iso ? Color.Black : Color.Transparent)
              .border({
                width: 1,
                color: this.currentIso === iso ? Color.Black : '#E0E0E0'
              })
              .fontColor(this.currentIso === iso ? Color.White : Color.Black)
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .textAlign(TextAlign.Center)
              .onClick(() => {
                this.onIsoSelected(iso);
              })
          })
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
  private value: number = 2.8;
  private onValueChange: (val: number) => void = () => {};

  build() {
    Column() {
      Row() {
        Text("Aperture Control")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
        Image($r('sys.media.ohos_ic_public_search'))
          .width(16)
          .height(16)
          .fillColor(Color.Gray)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Slider({
        value: this.value,
        min: 1.4,
        max: 16,
        step: 0.7,
        style: SliderStyle.OutSet
      })
        .blockColor(Color.Black)
        .selectedColor(Color.Black)
        .trackColor('#E0E0E0')
        .onChange((val: number, mode: SliderChangeMode) => {
          this.onValueChange(val);
        })
        .margin({ top: 8, bottom: 8 })

      Row() {
        Text("f/1.4").fontSize(12).fontColor(Color.Gray)
        Text("f/16").fontSize(12).fontColor(Color.Gray)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ShutterSpeedControl {
  private speeds: string[] = [];
  private selectedIndex: number = 0;
  private onSelect: (index: number) => void = () => {};

  build() {
    Column() {
      Text("Shutter Speed")
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 12 })

      Row() {
        SpeedOption({
          text: this.selectedIndex > 0 ? this.speeds[this.selectedIndex - 1] : "-",
          isSelected: false,
          onAction: () => {
            if (this.selectedIndex > 0) {
              this.onSelect(this.selectedIndex - 1);
            }
          }
        })

        SpeedOption({
          text: this.speeds[this.selectedIndex] || "-",
          isSelected: true,
          onAction: () => {}
        })

        SpeedOption({
          text: this.selectedIndex < this.speeds.length - 1 ? this.speeds[this.selectedIndex + 1] : "-",
          isSelected: false,
          onAction: () => {
            if (this.selectedIndex < this.speeds.length - 1) {
              this.onSelect(this.selectedIndex + 1);
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
  private text: string = "";
  private isSelected: boolean = false;
  private onAction: () => void = () => {};

  build() {
    Text(this.text)
      .width(100)
      .height(50)
      .borderRadius(12)
      .backgroundColor(this.isSelected ? '#F0F0F0' : Color.Transparent)
      .fontSize(this.isSelected ? 22 : 16)
      .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.isSelected ? Color.Black : Color.Gray)
      .textAlign(TextAlign.Center)
      .onClick(() => {
        if (!this.isSelected && this.text !== "-") {
          this.onAction();
        }
      })
  }
}

@Component
struct LogShotButton {
  build() {
    Row() {
      Row() {
        Text("+")
          .fontSize(16)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
      }
      .width(24)
      .height(24)
      .borderRadius(12)
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Text("LOG EXPOSURE")
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .letterSpacing(1)
        .margin({ left: 12 })
    }
    .width('100%')
    .height(56)
    .borderRadius(12)
    .backgroundColor(Color.Black)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }
}