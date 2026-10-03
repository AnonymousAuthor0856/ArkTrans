import { router } from '@kit.ArkUI';

// Design Tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF7043';
    export const secondary: string = '#FFB74D';
    export const tertiary: string = '#FFD180';
    export const background: string = '#FFF3E0';
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#FFE0B2';
    export const outline: string = '#D7CCC8';
    export const success: string = '#66BB6A';
    export const warning: string = '#FFCA28';
    export const error: string = '#D32F2F';
    export const onPrimary: string = '#FFFFFF';
    export const onSecondary: string = '#3E2723';
    export const onBackground: string = '#3E2723';
    export const onSurface: string = '#3E2723';
  }

  export namespace TypographyTokens {
    export const displaySize: number = 28;
    export const titleSize: number = 18;
    export const bodySize: number = 14;
    export const labelSize: number = 12;
  }

  export namespace Spacing {
    export const sm: number = 6;
    export const md: number = 10;
    export const lg: number = 16;
    export const xl: number = 24;
  }

  export namespace ShapeRadius {
    export const small: number = 6;
    export const medium: number = 10;
    export const large: number = 16;
  }
}

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.45;

  build() {
    Scroll() {
      Column({ space: AppTokens.Spacing.lg }) {

        // Title
        Text('Order Tracking')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')

        // Order Card
        Column({ space: AppTokens.Spacing.md }) {
          Text('Order #25491')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')

          Text('Estimated Delivery: 2 days')
            .fontSize(AppTokens.TypographyTokens.bodySize)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppTokens.Colors.secondary)
            .width('100%')

          // Progress Bar
          Stack({ alignContent: Alignment.Start }) {
            // Track
            Row()
              .width('100%')
              .height(10)
              .borderRadius(5)
              .backgroundColor(AppTokens.Colors.surfaceVariant)

            // Active track
            Row()
              .width(`${this.progress * 100}%`)
              .height(10)
              .borderRadius(5)
              .backgroundColor(AppTokens.Colors.primary)
          }
          .width('100%')
          .height(10)

          // Progress Labels
          Row() {
            Text('Processing')
              .fontSize(AppTokens.TypographyTokens.labelSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.secondary)

            Text(`${Math.floor(this.progress * 100)}%`)
              .fontSize(AppTokens.TypographyTokens.labelSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.primary)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.ShapeRadius.large)
        .shadow({
          radius: 8,
          color: '#26000000',
          offsetX: 0,
          offsetY: 4
        })

        // Adjust Progress Box
        Column({ space: AppTokens.Spacing.md }) {
          Text('Adjust Progress')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Center)

          // Slider
          Slider({
            value: this.progress * 100,
            min: 0,
            max: 100,
            step: 1,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .trackColor(AppTokens.Colors.surfaceVariant)
            .selectedColor(AppTokens.Colors.primary)
            .blockColor(AppTokens.Colors.primary)
            .onChange((value: number) => {
              this.progress = value / 100;
            })

          // Mark as Delivered Button
          Button('Mark as Delivered')
            .width('100%')
            .height(48)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(AppTokens.TypographyTokens.labelSize)
            .fontWeight(FontWeight.Medium)
            .borderRadius(AppTokens.ShapeRadius.medium)
            .onClick(() => {
              this.progress = 1.0;
            })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.ShapeRadius.large)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .scrollBar(BarState.Off)
  }
}