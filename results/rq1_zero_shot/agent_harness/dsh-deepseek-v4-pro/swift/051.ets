// MARK: - AppTokens (Translation of Kotlin AppTokens)

interface FontStyle {
  size: number;
  weight: FontWeight;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokens {
  static readonly Colors: Record<string, string> = {
    primary: '#00FFFF', // Cyan
    secondary: '#00B4FF', // Light Blue
    tertiary: '#8A2BE2', // Blue Violet
    background: '#0A0A1A', // Dark Navy
    surface: '#141436', // Darker Purple-Blue
    surfaceVariant: '#1E1E4A', // Even Darker Purple-Blue
    outline: '#2E2E5C', // Dark Purple-Blue
    success: '#00FFAA', // Greenish Cyan
    warning: '#FFCC00', // Yellow
    error: '#FF4444', // Red
    onPrimary: '#0A0A1A', // Dark Navy (on primary)
    onSecondary: '#FFFFFF', // White
    onBackground: '#FFFFFF', // White
    onSurface: '#FFFFFF', // White,
  };

  static readonly Typography: Record<string, FontStyle> = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static readonly Shapes: Record<string, number> = {
    small: 8,
    medium: 14,
    large: 22,
  };

  static readonly Spacing: Record<string, number> = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36,
  };

  static readonly ElevationMapping: Record<string, ShadowSpec> = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.1 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.15 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 },
  };
}

@Component
struct RootScreen {
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F'];
  private bottomBarHeight: number = 56;
  private fabSize: number = 56;
  private departures: string[] = ['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3'];
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private drawMetro(): void {
    const ctx: CanvasRenderingContext2D = this.context;
    const width: number = ctx.width;
    const height: number = ctx.height;
    const step: number = width / (this.stations.length - 1);
    ctx.beginPath();
    for (let i = 0; i < this.stations.length; i++) {
      const x: number = i * step;
      const y: number = i % 2 === 0 ? height / 4 : height * 3 / 4;
      if (i === 0) {
        ctx.moveTo(x, y);
      } else {
        ctx.lineTo(x, y);
      }
    }
    const gradient: CanvasGradient = ctx.createLinearGradient(0, 0, width, 0);
    gradient.addColorStop(0, AppTokens.Colors.secondary);
    gradient.addColorStop(1, AppTokens.Colors.primary);
    ctx.strokeStyle = gradient;
    ctx.lineWidth = 6;
    ctx.stroke();

    for (let i = 0; i < this.stations.length; i++) {
      const x: number = i * step;
      const y: number = i % 2 === 0 ? height / 4 : height * 3 / 4;
      ctx.beginPath();
      ctx.arc(x, y, 16, 0, Math.PI * 2);
      ctx.fillStyle = AppTokens.Colors.primary;
      ctx.fill();
      ctx.beginPath();
      ctx.arc(x, y, 6, 0, Math.PI * 2);
      ctx.fillStyle = AppTokens.Colors.background;
      ctx.fill();
    }
  }

  build() {
    Stack() {
      Column({ space: AppTokens.Spacing.lg }) {
        Text('Metro Planner')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .textAlign(TextAlign.Start)

        Canvas(this.context)
          .padding(AppTokens.Spacing.md)
          .height(260)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.large)
          .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          .onReady(() => {
            this.drawMetro();
          })

        Column({ space: AppTokens.Spacing.sm }) {
          Text('Next Departures')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.secondary)

          ForEach(this.departures, (departure: string) => {
            Row() {
              Text(departure)
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
              Blank()
              Text('On Time')
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(AppTokens.Colors.success)
            }
          }, (departure: string) => departure)
        }
        .alignItems(HorizontalAlign.Start)
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: '#262E2E5C',
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })
        .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

        Blank(AppTokens.Spacing.md)
      }
      .width('100%')
      .height('100%')
      .padding({ top: AppTokens.Spacing.lg, bottom: this.bottomBarHeight })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.background, 0.0],
          [AppTokens.Colors.surfaceVariant, 0.5],
          [AppTokens.Colors.background, 1.0]
        ]
      })

      // Floating Action Button (FAB)
      Column() {
        Blank()
        Row() {
          Blank()
          Button() {
            Text('+')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .width(this.fabSize)
          .height(this.fabSize)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(this.fabSize / 2)
          .margin({ right: AppTokens.Spacing.lg, bottom: this.bottomBarHeight + AppTokens.Spacing.lg })
          .onClick(() => {})
        }
      }
      .width('100%')
      .height('100%')

      // Bottom App Bar
      Column() {
        Blank()
        Row() {
          Text('Routes')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.secondary)
          Blank()
          Text('Planner')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
          Text('Tickets')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
          Text('Profile')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
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
}

@Entry
@Component
struct Index {
  build() {
    // statusBarHidden(true) has no direct ArkUI declarative equivalent.
    RootScreen()
  }
}
