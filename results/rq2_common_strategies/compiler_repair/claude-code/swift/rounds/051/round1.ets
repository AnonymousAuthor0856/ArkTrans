import prompt from '@ohos.promptAction';

// MARK: - AppTokens

interface FontToken {
  size: number;
  weight: number;
}

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF00FFFF';
    export const secondary: string = '#FF00B4FF';
    export const tertiary: string = '#FF8A2BE2';
    export const background: string = '#FF0A0A1A';
    export const surface: string = '#FF141436';
    export const surfaceVariant: string = '#FF1E1E4A';
    export const outline: string = '#FF2E2E5C';
    export const success: string = '#FF00FFAA';
    export const warning: string = '#FFFFCC00';
    export const error: string = '#FFFF4444';
    export const onPrimary: string = '#FF0A0A1A';
    export const onSecondary: string = '#FFFFFFFF';
    export const onBackground: string = '#FFFFFFFF';
    export const onSurface: string = '#FFFFFFFF';
  }

  export namespace TypographyTokens {
    export const display: FontToken = { size: 28, weight: FontWeight.Bold };
    export const title: FontToken = { size: 18, weight: FontWeight.Medium };
    export const body: FontToken = { size: 14, weight: FontWeight.Regular };
    export const label: FontToken = { size: 12, weight: FontWeight.Medium };
  }

  export namespace Shapes {
    export const smallCornerRadius: number = 8;
    export const mediumCornerRadius: number = 14;
    export const largeCornerRadius: number = 22;
  }

  export namespace Spacing {
    export const sm: number = 6;
    export const md: number = 10;
    export const lg: number = 16;
    export const xl: number = 24;
    export const xxl: number = 36;
  }

  export class ShadowSpec {
    elevation: number;
    radius: number;
    dy: number;
    opacity: number;

    constructor(elevation: number, radius: number, dy: number, opacity: number) {
      this.elevation = elevation;
      this.radius = radius;
      this.dy = dy;
      this.opacity = opacity;
    }
  }

  export namespace ElevationMapping {
    export const level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.1);
    export const level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.15);
    export const level3: ShadowSpec = new ShadowSpec(10, 12, 6, 0.18);
  }
}

// MARK: - RootScreen Component

@Entry
@Component
struct RootScreen {
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F'];
  private bottomBarHeight: number = 56;
  private fabSize: number = 56;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  @Builder
  DepartureItem(departure: string, status: string) {
    Row() {
      Text(departure)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Blank()

      Text(status)
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .fontColor(AppTokens.Colors.success)
    }
    .width('100%')
  }

  aboutToAppear(): void {
    this.drawMetroCanvas();
  }

  build() {
    Stack() {
      // Main content area
      Column({ space: AppTokens.Spacing.lg }) {
        Text('Metro Planner')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Canvas for metro line and stations
        Stack() {
          Canvas(this.canvasCtx)
            .width('100%')
            .height('100%')
        }
        .padding(AppTokens.Spacing.md)
        .height(260)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.largeCornerRadius)
        .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

        // Next Departures card
        Column({ space: AppTokens.Spacing.sm }) {
          Text('Next Departures')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.secondary)

          this.DepartureItem('08:45 • Line 1', 'On Time')
          this.DepartureItem('09:10 • Line 2', 'On Time')
          this.DepartureItem('09:30 • Line 3', 'On Time')
        }
        .alignItems(HorizontalAlign.Start)
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.largeCornerRadius)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: AppTokens.Colors.outline,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy,
          fill: false
        })
        .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

        Blank()
      }
      .padding({ top: AppTokens.Spacing.lg })
      .padding({ bottom: this.bottomBarHeight })
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[AppTokens.Colors.background, 0.0], [AppTokens.Colors.surfaceVariant, 0.5], [AppTokens.Colors.background, 1.0]]
      })

      // Floating Action Button
      Column() {
        Blank()
        Row() {
          Blank()
          Button('+', { type: ButtonType.Circle })
            .width(this.fabSize)
            .height(this.fabSize)
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .margin({ right: AppTokens.Spacing.lg, bottom: this.bottomBarHeight + AppTokens.Spacing.lg })
            .onClick(() => {
              prompt.showToast({ message: 'FAB clicked' });
            })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')

      // Bottom App Bar
      Column() {
        Blank()
        Row() {
          Text('Routes')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.secondary)

          Blank()

          Text('Planner')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Text('Tickets')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Text('Profile')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .width('100%')
        .height(this.bottomBarHeight)
        .backgroundColor(AppTokens.Colors.surface)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  private drawMetroCanvas(): void {
    const ctx = this.canvasCtx;
    const width: number = 360;
    const height: number = 240;
    const count: number = this.stations.length;
    const step: number = width / (count - 1);

    // Draw the metro line with gradient
    const gradient = ctx.createLinearGradient(0, 0, width, 0);
    gradient.addColorStop(0, AppTokens.Colors.secondary);
    gradient.addColorStop(1, AppTokens.Colors.primary);

    ctx.beginPath();
    ctx.strokeStyle = gradient;
    ctx.lineWidth = 6;
    ctx.lineCap = 'round';
    ctx.lineJoin = 'round';

    for (let i = 0; i < count; i++) {
      const x: number = i * step;
      const y: number = i % 2 === 0 ? height / 4 : height * 3 / 4;
      if (i === 0) {
        ctx.moveTo(x, y);
      } else {
        ctx.lineTo(x, y);
      }
    }
    ctx.stroke();

    // Draw station circles
    for (let i = 0; i < count; i++) {
      const x: number = i * step;
      const y: number = i % 2 === 0 ? height / 4 : height * 3 / 4;

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
