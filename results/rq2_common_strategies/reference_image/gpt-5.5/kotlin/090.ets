@Entry
@Component
struct Index {
  @State private selectedIso: string = '400'
  @State private apertureValue: number = 2.8
  @State private selectedSpeedIndex: number = 4

  private readonly shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8']
  private readonly isoValues: string[] = ['100', '200', '400', '800', '1600', '3200']

  build() {
    Column() {
      this.HeaderSection()

      this.CurrentSettingsDisplay(
        this.selectedIso,
        this.apertureValue.toFixed(1),
        this.shutterSpeeds[this.selectedSpeedIndex]
      )

      Column({ space: 32 }) {
        this.IsoSelector()
        this.ApertureControl()
        this.ShutterSpeedControl()
      }
      .width('100%')

      this.LogShotButton()
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24, top: 56, bottom: 24 })
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  private HeaderSection() {
    Row() {
      Column() {
        Text('LUMEN LOG')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#888888')
          .letterSpacing(2)

        Text('Roll #034')
          .fontSize(34)
          .fontWeight(FontWeight.Bolder)
          .fontColor(Color.Black)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Start)

      Row({ space: 28 }) {
        Text('☰')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .width(44)
          .height(44)
          .textAlign(TextAlign.Center)
          .onClick(() => {
          })

        Text('⚙')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .width(44)
          .height(44)
          .textAlign(TextAlign.Center)
          .onClick(() => {
          })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 16 })
  }

  @Builder
  private CurrentSettingsDisplay(iso: string, aperture: string, shutter: string) {
    Row() {
      Column() {
        Text(`f/${aperture}`)
          .fontSize(76)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
          .letterSpacing(-2)

        Text('APERTURE')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#888888')
          .margin({ top: 8 })
      }
      .layoutWeight(1.5)
      .height('100%')
      .padding({ left: 24 })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Start)

      Blank()
        .width(1)
        .height(80)
        .backgroundColor('#D3D3D3')

      Column() {
        this.SettingItemSmall('ISO', iso)

        Blank()
          .height(24)

        this.SettingItemSmall('SHUTTER', shutter)
      }
      .layoutWeight(1)
      .height('100%')
      .padding({ left: 24 })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(160)
    .backgroundColor('#F8F8F8')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  private SettingItemSmall(label: string, value: string) {
    Column() {
      Text(value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Text(label)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor('#888888')
        .margin({ top: 6 })
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private IsoSelector() {
    Column() {
      Text('Film Stock ISO')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor('#202124')
        .margin({ bottom: 28 })

      Scroll() {
        Row({ space: 24 }) {
          ForEach(this.isoValues, (iso: string) => {
            Stack() {
              Text(iso)
                .fontSize(18)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(this.selectedIso === iso ? Color.White : Color.Black)
            }
            .width(120)
            .height(70)
            .backgroundColor(this.selectedIso === iso ? Color.Black : Color.Transparent)
            .borderRadius(35)
            .border({
              width: 1,
              color: this.selectedIso === iso ? Color.Black : '#E0E0E0'
            })
            .onClick(() => {
              this.selectedIso = iso
            })
          }, (iso: string) => iso)
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private ApertureControl() {
    Column() {
      Row() {
        Text('Aperture Control')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#202124')

        Text('⚙')
          .fontSize(24)
          .fontColor('#888888')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank()
        .height(18)

      Slider({
        value: this.apertureValue,
        min: 1.4,
        max: 16,
        step: 0.1,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .height(48)
        .blockColor(Color.Black)
        .trackColor('#E0E0E0')
        .selectedColor(Color.Black)
        .showSteps(true)
        .showTips(false)
        .onChange((value: number) => {
          this.apertureValue = value
        })

      Row() {
        Text('f/1.4')
          .fontSize(18)
          .fontColor('#888888')

        Text('f/16')
          .fontSize(18)
          .fontColor('#888888')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private ShutterSpeedControl() {
    Column() {
      Text('Shutter Speed')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor('#202124')
        .margin({ bottom: 24 })

      Row() {
        this.SpeedOption(
          this.selectedSpeedIndex > 0 ? this.shutterSpeeds[this.selectedSpeedIndex - 1] : '-',
          false,
          this.selectedSpeedIndex - 1
        )

        this.SpeedOption(
          this.shutterSpeeds[this.selectedSpeedIndex],
          true,
          this.selectedSpeedIndex
        )

        this.SpeedOption(
          this.selectedSpeedIndex < this.shutterSpeeds.length - 1 ? this.shutterSpeeds[this.selectedSpeedIndex + 1] : '-',
          false,
          this.selectedSpeedIndex + 1
        )
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private SpeedOption(text: string, isSelected: boolean, targetIndex: number) {
    Stack() {
      Text(text)
        .fontSize(isSelected ? 34 : 26)
        .fontWeight(isSelected ? FontWeight.Bold : FontWeight.Regular)
        .fontColor(isSelected ? Color.Black : '#D0D0D0')
    }
    .width(140)
    .height(82)
    .backgroundColor(isSelected ? '#F0F0F0' : Color.Transparent)
    .borderRadius(18)
    .onClick(() => {
      if (!isSelected && text !== '-' && targetIndex >= 0 && targetIndex < this.shutterSpeeds.length) {
        this.selectedSpeedIndex = targetIndex
      }
    })
  }

  @Builder
  private LogShotButton() {
    Button({ type: ButtonType.Normal, stateEffect: true }) {
      Row({ space: 16 }) {
        Stack() {
          Text('+')
            .fontSize(30)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
            .textAlign(TextAlign.Center)
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.White)
        .borderRadius(20)

        Text('LOG EXPOSURE')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .letterSpacing(1)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(74)
    .backgroundColor(Color.Black)
    .borderRadius(18)
    .onClick(() => {
    })
  }
}