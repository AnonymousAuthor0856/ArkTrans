import { curves } from '@kit.ArkUI';

@Entry
@Component
struct LumenAppScreen {
  @State selectedIso: string = '400';
  @State apertureValue: number = 2.8;
  @State selectedSpeedIndex: number = 4;
  shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8'];

  build() {
    Column() {
      // 1. Header
      HeaderSection()

      // 2. Main Display
      CurrentSettingsDisplay({
        iso: this.selectedIso,
        aperture: this.apertureValue.toFixed(1),
        shutter: this.shutterSpeeds[this.selectedSpeedIndex]
      })

      // 3. Controls
      Column({ space: 32 }) {
        IsoSelector({
          currentIso: this.selectedIso,
          onIsoSelected: (iso: string) => {
            this.selectedIso = iso;
          }
        })

        ApertureControl({
          value: this.apertureValue,
          onValueChange: (v: number) => {
            this.apertureValue = v;
          }
        })

        ShutterSpeedControl({
          speeds: this.shutterSpeeds,
          selectedIndex: this.selectedSpeedIndex,
          onSelect: (idx: number) => {
            this.selectedSpeedIndex = idx;
          }
        })
      }

      // 4. Bottom Action
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
      .alignItems(HorizontalAlign.Start)

      Row() {
        Text('≡')
          .fontSize(24)
          .fontColor(Color.Black)
          .padding(8)
        Text('⚙')
          .fontSize(22)
          .fontColor(Color.Black)
          .padding(8)
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ bottom: 16 })
  }
}

@Component
struct CurrentSettingsDisplay {
  @Prop iso: string = '400';
  @Prop aperture: string = '2.8';
  @Prop shutter: string = '1/60';

  build() {
    Row() {
      // Aperture (Main Focus)
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
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)

      Divider()
        .vertical(true)
        .height(80)
        .color(Color.Gray)
        .strokeWidth(1)

      // Details Column
      Column() {
        SettingItemSmall({ label: 'ISO', value: this.iso })
        Blank().height(16)
        SettingItemSmall({ label: 'SHUTTER', value: this.shutter })
      }
      .layoutWeight(1)
      .padding({ left: 24 })
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(160)
    .backgroundColor(0xFFF8F8F8)
    .borderRadius(16)
    .border({ width: 1, color: 0xFFEEEEEE })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct SettingItemSmall {
  @Prop label: string = '';
  @Prop value: string = '';

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
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct IsoSelector {
  @Prop currentIso: string = '400';
  onIsoSelected: (iso: string) => void = () => {};
  isoValues: string[] = ['100', '200', '400', '800', '1600', '3200'];

  build() {
    Column() {
      Text('Film Stock ISO')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .padding({ bottom: 12 })

      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.isoValues, (iso: string) => {
            IsoChip({
              iso: iso,
              isSelected: this.currentIso === iso,
              onTap: () => {
                this.onIsoSelected(iso);
              }
            })
          })
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct IsoChip {
  @Prop iso: string = '';
  @Prop isSelected: boolean = false;
  onTap: () => void = () => {};

  build() {
    Text(this.iso)
      .fontSize(13)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? Color.White : Color.Black)
      .width(60)
      .height(36)
      .textAlign(TextAlign.Center)
      .backgroundColor(this.isSelected ? Color.Black : Color.Transparent)
      .borderRadius(50)
      .border({ width: 1, color: this.isSelected ? Color.Black : 0xFFE0E0E0 })
      .onClick(() => {
        this.onTap();
      })
  }
}

@Component
struct ApertureControl {
  @Prop value: number = 2.8;
  onValueChange: (v: number) => void = () => {};

  build() {
    Column() {
      Row() {
        Text('Aperture Control')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
        Text('⚙')
          .fontSize(16)
          .fontColor(Color.Gray)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Blank().height(8)

      Slider({
        value: this.value,
        min: 1.4,
        max: 16,
        step: 0.5,
        style: SliderStyle.OutSet
      })
        .trackColor(0xFFE0E0E0)
        .selectedColor(Color.Black)
        .blockColor(Color.Black)
        .width('100%')
        .onChange((value: number) => {
          this.onValueChange(value);
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
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ShutterSpeedControl {
  @Prop speeds: string[] = [];
  @Prop selectedIndex: number = 4;
  onSelect: (idx: number) => void = () => {};

  build() {
    Column() {
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .padding({ bottom: 12 })

      Row() {
        SpeedOptionItem({
          text: this.selectedIndex > 0 ? this.speeds[this.selectedIndex - 1] : '-',
          isSelected: false,
          onTap: () => {
            if (this.selectedIndex > 0) {
              this.onSelect(this.selectedIndex - 1);
            }
          }
        })

        SpeedOptionItem({
          text: this.speeds[this.selectedIndex],
          isSelected: true,
          onTap: () => {}
        })

        SpeedOptionItem({
          text: this.selectedIndex < this.speeds.length - 1 ? this.speeds[this.selectedIndex + 1] : '-',
          isSelected: false,
          onTap: () => {
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
    .width('100%')
  }
}

@Component
struct SpeedOptionItem {
  @Prop text: string = '';
  @Prop isSelected: boolean = false;
  onTap: () => void = () => {};

  build() {
    Text(this.text)
      .fontSize(this.isSelected ? 22 : 16)
      .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.isSelected ? Color.Black : Color.Gray)
      .width(100)
      .height(50)
      .textAlign(TextAlign.Center)
      .backgroundColor(this.isSelected ? 0xFFF0F0F0 : Color.Transparent)
      .borderRadius(12)
      .onClick(() => {
        if (!this.isSelected && this.text !== '-') {
          this.onTap();
        }
      })
  }
}

@Component
struct LogShotButton {
  build() {
    Row() {
      Text('+')
        .fontSize(16)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Bold)
        .width(24)
        .height(24)
        .textAlign(TextAlign.Center)
        .backgroundColor(Color.White)
        .borderRadius(12)

      Blank().width(12)

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
  }
}