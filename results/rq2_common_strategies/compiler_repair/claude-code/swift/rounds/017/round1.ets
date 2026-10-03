import prompt from '@ohos.prompt';

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF00FF66';
    export const secondary: string = '#FFCCCCCC';
    export const tertiary: string = '#FF999999';
    export const background: string = '#FF000000';
    export const surface: string = '#FF0A0A0A';
    export const surfaceVariant: string = '#FF141414';
    export const outline: string = '#FF2A2A2A';
    export const success: string = '#FF22C55E';
    export const warning: string = '#FFF59E0B';
    export const error: string = '#FFEF4444';
    export const onPrimary: string = '#FF000000';
    export const onSecondary: string = '#FFFFFFFF';
    export const onTertiary: string = '#FFFFFFFF';
    export const onBackground: string = '#FFE0E0E0';
    export const onSurface: string = '#FFE0E0E0';
  }

  export namespace Typography {
    export const displaySize: number = 26;
    export const titleSize: number = 16;
    export const bodySize: number = 13;
    export const labelSize: number = 11;
  }

  export namespace Shapes {
    export const small: number = 6;
    export const medium: number = 10;
    export const large: number = 14;
  }

  export namespace Spacing {
    export const xs: number = 4;
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 16;
    export const xl: number = 24;
    export const xxl: number = 32;
  }
}

@Component
struct MixerSlider {
  label: string = '';
  @Link value: number;

  build() {
    Column() {
      Text(`${this.label} ${Math.round(this.value * 100)}%`)
        .fontSize(AppTokens.Typography.bodySize)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start);

      Slider({
        value: this.value,
        min: 0,
        max: 1,
        step: 0.01,
        style: SliderStyle.OutSet
      })
        .blockColor(AppTokens.Colors.primary)
        .trackColor(AppTokens.Colors.surfaceVariant)
        .selectedColor(AppTokens.Colors.primary)
        .width('100%')
        .onChange((value: number) => {
          this.value = value;
        });
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start);
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
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        Text('Audio Mixer Terminal')
          .fontSize(AppTokens.Typography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .textAlign(TextAlign.Center)
          .height(64);

        Column({ space: AppTokens.Spacing.lg }) {
          MixerSlider({ label: 'Bass', value: $bass })
          MixerSlider({ label: 'Mid', value: $mid })
          MixerSlider({ label: 'Treble', value: $treble })

          Blank()
            .height(AppTokens.Spacing.lg);

          Progress({ value: this.master * 100, total: 100, type: ProgressType.Linear })
            .color(AppTokens.Colors.primary)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .width('100%')
            .height(6);

          Text(`Master Volume ${Math.round(this.master * 100)}%`)
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start);

          Slider({
            value: this.master,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet
          })
            .blockColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .selectedColor(AppTokens.Colors.primary)
            .width('100%')
            .onChange((value: number) => {
              this.master = value;
            });

          Button('Apply Settings', { type: ButtonType.Normal })
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .width('100%')
            .height(48)
            .onClick(() => {
              prompt.showToast({ message: 'Settings applied' });
            });
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .layoutWeight(1);
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}
