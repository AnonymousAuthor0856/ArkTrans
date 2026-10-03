// AppTokens.ets
export class AppTokens {
  static readonly Colors: Record<string, string> = {
    primary: '#FF00FFFF', // Cyan
    secondary: '#FF00B4FF', // Light Blue
    tertiary: '#FF8A2BE2', // Blue Violet
    background: '#FF0A0A1A', // Dark Navy
    surface: '#FF141436', // Darker Purple-Blue
    surfaceVariant: '#FF1E1E4A', // Even Darker Purple-Blue
    outline: '#FF2E2E5C', // Dark Purple-Blue
    success: '#FF00FFAA', // Greenish Cyan
    warning: '#FFFFCC00', // Yellow
    error: '#FFFF4444', // Red
    onPrimary: '#FF0A0A1A', // Dark Navy (on primary)
    onSecondary: '#FFFFFFFF', // White
    onBackground: '#FFFFFFFF', // White
    onSurface: '#FFFFFFFF' // White
  }

  static readonly TypographyTokens: Record<string, TypographyToken> = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes: Record<string, number> = {
    smallCornerRadius: 8,
    mediumCornerRadius: 14,
    largeCornerRadius: 22
  }

  static readonly Spacing: Record<string, number> = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36
  }

  static readonly ElevationMapping: Record<string, ShadowSpec> = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.1 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.15 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 }
  }
}

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

// Helper function to apply typography easily
function typography(token: TypographyToken): TypographyStyle {
  return {
    fontSize: token.size,
    fontWeight: token.weight
  };
}

interface TypographyStyle {
  fontSize: number;
  fontWeight: FontWeight;
}

// Helper function to apply shadow easily
function shadowSpec(spec: ShadowSpec): ShadowStyle {
  return {
    radius: spec.radius,
    color: AppTokens.Colors.outline,
    offsetX: 0,
    offsetY: spec.dy
  };
}

interface ShadowStyle {
  radius: number;
  color: string;
  offsetX: number;
  offsetY: number;
}

// RootScreen.ets
@Entry
@Component
struct RootScreen {
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F'];
  private bottomBarHeight: number = 56;
  private fabSize: number = 56;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Stack() {
      // Main content area
      Column() {
        Text('Metro Planner')
          .fontColor(AppTokens.Colors.primary)
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ bottom: AppTokens.Spacing.lg })

        // Canvas for drawing the metro line and stations
        Canvas(this.context)
          .width('100%')
          .height(260)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.largeCornerRadius)
          .margin({ bottom: AppTokens.Spacing.lg })
          .onReady(() => {
            const width = this.context.width;
            const height = this.context.height;
            const step = width / (this.stations.length - 1);

            // Draw the line
            const path = new Path2D();
            path.moveTo(0, height / 4);

            for (let i = 0; i < this.stations.length; i++) {
              const x = i * step;
              const y = i % 2 === 0 ? height / 4 : (height * 3) / 4;
              if (i === 0) {
                path.moveTo(x, y);
              } else {
                path.lineTo(x, y);
              }
            }

            // Apply linear gradient to the line
            const gradient = this.context.createLinearGradient(0, 0, width, 0);
            gradient.addColorStop(0, AppTokens.Colors.secondary);
            gradient.addColorStop(1, AppTokens.Colors.primary);
            this.context.strokeStyle = gradient;
            this.context.lineWidth = 6;
            this.context.stroke(path);

            // Draw the circles for stations
            for (let i = 0; i < this.stations.length; i++) {
              const x = i * step;
              const y = i % 2 === 0 ? height / 4 : (height * 3) / 4;

              // Outer circle
              this.context.fillStyle = AppTokens.Colors.primary;
              this.context.beginPath();
              this.context.arc(x, y, 16, 0, Math.PI * 2);
              this.context.fill();

              // Inner circle
              this.context.fillStyle = AppTokens.Colors.background;
              this.context.beginPath();
              this.context.arc(x, y, 6, 0, Math.PI * 2);
              this.context.fill();
            }
          })

        // Card for "Next Departures" section
        Column() {
          Text('Next Departures')
            .fontColor(AppTokens.Colors.secondary)
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .margin({ bottom: AppTokens.Spacing.sm })

          ForEach(['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3'], (departure: string) => {
            Row() {
              Text(departure)
                .fontColor(AppTokens.Colors.onSurface)
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontWeight(AppTokens.TypographyTokens.body.weight)

              Blank() // Spacer equivalent

              Text('On Time')
                .fontColor(AppTokens.Colors.success)
                .fontSize(AppTokens.TypographyTokens.label.size)
                .fontWeight(AppTokens.TypographyTokens.label.weight)
            }
            .width('100%')
            .margin({ bottom: AppTokens.Spacing.sm })
          })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.largeCornerRadius)
        .shadow(shadowSpec(AppTokens.ElevationMapping.level2))

        Blank() // Spacer to push content up
      }
      .width('100%')
      .height('100%')
      .padding({ top: AppTokens.Spacing.lg, left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: this.bottomBarHeight })
      .linearGradient({
        angle: 180,
        colors: [[AppTokens.Colors.background, 0.0], [AppTokens.Colors.surfaceVariant, 0.5], [AppTokens.Colors.background, 1.0]]
      })

      // Floating Action Button (FAB)
      Column() {
        Blank() // Pushes the FAB to the bottom
        Row() {
          Blank() // Pushes the FAB to the trailing edge
          Button({ type: ButtonType.Circle }) {
            Text('+')
              .fontColor(AppTokens.Colors.onPrimary)
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
          }
          .width(this.fabSize)
          .height(this.fabSize)
          .backgroundColor(AppTokens.Colors.primary)
          .margin({ right: AppTokens.Spacing.lg, bottom: this.bottomBarHeight + AppTokens.Spacing.lg })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')

      // Bottom App Bar
      Column() {
        Blank() // Pushes the bottom bar to the very bottom
        Row() {
          Text('Routes')
            .fontColor(AppTokens.Colors.secondary)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Text('Planner')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Text('Tickets')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Text('Profile')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(this.bottomBarHeight)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.surface)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}