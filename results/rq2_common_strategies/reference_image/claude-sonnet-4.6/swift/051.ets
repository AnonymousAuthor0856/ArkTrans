import { window } from '@kit.ArkUI';

// MARK: - AppTokens

export class AppColors {
  static readonly primary: string = '#00FFFF';        // Cyan
  static readonly secondary: string = '#00B4FF';      // Light Blue
  static readonly tertiary: string = '#8A2BE2';       // Blue Violet
  static readonly background: string = '#0A0A1A';     // Dark Navy
  static readonly surface: string = '#141436';        // Darker Purple-Blue
  static readonly surfaceVariant: string = '#1E1E4A'; // Even Darker Purple-Blue
  static readonly outline: string = '#2E2E5C';        // Dark Purple-Blue
  static readonly success: string = '#00FFAA';        // Greenish Cyan
  static readonly warning: string = '#FFCC00';        // Yellow
  static readonly error: string = '#FF4444';          // Red
  static readonly onPrimary: string = '#0A0A1A';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onBackground: string = '#FFFFFF';
  static readonly onSurface: string = '#FFFFFF';
}

export class AppTypography {
  static readonly display: number = 28;
  static readonly title: number = 18;
  static readonly body: number = 14;
  static readonly label: number = 12;

  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

export class AppShapes {
  static readonly smallCornerRadius: number = 8;
  static readonly mediumCornerRadius: number = 14;
  static readonly largeCornerRadius: number = 22;
}

export class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

export class ShadowSpec {
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

export class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.10);
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.15);
  static readonly level3: ShadowSpec = new ShadowSpec(10, 12, 6, 0.18);
}

// MARK: - RootScreen

@Entry
@Component
struct RootScreen {
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F'];
  private departures: string[] = ['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3'];

  // Standard Material Design BottomAppBar height
  private bottomBarHeight: number = 56;
  // Standard Material Design FloatingActionButton size
  private fabSize: number = 56;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  aboutToAppear(): void {
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      })
      .catch(() => {
        // full-screen setup is best-effort only
      });
  }

  private drawMetroLine(): void {
    const w: number = this.ctx.width;
    const h: number = this.ctx.height;
    const count: number = this.stations.length;
    if (count < 2 || w <= 0 || h <= 0) {
      return;
    }
    const step: number = w / (count - 1);

    const xs: number[] = [];
    const ys: number[] = [];
    for (let i = 0; i < count; i++) {
      xs.push(i * step);
      ys.push(i % 2 === 0 ? h / 4 : (h * 3) / 4);
    }

    // Polyline with horizontal gradient stroke.
    const gradient: CanvasGradient = this.ctx.createLinearGradient(0, 0, w, 0);
    gradient.addColorStop(0, AppColors.secondary);
    gradient.addColorStop(1, AppColors.primary);

    this.ctx.beginPath();
    this.ctx.moveTo(xs[0], ys[0]);
    for (let i = 1; i < count; i++) {
      this.ctx.lineTo(xs[i], ys[i]);
    }
    this.ctx.strokeStyle = gradient;
    this.ctx.lineWidth = 6;
    this.ctx.stroke();

    // Station circles: outer filled + inner punched-out.
    for (let i = 0; i < count; i++) {
      this.ctx.beginPath();
      this.ctx.arc(xs[i], ys[i], 16, 0, Math.PI * 2);
      this.ctx.fillStyle = AppColors.primary;
      this.ctx.fill();

      this.ctx.beginPath();
      this.ctx.arc(xs[i], ys[i], 6, 0, Math.PI * 2);
      this.ctx.fillStyle = AppColors.background;
      this.ctx.fill();
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {

      // ---------- Main content (Scaffold body) ----------
      Column({ space: AppSpacing.lg }) {
        Text('Metro Planner')
          .fontSize(AppTypography.display)
          .fontWeight(AppTypography.displayWeight)
          .fontColor(AppColors.primary)
          .width('100%')
          .textAlign(TextAlign.Start)

        Canvas(this.ctx)
          .width('100%')
          .height(260)
          .padding(AppSpacing.md)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.largeCornerRadius)
          .onReady(() => {
            this.drawMetroLine();
          })
          .padding({
            left: AppSpacing.lg,
            right: AppSpacing.lg
          })

        // "Next Departures" card
        Column({ space: AppSpacing.sm }) {
          Text('Next Departures')
            .fontSize(AppTypography.title)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(AppColors.secondary)

          ForEach(this.departures, (departure: string) => {
            Row() {
              Text(departure)
                .fontSize(AppTypography.body)
                .fontWeight(AppTypography.bodyWeight)
                .fontColor(AppColors.onSurface)
              Blank()
              Text('On Time')
                .fontSize(AppTypography.label)
                .fontWeight(AppTypography.labelWeight)
                .fontColor(AppColors.success)
            }
            .width('100%')
          }, (departure: string) => departure)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.largeCornerRadius)
        .shadow({
          radius: ElevationMapping.level2.radius,
          color: '#262E2E5C', // AppColors.outline @ 15% opacity
          offsetX: 0,
          offsetY: ElevationMapping.level2.dy
        })
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg
        })

        Blank()
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
      .padding({
        top: AppSpacing.lg,
        bottom: this.bottomBarHeight
      })

      // ---------- Floating Action Button ----------
      Column() {
        Blank()
        Row() {
          Blank()
          Button() {
            Text('+')
              .fontSize(AppTypography.title)
              .fontWeight(AppTypography.titleWeight)
              .fontColor(AppColors.onPrimary)
          }
          .width(this.fabSize)
          .height(this.fabSize)
          .borderRadius(this.fabSize / 2)
          .backgroundColor(AppColors.primary)
          .margin({
            right: AppSpacing.lg,
            bottom: this.bottomBarHeight + AppSpacing.lg
          })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')

      // ---------- Bottom App Bar ----------
      Column() {
        Blank()
        Row() {
          Text('Routes')
            .fontSize(AppTypography.body)
            .fontWeight(AppTypography.bodyWeight)
            .fontColor(AppColors.secondary) // active item
          Text('Planner')
            .fontSize(AppTypography.body)
            .fontWeight(AppTypography.bodyWeight)
            .fontColor(AppColors.onSurface)
          Text('Tickets')
            .fontSize(AppTypography.body)
            .fontWeight(AppTypography.bodyWeight)
            .fontColor(AppColors.onSurface)
          Text('Profile')
            .fontSize(AppTypography.body)
            .fontWeight(AppTypography.bodyWeight)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(this.bottomBarHeight)
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg
        })
        .backgroundColor(AppColors.surface)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [
        [AppColors.background, 0.0],
        [AppColors.surfaceVariant, 0.5],
        [AppColors.background, 1.0]
      ]
    })
  }
}