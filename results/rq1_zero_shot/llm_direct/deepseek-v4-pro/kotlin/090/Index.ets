import { hilog } from '@kit.PerformanceAnalysisKit';
import { display } from '@kit.ArkUI';

@Entry
@Component
struct MainPage {
  @State selectedIso: string = "400";
  @State apertureValue: number = 2.8;
  @State selectedSpeedIndex: number = 4;
  private shutterSpeeds: string[] = ["1/1000", "1/500", "1/250", "1/125", "1/60", "1/30", "1/15", "1/8"];
  private isoValues: string[] = ["100", "200", "400", "800", "1600", "3200"];

  build() {
    Column() {
      Column() {
        // Header
        this.HeaderSection();

        // Main Display
        this.CurrentSettingsDisplay(
          this.selectedIso,
          this.formatAperture(this.apertureValue),
          this.shutterSpeeds[this.selectedSpeedIndex]
        );

        // Controls
        Column({ space: 32 }) {
          this.IsoSelector();
          this.ApertureControl();
          this.ShutterSpeedControl();
        }

        // Bottom Action
        this.LogShotButton();
      }
      .width('100%')
      .height('100%')
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
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
          .fontColor(Color.Gray)
        Text('Roll #034')
          .fontSize(24)
          .fontWeight(FontWeight.ExtraBold)
          .fontColor(Color.Black)
      }

      Blank()

      Row() {
        Button({ type: ButtonType.Circle }) {
          Text('☰')
            .fontSize(20)
            .fontColor(Color.Black)
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.Transparent)

        Button({ type: ButtonType.Circle }) {
          Text('⚙')
            .fontSize(20)
            .fontColor(Color.Black)
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.Transparent)
      }
    }
    .width('100%')
    .padding({ bottom: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  CurrentSettingsDisplay(iso: string, aperture: string, shutter: string) {
    Row() {
      // Aperture (Main Focus)
      Column() {
        Text(`f/${aperture}`)
          .fontSize(56)
          .fontWeight(FontWeight.Light)
          .fontColor(Color.Black)
          .letterSpacing(-2)
        Text('APERTURE')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
      }
      .layoutWeight(1.5)
      .padding({ left: 24 })
      .justifyContent(FlexAlign.Center)

      // Divider
      Divider()
        .vertical(true)
        .width(1)
        .height(80)
        .color(Color.LightGray)

      // Details Column
      Column() {
        this.SettingItemSmall('ISO', iso);
        Blank().height(16);
        this.SettingItemSmall('SHUTTER', shutter);
      }
      .layoutWeight(1)
      .padding({ left: 24 })
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(160)
    .backgroundColor('#F8F8F8')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
    .alignItems(VerticalAlign.Center)
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
    }
  }

  @Builder
  IsoSelector() {
    Column() {
      Text('Film Stock ISO')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .padding({ bottom: 12 })

      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.isoValues, (iso: string) => {
            this.IsoChip(iso, this.selectedIso === iso);
          })
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
  }

  @Builder
  IsoChip(iso: string, isSelected: boolean) {
    Text(iso)
      .fontSize(13)
      .fontWeight(FontWeight.SemiBold)
      .fontColor(isSelected ? Color.White : Color.Black)
      .textAlign(TextAlign.Center)
      .width(60)
      .height(36)
      .backgroundColor(isSelected ? Color.Black : Color.Transparent)
      .borderRadius(50)
      .border({ width: 1, color: isSelected ? Color.Black : '#E0E0E0' })
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
        Blank()
        Text('⚙')
          .fontSize(16)
          .fontColor(Color.Gray)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Blank().height(8)

      Slider({
        value: this.apertureValue,
        min: 1.4,
        max: 16,
        step: 0.7,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .selectedColor(Color.Black)
        .trackColor('#E0E0E0')
        .blockColor(Color.Black)
        .onChange((value: number) => {
          this.apertureValue = value;
        })

      Row() {
        Text('f/1.4')
          .fontSize(12)
          .fontColor(Color.Gray)
        Blank()
        Text('f/16')
          .fontSize(12)
          .fontColor(Color.Gray)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }

  @Builder
  ShutterSpeedControl() {
    Column() {
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .padding({ bottom: 12 })

      Row() {
        // Previous
        this.SpeedOption(
          this.selectedSpeedIndex > 0 ? this.shutterSpeeds[this.selectedSpeedIndex - 1] : '-',
          false,
          () => {
            if (this.selectedSpeedIndex > 0) {
              this.selectedSpeedIndex--;
            }
          }
        );

        // Current
        this.SpeedOption(this.shutterSpeeds[this.selectedSpeedIndex], true, () => {});

        // Next
        this.SpeedOption(
          this.selectedSpeedIndex < this.shutterSpeeds.length - 1 ? this.shutterSpeeds[this.selectedSpeedIndex + 1] : '-',
          false,
          () => {
            if (this.selectedSpeedIndex < this.shutterSpeeds.length - 1) {
              this.selectedSpeedIndex++;
            }
          }
        );
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }

  @Builder
  SpeedOption(text: string, isSelected: boolean, onClick: () => void) {
    Text(text)
      .fontSize(isSelected ? 22 : 16)
      .fontWeight(isSelected ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(isSelected ? Color.Black : Color.LightGray)
      .textAlign(TextAlign.Center)
      .width(100)
      .height(50)
      .backgroundColor(isSelected ? '#F0F0F0' : Color.Transparent)
      .borderRadius(12)
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
        Text('+')
          .fontSize(16)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .width(24)
          .height(24)
          .backgroundColor(Color.White)
          .borderRadius(12)

        Text('LOG EXPOSURE')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(1)
          .fontColor(Color.White)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(56)
    .backgroundColor(Color.Black)
    .borderRadius(12)
  }

  private formatAperture(value: number): string {
    return value.toFixed(1);
  }
}