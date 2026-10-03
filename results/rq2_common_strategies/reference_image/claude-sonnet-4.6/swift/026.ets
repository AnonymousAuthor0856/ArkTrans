// entry/src/main/ets/pages/Index.ets

// MARK: - AppTokens

/** 32-bit hex (#AARRGGBB / #RRGGBB) -> ArkUI Color string */
function hex(color: number): string {
  const alpha: number = ((color >>> 24) & 0xFF);
  const rgb: string = (color & 0xFFFFFF).toString(16).padStart(6, '0').toUpperCase();
  if (alpha === 0) {
    return '#' + rgb; // no explicit alpha -> fully opaque
  }
  return '#' + alpha.toString(16).padStart(2, '0').toUpperCase() + rgb;
}

class Colors {
  static readonly primary: string = hex(0xFF38BDF8);
  static readonly secondary: string = hex(0xFFA78BFA);
  static readonly tertiary: string = hex(0xFF7DD3FC);
  static readonly background: string = hex(0xFFF1F5F9);
  static readonly surface: string = hex(0xFFFFFFFF);
  static readonly surfaceVariant: string = hex(0xFFE2E8F0);
  static readonly outline: string = hex(0xFFCBD5E1);
  static readonly success: string = hex(0xFF22C55E);
  static readonly warning: string = hex(0xFFF59E0B);
  static readonly error: string = hex(0xFFEF4444);
  static readonly onPrimary: string = hex(0xFFFFFFFF);
  static readonly onSecondary: string = hex(0xFF1E1E1E);
  static readonly onTertiary: string = hex(0xFF1E1E1E);
  static readonly onBackground: string = hex(0xFF1E1E1E);
  static readonly onSurface: string = hex(0xFF1E1E1E);

  // Pre-multiplied alpha variants (copy(alpha = ...))
  static readonly surfaceVariant80: string = '#CCE2E8F0';
  static readonly surface70: string = '#B3FFFFFF';
}

class TypographyTokens {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class Shapes {
  static readonly small: number = 6;
  static readonly medium: number = 12;
  static readonly large: number = 20;
}

class Spacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class ShadowSpec {
  readonly elevation: number;
  readonly radius: number;
  readonly dy: number;
  readonly opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18);
}

function shadowColor(spec: ShadowSpec): string {
  return 'rgba(0, 0, 0, ' + spec.opacity.toString() + ')';
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State scrollOffsetY: number = 0;
  private lastTouchOffsetY: number = 0;

  private lines: string[] = [
    'This is a sample line of text content number 1.',
    'This is a sample line of text content number 2.',
    'This is a sample line of text content number 3.',
    'This is a sample line of text content number 4.',
    'This is a sample line of text content number 5.',
    'This is a sample line of text content number 6.',
    'This is a sample line of text content number 7.',
    'This is a sample line of text content number 8.'
  ];

  build() {
    Column() {
      // CenterAlignedTopAppBar
      Text('Glass Doc Reader')
        .fontSize(TypographyTokens.displaySize)
        .fontWeight(TypographyTokens.displayWeight)
        .fontColor(Colors.onSurface)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 20, bottom: Spacing.lg, left: Spacing.lg, right: Spacing.lg })
        .backgroundColor(Colors.background)

      // Content Box (contentAlignment = Alignment.Center)
      Stack({ alignContent: Alignment.Center }) {

        // Background gradient of the Box
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            angle: 180,
            colors: [
              [Colors.surfaceVariant80, 0.0],
              [Colors.background, 0.5],
              [Colors.surfaceVariant80, 1.0]
            ]
          })

        // Surfaces / glass card
        Column({ space: Spacing.md }) {
          Text('Document Reader')
            .fontSize(TypographyTokens.titleSize)
            .fontWeight(TypographyTokens.titleWeight)
            .fontColor(Colors.primary)

          ForEach(this.lines, (item: string, index: number) => {
            Text(item)
              .fontSize(TypographyTokens.bodySize)
              .fontWeight(FontWeight.Regular)
              .fontColor(Colors.onSurface)
          }, (item: string, index: number) => index.toString())

          Blank()
        }
        .alignItems(HorizontalAlign.Start)
        .padding(Spacing.lg)
        .width('90%')          // fillMaxWidth(0.9f)
        .height(400)           // height(400.dp)
        .backgroundColor(Colors.surface70)
        .borderRadius(Shapes.large)
        .shadow({
          radius: ElevationMapping.level2.radius,
          color: shadowColor(ElevationMapping.level2),
          offsetX: 0,
          offsetY: ElevationMapping.level2.dy
        })
        .offset({ x: 0, y: this.scrollOffsetY / 5 })
        .gesture(
          PanGesture({ fingers: 1, direction: PanDirection.All })
            .onActionStart(() => {
              this.lastTouchOffsetY = 0;
            })
            .onActionUpdate((event: GestureEvent) => {
              const delta: number = event.offsetY - this.lastTouchOffsetY;
              this.lastTouchOffsetY = event.offsetY;
              this.scrollOffsetY = this.scrollOffsetY + delta;
            })
            .onActionEnd(() => {
              this.lastTouchOffsetY = 0;
            })
            .onActionCancel(() => {
              this.lastTouchOffsetY = 0;
            })
        )
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}