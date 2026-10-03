// MARK: - AppTokens
// Design tokens corresponding to the SwiftUI AppTokens struct
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FFEF476F';
    export const secondary: string = '#FFFFD166';
    export const tertiary: string = '#FF06D6A0';
    export const background: string = '#FFFFFCF2';
    export const surface: string = '#FFFFFFFF';
    export const surfaceVariant: string = '#FFF7EDE2';
    export const outline: string = '#FFE5D4B1';
    export const success: string = '#FF06D6A0';
    export const warning: string = '#FFFFA600';
    export const error: string = '#FFD62828';
    export const onPrimary: string = '#FFFFFFFF';
    export const onSecondary: string = '#FF1E1E1E';
    export const onTertiary: string = '#FF1E1E1E';
    export const onBackground: string = '#FF1E1E1E';
    export const onSurface: string = '#FF1E1E1E';
  }

  export namespace TypographyTokens {
    export const displaySize: number = 26;
    export const displayWeight: FontWeight = FontWeight.Bold;
    export const titleSize: number = 18;
    export const titleWeight: FontWeight = FontWeight.Medium;
    export const bodySize: number = 14;
    export const bodyWeight: FontWeight = FontWeight.Regular;
    export const labelSize: number = 12;
    export const labelWeight: FontWeight = FontWeight.Medium;
  }

  export namespace Shapes {
    export const smallCornerRadius: number = 6;
    export const mediumCornerRadius: number = 10;
    export const largeCornerRadius: number = 16;
  }

  export namespace Spacing {
    export const xs: number = 4;
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 16;
    export const xl: number = 24;
  }

  export namespace ElevationMapping {
    export const level1Radius: number = 2;
    export const level1Dy: number = 2;
    export const level1Opacity: number = 0.12;
    export const level2Radius: number = 4;
    export const level2Dy: number = 4;
    export const level2Opacity: number = 0.16;
  }
}

// MARK: - Drawing Point
interface DrawPoint {
  x: number;
  y: number;
}

// MARK: - RetroWhiteboardApp Component
@Entry
@Component
struct RetroWhiteboardApp {
  @State points: DrawPoint[] = [];
  @State currentColor: string = AppTokens.Colors.primary;

  private buttonHeight: number = 44;
  private fabSize: number = 56;
  private circleRadius: number = 10;

  private getTopBarHeight(): number {
    return 30 + (2 * AppTokens.Spacing.md);
  }

  private getBottomBarHeight(): number {
    return this.buttonHeight + (2 * AppTokens.Spacing.md);
  }

  private getFabBottomMargin(): number {
    return AppTokens.Spacing.xl;
  }

  private getCanvasBottomPadding(): number {
    return Math.max(this.getBottomBarHeight(), this.fabSize + this.getFabBottomMargin());
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // 2. Drawing canvas area
      Stack() {
        Canvas() {
          ForEach(this.points, (item: DrawPoint) => {
            Circle({
              width: this.circleRadius * 2,
              height: this.circleRadius * 2
            })
              .fill(this.currentColor)
              .translate({
                x: item.x - this.circleRadius,
                y: item.y - this.circleRadius
              })
          }, (item: DrawPoint, index: number) => index.toString())
        }
        .width('100%')
        .height('100%')
        .gesture(
          PanGesture({ distance: 0 })
            .onActionUpdate((event: GestureEvent) => {
              this.points.push({
                x: event.fingerList[0].localX,
                y: event.fingerList[0].localY
              });
            })
        )
      }
      .width('100%')
      .height('100%')
      .padding({
        top: this.getTopBarHeight(),
        bottom: this.getCanvasBottomPadding()
      })

      // 3. Top bar
      Text('Retro Whiteboard')
        .fontSize(AppTokens.TypographyTokens.displaySize)
        .fontWeight(AppTokens.TypographyTokens.displayWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(AppTokens.Colors.background)
        .align(Alignment.Top)

      // 4. Bottom color selection bar
      Row() {
        Blank()
        this.ColorButton('Red', AppTokens.Colors.primary, AppTokens.Colors.onPrimary)
        Blank()
        this.ColorButton('Yellow', AppTokens.Colors.secondary, AppTokens.Colors.onSecondary)
        Blank()
        this.ColorButton('Green', AppTokens.Colors.tertiary, AppTokens.Colors.onTertiary)
        Blank()
      }
      .width('100%')
      .padding(AppTokens.Spacing.md)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: AppTokens.ElevationMapping.level1Radius,
        color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1Opacity})`,
        offsetY: AppTokens.ElevationMapping.level1Dy
      })
      .align(Alignment.Bottom)

      // 5. Floating Action Button - Clear canvas
      Text('Clear')
        .fontSize(AppTokens.TypographyTokens.labelSize)
        .fontWeight(AppTokens.TypographyTokens.labelWeight)
        .fontColor(AppTokens.Colors.onSecondary)
        .width(this.fabSize)
        .height(this.fabSize)
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(this.fabSize / 2)
        .shadow({
          radius: AppTokens.ElevationMapping.level1Radius,
          color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1Opacity})`,
          offsetY: AppTokens.ElevationMapping.level1Dy
        })
        .onClick(() => {
          this.points = [];
        })
        .margin({ right: AppTokens.Spacing.xl, bottom: this.getFabBottomMargin() })
        .align(Alignment.BottomEnd)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  private ColorButton(label: string, bgColor: string, textColor: string) {
    Text(label)
      .fontSize(AppTokens.TypographyTokens.bodySize)
      .fontWeight(AppTokens.TypographyTokens.bodyWeight)
      .fontColor(textColor)
      .width('100%')
      .height(this.buttonHeight)
      .textAlign(TextAlign.Center)
      .backgroundColor(bgColor)
      .borderRadius(AppTokens.Shapes.smallCornerRadius)
      .onClick(() => {
        this.currentColor = bgColor;
      })
  }
}
