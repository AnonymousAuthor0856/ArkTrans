import { Color, Font, LinearGradient, Offset, Rect } from '@kit.ArkUI';

// MARK: - AppTokens
class AppTokens {
  static readonly Colors = {
    primary: '#38BDF8',
    secondary: '#A78BFA',
    tertiary: '#7DD3FC',
    background: '#F1F5F9',
    surface: '#FFFFFF',
    surfaceVariant: '#E2E8F0',
    outline: '#CBD5E1',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  };

  static readonly TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static readonly Shapes = {
    small: 6,
    medium: 12,
    large: 20
  };

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };

  static readonly ElevationMapping = {
    level2: {
      opacity: 0.18,
      radius: 8,
      dy: 4
    }
  };
}

@Entry
@Component
struct RootScreen {
  @State scrollOffset: number = 0;
  private dragGesture: GestureOverlay = new GestureOverlay();

  build() {
    Column() {
      // Top Bar
      Text('Glass Doc Reader')
        .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
        .foregroundColor(AppTokens.Colors.onSurface)
        .padding({ top: 20 })
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Stack({ alignContent: Alignment.Center }) {
        // Background Gradient
        LinearGradient({
          angle: 90,
          colors: [
            ['rgba(226, 232, 240, 0.8)', 0],
            ['#F1F5F9', 0.5],
            ['rgba(226, 232, 240, 0.8)', 1]
          ]
        })
          .width('100%')
          .height('100%')

        // Surface Card
        Column({ space: AppTokens.Spacing.md }) {
          Text('Document Reader')
            .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
            .foregroundColor(AppTokens.Colors.primary)

          ForEach(Array.from({ length: 8 }, (_, i) => i), (index: number) => {
            Text(`This is a sample line of text content number ${index + 1}.`)
              .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
              .foregroundColor(AppTokens.Colors.onSurface)
          })

          Blank()
        }
        .padding(AppTokens.Spacing.lg)
        .width('90%')
        .height(400)
        .backgroundColor(Color.White.withAlpha(0.7))
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: Color.Black.withAlpha(AppTokens.ElevationMapping.level2.opacity),
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })
        .translate({ y: this.scrollOffset / 5 })
        .gesture(
          PanGesture()
            .onActionUpdate((event?: GestureEvent) => {
              if (event) {
                this.scrollOffset += event.offsetY;
              }
            })
        )
      }
      .layoutWeight(1)
    }
    .backgroundColor(AppTokens.Colors.background)
    .width('100%')
    .height('100%')
  }
}