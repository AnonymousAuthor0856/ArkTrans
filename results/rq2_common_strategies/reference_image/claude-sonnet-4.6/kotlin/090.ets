/**
 * Lumen Log — ArkTS / ArkUI port of the Compose `LumenAppScreen`.
 * Target: entry/src/main/ets/pages/Index.ets  (HarmonyOS NEXT, API 11+)
 */
import { window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

const ISO_VALUES: string[] = ['100', '200', '400', '800', '1600', '3200'];
const SHUTTER_SPEEDS: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8'];
const APERTURE_MIN: number = 1.4;
const APERTURE_MAX: number = 16;

@Entry
@Component
struct LumenLog {
  @State selectedIso: string = '400';
  @State aperture: number = 2.8;
  @State speedIndex: number = 4;

  aboutToAppear(): void {
    // Immersive mode: full-screen layout, both system bars hidden.
    const ctx = getContext(this) as common.UIAbilityContext;
    window.getLastWindow(ctx)
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      })
      .catch((err: Error) => {
        console.error('LumenLog immersive setup failed: ' + err.message);
      });
  }

  build() {
    Column() {
      this.Header()
      this.ShotDisplay()

      Column({ space: 32 }) {
        this.IsoSection()
        this.ApertureSection()
        this.ShutterSection()
      }
      .width('100%')

      this.LogButton()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
    .justifyContent(FlexAlign.SpaceBetween)
  }

  /* ------------------------------- Header ------------------------------- */

  @Builder
  Header() {
    Row() {
      Column() {
        Text('LUMEN LOG')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
          .fontColor('#8A8A8A')
        Text('Roll #034')
          .fontSize(24)
          .fontWeight(FontWeight.Bolder)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        Text('☰')
          .fontSize(22)
          .fontColor('#000000')
          .textAlign(TextAlign.Center)
      }
      .width(44)
      .height(44)
      .justifyContent(FlexAlign.Center)
      .borderRadius(22)
      .onClick(() => {
        console.info('LumenLog: menu tapped');
      })

      Row() {
        Text('⚙')
          .fontSize(22)
          .fontColor('#000000')
          .textAlign(TextAlign.Center)
      }
      .width(44)
      .height(44)
      .justifyContent(FlexAlign.Center)
      .borderRadius(22)
      .onClick(() => {
        console.info('LumenLog: settings tapped');
      })
    }
    .width('100%')
    .margin({ bottom: 16 })
    .alignItems(VerticalAlign.Center)
  }

  /* --------------------------- Exposure "shot" -------------------------- */

  @Builder
  ShotDisplay() {
    Row() {
      Column() {
        Text('f/' + this.aperture.toFixed(1))
          .fontSize(56)
          .fontWeight(FontWeight.Lighter)
          .letterSpacing(-2)
          .fontColor('#000000')
        Text('APERTURE')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#8A8A8A')
      }
      .layoutWeight(3)
      .padding({ left: 20 })
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)

      Divider()
        .vertical(true)
        .strokeWidth(1)
        .color('#DDDDDD')
        .height(80)

      Column({ space: 16 }) {
        SettingItemSmall({ label: 'ISO', value: this.selectedIso })
        SettingItemSmall({ label: 'SHUTTER', value: SHUTTER_SPEEDS[this.speedIndex] })
      }
      .layoutWeight(2)
      .padding({ left: 20 })
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(160)
    .borderRadius(16)
    .backgroundColor('#F8F8F8')
    .border({ width: 1, color: '#EEEEEE' })
  }

  /* -------------------------------- ISO --------------------------------- */

  @Builder
  IsoSection() {
    Column() {
      Text('Film Stock ISO')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ bottom: 12 })

      Scroll() {
        Row({ space: 12 }) {
          ForEach(ISO_VALUES, (iso: string) => {
            Row() {
              Text(iso)
                .fontSize(13)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedIso === iso ? '#FFFFFF' : '#000000')
            }
            .width(60)
            .height(36)
            .justifyContent(FlexAlign.Center)
            .borderRadius(18)
            .backgroundColor(this.selectedIso === iso ? '#000000' : '#00FFFFFF')
            .border({ width: 1, color: this.selectedIso === iso ? '#000000' : '#E0E0E0' })
            .onClick(() => {
              this.selectedIso = iso;
            })
          }, (iso: string) => iso)
        }
      }
      .width('100%')
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  /* ------------------------------ Aperture ------------------------------ */

  @Builder
  ApertureSection() {
    Column() {
      Row() {
        Text('Aperture Control')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
        Blank()
        Text('⚙')
          .fontSize(16)
          .fontColor('#8A8A8A')
      }
      .width('100%')

      Slider({
        value: this.aperture,
        min: APERTURE_MIN,
        max: APERTURE_MAX,
        step: (APERTURE_MAX - APERTURE_MIN) / 21,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .blockColor('#000000')
        .selectedColor('#000000')
        .trackColor('#E0E0E0')
        .trackThickness(6)
        .margin({ top: 10, bottom: 6 })
        .onChange((value: number, mode: SliderChangeMode) => {
          this.aperture = value;
        })

      Row() {
        Text('f/1.4')
          .fontSize(12)
          .fontColor('#8A8A8A')
        Blank()
        Text('f/16')
          .fontSize(12)
          .fontColor('#8A8A8A')
      }
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  /* ---------------------------- Shutter speed --------------------------- */

  @Builder
  ShutterSection() {
    Column() {
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ bottom: 12 })

      Row() {
        SpeedOption({
          label: this.speedIndex > 0 ? SHUTTER_SPEEDS[this.speedIndex - 1] : '-',
          selected: false,
          onPick: () => {
            if (this.speedIndex > 0) {
              this.speedIndex -= 1;
            }
          }
        })

        SpeedOption({
          label: SHUTTER_SPEEDS[this.speedIndex],
          selected: true,
          onPick: () => {
          }
        })

        SpeedOption({
          label: this.speedIndex < SHUTTER_SPEEDS.length - 1 ? SHUTTER_SPEEDS[this.speedIndex + 1] : '-',
          selected: false,
          onPick: () => {
            if (this.speedIndex < SHUTTER_SPEEDS.length - 1) {
              this.speedIndex += 1;
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

  /* ----------------------------- Bottom CTA ----------------------------- */

  @Builder
  LogButton() {
    Row() {
      Row() {
        Text('+')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .textAlign(TextAlign.Center)
      }
      .width(24)
      .height(24)
      .justifyContent(FlexAlign.Center)
      .borderRadius(12)
      .backgroundColor('#FFFFFF')

      Text('LOG EXPOSURE')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .letterSpacing(1)
        .fontColor('#FFFFFF')
        .margin({ left: 12 })
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .borderRadius(12)
    .backgroundColor('#000000')
    .onClick(() => {
      console.info(`LumenLog: logged f/${this.aperture.toFixed(1)} ISO ${this.selectedIso} ${SHUTTER_SPEEDS[this.speedIndex]}`);
    })
  }
}

/* ---------------------------- Child components ---------------------------- */

@Component
struct SettingItemSmall {
  @Prop label: string = '';
  @Prop value: string = '';

  build() {
    Column() {
      Text(this.value)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#8A8A8A')
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SpeedOption {
  @Prop label: string = '-';
  @Prop selected: boolean = false;
  onPick: () => void = () => {
  };

  build() {
    Row() {
      Text(this.label)
        .fontSize(this.selected ? 22 : 16)
        .fontWeight(this.selected ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(this.selected ? '#000000' : '#C8C8C8')
        .textAlign(TextAlign.Center)
    }
    .width(100)
    .height(50)
    .justifyContent(FlexAlign.Center)
    .borderRadius(12)
    .backgroundColor(this.selected ? '#F0F0F0' : '#00FFFFFF')
    .enabled(!this.selected && this.label !== '-')
    .onClick(() => {
      this.onPick();
    })
  }
}