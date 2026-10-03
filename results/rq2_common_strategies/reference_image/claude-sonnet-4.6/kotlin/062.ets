/**
 * 101_ThermoCurve_en — SmartHome Form / Cold Gradient
 * ArkTS (ArkUI) port of the Jetpack Compose source.
 *
 * File: entry/src/main/ets/pages/Index.ets
 * Register it in entry/src/main/resources/base/profile/main_pages.json:
 *   { "src": ["pages/Index"] }
 *
 * Status-bar hiding from MainActivity is done in ArkTS via EntryAbility:
 *   window.setWindowLayoutFullScreen(true);
 *   window.setWindowSystemBarEnable([]);
 */

class Tokens {
  // Palette
  static readonly primary: string = '#3B82F6';
  static readonly secondary: string = '#06B6D4';
  static readonly tertiary: string = '#0EA5E9';
  static readonly background: string = '#F0F9FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E0F2FE';
  static readonly outline: string = '#CBD5E1';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#1E293B';

  // Spacing scale
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 18;
  static readonly xl: number = 26;
}

@Entry
@Component
struct ThermoCurve {
  @State targetTemp: number = 22;
  @State mode: string = 'Cool';

  /** Circle mode selector — mirrors the Compose ModeButton. */
  @Builder
  ModeButton(label: string, icon: string, selected: boolean) {
    Column({ space: 4 }) {
      Text(icon)
        .fontSize(30)
        .fontColor(selected ? Tokens.onPrimary : Tokens.onSurface)
      Text(label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(selected ? Tokens.onPrimary : Tokens.onSurface)
    }
    .justifyContent(FlexAlign.Center)
    .width(100)
    .height(100)
    .borderRadius(50)
    .backgroundColor(selected ? Tokens.primary : Tokens.surfaceVariant)
    .onClick(() => {
      this.mode = label;
    })
  }

  build() {
    Column() {
      // ---------- Top app bar ----------
      Row() {
        Text('🌡️')
          .fontSize(22)
          .margin({ left: Tokens.md })

        Text('ThermoCurve')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(Tokens.onBackground)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('☀️')
          .fontSize(22)
          .margin({ right: Tokens.md })
          .onClick(() => {
            this.targetTemp = Math.min(35, this.targetTemp + 1);
          })
      }
      .width('100%')
      .height(56)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Tokens.surfaceVariant)

      // ---------- Content ----------
      Column({ space: Tokens.xl }) {
        Text('Target Temperature')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(Tokens.onSurface)

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(Tokens.primary)

        Row({ space: Tokens.md }) {
          Button('–')
            .fontSize(20)
            .fontColor(Tokens.onPrimary)
            .width(88)
            .height(48)
            .borderRadius(24)
            .backgroundColor(Tokens.primary)
            .onClick(() => {
              if (this.targetTemp > 10) {
                this.targetTemp -= 1;
              }
            })

          Button('+')
            .fontSize(20)
            .fontColor(Tokens.onPrimary)
            .width(88)
            .height(48)
            .borderRadius(24)
            .backgroundColor(Tokens.primary)
            .onClick(() => {
              if (this.targetTemp < 35) {
                this.targetTemp += 1;
              }
            })
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        Divider()
          .width('80%')
          .strokeWidth(1)
          .color('#80CBD5E1')

        Text('Mode')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(Tokens.onSurface)

        Row({ space: Tokens.lg }) {
          this.ModeButton('Cool', '💨', this.mode === 'Cool')
          this.ModeButton('Heat', '☀️', this.mode === 'Heat')
        }

        Text(`Current Mode: ${this.mode}`)
          .fontSize(12)
          .fontColor(Tokens.onSurface)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(Tokens.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [['#2606B6D4', 0.0], ['#333B82F6', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Tokens.background)
  }
}