// MARK: - Color Utility for Hex Initialization
function colorFromHex(hex: number): string {
  let red: number = (hex & 0xFF0000) >> 16;
  let green: number = (hex & 0x00FF00) >> 8;
  let blue: number = hex & 0x0000FF;
  let alpha: number = (hex & 0xFF000000) >>> 24;
  let opacity: number = (hex & 0xFF000000) === 0 ? 1.0 : alpha / 255.0;
  let a: string = Math.round(opacity * 255).toString(16).padStart(2, '0');
  let r: string = red.toString(16).padStart(2, '0');
  let g: string = green.toString(16).padStart(2, '0');
  let b: string = blue.toString(16).padStart(2, '0');
  return '#' + a + r + g + b;
}

function withOpacity(color: string, opacity: number): string {
  if (color.length === 9) {
    let alpha: string = Math.round(opacity * 255).toString(16).padStart(2, '0');
    return '#' + alpha + color.substring(3);
  } else if (color.length === 7) {
    let alpha: string = Math.round(opacity * 255).toString(16).padStart(2, '0');
    return '#' + alpha + color.substring(1);
  }
  return color;
}

// MARK: - AppTokens
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

class AppColors {
  static primary: string = colorFromHex(0xFF38BDF8);
  static secondary: string = colorFromHex(0xFFA78BFA);
  static tertiary: string = colorFromHex(0xFF7DD3FC);
  static background: string = colorFromHex(0xFFF1F5F9);
  static surface: string = colorFromHex(0xFFFFFFFF);
  static surfaceVariant: string = colorFromHex(0xFFE2E8F0);
  static outline: string = colorFromHex(0xFFCBD5E1);
  static success: string = colorFromHex(0xFF22C55E);
  static warning: string = colorFromHex(0xFFF59E0B);
  static error: string = colorFromHex(0xFFEF4444);
  static onPrimary: string = colorFromHex(0xFFFFFFFF);
  static onSecondary: string = colorFromHex(0xFF1E1E1E);
  static onTertiary: string = colorFromHex(0xFF1E1E1E);
  static onBackground: string = colorFromHex(0xFF1E1E1E);
  static onSurface: string = colorFromHex(0xFF1E1E1E);
}

class AppTypographyTokens {
  static displaySize: number = 28;
  static displayWeight: FontWeight = FontWeight.Bold;
  static titleSize: number = 18;
  static titleWeight: FontWeight = FontWeight.Medium;
  static bodySize: number = 14;
  static bodyWeight: FontWeight = FontWeight.Normal;
  static labelSize: number = 12;
  static labelWeight: FontWeight = FontWeight.Medium;
}

class AppShapes {
  static small: number = 6;
  static medium: number = 12;
  static large: number = 20;
}

class AppSpacing {
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 32;
}

class AppElevationMapping {
  static level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18);
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State scrollOffsetY: number = 0;

  build() {
    Column() {
      // CenterAlignedTopAppBar
      Text('Glass Doc Reader')
        .fontSize(AppTypographyTokens.displaySize)
        .fontWeight(AppTypographyTokens.displayWeight)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 20 + AppSpacing.lg, bottom: AppSpacing.lg })
        .backgroundColor(AppColors.background)

      // Main content area (Box with contentAlignment center)
      Stack({ alignContent: Alignment.Center }) {
        // Background gradient
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            angle: 180,
            colors: [
              [withOpacity(AppColors.surfaceVariant, 0.8), 0],
              [AppColors.background, 0.5],
              [withOpacity(AppColors.surfaceVariant, 0.8), 1]
            ]
          })

        // Surface card
        Column() {
          Text('Document Reader')
            .fontSize(AppTypographyTokens.titleSize)
            .fontWeight(AppTypographyTokens.titleWeight)
            .fontColor(AppColors.primary)

          ForEach([0, 1, 2, 3, 4, 5, 6, 7], (index: number) => {
            Text('This is a sample line of text content number ' + (index + 1) + '.')
              .fontSize(AppTypographyTokens.bodySize)
              .fontWeight(AppTypographyTokens.bodyWeight)
              .fontColor(AppColors.onSurface)
          }, (index: number) => index.toString())

          Blank()
        }
        .width('90%')
        .height(400)
        .padding(AppSpacing.lg)
        .alignItems(HorizontalAlign.Start)
        .backgroundColor(withOpacity(AppColors.surface, 0.7))
        .borderRadius(AppShapes.large)
        .shadow({
          radius: AppElevationMapping.level2.radius,
          color: 'rgba(0, 0, 0, ' + AppElevationMapping.level2.opacity + ')',
          offsetX: 0,
          offsetY: AppElevationMapping.level2.dy
        })
        .translate({ y: this.scrollOffsetY / 5 })
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.scrollOffsetY += event.offsetY;
            })
        )
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
