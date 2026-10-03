import { window } from '@kit.ArkUI';

// --- App Tokens & Constants ---
const NAME = "016AudioMixeren";
const UI_TYPE = "Media";
const STYLE_THEME = "Monochrome Terminal";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

class AppTokens {
  static Colors = {
    primary: '#00FF66',
    secondary: '#CCCCCC',
    tertiary: '#999999',
    background: '#000000',
    surface: '#0A0A0A',
    surfaceVariant: '#141414',
    outline: '#2A2A2A',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#000000',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#E0E0E0',
    onSurface: '#E0E0E0'
  };

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };
}

// --- Components ---

@Component
struct MixerSlider {
  @Prop label: string;
  @Link value: number;

  build() {
    Column() {
      Text(`${this.label} ${Math.round(this.value * 100)}%`)
        .font({ size: 13, weight: FontWeight.Normal })
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)

      Slider({ value: this.value, min: 0, max: 1, step: 0.01 })
        .trackColor(AppTokens.Colors.surfaceVariant)
        .selectedColor(AppTokens.Colors.primary)
        .blockColor(AppTokens.Colors.primary)
        .width('100%')
        .height(32) // Approximate height for slider track + thumb area
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding({ bottom: AppTokens.Spacing.xs })
  }
}

@Entry
@Component
struct RootScreen {
  @State bass: number = 0.4;
  @State mid: number = 0.5;
  @State treble: number = 0.6;
  @State master: number = 0.7;

  aboutToAppear() {
    // Hide system bars to match the immersive Android behavior
    try {
      let windowClass: window.Window = window.getClass();
      windowClass.setWindowSystemBarEnable([], (err) => {
        if (err) {
          console.error(`Failed to set window system bar enable. Code is ${err.code}, message is ${err.message}`);
        }
      });
    } catch (e) {
      console.error("Error hiding status bar", e);
    }
  }

  build() {
    Column() {
      // Top Bar Area
      Row() {
        Text("Audio Mixer Terminal")
          .font({ size: 26, weight: FontWeight.Bold })
          .fontColor(AppTokens.Colors.primary)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main Content
      Column() {
        MixerSlider({ label: 'Bass', value: $bass })
        MixerSlider({ label: 'Mid', value: $mid })
        MixerSlider({ label: 'Treble', value: $treble })

        Blank().height(AppTokens.Spacing.lg)

        // Master Volume Progress Indicator
        Progress({ value: this.master, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)

        Text(`Master Volume ${Math.round(this.master * 100)}%`)
          .font({ size: 16, weight: FontWeight.Medium })
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.sm })

        // Master Slider
        Slider({ value: this.master, min: 0, max: 1, step: 0.01 })
          .trackColor(AppTokens.Colors.surfaceVariant)
          .selectedColor(AppTokens.Colors.primary)
          .blockColor(AppTokens.Colors.primary)
          .width('100%')
          .height(32)
          .onChange((value: number) => {
            this.master = value;
          })

        Button("Apply Settings")
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .borderRadius(10)
          .width('100%')
          .height(48)
          .margin({ top: AppTokens.Spacing.lg })
          .onClick(() => {
            // Apply logic here
          })
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}