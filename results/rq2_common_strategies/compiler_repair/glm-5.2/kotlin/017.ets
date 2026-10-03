// Index.ets

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokens {
  static Colors: Record<string, ResourceColor> = {
    primary: '#FF00FF66',
    secondary: '#FFCCCCCC',
    tertiary: '#FF999999',
    background: '#FF000000',
    surface: '#FF0A0A0A',
    surfaceVariant: '#FF141414',
    outline: '#FF2A2A2A',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FF000000',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FFE0E0E0',
    onSurface: '#FFE0E0E0'
  };

  static TypographyTokens: Record<string, object> = {
    display: { fontSize: 26, fontWeight: FontWeight.Bold },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 13, fontWeight: FontWeight.Normal },
    label: { fontSize: 11, fontWeight: FontWeight.Medium }
  };

  static Spacing: Record<string, number> = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };

  static ElevationMapping: Record<string, ShadowSpec> = {
    level1: { elevation: 0, radius: 0, dy: 0, opacity: 0 },
    level2: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 }
  };
}

@Entry
@Component
struct RootScreen {
  @State bass: number = 0.4;
  @State mid: number = 0.5;
  @State treble: number = 0.6;
  @State master: number = 0.7;

  @Builder
  MixerSlider(label: string, value: number, onChange: (val: number) => void) {
    Column({ space: AppTokens.Spacing.xs }) {
      Text(`${label} ${(value * 100).toFixed(0)}%`)
        .fontSize(AppTokens.TypographyTokens.body.fontSize as number)
        .fontWeight(AppTokens.TypographyTokens.body.fontWeight as number)
        .fontColor(AppTokens.Colors.onSurface as ResourceColor)
        .width('100%')
      Slider({
        value: value,
        onChange: onChange,
        style: SliderStyle.OutSet
      })
        .blockColor(AppTokens.Colors.primary as ResourceColor)
        .selectedColor(AppTokens.Colors.primary as ResourceColor)
        .trackColor(AppTokens.Colors.surfaceVariant as ResourceColor)
        .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  build() {
    Column() {
      // TopAppBar Replacement
      Text('Audio Mixer Terminal')
        .fontSize(AppTokens.TypographyTokens.display.fontSize as number)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight as number)
        .fontColor(AppTokens.Colors.primary as ResourceColor)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding(16)

      // Content
      Column({ space: AppTokens.Spacing.lg }) {
        this.MixerSlider('Bass', this.bass, (val: number) => { this.bass = val; })
        this.MixerSlider('Mid', this.mid, (val: number) => { this.mid = val; })
        this.MixerSlider('Treble', this.treble, (val: number) => { this.treble = val; })

        Blank().height(AppTokens.Spacing.lg)

        // Linear Progress Indicator
        Progress({ value: this.master * 100, total: 100, type: ProgressType.Linear })
          .color(AppTokens.Colors.primary as ResourceColor)
          .backgroundColor(AppTokens.Colors.surfaceVariant as ResourceColor)
          .width('100%')
          .height(6)

        Text(`Master Volume ${(this.master * 100).toFixed(0)}%`)
          .fontSize(AppTokens.TypographyTokens.title.fontSize as number)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight as number)
          .fontColor(AppTokens.Colors.onSurface as ResourceColor)

        Slider({
          value: this.master,
          onChange: (val: number) => { this.master = val; },
          style: SliderStyle.OutSet
        })
          .blockColor(AppTokens.Colors.primary as ResourceColor)
          .selectedColor(AppTokens.Colors.primary as ResourceColor)
          .trackColor(AppTokens.Colors.surfaceVariant as ResourceColor)
          .width('100%')

        Button('Apply Settings')
          .backgroundColor(AppTokens.Colors.primary as ResourceColor)
          .fontColor(AppTokens.Colors.onPrimary as ResourceColor)
          .borderRadius(10)
          .width('100%')
          .height(48)
          .fontSize(AppTokens.TypographyTokens.title.fontSize as number)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight as number)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background as ResourceColor)
  }
}