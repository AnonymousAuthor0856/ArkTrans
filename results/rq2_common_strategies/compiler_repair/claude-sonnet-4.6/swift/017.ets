// AppTokens Colors
class AppColors {
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
}

class AppTypography {
  static readonly displaySize: number = 26;
  static readonly titleSize: number = 16;
  static readonly bodySize: number = 13;
  static readonly labelSize: number = 11;
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

// MixerSlider Component
@Component
struct MixerSlider {
  @Prop label: string = '';
  @Link value: number;

  build() {
    Column({ space: AppSpacing.xs }) {
      Text(`${this.label} ${Math.round(this.value * 100)}%`)
        .fontSize(AppTypography.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)

      Slider({
        value: this.value,
        min: 0,
        max: 1,
        step: 0.01,
        style: SliderStyle.OutSet,
      })
        .width('100%')
        .selectedColor(AppColors.primary)
        .trackColor(AppColors.surfaceVariant)
        .blockColor(AppColors.primary)
        .trackThickness(4)
        .onChange((value: number) => {
          this.value = value;
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// RootScreen - Main UI Screen
@Entry
@Component
struct RootScreen {
  @State bass: number = 0.4;
  @State mid: number = 0.5;
  @State treble: number = 0.6;
  @State master: number = 0.7;

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppColors.background)

      Column({ space: 0 }) {
        // Top Bar
        Text('Audio Mixer Terminal')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .width('100%')
          .height(64)
          .textAlign(TextAlign.Center)
          .backgroundColor(AppColors.background)

        // Content Area
        Column({ space: AppSpacing.lg }) {
          MixerSlider({ label: 'Bass', value: $bass })
          MixerSlider({ label: 'Mid', value: $mid })
          MixerSlider({ label: 'Treble', value: $treble })

          // Spacer
          Row()
            .height(AppSpacing.lg)
            .width('100%')

          // Progress Bar - Master Volume
          Progress({
            value: this.master * 100,
            total: 100,
            type: ProgressType.Linear,
          })
            .width('100%')
            .height(6)
            .color(AppColors.primary)
            .backgroundColor(AppColors.surfaceVariant)
            .style({ strokeWidth: 6 })

          // Master Volume Label
          Text(`Master Volume ${Math.round(this.master * 100)}%`)
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
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
            .selectedColor(AppColors.primary)
            .trackColor(AppColors.surfaceVariant)
            .blockColor(AppColors.primary)
            .trackThickness(4)
            .onChange((value: number) => {
              this.master = value;
            })

          // Apply Settings Button
          Button() {
            Text('Apply Settings')
              .fontSize(AppTypography.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onPrimary)
              .width('100%')
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .height(48)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)
          .onClick(() => {
            // Apply settings action
          })
        }
        .padding(AppSpacing.lg)
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(AppColors.background)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}