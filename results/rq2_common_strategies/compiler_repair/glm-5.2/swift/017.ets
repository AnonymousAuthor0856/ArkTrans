// Index.ets

// MARK: - AppTokens Interfaces
// Explicitly declared interfaces to satisfy arkts-no-untyped-obj-literals
interface AppColors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface AppTypographyItem {
  size: number;
  weight: FontWeight;
}

interface AppTypography {
  display: AppTypographyItem;
  title: AppTypographyItem;
  body: AppTypographyItem;
  label: AppTypographyItem;
}

interface AppShapes {
  small: number;
  medium: number;
  large: number;
}

interface AppSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

// MARK: - AppTokens
// Centralized definitions for colors, typography, shapes, and spacing.
class AppTokens {
  static Colors: AppColors = {
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

  static Typography: AppTypography = {
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 13, weight: FontWeight.Normal },
    label: { size: 11, weight: FontWeight.Medium }
  };

  static Shapes: AppShapes = {
    small: 6,
    medium: 10,
    large: 14
  };

  static Spacing: AppSpacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };
}

// MARK: - MixerSlider Component
// Reusable component for the individual audio mixer sliders.
@Component
struct MixerSlider {
  private label: string = ''; // Initialized to fix "no initializer" error
  @Link value: number; // Use @Link to allow external modification of the slider value

  build() {
    Column() {
      Text(`${this.label} ${Math.round(this.value * 100)}%`)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ bottom: AppTokens.Spacing.xs })

      Slider({
        value: this.value,
        min: 0,
        max: 1,
        style: SliderStyle.OutSet
      })
        .blockColor(AppTokens.Colors.primary) // Thumb color
        .selectedColor(AppTokens.Colors.primary) // Active track color
        .trackColor(AppTokens.Colors.surfaceVariant) // Inactive track color
        .width('100%')
        .onChange((val: number) => {
          this.value = val;
        })
    }
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - RootScreen
// The main UI screen.
@Entry
@Component
struct RootScreen {
  // @State variables to hold the mutable slider values
  @State bass: number = 0.4;
  @State mid: number = 0.5;
  @State treble: number = 0.6;
  @State master: number = 0.7;

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Full screen background color
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column() {
        // Top Bar equivalent: CenterAlignedTopAppBar (64vp height)
        Text('Audio Mixer Terminal')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .height(64)
          .textAlign(TextAlign.Center)
          .backgroundColor(AppTokens.Colors.background)

        // Content area
        Column({ space: AppTokens.Spacing.lg }) {
          MixerSlider({ label: 'Bass', value: this.bass })
          MixerSlider({ label: 'Mid', value: this.mid })
          MixerSlider({ label: 'Treble', value: this.treble })

          // Spacer equivalent
          Blank()
            .height(AppTokens.Spacing.lg)

          // LinearProgressIndicator equivalent
          Progress({ value: this.master * 100, total: 100, type: ProgressType.Linear })
            .color(AppTokens.Colors.primary) // Filled progress color
            .backgroundColor(AppTokens.Colors.surfaceVariant) // Unfilled track color
            .width('100%')
            .height(6)
            .borderRadius(3)

          Text(`Master Volume ${Math.round(this.master * 100)}%`)
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ top: AppTokens.Spacing.xs })

          // Master volume Slider
          Slider({
            value: this.master,
            min: 0,
            max: 1,
            style: SliderStyle.OutSet
          })
            .blockColor(AppTokens.Colors.primary)
            .selectedColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .width('100%')
            .onChange((val: number) => {
              this.master = val;
            })

          // Apply Settings Button
          Button('Apply Settings')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .width('100%')
            .height(48)
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .layoutWeight(1) // Make content column fill remaining space
        .backgroundColor(AppTokens.Colors.background)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM]) // Extends background to safe areas
  }
}