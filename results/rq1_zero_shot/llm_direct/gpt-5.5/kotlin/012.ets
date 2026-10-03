import window from '@ohos.window';
import { BusinessError } from '@ohos.base';

const NAME: string = '009FavoritesGriden';
const UI_TYPE: string = 'Social';
const STYLE_THEME: string = 'Glassmorphic';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

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
  static readonly primary: string = '#60A5FA';
  static readonly secondary: string = '#93C5FD';
  static readonly tertiary: string = '#A5B4FC';
  static readonly background: string = '#F9FAFB';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#EFF6FF';
  static readonly outline: string = '#D1D5DB';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#DC2626';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E293B';
  static readonly onTertiary: string = '#1E1E2F';
  static readonly onBackground: string = '#111827';
  static readonly onSurface: string = '#111827';

  static readonly white60: string = 'rgba(255, 255, 255, 0.60)';
  static readonly white70: string = 'rgba(255, 255, 255, 0.70)';
  static readonly surface80: string = 'rgba(255, 255, 255, 0.80)';
  static readonly surfaceVariant50: string = 'rgba(239, 246, 255, 0.50)';
  static readonly surfaceVariant60: string = 'rgba(239, 246, 255, 0.60)';
  static readonly secondary30: string = 'rgba(147, 197, 253, 0.30)';
  static readonly secondary20: string = 'rgba(147, 197, 253, 0.20)';
  static readonly primary30: string = 'rgba(96, 165, 250, 0.30)';
}

class AppTypographyTokens {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 16;
  static readonly large: number = 24;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(3, 8, 4, 0.14);
  static readonly level3: ShadowSpec = new ShadowSpec(6, 12, 6, 0.16);
}

@Entry
@Component
struct RootScreen {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  @State private markerX: number = 200;
  @State private markerY: number = 400;
  @State private canvasWidth: number = 688;
  @State private canvasHeight: number = 400;

  aboutToAppear(): void {
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      })
      .catch((err: BusinessError) => {
        console.error(`Window immersive setup failed. code=${err.code}, message=${err.message}`);
      });
  }

  private parseAreaValue(value: Length): number {
    const parsed: number = Number.parseFloat(value.toString());
    return Number.isNaN(parsed) ? 0 : parsed;
  }

  private drawMap(): void {
    const width: number = this.canvasWidth > 0 ? this.canvasWidth : 688;
    const height: number = this.canvasHeight > 0 ? this.canvasHeight : 400;

    this.canvasContext.clearRect(0, 0, width, height);

    this.canvasContext.beginPath();
    this.canvasContext.fillStyle = AppColors.secondary30;
    this.canvasContext.arc(width / 2, height / 2, 220, 0, Math.PI * 2);
    this.canvasContext.fill();

    this.canvasContext.beginPath();
    this.canvasContext.fillStyle = AppColors.secondary20;
    this.canvasContext.arc(width / 2, height / 2, 340, 0, Math.PI * 2);
    this.canvasContext.fill();

    this.canvasContext.beginPath();
    this.canvasContext.fillStyle = AppColors.primary;
    this.canvasContext.arc(this.markerX, this.markerY, 14, 0, Math.PI * 2);
    this.canvasContext.fill();

    this.canvasContext.beginPath();
    this.canvasContext.strokeStyle = AppColors.primary30;
    this.canvasContext.lineWidth = 3;
    this.canvasContext.arc(this.markerX, this.markerY, 30, 0, Math.PI * 2);
    this.canvasContext.stroke();
  }

  build() {
    Column() {
      Row() {
        Text('Favorite Spots Map')
          .fontSize(AppTypographyTokens.displaySize)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .maxLines(1)
      }
      .width('100%')
      .height(88)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Stack({ alignContent: Alignment.Center }) {
        Stack({ alignContent: Alignment.Center }) {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawMap();
            })
            .onAreaChange((oldValue: Area, newValue: Area) => {
              this.canvasWidth = this.parseAreaValue(newValue.width);
              this.canvasHeight = this.parseAreaValue(newValue.height);
              this.drawMap();
            })
        }
        .width('100%')
        .height(400)
        .borderRadius(AppShapes.large)
        .backgroundColor(AppColors.surface80)
        .radialGradient({
          center: ['50%', '50%'],
          radius: '80%',
          colors: [
            [AppColors.surface80, 0.0],
            [AppColors.surfaceVariant60, 1.0]
          ]
        })
        .border({
          width: 1,
          color: AppColors.outline,
          radius: AppShapes.large
        })

        Column({ space: AppSpacing.md }) {
          Text(`Spot Coordinates: (${Math.trunc(this.markerX)}, ${Math.trunc(this.markerY)})`)
            .fontSize(AppTypographyTokens.bodySize)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.onSurface)
            .textAlign(TextAlign.Center)

          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('Save Marker')
              .fontSize(AppTypographyTokens.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onPrimary)
          }
          .width('100%')
          .height(48)
          .borderRadius(AppShapes.medium)
          .backgroundColor(AppColors.primary)
          .onClick(() => {
          })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .align(Alignment.Bottom)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          [AppColors.white60, 0.0],
          [AppColors.surfaceVariant50, 0.5],
          [AppColors.white70, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM, SafeAreaEdge.START, SafeAreaEdge.END])
  }
}