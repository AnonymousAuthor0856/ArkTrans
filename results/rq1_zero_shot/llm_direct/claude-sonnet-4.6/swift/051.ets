import { LengthMetrics } from '@kit.ArkUI';

// MARK: - AppTokens

namespace AppTokens {
  export namespace Colors {
    export const primary = '#FF00FFFF';
    export const secondary = '#FF00B4FF';
    export const tertiary = '#FF8A2BE2';
    export const background = '#FF0A0A1A';
    export const surface = '#FF141436';
    export const surfaceVariant = '#FF1E1E4A';
    export const outline = '#FF2E2E5C';
    export const success = '#FF00FFAA';
    export const warning = '#FFFFCC00';
    export const error = '#FFFF4444';
    export const onPrimary = '#FF0A0A1A';
    export const onSecondary = '#FFFFFFFF';
    export const onBackground = '#FFFFFFFF';
    export const onSurface = '#FFFFFFFF';
  }

  export namespace TypographyTokens {
    export const displaySize = 28;
    export const titleSize = 18;
    export const bodySize = 14;
    export const labelSize = 12;
  }

  export namespace Shapes {
    export const smallCornerRadius = 8;
    export const mediumCornerRadius = 14;
    export const largeCornerRadius = 22;
  }

  export namespace Spacing {
    export const sm = 6;
    export const md = 10;
    export const lg = 16;
    export const xl = 24;
    export const xxl = 36;
  }

  export interface ShadowSpec {
    elevation: number;
    radius: number;
    dy: number;
    opacity: number;
  }

  export namespace ElevationMapping {
    export const level1: ShadowSpec = { elevation: 2, radius: 4, dy: 2, opacity: 0.1 };
    export const level2: ShadowSpec = { elevation: 6, radius: 8, dy: 4, opacity: 0.15 };
    export const level3: ShadowSpec = { elevation: 10, radius: 12, dy: 6, opacity: 0.18 };
  }
}

// MARK: - MetroCanvasComponent

@Component
struct MetroCanvas {
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F'];
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Canvas(this.context)
      .width('100%')
      .height(260)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.largeCornerRadius)
      .padding(AppTokens.Spacing.md)
      .onReady(() => {
        this.drawMetroMap();
      })
  }

  private drawMetroMap() {
    const ctx = this.context;
    const width = ctx.width;
    const height = ctx.height;
    const count = this.stations.length;
    const step = width / (count - 1);

    // Draw line with gradient
    const gradient = ctx.createLinearGradient(0, 0, width, 0);
    gradient.addColorStop(0, AppTokens.Colors.secondary);
    gradient.addColorStop(1, AppTokens.Colors.primary);

    ctx.beginPath();
    for (let i = 0; i < count; i++) {
      const x = i * step;
      const y = i % 2 === 0 ? height / 4 : (height * 3) / 4;
      if (i === 0) {
        ctx.moveTo(x, y);
      } else {
        ctx.lineTo(x, y);
      }
    }
    ctx.strokeStyle = gradient;
    ctx.lineWidth = 6;
    ctx.stroke();

    // Draw station circles
    for (let i = 0; i < count; i++) {
      const x = i * step;
      const y = i % 2 === 0 ? height / 4 : (height * 3) / 4;

      // Outer circle
      ctx.beginPath();
      ctx.arc(x, y, 16, 0, Math.PI * 2);
      ctx.fillStyle = AppTokens.Colors.primary;
      ctx.fill();

      // Inner circle
      ctx.beginPath();
      ctx.arc(x, y, 6, 0, Math.PI * 2);
      ctx.fillStyle = AppTokens.Colors.background;
      ctx.fill();
    }
  }
}

// MARK: - RootScreen

@Entry
@Component
struct RootScreen {
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F'];
  private bottomBarHeight = 56;
  private fabSize = 56;
  private departures: string[] = ['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3'];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Main scrollable content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Title
          Text('Metro Planner')
            .fontSize(AppTokens.TypographyTokens.displaySize)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.primary)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Metro Map Canvas
          MetroCanvas()
            .width('100%')
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

          // Next Departures Card
          Column({ space: AppTokens.Spacing.sm }) {
            Text('Next Departures')
              .fontSize(AppTokens.TypographyTokens.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.secondary)
              .width('100%')
              .textAlign(TextAlign.Start)

            ForEach(this.departures, (departure: string) => {
              Row() {
                Text(departure)
                  .fontSize(AppTokens.TypographyTokens.bodySize)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(AppTokens.Colors.onSurface)

                Blank()

                Text('On Time')
                  .fontSize(AppTokens.TypographyTokens.labelSize)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.success)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
            }, (item: string) => item)
          }
          .padding(AppTokens.Spacing.lg)
          .width('100%')
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.largeCornerRadius)
          .shadow({
            radius: AppTokens.ElevationMapping.level2.radius,
            color: AppTokens.Colors.outline,
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level2.dy
          })
          .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

          // Bottom spacer to avoid FAB/BottomBar overlap
          Blank()
            .height(this.bottomBarHeight + AppTokens.Spacing.xl)
        }
        .padding({ top: AppTokens.Spacing.lg })
        .width('100%')
        .constraintSize({ minHeight: '100%' })
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.background, 0.0],
          [AppTokens.Colors.surfaceVariant, 0.5],
          [AppTokens.Colors.background, 1.0]
        ]
      })
      .scrollBar(BarState.Off)

      // Bottom App Bar
      Row({ space: 0 }) {
        Text('Routes')
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontColor(AppTokens.Colors.secondary)

        Blank()

        Text('Planner')
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Text('Tickets')
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Text('Profile')
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(this.bottomBarHeight)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)

      // Floating Action Button
      Button('+')
        .fontSize(AppTokens.TypographyTokens.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .width(this.fabSize)
        .height(this.fabSize)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(this.fabSize / 2)
        .margin({
          right: AppTokens.Spacing.lg,
          bottom: this.bottomBarHeight + AppTokens.Spacing.lg
        })
        .alignSelf(ItemAlign.End)
        .onClick(() => {})
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}