// MARK: - AppTokens
// Design tokens corresponding to the SwiftUI AppTokens struct
class AppTokens {
  static class Colors {
    static readonly primary: string = '#FFEF476F';
    static readonly secondary: string = '#FFFFD166';
    static readonly tertiary: string = '#FF06D6A0';
    static readonly background: string = '#FFFFFCF2';
    static readonly surface: string = '#FFFFFFFF';
    static readonly surfaceVariant: string = '#FFF7EDE2';
    static readonly outline: string = '#FFE5D4B1';
    static readonly success: string = '#FF06D6A0';
    static readonly warning: string = '#FFFFA600';
    static readonly error: string = '#FFD62828';
    static readonly onPrimary: string = '#FFFFFFFF';
    static readonly onSecondary: string = '#FF1E1E1E';
    static readonly onTertiary: string = '#FF1E1E1E';
    static readonly onBackground: string = '#FF1E1E1E';
    static readonly onSurface: string = '#FF1E1E1E';
  }

  static class TypographyTokens {
    static readonly displaySize: number = 26;
    static readonly displayWeight: FontWeight = FontWeight.Bold;
    static readonly titleSize: number = 18;
    static readonly titleWeight: FontWeight = FontWeight.Medium;
    static readonly bodySize: number = 14;
    static readonly bodyWeight: FontWeight = FontWeight.Regular;
    static readonly labelSize: number = 12;
    static readonly labelWeight: FontWeight = FontWeight.Medium;
  }

  static class Shapes {
    static readonly smallCornerRadius: number = 6;
    static readonly mediumCornerRadius: number = 10;
    static readonly largeCornerRadius: number = 16;
  }

  static class Spacing {
    static readonly xs: number = 4;
    static readonly sm: number = 8;
    static readonly md: number = 12;
    static readonly lg: number = 16;
    static readonly xl: number = 24;
  }

  static class ElevationMapping {
    static readonly level1Radius: number = 2;
    static readonly level1Dy: number = 2;
    static readonly level1Opacity: number = 0.12;
    static readonly level2Radius: number = 4;
    static readonly level2Dy: number = 4;
    static readonly level2Opacity: number = 0.16;
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

  private readonly buttonHeight: number = 44;
  private readonly fabSize: number = 56;
  private readonly circleRadius: number = 10;

  private get topBarHeight(): number {
    return 30 + (2 * AppTokens.Spacing.md);
  }

  private get bottomBarHeight(): number {
    return this.buttonHeight + (2 * AppTokens.Spacing.md);
  }

  private get fabBottomMargin(): number {
    return AppTokens.Spacing.xl;
  }

  private get canvasBottomPadding(): number {
    return Math.max(this.bottomBarHeight, this.fabSize + this.fabBottomMargin);
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
        top: this.topBarHeight,
        bottom: this.canvasBottomPadding
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
        .margin({ right: AppTokens.Spacing.xl, bottom: this.fabBottomMargin })
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
