import { window } from '@kit.ArkUI';

@Entry
@Component
struct LumenAppScreen {
  @State private selectedIso: string = '400';
  @State private apertureValue: number = 2.8;
  @State private selectedSpeedIndex: number = 4;

  private shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8'];

  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    });
  }

  build() {
    Column() {
      HeaderSection()
        .margin({ bottom: 16 })

      CurrentSettingsDisplay({
        iso: this.selectedIso,
        aperture: this.apertureValue.toFixed(1),
        shutter: this.shutterSpeeds[this.selectedSpeedIndex]
      })

      Column({ space: 32 }) {
        IsoSelector({
          currentIso: this.selectedIso,
          onIsoSelected: (iso: string) => {
            this.selectedIso = iso;
          }
        })

        ApertureControl({
          value: $apertureValue
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
      .margin({ top: 16 })

      Blank()
        .layoutWeight(1)

      LogShotButton()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Start)
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
          .fontColor('#8E8E93')
          .letterSpacing(2)

        Text('Roll #034')
          .fontSize(24)
          .fontWeight('900')
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Row() {
        Button({ type: ButtonType.Normal, stateEffect: false }) {
          MenuIcon()
        }
        .width(44)
        .height(44)
        .padding(0)
        .backgroundColor(Color.Transparent)

        Button({ type: ButtonType.Normal, stateEffect: false }) {
          Text('⚙')
            .fontSize(34)
            .fontColor(Color.Black)
            .textAlign(TextAlign.Center)
        }
        .width(44)
        .height(44)
        .padding(0)
        .backgroundColor(Color.Transparent)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MenuIcon {
  build() {
    Column({ space: 5 }) {
      Blank()
        .width(28)
        .height(3)
        .borderRadius(2)
        .backgroundColor(Color.Black)

      Blank()
        .width(28)
        .height(3)
        .borderRadius(2)
        .backgroundColor(Color.Black)

      Blank()
        .width(28)
        .height(3)
        .borderRadius(2)
        .backgroundColor(Color.Black)
    }
    .width(44)
    .height(44)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct CurrentSettingsDisplay {
  @Prop iso: string = '';
  @Prop aperture: string = '';
  @Prop shutter: string = '';

  build() {
    Row() {
      Column() {
        Text('f/' + this.aperture)
          .fontSize(56)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
          .letterSpacing(-2)

        Text('APERTURE')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#8E8E93')
      }
      .height('100%')
      .layoutWeight(1.5)
      .padding({ left: 24 })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Start)

      Blank()
        .width(1)
        .height(80)
        .backgroundColor('#E0E0E0')

      Column() {
        SettingItemSmall({
          label: 'ISO',
          value: this.iso
        })

        Blank()
          .height(16)

        SettingItemSmall({
          label: 'SHUTTER',
          value: this.shutter
        })
      }
      .height('100%')
      .layoutWeight(1)
      .padding({ left: 24 })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(160)
    .backgroundColor('#F8F8F8')
    .border({
      width: 1,
      color: '#EEEEEE',
      radius: 16
    })
    .clip(true)
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
        .fontColor('#8E8E93')
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct IsoSelector {
  @Prop currentIso: string = '';
  private isoValues: string[] = ['100', '200', '400', '800', '1600', '3200'];
  onIsoSelected: (iso: string) => void = () => {
  };

  build() {
    Column() {
      Text('Film Stock ISO')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ bottom: 12 })

      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.isoValues, (iso: string) => {
            IsoItem({
              iso: iso,
              selected: this.currentIso === iso,
              onClick: () => {
                this.onIsoSelected(iso);
              }
            })
          }, (iso: string) => iso)
        }
        .height(48)
      }
      .width('100%')
      .height(48)
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct IsoItem {
  @Prop iso: string = '';
  @Prop selected: boolean = false;
  onClick: () => void = () => {
  };

  build() {
    Text(this.iso)
      .fontSize(13)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selected ? Color.White : Color.Black)
      .textAlign(TextAlign.Center)
      .width(60)
      .height(36)
      .backgroundColor(this.selected ? Color.Black : Color.Transparent)
      .borderRadius(50)
      .border({
        width: 1,
        color: this.selected ? Color.Black : '#E0E0E0',
        radius: 50
      })
      .onClick(() => {
        this.onClick();
      })
  }
}

@Component
struct ApertureControl {
  @Link value: number;

  private sliderStep: number = (16.0 - 1.4) / 20.0;

  build() {
    Column() {
      Row() {
        Text('Aperture Control')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)

        Blank()
          .layoutWeight(1)

        Text('⚙')
          .fontSize(22)
          .fontColor('#8E8E93')
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Slider({
        value: this.value,
        min: 1.4,
        max: 16.0,
        step: this.sliderStep,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .height(38)
        .margin({ top: 8 })
        .blockColor(Color.Black)
        .trackColor('#E0E0E0')
        .selectedColor(Color.Black)
        .showSteps(false)
        .showTips(false)
        .onChange((value: number) => {
          this.value = value;
        })

      Row() {
        Text('f/1.4')
          .fontSize(12)
          .fontColor('#8E8E93')

        Blank()
          .layoutWeight(1)

        Text('f/16')
          .fontSize(12)
          .fontColor('#8E8E93')
      }
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ShutterSpeedControl {
  @Prop speeds: string[] = [];
  @Prop selectedIndex: number = 0;
  onSelect: (index: number) => void = () => {
  };

  private previousSpeed(): string {
    if (this.selectedIndex > 0 && this.selectedIndex - 1 < this.speeds.length) {
      return this.speeds[this.selectedIndex - 1];
    }
    return '-';
  }

  private currentSpeed(): string {
    if (this.selectedIndex >= 0 && this.selectedIndex < this.speeds.length) {
      return this.speeds[this.selectedIndex];
    }
    return '-';
  }

  private nextSpeed(): string {
    if (this.selectedIndex + 1 < this.speeds.length) {
      return this.speeds[this.selectedIndex + 1];
    }
    return '-';
  }

  build() {
    Column() {
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ bottom: 12 })

      Row() {
        SpeedOption({
          text: this.previousSpeed(),
          isSelected: false,
          onSelect: () => {
            if (this.selectedIndex > 0) {
              this.onSelect(this.selectedIndex - 1);
            }
          }
        })

        SpeedOption({
          text: this.currentSpeed(),
          isSelected: true,
          onSelect: () => {
          }
        })

        SpeedOption({
          text: this.nextSpeed(),
          isSelected: false,
          onSelect: () => {
            if (this.selectedIndex < this.speeds.length - 1) {
              this.onSelect(this.selectedIndex + 1);
            }
          }
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SpeedOption {
  @Prop text: string = '';
  @Prop isSelected: boolean = false;
  onSelect: () => void = () => {
  };

  build() {
    Text(this.text)
      .fontSize(this.isSelected ? 22 : 16)
      .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Regular)
      .fontColor(this.isSelected ? Color.Black : '#E0E0E0')
      .textAlign(TextAlign.Center)
      .width(100)
      .height(50)
      .backgroundColor(this.isSelected ? '#F0F0F0' : Color.Transparent)
      .borderRadius(12)
      .onClick(() => {
        if (!this.isSelected && this.text !== '-') {
          this.onSelect();
        }
      })
  }
}

@Component
struct LogShotButton {
  build() {
    Button({ type: ButtonType.Normal, stateEffect: false }) {
      Row({ space: 12 }) {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(24)
            .height(24)
            .fill(Color.White)

          Text('+')
            .fontSize(28)
            .fontWeight(FontWeight.Regular)
            .fontColor(Color.Black)
            .translate({ y: -1 })
        }
        .width(24)
        .height(24)

        Text('LOG EXPOSURE')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .letterSpacing(1)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(56)
    .padding(0)
    .backgroundColor(Color.Black)
    .borderRadius(12)
  }
}