// entry/src/main/ets/pages/Index.ets
import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

const NAME: string = '027*DocReader*en';
const UI_TYPE: string = 'Productivity';
const STYLE_THEME: string = 'Glassmorphic';
const LANG: string = 'en';
const BASELINE_SIZE: string = '750x1334';

class AppColors {
  static readonly primary: string = '#38BDF8';
  static readonly secondary: string = '#A78BFA';
  static readonly tertiary: string = '#7DD3FC';
  static readonly background: string = '#F1F5F9';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#CBD5E1';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#1E1E1E';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';

  // 0x70 alpha white (glass card fill, 70% opacity)
  static readonly glassSurface: string = '#B3FFFFFF';
  static readonly glassBorder: string = '#80FFFFFF';
  static readonly gradientEdge: string = '#CCE2E8F0';
}

class AppTypography {
  static readonly display: number = 28;
  static readonly title: number = 18;
  static readonly body: number = 14;
  static readonly label: number = 12;
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

@Entry
@Component
struct GlassDocReader {
  @State private cardOffsetY: number = 0;
  private lastPanY: number = 0;
  private readonly lineItems: number[] = [1, 2, 3, 4, 5, 6, 7, 8];

  aboutToAppear(): void {
    this.enterImmersiveMode();
  }

  onWindowStageFocus(): void {
    this.enterImmersiveMode();
  }

  private enterImmersiveMode(): void {
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      })
      .catch((err: BusinessError) => {
        console.error(`Failed to enter immersive mode: ${err.message}`);
      });
  }

  @Builder
  private topBar() {
    Text('Glass Doc Reader')
      .fontSize(AppTypography.display)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.onSurface)
      .width('100%')
      .textAlign(TextAlign.Center)
      .padding({
        top: AppSpacing.xl,
        bottom: AppSpacing.lg,
        left: AppSpacing.lg,
        right: AppSpacing.lg
      })
  }

  @Builder
  private readerCard() {
    Column({ space: AppSpacing.md }) {
      Text('Document Reader')
        .fontSize(AppTypography.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
        .width('100%')

      ForEach(this.lineItems, (item: number) => {
        Text(`This is a sample line of text content number ${item}.`)
          .fontSize(AppTypography.body)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)
          .width('100%')
      }, (item: number) => item.toString())
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
  }

  build() {
    Column() {
      this.topBar()

      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            angle: 180,
            colors: [
              [AppColors.gradientEdge, 0.0],
              [AppColors.background, 0.5],
              [AppColors.gradientEdge, 1.0]
            ]
          })

        Column() {
          this.readerCard()
        }
        .width('90%')
        .height(400)
        .borderRadius(AppShapes.large)
        .backgroundColor(AppColors.glassSurface)
        .backdropBlur(20)
        .border({ width: 1, color: AppColors.glassBorder })
        .shadow({
          radius: ElevationMapping.level2.radius,
          color: '#2E000000',
          offsetX: 0,
          offsetY: ElevationMapping.level2.dy
        })
        .translate({ y: this.cardOffsetY })
        .gesture(
          PanGesture({ direction: PanDirection.Vertical })
            .onActionStart(() => {
              this.lastPanY = 0;
            })
            .onActionUpdate((event: GestureEvent) => {
              const delta: number = event.offsetY - this.lastPanY;
              this.lastPanY = event.offsetY;
              this.cardOffsetY += delta / 5;
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