import { router } from '@kit.ArkUI';

// Design tokens
const Colors = {
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
  onSurface: '#E0E0E0',
};

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32,
};

@Component
struct MixerSlider {
  @Prop label: string = '';
  @Prop value: number = 0;
  onChange: (val: number) => void = () => {};

  build() {
    Column({ space: Spacing.xs }) {
      Text(`${this.label} ${Math.floor(this.value * 100)}%`)
        .fontSize(13)
        .fontWeight(FontWeight.Normal)
        .fontColor(Colors.onSurface)
        .width('100%')

      Slider({
        value: this.value * 100,
        min: 0,
        max: 100,
        step: 1,
        style: SliderStyle.OutSet,
      })
        .width('100%')
        .selectedColor(Colors.primary)
        .trackColor(Colors.surfaceVariant)
        .blockColor(Colors.primary)
        .onChange((value: number) => {
          this.onChange(value / 100);
        })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
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
    Column() {
      // Top App Bar
      Row() {
        Text('Audio Mixer Terminal')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.primary)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Colors.background)

      // Content
      Scroll() {
        Column({ space: Spacing.lg }) {
          MixerSlider({
            label: 'Bass',
            value: this.bass,
            onChange: (val: number) => {
              this.bass = val;
            }
          })

          MixerSlider({
            label: 'Mid',
            value: this.mid,
            onChange: (val: number) => {
              this.mid = val;
            }
          })

          MixerSlider({
            label: 'Treble',
            value: this.treble,
            onChange: (val: number) => {
              this.treble = val;
            }
          })

          // Spacer
          Row().height(Spacing.lg)

          // Master Volume Progress Bar
          Progress({
            value: this.master * 100,
            total: 100,
            type: ProgressType.Linear,
          })
            .width('100%')
            .height(6)
            .color(Colors.primary)
            .backgroundColor(Colors.surfaceVariant)

          // Master Volume Label
          Text(`Master Volume ${Math.floor(this.master * 100)}%`)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
            .width('100%')

          // Master Volume Slider
          Slider({
            value: this.master * 100,
            min: 0,
            max: 100,
            step: 1,
            style: SliderStyle.OutSet,
          })
            .width('100%')
            .selectedColor(Colors.primary)
            .trackColor(Colors.surfaceVariant)
            .blockColor(Colors.primary)
            .onChange((value: number) => {
              this.master = value / 100;
            })

          // Apply Button
          Button('Apply Settings')
            .width('100%')
            .height(48)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onPrimary)
            .backgroundColor(Colors.primary)
            .borderRadius(10)
            .onClick(() => {})
        }
        .width('100%')
        .padding(Spacing.lg)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}