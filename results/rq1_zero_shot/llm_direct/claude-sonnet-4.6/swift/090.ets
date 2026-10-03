import { router } from '@kit.ArkUI';

// MARK: - Main Entry
@Entry
@Component
struct LumenAppScreen {
  @State selectedIso: string = '400';
  @State apertureValue: number = 2.8;
  @State selectedSpeedIndex: number = 4;

  private shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8'];

  private screenPadding: number = 24;
  private verticalSpacingLarge: number = 32;
  private verticalSpacingMedium: number = 16;

  build() {
    Stack() {
      Column({ space: 0 }) {
        // 1. Header
        HeaderSection()
          .margin({ bottom: this.verticalSpacingMedium })

        // 2. Main Display
        CurrentSettingsDisplay({
          iso: this.selectedIso,
          aperture: this.apertureValue.toFixed(1),
          shutter: this.shutterSpeeds[this.selectedSpeedIndex]
        })

        Blank()

        // 3. Controls
        Column({ space: this.verticalSpacingLarge }) {
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
            onSelect: (index: number) => {
              this.selectedSpeedIndex = index;
            }
          })
        }

        Blank()

        // 4. Bottom Action
        LogShotButton()
      }
      .padding(this.screenPadding)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

// MARK: - HeaderSection
@Component
struct HeaderSection {
  private letterSpacingHeader: number = 2;
  private iconButtonSize: number = 44;

  build() {
    Row() {
      Column({ space: 0 }) {
        Text('LUMEN LOG')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(this.letterSpacingHeader)
          .fontColor('#FF888888')

        Text('Roll #034')
          .fontSize(24)
          .fontWeight(FontWeight.ExtraBold)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row({ space: 0 }) {
        Button({ type: ButtonType.Normal }) {
          Image($r('sys.media.ohos_ic_public_list_para'))
            .width(22)
            .height(22)
            .fillColor(Color.Black)
        }
        .width(this.iconButtonSize)
        .height(this.iconButtonSize)
        .backgroundColor(Color.Transparent)

        Button({ type: ButtonType.Normal }) {
          Image($r('sys.media.ohos_ic_public_settings'))
            .width(22)
            .height(22)
            .fillColor(Color.Black)
        }
        .width(this.iconButtonSize)
        .height(this.iconButtonSize)
        .backgroundColor(Color.Transparent)
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

// MARK: - CurrentSettingsDisplay
@Component
struct CurrentSettingsDisplay {
  @Prop iso: string = '400';
  @Prop aperture: string = '2.8';
  @Prop shutter: string = '1/60';

  private cardHeight: number = 160;
  private cornerRadius: number = 16;
  private horizontalPadding: number = 24;
  private dividerHeight: number = 80;
  private detailSpacing: number = 16;

  build() {
    Row({ space: 0 }) {
      // Aperture (Main Focus)
      Column({ space: 0 }) {
        Text(`f/${this.aperture}`)
          .fontSize(56)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
          .letterSpacing(-2)

        Text('APERTURE')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF888888')
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
      .padding({ left: this.horizontalPadding })
      .layoutWeight(1.5)
      .height('100%')

      // Divider
      Divider()
        .vertical(true)
        .height(this.dividerHeight)
        .color('#FFE0E0E0')
        .strokeWidth(1)

      // Details Column
      Column({ space: 0 }) {
        SettingItemSmall({ label: 'ISO', value: this.iso })
        Blank().height(this.detailSpacing)
        SettingItemSmall({ label: 'SHUTTER', value: this.shutter })
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
      .padding({ left: this.horizontalPadding })
      .layoutWeight(1)
      .height('100%')
    }
    .width('100%')
    .height(this.cardHeight)
    .backgroundColor('#FFF8F8F8')
    .borderRadius(this.cornerRadius)
    .border({ width: 1, color: '#FFEEEEEE', radius: this.cornerRadius })
    .alignItems(VerticalAlign.Center)
  }
}

// MARK: - SettingItemSmall
@Component
struct SettingItemSmall {
  @Prop label: string = '';
  @Prop value: string = '';

  build() {
    Column({ space: 0 }) {
      Text(this.value)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)

      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF888888')
    }
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - IsoSelector
@Component
struct IsoSelector {
  private isoValues: string[] = ['100', '200', '400', '800', '1600', '3200'];
  @Prop currentIso: string = '400';
  onIsoSelected: (iso: string) => void = () => {};

  private bottomPadding: number = 12;
  private itemWidth: number = 60;
  private itemHeight: number = 36;
  private cornerRadius: number = 50;
  private horizontalSpacing: number = 12;

  build() {
    Column({ space: 0 }) {
      Text('Film Stock ISO')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: this.bottomPadding })

      Scroll() {
        Row({ space: this.horizontalSpacing }) {
          ForEach(this.isoValues, (iso: string) => {
            Text(iso)
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.currentIso === iso ? Color.White : Color.Black)
              .width(this.itemWidth)
              .height(this.itemHeight)
              .textAlign(TextAlign.Center)
              .backgroundColor(this.currentIso === iso ? Color.Black : Color.Transparent)
              .borderRadius(this.cornerRadius)
              .border({
                width: 1,
                color: this.currentIso === iso ? Color.Black : '#FFE0E0E0',
                radius: this.cornerRadius
              })
              .onClick(() => {
                this.onIsoSelected(iso);
              })
          }, (iso: string) => iso)
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// MARK: - ApertureControl
@Component
struct ApertureControl {
  @Prop value: number = 2.8;
  onValueChange: (v: number) => void = () => {};

  private sliderTopSpacing: number = 8;
  private iconSize: number = 16;
  private minVal: number = 1.4;
  private maxVal: number = 16.0;
  private steps: number = 20;

  build() {
    Column({ space: 0 }) {
      Row() {
        Text('Aperture Control')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)

        Blank()

        Image($r('sys.media.ohos_ic_public_settings'))
          .width(this.iconSize)
          .height(this.iconSize)
          .fillColor('#FF888888')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank().height(this.sliderTopSpacing)

      Slider({
        value: this.value,
        min: this.minVal,
        max: this.maxVal,
        step: (this.maxVal - this.minVal) / this.steps,
        style: SliderStyle.OutSet
      })
        .trackColor('#FFE0E0E0')
        .selectedColor(Color.Black)
        .blockColor(Color.Black)
        .trackThickness(2)
        .width('100%')
        .onChange((value: number) => {
          this.onValueChange(value);
        })

      Row() {
        Text('f/1.4')
          .fontSize(12)
          .fontColor('#FF888888')

        Blank()

        Text('f/16')
          .fontSize(12)
          .fontColor('#FF888888')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// MARK: - ShutterSpeedControl
@Component
struct ShutterSpeedControl {
  @Prop speeds: string[] = [];
  @Prop selectedIndex: number = 4;
  onSelect: (index: number) => void = () => {};

  private bottomPadding: number = 12;
  private horizontalSpacing: number = 12;

  build() {
    Column({ space: 0 }) {
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: this.bottomPadding })

      Row({ space: this.horizontalSpacing }) {
        SpeedOption({
          text: this.selectedIndex > 0 ? this.speeds[this.selectedIndex - 1] : '-',
          isSelected: false,
          onClick: () => {
            if (this.selectedIndex > 0) {
              this.onSelect(this.selectedIndex - 1);
            }
          }
        })

        SpeedOption({
          text: this.speeds[this.selectedIndex],
          isSelected: true,
          onClick: () => {}
        })

        SpeedOption({
          text: this.selectedIndex < this.speeds.length - 1 ? this.speeds[this.selectedIndex + 1] : '-',
          isSelected: false,
          onClick: () => {
            if (this.selectedIndex < this.speeds.length - 1) {
              this.onSelect(this.selectedIndex + 1);
            }
          }
        })
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// MARK: - SpeedOption
@Component
struct SpeedOption {
  @Prop text: string = '';
  @Prop isSelected: boolean = false;
  onClick: () => void = () => {};

  private itemWidth: number = 100;
  private itemHeight: number = 50;
  private cornerRadius: number = 12;

  build() {
    Text(this.text)
      .fontSize(this.isSelected ? 22 : 16)
      .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.isSelected ? Color.Black : '#FFE0E0E0')
      .width(this.itemWidth)
      .height(this.itemHeight)
      .textAlign(TextAlign.Center)
      .backgroundColor(this.isSelected ? '#FFF0F0F0' : Color.Transparent)
      .borderRadius(this.cornerRadius)
      .onClick(() => {
        if (!this.isSelected && this.text !== '-') {
          this.onClick();
        }
      })
  }
}

// MARK: - LogShotButton
@Component
struct LogShotButton {
  private buttonHeight: number = 56;
  private cornerRadius: number = 12;
  private iconBoxSize: number = 24;
  private iconSize: number = 16;
  private iconTextSpacing: number = 12;
  private letterSpacingButton: number = 1;

  build() {
    Button({ type: ButtonType.Normal }) {
      Row({ space: this.iconTextSpacing }) {
        Stack() {
          Circle()
            .fill(Color.White)
            .width(this.iconBoxSize)
            .height(this.iconBoxSize)

          Image($r('sys.media.ohos_ic_public_add'))
            .width(this.iconSize)
            .height(this.iconSize)
            .fillColor(Color.Black)
        }
        .width(this.iconBoxSize)
        .height(this.iconBoxSize)

        Text('LOG EXPOSURE')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(this.letterSpacingButton)
          .fontColor(Color.White)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(this.buttonHeight)
    .backgroundColor(Color.Black)
    .borderRadius(this.cornerRadius)
  }
}