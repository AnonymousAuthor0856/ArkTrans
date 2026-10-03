/**
 * Audio Mixer Terminal — ArkTS / ArkUI port of the SwiftUI screen.
 * Target: HarmonyOS NEXT (API 11+), Stage model, ArkTS strict mode.
 * Drop this file in: entry/src/main/ets/pages/Index.ets
 * and register it in main_pages.json.
 */

// ---------------------------------------------------------------------------
// MARK: - Design tokens (mirrors AppTokens)
// ---------------------------------------------------------------------------

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

class AppTypography {
  // fontSize(sp) maps 1:1 to ArkUI .fontSize(number) which is vp by default.
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

// ---------------------------------------------------------------------------
// MARK: - MixerSlider component
// Reusable audio mixer slider (label + Slider), mirrors the SwiftUI view.
// ---------------------------------------------------------------------------

@Component
struct MixerSlider {
  @Prop label: string = '';
  @Link value: number;

  private prettyValue(): string {
    return Math.round(this.value * 100).toString();
  }

  build() {
    Column({ space: AppSpacing.xs }) {
      Text(`${this.label} ${this.prettyValue()}%`)
        .fontSize(AppTypography.bodySize)
        .fontWeight(AppTypography.bodyWeight)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)

      Slider({
        value: this.value,
        min: 0,
        max: 1,
        step: 0.01,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .selectedColor(AppColors.primary)      // active / minimum track
        .trackColor(AppColors.surfaceVariant)  // inactive / maximum track
        .blockColor(AppColors.primary)         // thumb
        .trackThickness(4)
        .onChange((value: number, mode: SliderChangeMode) => {
          this.value = value;
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// ---------------------------------------------------------------------------
// MARK: - RootScreen
// ---------------------------------------------------------------------------

@Entry
@Component
struct RootScreen {
  @State bass: number = 0.4;
  @State mid: number = 0.5;
  @State treble: number = 0.6;
  @State master: number = 0.7;

  build() {
    Column() {
      // --- CenterAlignedTopAppBar equivalent (64vp tall) ---
      Row() {
        Text('Audio Mixer Terminal')
          .fontSize(AppTypography.displaySize)
          .fontWeight(AppTypography.displayWeight)
          .fontColor(AppColors.primary)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      // --- Content column ---
      Column({ space: AppSpacing.lg }) {
        MixerSlider({ label: 'Bass', value: $bass })
        MixerSlider({ label: 'Mid', value: $mid })
        MixerSlider({ label: 'Treble', value: $treble })

        // LinearProgressIndicator equivalent
        Progress({
          value: this.master * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(6)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .style({ strokeWidth: 6 })
          .margin({ top: AppSpacing.lg })

        Text(`Master Volume ${Math.round(this.master * 100)}%`)
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Master volume Slider
        Slider({
          value: this.master,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .selectedColor(AppColors.primary)
          .trackColor(AppColors.surfaceVariant)
          .blockColor(AppColors.primary)
          .trackThickness(4)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.master = value;
          })

        // --- Apply Settings button ---
        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Apply Settings')
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(AppColors.onPrimary)
        }
        .width('100%')
        .height(48)
        .borderRadius(AppShapes.medium)
        .backgroundColor(AppColors.primary)
        .onClick(() => {
          // Wire up to your audio engine here.
          console.info(`Mixer applied: bass=${this.bass} mid=${this.mid} ` +
          `treble=${this.treble} master=${this.master}`);
        })
      }
      .width('100%')
      .layoutWeight(1)                        // fills remaining space
      .alignItems(HorizontalAlign.Start)
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}