// index.ets

// MARK: - Color Extension for Hex Initialization
function hexToColor(hex: number): string {
  const red = (hex & 0xFF0000) >> 16;
  const green = (hex & 0x00FF00) >> 8;
  const blue = hex & 0x0000FF;
  const alpha = (hex & 0xFF000000) >> 24;
  const finalAlpha = (hex & 0xFF000000) === 0 ? 255 : alpha;
  return `#${finalAlpha.toString(16).padStart(2, '0')}${red.toString(16).padStart(2, '0')}${green.toString(16).padStart(2, '0')}${blue.toString(16).padStart(2, '0')}`;
}

// MARK: - AppTokens
class Colors {
  primary: string = hexToColor(0xFF38BDF8);
  secondary: string = hexToColor(0xFFA78BFA);
  tertiary: string = hexToColor(0xFF7DD3FC);
  background: string = hexToColor(0xFFF1F5F9);
  surface: string = hexToColor(0xFFFFFFFF);
  surfaceVariant: string = hexToColor(0xFFE2E8F0);
  outline: string = hexToColor(0xFFCBD5E1);
  success: string = hexToColor(0xFF22C55E);
  warning: string = hexToColor(0xFFF59E0B);
  error: string = hexToColor(0xFFEF4444);
  onPrimary: string = hexToColor(0xFFFFFFFF);
  onSecondary: string = hexToColor(0xFF1E1E1E);
  onTertiary: string = hexToColor(0xFF1E1E1E);
  onBackground: string = hexToColor(0xFF1E1E1E);
  onSurface: string = hexToColor(0xFF1E1E1E);
}

class TypographyTokens {
  display: FontConfig = { size: 28, weight: FontWeight.Bold };
  title: FontConfig = { size: 18, weight: FontWeight.Medium };
  body: FontConfig = { size: 14, weight: FontWeight.Normal };
  label: FontConfig = { size: 12, weight: FontWeight.Medium };
}

class Shapes {
  small: number = 6;
  medium: number = 12;
  large: number = 20;
}

class Spacing {
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 32;
}

class ShadowSpec {
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

class ElevationMapping {
  level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18);
}

class AppTokens {
  static Colors: Colors = new Colors();
  static TypographyTokens: TypographyTokens = new TypographyTokens();
  static Shapes: Shapes = new Shapes();
  static Spacing: Spacing = new Spacing();
  static ElevationMapping: ElevationMapping = new ElevationMapping();
}

interface FontConfig {
  size: number;
  weight: FontWeight;
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State scrollOffsetY: number = 0;
  private lastScrollOffsetY: number = 0;

  build() {
    Column() {
      // Top App Bar
      Text('Glass Doc Reader')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .padding({ top: 20, bottom: AppTokens.Spacing.lg })
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Stack({ alignContent: Alignment.Center }) {
        // Background Gradient
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [
              [AppTokens.Colors.surfaceVariant, 0.8],
              [AppTokens.Colors.background, 1.0],
              [AppTokens.Colors.surfaceVariant, 0.8]
            ]
          })

        // Surface Content
        Column() {
          Text('Document Reader')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.primary)
            .margin({ bottom: AppTokens.Spacing.md })

          ForEach([0, 1, 2, 3, 4, 5, 6, 7], (index: number) => {
            Text(`This is a sample line of text content number ${index + 1}.`)
              .fontSize(AppTokens.TypographyTokens.body.size)
              .fontWeight(AppTokens.TypographyTokens.body.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.sm })
          })

          Blank()
        }
        .padding(AppTokens.Spacing.lg)
        .width('90%')
        .height(400)
        .backgroundColor(AppTokens.Colors.surface)
        .opacity(0.7)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })
        .offset({ y: this.scrollOffsetY / 5 })
        .gesture(
          PanGesture()
            .onActionStart(() => {
              this.lastScrollOffsetY = this.scrollOffsetY;
            })
            .onActionUpdate((event: GestureEvent) => {
              this.scrollOffsetY = this.lastScrollOffsetY + event.offsetY;
            })
        )
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}