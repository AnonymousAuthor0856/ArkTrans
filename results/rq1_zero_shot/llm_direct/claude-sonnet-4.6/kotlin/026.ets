import { curves } from '@kit.ArkUI';

// Token definitions
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#38BDF8';
    export const secondary: string = '#A78BFA';
    export const tertiary: string = '#7DD3FC';
    export const background: string = '#F1F5F9';
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#E2E8F0';
    export const outline: string = '#CBD5E1';
    export const success: string = '#22C55E';
    export const warning: string = '#F59E0B';
    export const error: string = '#EF4444';
    export const onPrimary: string = '#FFFFFF';
    export const onSecondary: string = '#1E1E1E';
    export const onTertiary: string = '#1E1E1E';
    export const onBackground: string = '#1E1E1E';
    export const onSurface: string = '#1E1E1E';
  }

  export namespace Spacing {
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
  @State scrollOffsetY: number = 0;
  @State lastTouchY: number = 0;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Glass Doc Reader')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main content area
      Stack({ alignContent: Alignment.Center }) {
        // Background gradient layer
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [
              ['#CCE2E8F0', 0.0],
              ['#FFF1F5F9', 0.5],
              ['#CCE2E8F0', 1.0]
            ]
          })

        // Glass card
        Column({ space: AppTokens.Spacing.md }) {
          Text('Document Reader')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.primary)

          ForEach([1, 2, 3, 4, 5, 6, 7, 8], (item: number) => {
            Text(`This is a sample line of text content number ${item}.`)
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppTokens.Colors.onSurface)
              .width('100%')
          })
        }
        .width('90%')
        .height(400)
        .padding(AppTokens.Spacing.lg)
        .backgroundColor('#B3FFFFFF')
        .borderRadius(20)
        .shadow({
          radius: 8,
          color: '#2E000000',
          offsetX: 0,
          offsetY: 4
        })
        .translate({ y: this.scrollOffsetY / 5 })
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Down) {
            this.lastTouchY = event.touches[0].y;
          } else if (event.type === TouchType.Move) {
            const deltaY = event.touches[0].y - this.lastTouchY;
            this.scrollOffsetY += deltaY;
            this.lastTouchY = event.touches[0].y;
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .onTouch((event: TouchEvent) => {
        if (event.type === TouchType.Down) {
          this.lastTouchY = event.touches[0].y;
        } else if (event.type === TouchType.Move) {
          const deltaY = event.touches[0].y - this.lastTouchY;
          this.scrollOffsetY += deltaY;
          this.lastTouchY = event.touches[0].y;
        }
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}