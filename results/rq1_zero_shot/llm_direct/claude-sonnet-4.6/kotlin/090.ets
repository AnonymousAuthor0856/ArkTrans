import { curves } from '@kit.ArkUI';

// --- Data & State ---
@Entry
@Component
struct LumenAppScreen {
  @State selectedIso: string = '400';
  @State apertureValue: number = 2.8;
  @State selectedSpeedIndex: number = 4;

  private shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8'];
  private isoValues: string[] = ['100', '200', '400', '800', '1600', '3200'];

  build() {
    Column() {
      // 1. Header
      this.HeaderSection()

      // 2. Main Display
      this.CurrentSettingsDisplay()

      // 3. Controls
      Column({ space: 32 }) {
        this.IsoSelector()
        this.ApertureControl()
        this.ShutterSpeedControl()
      }

      // 4. Bottom Action
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
        Text('LUMEN LOG')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
          .fontColor('#FF9E9E9E')

        Text('Roll #034')
          .fontSize(24)
          .fontWeight(FontWeight.ExtraBold)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Row() {
        Button({ type: ButtonType.Circle }) {
          Image($r('sys.media.ohos_ic_public_list_arrow'))
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.Transparent)

        Button({ type: ButtonType.Circle }) {
          Image($r('sys.media.ohos_ic_public_settings'))
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.Transparent)
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ bottom: 16 })
  }

  @Builder
  CurrentSettingsDisplay() {
    Row() {
      // Aperture (Main Focus)
      Column() {
        Text(`f/${this.apertureValue.toFixed(1)}`)
          .fontSize(56)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
          .letterSpacing(-2)

        Text('APERTURE')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF9E9E9E')
      }
      .layoutWeight(1.5)
      .padding({ left: 24 })
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)

      Divider()
        .vertical(true)
        .height(80)
        .color('#FFCCCCCC')
        .strokeWidth(1)

      // Details Column
      Column({ space: 16 }) {
        this.SettingItemSmall('ISO', this.selectedIso)
        this.SettingItemSmall('SHUTTER', this.shutterSpeeds[this.selectedSpeedIndex])
      }
      .layoutWeight(1)
      .padding({ left: 24 })
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(160)
    .borderRadius(16)
    .backgroundColor('#FFF8F8F8')
    .border({ width: 1, color: '#FFEEEEEE', radius: 16 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SettingItemSmall(label: string, value: string) {
    Column() {
      Text(value)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)

      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF9E9E9E')
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  IsoSelector() {
    Column() {
      Text('Film Stock ISO')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 12 })

      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.isoValues, (iso: string) => {
            this.IsoChip(iso)
          })
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  @Builder
  IsoChip(iso: string) {
    Text(iso)
      .fontSize(13)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selectedIso === iso ? Color.White : Color.Black)
      .width(60)
      .height(36)
      .textAlign(TextAlign.Center)
      .borderRadius(50)
      .backgroundColor(this.selectedIso === iso ? Color.Black : Color.Transparent)
      .border({
        width: 1,
        color: this.selectedIso === iso ? Color.Black : '#FFE0E0E0',
        radius: 50
      })
      .onClick(() => {
        this.selectedIso = iso;
      })
  }

  @Builder
  ApertureControl() {
    Column() {
      Row() {
        Text('Aperture Control')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)

        Image($r('sys.media.ohos_ic_public_settings'))
          .width(16)
          .height(16)
          .fillColor('#FF9E9E9E')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Slider({
        value: this.apertureValue,
        min: 1.4,
        max: 16,
        step: 0.5,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .trackColor('#FFE0E0E0')
        .selectedColor(Color.Black)
        .blockColor(Color.Black)
        .margin({ top: 8 })
        .onChange((value: number) => {
          this.apertureValue = Math.round(value * 10) / 10;
        })

      Row() {
        Text('f/1.4')
          .fontSize(12)
          .fontColor('#FF9E9E9E')

        Text('f/16')
          .fontSize(12)
          .fontColor('#FF9E9E9E')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  ShutterSpeedControl() {
    Column() {
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 12 })

      Row() {
        this.SpeedOption(
          this.selectedSpeedIndex > 0 ? this.shutterSpeeds[this.selectedSpeedIndex - 1] : '-',
          false,
          () => {
            if (this.selectedSpeedIndex > 0) {
              this.selectedSpeedIndex -= 1;
            }
          }
        )

        this.SpeedOption(
          this.shutterSpeeds[this.selectedSpeedIndex],
          true,
          () => {}
        )

        this.SpeedOption(
          this.selectedSpeedIndex < this.shutterSpeeds.length - 1
            ? this.shutterSpeeds[this.selectedSpeedIndex + 1]
            : '-',
          false,
          () => {
            if (this.selectedSpeedIndex < this.shutterSpeeds.length - 1) {
              this.selectedSpeedIndex += 1;
            }
          }
        )
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  @Builder
  SpeedOption(text: string, isSelected: boolean, onClick: () => void) {
    Text(text)
      .fontSize(isSelected ? 22 : 16)
      .fontWeight(isSelected ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(isSelected ? Color.Black : '#FFCCCCCC')
      .width(100)
      .height(50)
      .textAlign(TextAlign.Center)
      .borderRadius(12)
      .backgroundColor(isSelected ? '#FFF0F0F0' : Color.Transparent)
      .onClick(() => {
        if (!isSelected && text !== '-') {
          onClick();
        }
      })
  }

  @Builder
  LogShotButton() {
    Button() {
      Row({ space: 12 }) {
        Stack() {
          Circle()
            .width(24)
            .height(24)
            .fill(Color.White)

          Text('+')
            .fontSize(18)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
        }

        Text('LOG EXPOSURE')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .letterSpacing(1)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(56)
    .backgroundColor(Color.Black)
    .borderRadius(12)
    .type(ButtonType.Normal)
  }
}