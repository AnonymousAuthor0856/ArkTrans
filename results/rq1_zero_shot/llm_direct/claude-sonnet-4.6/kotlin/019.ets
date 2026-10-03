import { router } from '@kit.ArkUI';

// Design tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#8B5CF6';
    export const secondary: string = '#D946EF';
    export const tertiary: string = '#3B82F6';
    export const background: string = '#F9F5FF';
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#F1E9FE';
    export const outline: string = '#E3D7FE';
    export const success: string = '#22C55E';
    export const warning: string = '#FACC15';
    export const error: string = '#EF4444';
    export const onPrimary: string = '#FFFFFF';
    export const onSecondary: string = '#FFFFFF';
    export const onTertiary: string = '#FFFFFF';
    export const onBackground: string = '#1E1E1E';
    export const onSurface: string = '#1E1E1E';
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

@Entry
@Component
struct RootScreen {
  @State fontSize: number = 24;
  @State syncProgress: number = 0.3;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Subtitle Editor')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main Content
      Column({ space: AppTokens.Spacing.lg }) {

        // Preview Surface
        Stack({ alignContent: Alignment.Center }) {
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(22)
        .shadow({
          radius: 12,
          color: '#2E000000',
          offsetX: 0,
          offsetY: 6
        })

        // Font Size Label
        Text(`Font Size: ${Math.floor(this.fontSize)}sp`)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
          .alignSelf(ItemAlign.Start)

        // Font Size Slider
        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .selectedColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .blockColor(AppTokens.Colors.secondary)
          .onChange((value: number) => {
            this.fontSize = value;
          })

        // Sync Progress Label
        Text('Sync Progress')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
          .alignSelf(ItemAlign.Start)

        // Progress Bar
        Progress({
          value: this.syncProgress * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(6)
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)

        // Buttons Row
        Row({ space: AppTokens.Spacing.md }) {
          Button('Sync +')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(14)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0);
            })

          Button('Sync -')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSecondary)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(14)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0);
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 135,
        colors: [
          [AppTokens.Colors.surfaceVariant, 0.0],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.surface, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}