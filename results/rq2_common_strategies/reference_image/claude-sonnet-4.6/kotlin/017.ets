/**
 * NAME: 016AudioMixeren
 * UI_TYPE: Media
 * STYLE_THEME: Monochrome Terminal
 * LANG: en
 * BASELINE_SIZE: 720x1280
 *
 * Note: this converter emits source only — I can't render or attach an image from here.
 * Paste the file into a DevEco Studio project (entry/src/main/ets/pages/Index.ets),
 * use the Previewer, or run on a 720x1280 emulator to capture the screenshot.
 */

const NAME: string = '016AudioMixeren';
const UI_TYPE: string = 'Media';
const STYLE_THEME: string = 'Monochrome Terminal';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#00FF66';
  static readonly secondary: string = '#CCCCCC';
  static readonly tertiary: string = '#999999';
  static readonly background: string = '#000000';
  static readonly surface: string = '#0A0A0A';
  static readonly surfaceVariant: string = '#141414';
  static readonly outline: string = '#2A2A2A';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#000000';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#E0E0E0';
  static readonly onSurface: string = '#E0E0E0';
}

class AppType {
  static readonly displaySize: number = 26;
  static readonly titleSize: number = 16;
  static readonly bodySize: number = 13;
  static readonly labelSize: number = 11;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

@Component
struct MixerSlider {
  @Prop label: string = '';
  @Prop value: number = 0;
  onChange: (value: number) => void = () => {};

  build() {
    Column({ space: AppSpacing.xs }) {
      Text(`${this.label} ${Math.round(this.value)}%`)
        .fontSize(AppType.bodySize)
        .fontWeight(AppType.bodyWeight)
        .fontColor(AppColors.onSurface)

      Slider({
        value: this.value,
        min: 0,
        max: 100,
        step: 1,
        style: SliderStyle.OutSet
      })
        .selectedColor(AppColors.primary)
        .trackColor(AppColors.surfaceVariant)
        .blockColor(AppColors.primary)
        .trackThickness(6)
        .width('100%')
        .onChange((value: number, mode: SliderChangeMode) => {
          this.onChange(value);
        })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Entry
@Component
struct RootScreen {
  @State bass: number = 40;
  @State mid: number = 50;
  @State treble: number = 60;
  @State master: number = 70;

  build() {
    Column() {
      // CenterAlignedTopAppBar
      Row() {
        Text('Audio Mixer Terminal')
          .fontSize(AppType.displaySize)
          .fontWeight(AppType.displayWeight)
          .fontColor(AppColors.primary)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)

      Column({ space: AppSpacing.lg }) {
        MixerSlider({
          label: 'Bass',
          value: this.bass,
          onChange: (value: number) => {
            this.bass = value;
          }
        })

        MixerSlider({
          label: 'Mid',
          value: this.mid,
          onChange: (value: number) => {
            this.mid = value;
          }
        })

        MixerSlider({
          label: 'Treble',
          value: this.treble,
          onChange: (value: number) => {
            this.treble = value;
          }
        })

        // Spacer(lg)
        Blank().height(AppSpacing.lg)

        Progress({
          value: this.master,
          total: 100,
          type: ProgressType.Linear
        })
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .style({ strokeWidth: 6 })
          .width('100%')

        Text(`Master Volume ${Math.round(this.master)}%`)
          .fontSize(AppType.titleSize)
          .fontWeight(AppType.titleWeight)
          .fontColor(AppColors.onSurface)

        Slider({
          value: this.master,
          min: 0,
          max: 100,
          step: 1,
          style: SliderStyle.OutSet
        })
          .selectedColor(AppColors.primary)
          .trackColor(AppColors.surfaceVariant)
          .blockColor(AppColors.primary)
          .trackThickness(6)
          .width('100%')
          .onChange((value: number, mode: SliderChangeMode) => {
            this.master = value;
          })

        Button('Apply Settings')
          .fontSize(AppType.titleSize)
          .fontWeight(AppType.titleWeight)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)
          .width('100%')
          .height(48)
          .onClick(() => {
            // Apply Settings
          })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: AppSpacing.lg
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}