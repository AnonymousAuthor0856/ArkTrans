// Index.ets
import { Length, ResourceStr } from '@ohos.arkui.arkui.full';

@Extend(Text)
function customText(color: ResourceColor, fontSize: number, weight: number | string) {
  .fontColor(color)
  .fontSize(fontSize)
  .fontWeight(weight)
}

@Component
export struct LumenApp {
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
        // ISO Selector
        this.IsoSelector()

        // Aperture Slider
        this.ApertureControl()

        // Shutter Speed Selector
        this.ShutterSpeedControl()
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      // 4. Bottom Action
      this.LogShotButton()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('LUMEN LOG')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .letterSpacing(2)
        Text('Roll #034')
          .fontSize(24)
          .fontWeight(FontWeight.Bolder)
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

        Image($r('sys.media.ohos_ic_public_settings'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
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
          .fontColor(Color.Gray)
          .margin({ top: 4 })
      }
      .layoutWeight(1.5)
      .alignItems(HorizontalAlign.Start)

      Divider()
        .vertical(true)
        .height(80)
        .color(Color.LightGray)
        .margin({ left: 12, right: 12 })

      // Details Column
      Column() {
        this.SettingItemSmall('ISO', this.selectedIso)
        Blank().height(16)
        this.SettingItemSmall('SHUTTER', this.shutterSpeeds[this.selectedSpeedIndex])
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(160)
    .padding(24)
    .borderRadius(16)
    .backgroundColor('#F8F8F8')
    .border({ width: 1, color: '#EEEEEE', radius: 16 })
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
        .fontColor(Color.Gray)
        .margin({ top: 2 })
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  IsoSelector() {
    Column() {
      Text('Film Stock ISO')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ bottom: 12 })

      // Horizontal Scroller for ISO values
      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.isoValues, (iso: string) => {
            Text(iso)
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedIso === iso ? Color.White : Color.Black)
              .textAlign(TextAlign.Center)
              .width(60)
              .height(36)
              .borderRadius(50)
              .backgroundColor(this.selectedIso === iso ? Color.Black : Color.Transparent)
              .border({
                width: 1,
                color: this.selectedIso === iso ? Color.Black : '#E0E0E0',
                radius: 50
              })
              .onClick(() => {
                this.selectedIso = iso;
              })
          }, (iso: string) => iso)
        }
        .padding(2)
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  ApertureControl() {
    Column() {
      Row() {
        Text('Aperture Control')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
        Blank()
        Image($r('sys.media.ohos_ic_public_settings'))
          .width(16)
          .height(16)
          .fillColor(Color.Gray)
      }
      .width('100%')

      Slider({
        value: this.apertureValue,
        min: 1.4,
        max: 16,
        step: 0.7,
        style: SliderStyle.OutSet
      })
        .blockColor(Color.Black)
        .trackColor('#E0E0E0')
        .selectedColor(Color.Black)
        .width('100%')
        .margin({ top: 8, bottom: 4 })
        .onChange((value: number, mode: SliderChangeMode) => {
          this.apertureValue = value;
        })

      Row() {
        Text('f/1.4').fontSize(12).fontColor(Color.Gray)
        Blank()
        Text('f/16').fontSize(12).fontColor(Color.Gray)
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  ShutterSpeedControl() {
    Column() {
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ bottom: 12 })

      Row() {
        this.SpeedOption(
          this.selectedSpeedIndex > 0 ? this.shutterSpeeds[this.selectedSpeedIndex - 1] : '-',
          false,
          () => {
            if (this.selectedSpeedIndex > 0) {
              this.selectedSpeedIndex--;
            }
          }
        )

        this.SpeedOption(
          this.shutterSpeeds[this.selectedSpeedIndex],
          true,
          () => {}
        )

        this.SpeedOption(
          this.selectedSpeedIndex < this.shutterSpeeds.length - 1 ? this.shutterSpeeds[this.selectedSpeedIndex + 1] : '-',
          false,
          () => {
            if (this.selectedSpeedIndex < this.shutterSpeeds.length - 1) {
              this.selectedSpeedIndex++;
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
      .borderRadius(12)
      .backgroundColor(isSelected ? '#F0F0F0' : Color.Transparent)
      .textAlign(TextAlign.Center)
      .onClick(() => {
        if (!isSelected && text !== '-') {
          onClick();
        }
      })
  }

  @Builder
  LogShotButton() {
    Row() {
      Row() {
        Text('+')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width(24)
      .height(24)
      .borderRadius(12)
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Text('LOG EXPOSURE')
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

@Entry
@Component
struct Index {
  build() {
    Column() {
      LumenApp()
    }
    .width('100%')
    .height('100%')
  }
}