import { display } from '@kit.ArkUI';

// MARK: - AppTokens
class AppColors {
  static readonly primary: string = '#FF38BDF8';
  static readonly secondary: string = '#FFA78BFA';
  static readonly tertiary: string = '#FF7DD3FC';
  static readonly background: string = '#FFF1F5F9';
  static readonly surface: string = '#FFFFFFFF';
  static readonly surfaceVariant: string = '#FFE2E8F0';
  static readonly outline: string = '#FFCBD5E1';
  static readonly success: string = '#FF22C55E';
  static readonly warning: string = '#FFF59E0B';
  static readonly error: string = '#FFEF4444';
  static readonly onPrimary: string = '#FFFFFFFF';
  static readonly onSecondary: string = '#FF1E1E1E';
  static readonly onTertiary: string = '#FF1E1E1E';
  static readonly onBackground: string = '#FF1E1E1E';
  static readonly onSurface: string = '#FF1E1E1E';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
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
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18);
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State private scrollOffsetY: number = 0;
  private lastTouchY: number = 0;

  build() {
    Column() {
      // Top App Bar
      Text('Glass Doc Reader')
        .fontSize(AppTypography.displaySize)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({
          top: 20,
          bottom: AppSpacing.lg,
          left: 0,
          right: 0
        })
        .backgroundColor(AppColors.background)

      // Main content area
      Stack({ alignContent: Alignment.Center }) {
        // Background gradient
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [
              ['#CCE2E8F0', 0.0],
              ['#FFF1F5F9', 0.5],
              ['#CCE2E8F0', 1.0]
            ]
          })

        // Surface card
        Column({ space: AppSpacing.md }) {
          Text('Document Reader')
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(AppColors.primary)

          ForEach(
            [0, 1, 2, 3, 4, 5, 6, 7],
            (index: number) => {
              Text(`This is a sample line of text content number ${index + 1}.`)
                .fontSize(AppTypography.bodySize)
                .fontWeight(AppTypography.bodyWeight)
                .fontColor(AppColors.onSurface)
            },
            (index: number) => index.toString()
          )

          Blank()
        }
        .alignItems(HorizontalAlign.Start)
        .padding(AppSpacing.lg)
        .width('90%')
        .height(400)
        .backgroundColor('#B3FFFFFF')
        .borderRadius(AppShapes.large)
        .shadow({
          color: `rgba(0,0,0,${AppElevation.level2.opacity})`,
          radius: AppElevation.level2.radius,
          offsetX: 0,
          offsetY: AppElevation.level2.dy
        })
        .translate({ x: 0, y: this.scrollOffsetY / 5 })
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Down) {
            this.lastTouchY = event.touches[0].y;
          } else if (event.type === TouchType.Move) {
            const currentY = event.touches[0].y;
            const deltaY = currentY - this.lastTouchY;
            this.lastTouchY = currentY;
            this.scrollOffsetY += deltaY;
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}