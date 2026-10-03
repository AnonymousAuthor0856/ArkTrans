// AppTokens - Color definitions
class ColorsClass {
  primary: string = '#00FF66';
  secondary: string = '#CCCCCC';
  tertiary: string = '#999999';
  background: string = '#000000';
  surface: string = '#0A0A0A';
  surfaceVariant: string = '#141414';
  outline: string = '#2A2A2A';
  success: string = '#22C55E';
  warning: string = '#F59E0B';
  error: string = '#EF4444';
  onPrimary: string = '#000000';
  onSecondary: string = '#FFFFFF';
  onTertiary: string = '#FFFFFF';
  onBackground: string = '#E0E0E0';
  onSurface: string = '#E0E0E0';
}

class SpacingClass {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 32;
}

class ShapesClass {
  small: number = 6;
  medium: number = 10;
  large: number = 14;
}

const Colors: ColorsClass = new ColorsClass();
const Spacing: SpacingClass = new SpacingClass();
const Shapes: ShapesClass = new ShapesClass();

// MixerSlider Component
@Component
struct MixerSlider {
  label: string = '';
  @Link value: number;

  build() {
    Column({ space: Spacing.xs }) {
      Text(`${this.label} ${Math.round(this.value * 100)}%`)
        .fontSize(13)
        .fontWeight(FontWeight.Normal)
        .fontColor(Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)

      Slider({
        value: this.value * 100,
        min: 0,
        max: 100,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .trackColor(Colors.surfaceVariant)
        .selectedColor(Colors.primary)
        .blockColor(Colors.primary)
        .trackThickness(4)
        .blockSize({ width: 28, height: 28 })
        .onChange((value: number) => {
          this.value = value / 100;
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// RootScreen
@Entry
@Component
struct RootScreen {
  @State bass: number = 0.4;
  @State mid: number = 0.5;
  @State treble: number = 0.6;
  @State master: number = 0.7;

  build() {
    Column() {
      // Top Bar
      Text('Audio Mixer Terminal')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.primary)
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)
        .backgroundColor(Colors.background)

      // Content Area
      Column({ space: Spacing.lg }) {
        MixerSlider({ label: 'Bass', value: $bass })
        MixerSlider({ label: 'Mid', value: $mid })
        MixerSlider({ label: 'Treble', value: $treble })

        // Spacer
        Row().height(Spacing.lg)

        // Progress Bar
        Progress({
          value: this.master * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(6)
          .color(Colors.primary)
          .backgroundColor(Colors.surfaceVariant)
          .style({ strokeWidth: 6 })

        // Master Volume Label
        Text(`Master Volume ${Math.round(this.master * 100)}%`)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Master Volume Slider
        Slider({
          value: this.master * 100,
          min: 0,
          max: 100,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .trackColor(Colors.surfaceVariant)
          .selectedColor(Colors.primary)
          .blockColor(Colors.primary)
          .trackThickness(4)
          .blockSize({ width: 28, height: 28 })
          .onChange((value: number) => {
            this.master = value / 100;
          })

        // Apply Settings Button
        Button('Apply Settings')
          .width('100%')
          .height(48)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.primary)
          .borderRadius(Shapes.medium)
          .onClick(() => {})
      }
      .padding(Spacing.lg)
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(Colors.background)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}