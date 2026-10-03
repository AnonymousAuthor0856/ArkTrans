import window from '@ohos.window';
import { BusinessError } from '@ohos.base';

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface AppTokenSet {
  Colors: {
    primary: ResourceColor;
    secondary: ResourceColor;
    tertiary: ResourceColor;
    background: ResourceColor;
    surface: ResourceColor;
    surfaceVariant: ResourceColor;
    outline: ResourceColor;
    success: ResourceColor;
    warning: ResourceColor;
    error: ResourceColor;
    onPrimary: ResourceColor;
    onSecondary: ResourceColor;
    onTertiary: ResourceColor;
    onBackground: ResourceColor;
    onSurface: ResourceColor;
  };
  TypographyTokens: {
    display: TypographyToken;
    title: TypographyToken;
    body: TypographyToken;
    label: TypographyToken;
  };
  Shapes: {
    small: number;
    medium: number;
    large: number;
  };
  Spacing: {
    xs: number;
    sm: number;
    md: number;
    lg: number;
    xl: number;
    xxl: number;
  };
}

const AppTokens: AppTokenSet = {
  Colors: {
    primary: 0xFF00FF66,
    secondary: 0xFFCCCCCC,
    tertiary: 0xFF999999,
    background: 0xFF000000,
    surface: 0xFF0A0A0A,
    surfaceVariant: 0xFF141414,
    outline: 0xFF2A2A2A,
    success: 0xFF22C55E,
    warning: 0xFFF59E0B,
    error: 0xFFEF4444,
    onPrimary: 0xFF000000,
    onSecondary: 0xFFFFFFFF,
    onTertiary: 0xFFFFFFFF,
    onBackground: 0xFFE0E0E0,
    onSurface: 0xFFE0E0E0
  },
  TypographyTokens: {
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 13, weight: FontWeight.Regular },
    label: { size: 11, weight: FontWeight.Medium }
  },
  Shapes: {
    small: 6,
    medium: 10,
    large: 14
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }
};

@Component
struct MixerSlider {
  label: string = '';
  @Link value: number;

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Text(`${this.label} ${Math.trunc(this.value * 100)}%`)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Slider({
        value: this.value,
        min: 0,
        max: 1,
        step: 0.01,
        style: SliderStyle.OutSet,
        direction: Axis.Horizontal,
        reverse: false
      })
        .width('100%')
        .selectedColor(AppTokens.Colors.primary)
        .trackColor(AppTokens.Colors.surfaceVariant)
        .blockColor(AppTokens.Colors.primary)
        .trackThickness(4)
        .showTips(false)
        .onChange((value: number): void => {
          this.value = value;
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Entry
@Component
struct RootScreen {
  @State private bass: number = 0.4;
  @State private mid: number = 0.5;
  @State private treble: number = 0.6;
  @State private master: number = 0.7;

  aboutToAppear(): void {
    window.getLastWindow(getContext(this))
      .then((win: window.Window): void => {
        win.setWindowSystemBarEnable(['navigation'])
          .catch((error: BusinessError): void => {
          });
      })
      .catch((error: BusinessError): void => {
      });
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        Text('Audio Mixer Terminal')
          .width('100%')
          .height(64)
          .textAlign(TextAlign.Center)
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.background)

        Column({ space: AppTokens.Spacing.lg }) {
          MixerSlider({ label: 'Bass', value: $bass })
          MixerSlider({ label: 'Mid', value: $mid })
          MixerSlider({ label: 'Treble', value: $treble })

          Blank()
            .width('100%')
            .height(AppTokens.Spacing.lg)

          Stack({ alignContent: Alignment.Start }) {
            Row()
              .width('100%')
              .height(6)
              .borderRadius(3)
              .backgroundColor(AppTokens.Colors.surfaceVariant)

            Row()
              .width(`${this.master * 100}%`)
              .height(6)
              .borderRadius(3)
              .backgroundColor(AppTokens.Colors.primary)
          }
          .width('100%')
          .height(6)

          Text(`Master Volume ${Math.trunc(this.master * 100)}%`)
            .width('100%')
            .textAlign(TextAlign.Start)
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Slider({
            value: this.master,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet,
            direction: Axis.Horizontal,
            reverse: false
          })
            .width('100%')
            .selectedColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .blockColor(AppTokens.Colors.primary)
            .trackThickness(4)
            .showTips(false)
            .onChange((value: number): void => {
              this.master = value;
            })

          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('Apply Settings')
              .width('100%')
              .textAlign(TextAlign.Center)
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .width('100%')
          .height(48)
          .borderRadius(AppTokens.Shapes.medium)
          .backgroundColor(AppTokens.Colors.primary)
          .onClick((): void => {
          })
        }
        .width('100%')
        .layoutWeight(1)
        .padding(AppTokens.Spacing.lg)
        .alignItems(HorizontalAlign.Start)
        .backgroundColor(AppTokens.Colors.background)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}