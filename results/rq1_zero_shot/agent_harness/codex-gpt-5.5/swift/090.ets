@Entry
@Component
struct LumenAppScreen {
  @State private selectedIso: string = '400';
  @State private apertureValue: number = 2.8;
  @State private selectedSpeedIndex: number = 4;
  private shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8'];

  @Builder
  private HeaderSection() {
    Row() {
      Column({ space: 0 }) {
        Text('LUMEN LOG')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')
        Text('Roll #034')
          .fontSize(24)
          .fontWeight(FontWeight.Bolder)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      Row({ space: 0 }) {
        Button('☰')
          .width(44)
          .height(44)
          .fontSize(22)
          .fontColor(Color.Black)
          .backgroundColor(Color.Transparent)
        Button('⚙')
          .width(44)
          .height(44)
          .fontSize(22)
          .fontColor(Color.Black)
          .backgroundColor(Color.Transparent)
      }
    }
    .width('100%')
  }

  @Builder
  private SettingItemSmall(label: string, value: string) {
    Column({ space: 0 }) {
      Text(value)
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color.Black)
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#808080')
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private CurrentSettingsDisplay() {
    Row({ space: 0 }) {
      Column({ space: 0 }) {
        Text(`f/${this.apertureValue.toFixed(1)}`)
          .fontSize(56)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
        Text('APERTURE')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')
      }
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 24 })
      .layoutWeight(1.5)

      Divider()
        .vertical(true)
        .height(80)
        .width(1)
        .color('#E0E0E0')

      Column({ space: 16 }) {
        this.SettingItemSmall('ISO', this.selectedIso)
        this.SettingItemSmall('SHUTTER', this.shutterSpeeds[this.selectedSpeedIndex])
      }
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 24 })
      .layoutWeight(1)
    }
    .height(160)
    .width('100%')
    .backgroundColor('#F8F8F8')
    .border({ width: 1, color: '#EEEEEE' })
    .borderRadius(16)
  }

  @Builder
  private IsoSelector() {
    Column({ space: 0 }) {
      Text('Film Stock ISO')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .padding({ bottom: 12 })
        .width('100%')
        .textAlign(TextAlign.Start)
      Scroll() {
        Row({ space: 12 }) {
          ForEach(['100', '200', '400', '800', '1600', '3200'], (iso: string) => {
            Text(iso)
              .fontSize(13)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(this.selectedIso === iso ? Color.White : Color.Black)
              .width(60)
              .height(36)
              .textAlign(TextAlign.Center)
              .backgroundColor(this.selectedIso === iso ? Color.Black : Color.Transparent)
              .border({ width: 1, color: this.selectedIso === iso ? Color.Black : '#E0E0E0' })
              .borderRadius(18)
              .onClick(() => {
                this.selectedIso = iso;
              })
          })
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .width('100%')
  }

  @Builder
  private ApertureControl() {
    Column({ space: 0 }) {
      Row() {
        Text('Aperture Control')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
        Blank()
        Text('⚙')
          .fontSize(16)
          .fontColor('#808080')
      }
      .width('100%')
      Blank().height(8)
      Slider({ value: this.apertureValue, min: 1.4, max: 16, step: (16 - 1.4) / 20 })
        .selectedColor(Color.Black)
        .trackColor('#E0E0E0')
        .onChange((value: number) => {
          this.apertureValue = value;
        })
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
    .width('100%')
  }

  @Builder
  private SpeedOption(text: string, isSelected: boolean, delta: number) {
    Text(text)
      .fontSize(isSelected ? 22 : 16)
      .fontWeight(isSelected ? FontWeight.Bold : FontWeight.Regular)
      .fontColor(isSelected ? Color.Black : '#E0E0E0')
      .width(100)
      .height(50)
      .textAlign(TextAlign.Center)
      .backgroundColor(isSelected ? '#F0F0F0' : Color.Transparent)
      .borderRadius(12)
      .onClick(() => {
        if (!isSelected && text !== '-') {
          this.selectedSpeedIndex += delta;
        }
      })
  }

  @Builder
  private ShutterSpeedControl() {
    Column({ space: 0 }) {
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .padding({ bottom: 12 })
        .width('100%')
        .textAlign(TextAlign.Start)
      Row({ space: 12 }) {
        this.SpeedOption(this.selectedSpeedIndex > 0 ? this.shutterSpeeds[this.selectedSpeedIndex - 1] : '-', false, -1)
        this.SpeedOption(this.shutterSpeeds[this.selectedSpeedIndex], true, 0)
        this.SpeedOption(this.selectedSpeedIndex < this.shutterSpeeds.length - 1 ? this.shutterSpeeds[this.selectedSpeedIndex + 1] : '-', false, 1)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
  }

  @Builder
  private LogShotButton() {
    Button('＋  LOG EXPOSURE')
      .height(56)
      .width('100%')
      .fontSize(16)
      .fontWeight(FontWeight.Bold)
      .fontColor(Color.White)
      .backgroundColor(Color.Black)
      .borderRadius(12)
  }

  build() {
    Column({ space: 0 }) {
      this.HeaderSection()
        .padding({ bottom: 16 })
      this.CurrentSettingsDisplay()
      Blank()
      Column({ space: 32 }) {
        this.IsoSelector()
        this.ApertureControl()
        this.ShutterSpeedControl()
      }
      .width('100%')
      Blank()
      this.LogShotButton()
    }
    .padding(24)
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
