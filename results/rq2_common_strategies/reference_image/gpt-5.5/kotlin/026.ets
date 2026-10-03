const NAME: string = '027*DocReader*en';
const UI_TYPE: string = 'Productivity';
const STYLE_THEME: string = 'Glassmorphic';
const LANG: string = 'en';
const BASELINE_SIZE: string = '750x1334';

class AppColors {
  static readonly primary: ResourceColor = '#38BDF8';
  static readonly secondary: ResourceColor = '#A78BFA';
  static readonly tertiary: ResourceColor = '#7DD3FC';
  static readonly background: ResourceColor = '#F1F5F9';
  static readonly surface: ResourceColor = '#FFFFFF';
  static readonly surfaceGlass: ResourceColor = 0xB3FFFFFF;
  static readonly surfaceVariant: ResourceColor = '#E2E8F0';
  static readonly surfaceVariantGlass: ResourceColor = 0xCCE2E8F0;
  static readonly outline: ResourceColor = '#CBD5E1';
  static readonly success: ResourceColor = '#22C55E';
  static readonly warning: ResourceColor = '#F59E0B';
  static readonly error: ResourceColor = '#EF4444';
  static readonly onPrimary: ResourceColor = '#FFFFFF';
  static readonly onSecondary: ResourceColor = '#1E1E1E';
  static readonly onTertiary: ResourceColor = '#1E1E1E';
  static readonly onBackground: ResourceColor = '#1E1E1E';
  static readonly onSurface: ResourceColor = '#1E1E1E';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 12;
  static readonly large: number = 20;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacityColor: ResourceColor;

  constructor(elevation: number, radius: number, dy: number, opacityColor: ResourceColor) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacityColor = opacityColor;
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0x1F000000);
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0x2E000000);
}

@Entry
@Component
struct Index {
  @State private cardOffsetY: number = 0;
  private gestureStartOffsetY: number = 0;

  private readonly lines: string[] = [
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
      Row() {
        Text('Glass Doc Reader')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Stack({ alignContent: Alignment.Center }) {
        Column() {
          Text('Document Reader')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)
            .maxLines(1)

          ForEach(this.lines, (line: string) => {
            Text(line)
              .fontSize(AppTypography.bodySize)
              .fontWeight(FontWeight.Regular)
              .fontColor(AppColors.onSurface)
              .maxLines(1)
              .margin({ top: AppSpacing.md })
          }, (line: string) => line)
        }
        .width('90%')
        .height(400)
        .padding(AppSpacing.lg)
        .alignItems(HorizontalAlign.Start)
        .backgroundColor(AppColors.surfaceGlass)
        .borderRadius(AppShapes.large)
        .shadow({
          radius: AppElevation.level2.radius,
          color: AppElevation.level2.opacityColor,
          offsetX: 0,
          offsetY: AppElevation.level2.dy
        })
        .translate({ y: this.cardOffsetY })
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppColors.surfaceVariantGlass, 0.0],
          [AppColors.background, 0.5],
          [AppColors.surfaceVariantGlass, 1.0]
        ]
      })
      .gesture(
        PanGesture({ direction: PanDirection.All })
          .onActionStart(() => {
            this.gestureStartOffsetY = this.cardOffsetY;
          })
          .onActionUpdate((event: GestureEvent) => {
            this.cardOffsetY = this.gestureStartOffsetY + event.offsetY / 5;
          })
      )
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}