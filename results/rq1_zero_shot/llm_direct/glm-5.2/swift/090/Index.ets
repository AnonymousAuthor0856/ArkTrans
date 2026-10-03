import { 
  EntryComponent, 
  Component, 
  Column, 
  Row, 
  Text, 
  Button, 
  Slider, 
  Image, 
  Stack, 
  ForEach, 
  Scroll, 
  Circle, 
  Rect, 
  Color, 
  FontWeight, 
  TextAlign, 
  ImageFit 
} from '@tianzu/arkui-v2';

// MARK: - Color Extension for Hex
function colorFromHex(hex: number, alpha: number = 1.0): Color {
  const r = (hex >> 16) & 0xff;
  const g = (hex >> 8) & 0xff;
  const b = hex & 0xff;
  return Color.rgb(r, g, b).alpha(alpha);
}

// MARK: - Entry Point
@EntryComponent
@Component
struct LumenApp {
  build() {
    Column() {
      LumenAppScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.WHITE)
    .expandSafeArea(true);
  }
}

// MARK: - Main Screen
@Component
struct LumenAppScreen {
  @State selectedIso: string = "400";
  @State apertureValue: number = 2.8;
  @State selectedSpeedIndex: number = 4;

  private shutterSpeeds: string[] = ["1/1000", "1/500", "1/250", "1/125", "1/60", "1/30", "1/15", "1/8"];

  private screenPadding: number = 24;
  private verticalSpacingLarge: number = 32;
  private verticalSpacingMedium: number = 16;

  build() {
    Column() {
      // 1. Header
      HeaderSection()
        .padding({ bottom: this.verticalSpacingMedium })

      // 2. Main Display (The "Shot")
      CurrentSettingsDisplay({
        iso: this.selectedIso,
        aperture: this.apertureValue.toFixed(1),
        shutter: this.shutterSpeeds[this.selectedSpeedIndex]
      })

      // Spacer
      Column().layoutWeight(1)

      // 3. Controls
      Column() {
        // ISO Selector
        IsoSelector({
          currentIso: this.selectedIso,
          onIsoSelected: (iso: string) => { this.selectedIso = iso; }
        })

        // Aperture Slider
        ApertureControl({
          value: this.apertureValue,
          onValueChange: (val: number) => { this.apertureValue = val; }
        })
          .margin({ top: this.verticalSpacingLarge })

        // Shutter Speed Selector
        ShutterSpeedControl({
          speeds: this.shutterSpeeds,
          selectedIndex: this.selectedSpeedIndex,
          onSelect: (index: number) => { this.selectedSpeedIndex = index; }
        })
          .margin({ top: this.verticalSpacingLarge })
      }

      // Spacer
      Column().layoutWeight(1)

      // 4. Bottom Action
      LogShotButton()
    }
    .width('100%')
    .height('100%')
    .padding(this.screenPadding)
    .backgroundColor(Color.WHITE);
  }
}

// MARK: - Sub-Components
@Component
struct HeaderSection {
  private bottomPadding: number = 16;
  private letterSpacingHeader: number = 2;
  private iconButtonSize: number = 44;

  build() {
    Row() {
      Column() {
        Text("LUMEN LOG")
          .fontSize(14)
          .fontWeight(FontWeight.BOLD)
          .letterSpacing(this.letterSpacingHeader)
          .fontColor(Color.GRAY)
        Text("Roll #034")
          .fontSize(24)
          .fontWeight(FontWeight.HEAVY)
          .fontColor(Color.BLACK)
      }
      .alignItems(HorizontalAlign.Start)

      Row().layoutWeight(1)

      Row() {
        Button() {
          Image($r('sys.media.ohos_ic_public_drawer'))
            .width(22)
            .height(22)
            .fillColor(Color.BLACK)
        }
        .width(this.iconButtonSize)
        .height(this.iconButtonSize)
        .backgroundColor(Color.TRANSPARENT)

        Button() {
          Image($r('sys.media.ohos_ic_public_settings'))
            .width(22)
            .height(22)
            .fillColor(Color.BLACK)
        }
        .width(this.iconButtonSize)
        .height(this.iconButtonSize)
        .backgroundColor(Color.TRANSPARENT)
        .margin({ left: 8 })
      }
    }
    .width('100%')
    .alignItems(VerticalAlign.Center);
  }
}

@Component
struct CurrentSettingsDisplay {
  let iso: string;
  let aperture: string;
  let shutter: string;

  private cardHeight: number = 160;
  private cornerRadius: number = 16;
  private horizontalPadding: number = 24;
  private dividerHeight: number = 80;
  private detailSpacing: number = 16;

  build() {
    Row() {
      // Aperture (Main Focus)
      Column() {
        Text(`f/${this.aperture}`)
          .fontSize(56)
          .fontWeight(FontWeight.LIGHT)
          .fontColor(Color.BLACK)
          .letterSpacing(-2)
        Text("APERTURE")
          .fontSize(12)
          .fontWeight(FontWeight.BOLD)
          .fontColor(Color.GRAY)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1.5)
      .padding({ left: this.horizontalPadding })

      // Divider
      Rect()
        .width(1)
        .height(this.dividerHeight)
        .fillColor(colorFromHex(0xFFE0E0E0))

      // Details Column
      Column() {
        SettingItemSmall({ label: "ISO", value: this.iso })
        SettingItemSmall({ label: "SHUTTER", value: this.shutter })
          .margin({ top: this.detailSpacing })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .padding({ left: this.horizontalPadding })
    }
    .width('100%')
    .height(this.cardHeight)
    .backgroundColor(colorFromHex(0xFFF8F8F8))
    .borderRadius(this.cornerRadius)
    .border({ width: 1, color: colorFromHex(0xFFEEEEEE) });
  }
}

@Component
struct SettingItemSmall {
  let label: string;
  let value: string;

  build() {
    Column() {
      Text(this.value)
        .fontSize(20)
        .fontWeight(FontWeight.SEMI_BOLD)
        .fontColor(Color.BLACK)
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.BOLD)
        .fontColor(Color.GRAY)
    }
    .alignItems(HorizontalAlign.Start);
  }
}

@Component
struct IsoSelector {
  private isoValues: string[] = ["100", "200", "400", "800", "1600", "3200"];
  let currentIso: string;
  onIsoSelected: (iso: string) => void;

  private bottomPadding: number = 12;
  private itemWidth: number = 60;
  private itemHeight: number = 36;
  private cornerRadius: number = 50;
  private horizontalSpacing: number = 12;

  build() {
    Column() {
      Text("Film Stock ISO")
        .fontSize(14)
        .fontWeight(FontWeight.MEDIUM)
        .margin({ bottom: this.bottomPadding })

      Scroll() {
        Row({ space: this.horizontalSpacing }) {
          ForEach(this.isoValues, (iso: string) => {
            Text(iso)
              .fontSize(13)
              .fontWeight(FontWeight.SEMI_BOLD)
              .fontColor(this.currentIso === iso ? Color.WHITE : Color.BLACK)
              .width(this.itemWidth)
              .height(this.itemHeight)
              .textAlign(TextAlign.CENTER)
              .backgroundColor(this.currentIso === iso ? Color.BLACK : Color.TRANSPARENT)
              .borderRadius(this.cornerRadius)
              .border({ width: 1, color: this.currentIso === iso ? Color.BLACK : colorFromHex(0xFFE0E0E0) })
              .onClick(() => {
                this.onIsoSelected(iso);
              })
          }, (iso: string) => iso)
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
    .alignItems(HorizontalAlign.Start);
  }
}

@Component
struct ApertureControl {
  @State value: number = 2.8;
  onValueChange: (val: number) => void;

  private sliderTopSpacing: number = 8;
  private iconSize: number = 16;
  private trackHeight: number = 2;
  private thumbDiameter: number = 28;

  build() {
    Column() {
      Row() {
        Text("Aperture Control")
          .fontSize(14)
          .fontWeight(FontWeight.MEDIUM)
        Row().layoutWeight(1)
        Image($r('sys.media.ohos_ic_public_settings'))
          .width(this.iconSize)
          .height(this.iconSize)
          .fillColor(Color.GRAY)
      }

      Column()
        .height(this.sliderTopSpacing)

      Stack({ alignContent: Alignment.Start }) {
        // Inactive Track
        Rect()
          .width('100%')
          .height(this.trackHeight)
          .fillColor(colorFromHex(0xFFE0E0E0))

        // Active Track
        Rect()
          .width(`${((this.value - 1.4) / (16.0 - 1.4)) * 100}%`)
          .height(this.trackHeight)
          .fillColor(Color.BLACK)

        // Thumb
        Circle()
          .width(this.thumbDiameter)
          .height(this.thumbDiameter)
          .fillColor(Color.BLACK)
          .offset({ x: `calc(${((this.value - 1.4) / (16.0 - 1.4)) * 100}% - ${this.thumbDiameter / 2}px)` })
          .shadow({ radius: 2, color: 'rgba(0,0,0,0.2)' })
      }
      .height(this.thumbDiameter)
      .alignContent(Alignment.Center)
      .width('100%')

      Slider({
        value: this.value,
        min: 1.4,
        max: 16.0,
        step: (16.0 - 1.4) / 20.0
      })
        .opacity(0.001)
        .onChange((val: number) => {
          this.value = val;
          this.onValueChange(val);
        })
        .width('100%')
        .height(this.thumbDiameter)
        .position({ x: 0, y: 0 })

      Row() {
        Text("f/1.4")
          .fontSize(12)
          .fontColor(Color.GRAY)
        Row().layoutWeight(1)
        Text("f/16")
          .fontSize(12)
          .fontColor(Color.GRAY)
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start);
  }
}

@Component
struct ShutterSpeedControl {
  let speeds: string[];
  let selectedIndex: number;
  onSelect: (index: number) => void;

  private bottomPadding: number = 12;
  private horizontalSpacing: number = 12;

  build() {
    Column() {
      Text("Shutter Speed")
        .fontSize(14)
        .fontWeight(FontWeight.MEDIUM)
        .margin({ bottom: this.bottomPadding })

      Row({ space: this.horizontalSpacing }) {
        SpeedOption({
          text: this.selectedIndex > 0 ? this.speeds[this.selectedIndex - 1] : "-",
          isSelected: false,
          onClick: () => {
            if (this.selectedIndex > 0) {
              this.onSelect(this.selectedIndex - 1);
            }
          }
        })
        .layoutWeight(1)

        SpeedOption({
          text: this.speeds[this.selectedIndex],
          isSelected: true,
          onClick: () => {}
        })
        .layoutWeight(1)

        SpeedOption({
          text: this.selectedIndex < this.speeds.length - 1 ? this.speeds[this.selectedIndex + 1] : "-",
          isSelected: false,
          onClick: () => {
            if (this.selectedIndex < this.speeds.length - 1) {
              this.onSelect(this.selectedIndex + 1);
            }
          }
        })
        .layoutWeight(1)
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start);
  }
}

@Component
struct SpeedOption {
  let text: string;
  let isSelected: boolean;
  onClick: () => void;

  private itemHeight: number = 50;
  private cornerRadius: number = 12;

  build() {
    Text(this.text)
      .fontSize(this.isSelected ? 22 : 16)
      .fontWeight(this.isSelected ? FontWeight.BOLD : FontWeight.NORMAL)
      .fontColor(this.isSelected ? Color.BLACK : colorFromHex(0xFFE0E0E0))
      .height(this.itemHeight)
      .width('100%')
      .textAlign(TextAlign.CENTER)
      .backgroundColor(this.isSelected ? colorFromHex(0xFFF0F0F0) : Color.TRANSPARENT)
      .borderRadius(this.cornerRadius)
      .onClick(() => {
        if (!this.isSelected && this.text !== "-") {
          this.onClick();
        }
      })
  }
}

@Component
struct LogShotButton {
  private buttonHeight: number = 56;
  private cornerRadius: number = 12;
  private iconBoxSize: number = 24;
  private iconSize: number = 16;
  private iconTextSpacing: number = 12;
  private letterSpacingButton: number = 1;

  build() {
    Button() {
      Row({ space: this.iconTextSpacing }) {
        Stack() {
          Circle()
            .width(this.iconBoxSize)
            .height(this.iconBoxSize)
            .fillColor(Color.WHITE)
          Image($r('sys.media.ohos_ic_public_add'))
            .width(this.iconSize)
            .height(this.iconSize)
            .fillColor(Color.BLACK)
        }
        Text("LOG EXPOSURE")
          .fontSize(16)
          .fontWeight(FontWeight.BOLD)
          .letterSpacing(this.letterSpacingButton)
          .fontColor(Color.WHITE)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(this.buttonHeight)
    .backgroundColor(Color.BLACK)
    .borderRadius(this.cornerRadius);
  }
}