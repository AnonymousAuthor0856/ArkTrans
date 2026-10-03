import { Length, Resource, ResourceStr } from '@ohos.arkui.UIContext';

class AppTokens {
  static readonly Colors = {
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
  };

  static readonly TypographyTokens = {
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 13, weight: FontWeight.Normal },
    label: { size: 11, weight: FontWeight.Medium },
  };

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };
}

interface MixerSliderProps {
  label: string;
  value: number;
  onChange: (value: number) => void;
}

@Component
struct MixerSlider {
  @Prop label: string = '';
  @Link value: number;
  
  build() {
    Column() {
      Text(`${this.label} ${Math.round(this.value * 100)}%`)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ bottom: AppTokens.Spacing.xs })

      Slider({
        value: this.value,
        min: 0,
        max: 1,
        step: 0.01,
      })
        .selectedColor(AppTokens.Colors.primary)
        .trackColor(AppTokens.Colors.surfaceVariant)
        .blockColor(AppTokens.Colors.primary)
        .width('100%')
        .onChange((val: number) => {
          this.value = val;
        })
    }
    .alignItems(HorizontalAlign.Start)
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
    Stack() {
      // Full screen background color
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column() {
        // Top Bar
        Text('Audio Mixer Terminal')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .height(64)
          .textAlign(TextAlign.Center)
          .backgroundColor(AppTokens.Colors.background)

        // Content Area
        Column() {
          MixerSlider({ label: 'Bass', value: $bass })
          MixerSlider({ label: 'Mid', value: $mid })
          MixerSlider({ label: 'Treble', value: $treble })

          // Spacer
          Column().height(AppTokens.Spacing.lg)

          // Progress Bar
          Progress({ value: this.master * 100, total: 100, type: ProgressType.Linear })
            .color(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .width('100%')
            .height(6)

          Text(`Master Volume ${Math.round(this.master * 100)}%`)
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ top: AppTokens.Spacing.sm })

          // Master Slider
          Slider({
            value: this.master,
            min: 0,
            max: 1,
            step: 0.01,
          })
            .selectedColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .blockColor(AppTokens.Colors.primary)
            .width('100%')
            .onChange((val: number) => {
              this.master = val;
            })

          // Apply Settings Button
          Button('Apply Settings')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('100%')
            .height(48)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .margin({ top: AppTokens.Spacing.lg })
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(AppTokens.Colors.background)
      }
    }
    .width('100%')
    .height('100%')
    .statusBarHidden(true)
  }
}