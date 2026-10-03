import { darkColorScheme } from '@ohos/material';

@Entry
@Component
struct AudioMixerScreen {
  @State bass: number = 0.4;
  @State mid: number = 0.5;
  @State treble: number = 0.6;
  @State master: number = 0.7;

  private primaryColor: string = '#00FF66';
  private secondaryColor: string = '#CCCCCC';
  private tertiaryColor: string = '#999999';
  private backgroundColor: string = '#000000';
  private surfaceColor: string = '#0A0A0A';
  private surfaceVariantColor: string = '#141414';
  private outlineColor: string = '#2A2A2A';
  private onPrimaryColor: string = '#000000';
  private onSurfaceColor: string = '#E0E0E0';

  @Builder
  MixerSlider(label: string, value: number, onChange: (number) => void) {
    Column({ space: 4 }) {
      Text(`${label} ${Math.round(value * 100)}%`)
        .fontSize(13)
        .fontColor(this.onSurfaceColor)
        .fontWeight(FontWeight.Normal)

      Slider({
        value: value,
        min: 0,
        max: 1,
        step: 0.01,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .selectedColor(this.primaryColor)
        .trackColor(this.surfaceVariantColor)
        .blockColor(this.primaryColor)
        .onChange((newValue: number) => {
          onChange(newValue);
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Audio Mixer Terminal')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.primaryColor)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(this.backgroundColor)

      // Main Content
      Column({ space: 16 }) {
        this.MixerSlider('Bass', this.bass, (newValue: number) => {
          this.bass = newValue;
        });

        this.MixerSlider('Mid', this.mid, (newValue: number) => {
          this.mid = newValue;
        });

        this.MixerSlider('Treble', this.treble, (newValue: number) => {
          this.treble = newValue;
        });

        // Spacer
        Row()
          .width('100%')
          .height(16)

        // Master Volume Progress
        Progress({
          value: Math.round(this.master * 100),
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(6)
          .color(this.primaryColor)
          .backgroundColor(this.surfaceVariantColor)

        Text(`Master Volume ${Math.round(this.master * 100)}%`)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurfaceColor)

        Slider({
          value: this.master,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .selectedColor(this.primaryColor)
          .trackColor(this.surfaceVariantColor)
          .blockColor(this.primaryColor)
          .onChange((newValue: number) => {
            this.master = newValue;
          })

        Button('Apply Settings')
          .width('100%')
          .height(48)
          .backgroundColor(this.primaryColor)
          .fontColor(this.onPrimaryColor)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .borderRadius(10)
          .onClick(() => {
            // Apply settings action
          })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor(this.backgroundColor)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
}