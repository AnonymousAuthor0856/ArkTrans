import { router } from '@kit.ArkUI';

// MARK: - AppTokens
const AppTokens = {
  Colors: {
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
    onSurface: '#FFE0E0E0',
  },
  Typography: {
    displaySize: 26,
    titleSize: 16,
    bodySize: 13,
    labelSize: 11,
  },
  Shapes: {
    small: 6,
    medium: 10,
    large: 14,
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  },
};

// MARK: - MixerSlider Component
@Component
struct MixerSlider {
  @Prop label: string = '';
  @Link value: number;

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Text(`${this.label} ${Math.round(this.value * 100)}%`)
        .fontSize(AppTokens.Typography.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')

      Slider({
        value: this.value,
        min: 0,
        max: 1,
        step: 0.01,
        style: SliderStyle.OutSet,
      })
        .width('100%')
        .trackColor(AppTokens.Colors.surfaceVariant)
        .selectedColor(AppTokens.Colors.primary)
        .blockColor(AppTokens.Colors.primary)
        .onChange((value: number) => {
          this.value = value;
        })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State bass: number = 0.4;
  @State mid: number = 0.5;
  @State treble: number = 0.6;
  @State master: number = 0.7;

  build() {
    Stack() {
      Column({ space: 0 }) {
        // Top Bar
        Text('Audio Mixer Terminal')
          .fontSize(AppTokens.Typography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .height(64)
          .textAlign(TextAlign.Center)
          .backgroundColor(AppTokens.Colors.background)

        // Content Area
        Column({ space: AppTokens.Spacing.lg }) {
          MixerSlider({ label: 'Bass', value: $bass })
          MixerSlider({ label: 'Mid', value: $mid })
          MixerSlider({ label: 'Treble', value: $treble })

          // Spacer
          Row()
            .height(AppTokens.Spacing.lg)
            .width('100%')

          // Progress Bar
          Progress({
            value: this.master * 100,
            total: 100,
            type: ProgressType.Linear,
          })
            .width('100%')
            .height(6)
            .color(AppTokens.Colors.primary)
            .backgroundColor(AppTokens.Colors.surfaceVariant)

          Text(`Master Volume ${Math.round(this.master * 100)}%`)
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Master Volume Slider
          Slider({
            value: this.master,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet,
          })
            .width('100%')
            .trackColor(AppTokens.Colors.surfaceVariant)
            .selectedColor(AppTokens.Colors.primary)
            .blockColor(AppTokens.Colors.primary)
            .onChange((value: number) => {
              this.master = value;
            })

          // Apply Settings Button
          Button('Apply Settings')
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('100%')
            .height(48)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {})
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(AppTokens.Colors.background)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}