// Index.ets

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface TextStyleSpec {
  fontSize: number;
  fontWeight: number;
}

class AppTokens {
  static readonly Colors = {
    primary: '#EF476F',
    secondary: '#FFD166',
    tertiary: '#06D6A0',
    background: '#FFFCF2',
    surface: '#FFFFFF',
    surfaceVariant: '#F7EDE2',
    outline: '#E5D4B1',
    success: '#06D6A0',
    warning: '#FFA600',
    error: '#D62828',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E',
  };

  static readonly TypographyTokens: Record<string, TextStyleSpec> = {
    display: { fontSize: 26, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  };

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 16,
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
  };

  static readonly ElevationMapping: Record<string, ShadowSpec> = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.16 },
  };
}

interface Point {
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  @State points: Point[] = [];
  @State color: string = AppTokens.Colors.primary;

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background);

      // Main Content Area
      Column() {
        // Top App Bar
        Row() {
          Text('Retro Whiteboard')
            .fontSize(AppTokens.TypographyTokens.display.fontSize)
            .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
            .fontColor(AppTokens.Colors.onSurface);
        }
        .width('100%')
        .height(56)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppTokens.Colors.background);

        // Canvas Area
        Stack() {
          ForEach(this.points, (point: Point, index: number) => {
            Circle({ width: 20, height: 20 })
              .fill(this.color)
              .position({ x: point.x - 10, y: point.y - 10 });
          }, (point: Point, index: number) => `${index}-${point.x}-${point.y}`);
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(AppTokens.Colors.background)
        .gesture(
          PanGesture()
            .onActionStart((event: GestureEvent) => {
              const x = event.fingerList[0].localX;
              const y = event.fingerList[0].localY;
              this.points.push({ x, y });
            })
            .onActionUpdate((event: GestureEvent) => {
              const x = event.fingerList[0].localX;
              const y = event.fingerList[0].localY;
              this.points.push({ x, y });
            })
        );

        // Bottom Bar
        Row() {
          Button('Red')
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .borderRadius(AppTokens.Shapes.small)
            .onClick(() => {
              this.color = AppTokens.Colors.primary;
            });

          Button('Yellow')
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .borderRadius(AppTokens.Shapes.small)
            .onClick(() => {
              this.color = AppTokens.Colors.secondary;
            });

          Button('Green')
            .backgroundColor(AppTokens.Colors.tertiary)
            .fontColor(AppTokens.Colors.onTertiary)
            .borderRadius(AppTokens.Shapes.small)
            .onClick(() => {
              this.color = AppTokens.Colors.tertiary;
            });
        }
        .width('100%')
        .padding(AppTokens.Spacing.md)
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.ElevationMapping.level1.radius,
          color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level1.dy
        });
      }
      .width('100%')
      .height('100%');

      // Floating Action Button
      Button('Clear')
        .backgroundColor(AppTokens.Colors.secondary)
        .fontColor(AppTokens.Colors.onSecondary)
        .borderRadius(28)
        .width(80)
        .height(56)
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
        .position({ x: '80%', y: '85%' })
        .onClick(() => {
          this.points = [];
        });
    }
    .width('100%')
    .height('100%');
  }
}