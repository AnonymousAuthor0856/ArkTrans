@Entry
@Component
struct LumenAppScreen {
  @State selectedIso: string = '400';
  @State apertureValue: number = 2.8;
  @State selectedSpeedIndex: number = 4;

  shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8'];

  build() {
    Stack() {
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
              this.selectedIso = iso;
            }
          })

          ApertureControl({
            value: this.apertureValue,
            onChange: (v: number) => {
              this.apertureValue = v;
            }
          })

          ShutterSpeedControl({
            speeds: this.shutterSpeeds,
            selectedIndex: this.selectedSpeedIndex,
            onSelect: (index: number) => {
              this.selectedSpeedIndex = index;
            }
          })
        }
        .width('100%')

        Blank()
          .layoutWeight(1)

        LogShotButton()
      }
      .padding(24)
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
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
          .fontColor('#999999')
          .letterSpacing(2)

        Text('Roll #034')
          .fontSize(24)
          .fontWeight(FontWeight.Bolder)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Row() {
        Button({ type: ButtonType.Normal }) {
          Text('≡')
            .fontSize(22)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
        }
        .width(44)
        .height(44)
        .backgroundColor(Color.Transparent)
        .borderRadius(0)

        Button({ type: ButtonType.Normal }) {
          Text('⚙')
            .fontSize(22)
            .fontColor(Color.Black)
        }
        .width(44)
        .height(44)
        .backgroundColor(Color.Transparent)
        .borderRadius(0)
      }
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct CurrentSettingsDisplay {
  @Prop iso: string = '400';
  @Prop aperture: string = '2.8';
  @Prop shutter: string = '1/60';

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
      .padding({ left: 24 })
      .layoutWeight(1.5)
      .height('100%')

      Divider()
        .vertical(true)
        .height(80)
        .color('#E0E0E0')
        .strokeWidth(1)

      Column() {
        SettingItemSmall({ label: 'ISO', value: this.iso })
        Blank().height(16)
        SettingItemSmall({ label: 'SHUTTER', value: this.shutter })
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
      .padding({ left: 24 })
      .layoutWeight(1)
      .height('100%')
    }
    .width('100%')
    .height(160)
    .backgroundColor('#F8F8F8')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
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
        .fontColor('#999999')
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct IsoSelector {
  isoValues: string[] = ['100', '200', '400', '800', '1600', '3200'];
  @Prop currentIso: string = '400';
  onIsoSelected: (iso: string) => void = () => {};

  build() {
    Column() {
      Text('Film Stock ISO')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 12 })

      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.isoValues, (iso: string) => {
            Text(iso)
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.currentIso === iso ? Color.White : Color.Black)
              .width(60)
              .height(36)
              .textAlign(TextAlign.Center)
              .backgroundColor(this.currentIso === iso ? Color.Black : Color.Transparent)
              .borderRadius(50)
              .border({
                width: 1,
                color: this.currentIso === iso ? Color.Black : '#E0E0E0'
              })
              .onClick(() => {
                this.onIsoSelected(iso);
              })
          }, (iso: string) => iso)
        }
        .padding({ left: 2, right: 2 })
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
  @Prop value: number = 2.8;
  onChange: (v: number) => void = () => {};

  build() {
    Column() {
      Row() {
        Text('Aperture Control')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)

        Blank().layoutWeight(1)

        Text('⚙')
          .fontSize(16)
          .fontColor('#999999')
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Blank().height(8)

      Slider({
        value: this.value,
        min: 1.4,
        max: 16.0,
        step: (16.0 - 1.4) / 20.0,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .trackColor('#E0E0E0')
        .selectedColor(Color.Black)
        .blockColor(Color.Black)
        .trackThickness(2)
        .onChange((value: number) => {
          this.onChange(value);
        })

      Row() {
        Text('f/1.4')
          .fontSize(12)
          .fontColor('#999999')

        Blank().layoutWeight(1)

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
  @Prop speeds: string[] = [];
  @Prop selectedIndex: number = 0;
  onSelect: (index: number) => void = () => {};

  build() {
    Column() {
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 12 })

      Row({ space: 12 }) {
        SpeedOption({
          text: this.selectedIndex > 0 ? this.speeds[this.selectedIndex - 1] : '-',
          isSelected: false,
          onItemClick: () => {
            if (this.selectedIndex > 0) {
              this.onSelect(this.selectedIndex - 1);
            }
          }
        })

        SpeedOption({
          text: this.speeds[this.selectedIndex],
          isSelected: true,
          onItemClick: () => {}
        })

        SpeedOption({
          text: this.selectedIndex < this.speeds.length - 1 ? this.speeds[this.selectedIndex + 1] : '-',
          isSelected: false,
          onItemClick: () => {
            if (this.selectedIndex < this.speeds.length - 1) {
              this.onSelect(this.selectedIndex + 1);
            }
          }
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct SpeedOption {
  @Prop text: string = '';
  @Prop isSelected: boolean = false;
  onItemClick: () => void = () => {};

  build() {
    Text(this.text)
      .fontSize(this.isSelected ? 22 : 16)
      .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.isSelected ? Color.Black : '#E0E0E0')
      .width(100)
      .height(50)
      .textAlign(TextAlign.Center)
      .backgroundColor(this.isSelected ? '#F0F0F0' : Color.Transparent)
      .borderRadius(12)
      .onClick(() => {
        if (!this.isSelected && this.text !== '-') {
          this.onItemClick();
        }
      })
  }
}

@Component
struct LogShotButton {
  build() {
    Button({ type: ButtonType.Normal }) {
      Row({ space: 12 }) {
        Stack() {
          Circle()
            .width(24)
            .height(24)
            .fill(Color.White)

          Text('+')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }

        Text('LOG EXPOSURE')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .letterSpacing(1)
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height(56)
    .backgroundColor(Color.Black)
    .borderRadius(12)
  }
}