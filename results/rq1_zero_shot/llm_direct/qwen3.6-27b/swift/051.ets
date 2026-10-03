import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens (Translation of Kotlin AppTokens)

class AppTokens {
  static Colors = {
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
    onSurface: '#FFFFFF' // White
  };

  static TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes = {
    smallCornerRadius: 8,
    mediumCornerRadius: 14,
    largeCornerRadius: 22
  };

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36
  };

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.1 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.15 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 }
  };
}

@Entry
@Component
struct RootScreen {
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F'];
  private bottomBarHeight: number = 56;
  private fabSize: number = 56;

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Text('Metro Planner')
          .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
          .foregroundColor(AppTokens.Colors.primary)
          .alignSelf(ItemAlignment.Start)

        // Canvas for drawing the metro line and stations
        CustomPainter(this.stations)
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
          .height(260)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.largeCornerRadius)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

        // Card for "Next Departures" section
        Column({ space: AppTokens.Spacing.sm }) {
          Text('Next Departures')
            .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
            .foregroundColor(AppTokens.Colors.secondary)
            .alignSelf(ItemAlignment.Start)

          ForEach(['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3'], (departure: string) => {
            Row() {
              Text(departure)
                .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
                .foregroundColor(AppTokens.Colors.onSurface)
              Blank().layoutWeight(1)
              Text('On Time')
                .font({ size: AppTokens.TypographyTokens.label.size, weight: AppTokens.TypographyTokens.label.weight })
                .foregroundColor(AppTokens.Colors.success)
            }
          })
        }
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.largeCornerRadius)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: Color(AppTokens.Colors.outline).withOpacity(AppTokens.ElevationMapping.level2.opacity),
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

        Blank().height(AppTokens.Spacing.md)
      }
      .padding({ top: AppTokens.Spacing.lg, bottom: this.bottomBarHeight })
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.background, 0],
          [AppTokens.Colors.surfaceVariant, 0.5],
          [AppTokens.Colors.background, 1]
        ]
      })

      // Floating Action Button (FAB)
      Button() {
        Text('+')
          .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
          .foregroundColor(AppTokens.Colors.onPrimary)
      }
      .type(ButtonType.Circle)
      .width(this.fabSize)
      .height(this.fabSize)
      .backgroundColor(AppTokens.Colors.primary)
      .position({ x: '100%', y: '100%' })
      .offset({ x: -(this.fabSize / 2 + AppTokens.Spacing.lg), y: -(this.bottomBarHeight + AppTokens.Spacing.lg + this.fabSize / 2) })

      // Bottom App Bar
      Row() {
        Text('Routes')
          .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
          .foregroundColor(AppTokens.Colors.secondary)
        Blank().layoutWeight(1)
        Text('Planner')
          .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
          .foregroundColor(AppTokens.Colors.onSurface)
        Blank().layoutWeight(1)
        Text('Tickets')
          .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
          .foregroundColor(AppTokens.Colors.onSurface)
        Blank().layoutWeight(1)
        Text('Profile')
          .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
          .foregroundColor(AppTokens.Colors.onSurface)
      }
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .width('100%')
      .height(this.bottomBarHeight)
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct CustomPainter {
  private stations: string[] = [];

  aboutToAppear(): void {
    // Initialization if needed
  }

  build() {
    CustomShape(this.drawPath)
      .width('100%')
      .height('100%')
  }

  drawPath(context: CanvasRenderingContext2D, width: number, height: number): void {
    const step = width / (this.stations.length - 1);
    let path = new Path2D();

    for (let i = 0; i < this.stations.length; i++) {
      const x = i * step;
      const y = i % 2 === 0 ? height / 4 : height * 3 / 4;
      if (i === 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    // Draw the line with a horizontal gradient brush and stroke width
    const gradient = context.createLinearGradient(0, 0, width, 0);
    gradient.addColorStop(0, AppTokens.Colors.secondary);
    gradient.addColorStop(1, AppTokens.Colors.primary);
    context.strokeStyle = gradient;
    context.lineWidth = 6;
    context.stroke(path);

    // Draw the circles for stations
    for (let i = 0; i < this.stations.length; i++) {
      const x = i * step;
      const y = i % 2 === 0 ? height / 4 : height * 3 / 4;

      // Outer circle
      context.fillStyle = AppTokens.Colors.primary;
      context.beginPath();
      context.arc(x, y, 16, 0, Math.PI * 2);
      context.fill();

      // Inner circle
      context.fillStyle = AppTokens.Colors.background;
      context.beginPath();
      context.arc(x, y, 6, 0, Math.PI * 2);
      context.fill();
    }
  }
}