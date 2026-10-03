import prompt from '@ohos.prompt';

@Observed
class AppTokens {
  static readonly Colors = class {
    static readonly primary: string = '#FF00FF66';
    static readonly secondary: string = '#FFCCCCCC';
    static readonly tertiary: string = '#FF999999';
    static readonly background: string = '#FF000000';
    static readonly surface: string = '#FF0A0A0A';
    static readonly surfaceVariant: string = '#FF141414';
    static readonly outline: string = '#FF2A2A2A';
    static readonly success: string = '#FF22C55E';
    static readonly warning: string = '#FFF59E0B';
    static readonly error: string = '#FFEF4444';
    static readonly onPrimary: string = '#FF000000';
    static readonly onSecondary: string = '#FFFFFFFF';
    static readonly onTertiary: string = '#FFFFFFFF';
    static readonly onBackground: string = '#FFE0E0E0';
    static readonly onSurface: string = '#FFE0E0E0';
  };

  static readonly Typography = class {
    static readonly displaySize: number = 26;
    static readonly titleSize: number = 16;
    static readonly bodySize: number = 13;
    static readonly labelSize: number = 11;
  };

  static readonly Shapes = class {
    static readonly small: number = 6;
    static readonly medium: number = 10;
    static readonly large: number = 14;
  };

  static readonly Spacing = class {
    static readonly xs: number = 4;
    static readonly sm: number = 8;
    static readonly md: number = 12;
    static readonly lg: number = 16;
    static readonly xl: number = 24;
    static readonly xxl: number = 32;
  };
}

@Component
struct MixerSlider {
  label: string = '';
  @Link value: number;

  build() {
    Column() {
      Text(`${this.label} ${Math.round(this.value * 100)}%`)
        .fontSize(AppTokens.Typography.bodySize)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start);

      Slider({
        value: this.value,
        min: 0,
        max: 1,
        step: 0.01,
        style: SliderStyle.OutSet
      })
        .blockColor(AppTokens.Colors.primary)
        .trackColor(AppTokens.Colors.surfaceVariant)
        .selectedColor(AppTokens.Colors.primary)
        .width('100%')
        .onChange((value: number) => {
          this.value = value;
        });
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start);
  }
}

@Entry
@Component
struct RootScreen {
  @State bass: number = 0.4;
  @State mid: number = 0.5;
  @State treble: number = 0.6;
  @State master: number = 0.7;

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        Text('Audio Mixer Terminal')
          .fontSize(AppTokens.Typography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .textAlign(TextAlign.Center)
          .height(64);

      Column({ space: AppTokens.Spacing.lg }) {
          MixerSlider({ label: 'Bass', value: $bass })
          MixerSlider({ label: 'Mid', value: $mid })
          MixerSlider({ label: 'Treble', value: $treble })

          Blank()
            .height(AppTokens.Spacing.lg);

          Progress({ value: this.master * 100, total: 100, type: ProgressType.Linear })
            .color(AppTokens.Colors.primary)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .width('100%')
            .height(6);

          Text(`Master Volume ${Math.round(this.master * 100)}%`)
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start);

          Slider({
            value: this.master,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet
          })
            .blockColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .selectedColor(AppTokens.Colors.primary)
            .width('100%')
            .onChange((value: number) => {
              this.master = value;
            });

          Button('Apply Settings', { type: ButtonType.Normal })
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .width('100%')
            .height(48)
            .onClick(() => {
              prompt.showToast({ message: 'Settings applied' });
            });
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .layoutWeight(1);
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}
