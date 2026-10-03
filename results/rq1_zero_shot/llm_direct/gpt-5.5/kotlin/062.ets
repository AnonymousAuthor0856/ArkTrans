import window from '@ohos.window';

const NAME: string = '101_ThermoCurve_en';
const UI_TYPE: string = 'SmartHome Form';
const STYLE_THEME: string = 'Cold Gradient';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppTokens {
  static readonly Colors = {
    primary: '#3B82F6',
    secondary: '#06B6D4',
    tertiary: '#0EA5E9',
    background: '#F0F9FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E0F2FE',
    outline: '#CBD5E1',
    onPrimary: '#FFFFFF',
    onBackground: '#0F172A',
    onSurface: '#1E293B',
    secondaryAlpha15: 'rgba(6, 182, 212, 0.15)',
    primaryAlpha20: 'rgba(59, 130, 246, 0.20)',
    outlineAlpha50: 'rgba(203, 213, 225, 0.50)'
  };

  static readonly TypographyTokens = {
    displaySize: 26,
    headlineSize: 18,
    titleSize: 14,
    bodySize: 12
  };

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 18
  };

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 18,
    xl: 26
  };
}

@Entry
@Component
struct RootScreen {
  @State targetTemp: number = 22;
  @State mode: string = 'Cool';

  aboutToAppear(): void {
    window.getLastWindow(getContext(this), (err, win) => {
      if (!err.code) {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      }
    });
  }

  @Builder
  TopAppBar() {
    Stack() {
      Text('ThermoCurve')
        .fontSize(AppTokens.TypographyTokens.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .align(Alignment.Center)

      Row() {
        Text('🌡')
          .fontSize(28)
          .fontColor(AppTokens.Colors.primary)
          .margin({ left: 12 })

        Blank()

        Button({ type: ButtonType.Circle, stateEffect: true }) {
          Text('☀')
            .fontSize(24)
            .fontColor(AppTokens.Colors.secondary)
        }
        .width(48)
        .height(48)
        .backgroundColor('rgba(255, 255, 255, 0)')
        .onClick(() => {
          this.targetTemp++;
        })
        .margin({ right: 8 })
      }
      .width('100%')
      .height('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(72)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
  }

  @Builder
  TemperatureButton(label: string, increase: boolean) {
    Button({ type: ButtonType.Capsule, stateEffect: true }) {
      Text(label)
        .fontSize(20)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontWeight(FontWeight.Medium)
    }
    .height(48)
    .width(88)
    .backgroundColor(AppTokens.Colors.primary)
    .onClick(() => {
      if (increase) {
        if (this.targetTemp < 35) {
          this.targetTemp++;
        }
      } else {
        if (this.targetTemp > 10) {
          this.targetTemp--;
        }
      }
    })
  }

  @Builder
  ModeButton(label: string, icon: string) {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Column() {
        Text(icon)
          .fontSize(32)
          .fontColor(this.mode === label ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)

        Text(label)
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(this.mode === label ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width(100)
    .height(100)
    .backgroundColor(this.mode === label ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
    .onClick(() => {
      this.mode = label;
    })
  }

  build() {
    Column() {
      this.TopAppBar()

      Column() {
        Text('Target Temperature')
          .fontSize(AppTokens.TypographyTokens.headlineSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)

        Row() {
          this.TemperatureButton('–', false)
          this.TemperatureButton('+', true)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .columnGap(AppTokens.Spacing.md)

        Divider()
          .width('80%')
          .height(1)
          .color(AppTokens.Colors.outlineAlpha50)

        Text('Mode')
          .fontSize(AppTokens.TypographyTokens.headlineSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        Row() {
          this.ModeButton('Cool', '☴')
          this.ModeButton('Heat', '☀')
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .columnGap(AppTokens.Spacing.lg)

        Text(`Current Mode: ${this.mode}`)
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)
      .rowGap(AppTokens.Spacing.xl)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.secondaryAlpha15, 0.0],
          [AppTokens.Colors.primaryAlpha20, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}