import { window } from '@kit.ArkUI';

const NAME: string = '011*MusicPlayer*en';
const UI_TYPE: string = 'Media';
const STYLE_THEME: string = 'Retro Flat';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: ResourceColor = '#EF476F';
  static readonly secondary: ResourceColor = '#FFD166';
  static readonly tertiary: ResourceColor = '#06D6A0';
  static readonly background: ResourceColor = '#FFFCF2';
  static readonly surface: ResourceColor = '#FFF8E1';
  static readonly surfaceVariant: ResourceColor = '#FCE7E7';
  static readonly outline: ResourceColor = '#BDBDBD';
  static readonly success: ResourceColor = '#06D6A0';
  static readonly warning: ResourceColor = '#FFA600';
  static readonly error: ResourceColor = '#D62828';
  static readonly onPrimary: ResourceColor = '#FFFFFF';
  static readonly onSecondary: ResourceColor = '#1F1F1F';
  static readonly onTertiary: ResourceColor = '#1F1F1F';
  static readonly onBackground: ResourceColor = '#1F1F1F';
  static readonly onSurface: ResourceColor = '#1F1F1F';
}

class AppTypographyTokens {
  static readonly displaySize: number = 30;
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
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly xs: number = 4;
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

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 6, 3, 0.16);
}

@Entry
@Component
struct Index {
  @State private knobX: number = 300;
  @State private knobY: number = 300;

  private readonly canvasSize: number = 280;
  private readonly canvasSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private readonly canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.canvasSettings);

  aboutToAppear(): void {
    this.enterImmersiveMode();
  }

  onPageShow(): void {
    this.enterImmersiveMode();
  }

  private enterImmersiveMode(): void {
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      })
      .catch(() => {
      });
  }

  private drawKnob(): void {
    this.canvasContext.clearRect(0, 0, this.canvasSize, this.canvasSize);

    this.canvasContext.beginPath();
    this.canvasContext.lineWidth = 12;
    this.canvasContext.strokeStyle = AppColors.secondary as string;
    this.canvasContext.arc(
      this.canvasSize / 2,
      this.canvasSize / 2,
      this.canvasSize / 2 - 20,
      0,
      Math.PI * 2
    );
    this.canvasContext.stroke();
    this.canvasContext.closePath();

    this.canvasContext.beginPath();
    this.canvasContext.fillStyle = AppColors.primary as string;
    this.canvasContext.arc(this.knobX, this.knobY, 20, 0, Math.PI * 2);
    this.canvasContext.fill();
    this.canvasContext.closePath();
  }

  build() {
    Column() {
      Row() {
        Text('Retro Music Player')
          .fontSize(AppTypographyTokens.displaySize)
          .fontWeight(AppTypographyTokens.displayWeight)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(72)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Column() {
        Stack({ alignContent: Alignment.Center }) {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawKnob();
            })
        }
        .width(this.canvasSize)
        .height(this.canvasSize)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)
        .border({
          width: 3,
          color: AppColors.outline,
          radius: AppShapes.large
        })
        .onTouch((event: TouchEvent) => {
          if ((event.type === TouchType.Down || event.type === TouchType.Move) && event.touches.length > 0) {
            this.knobX = event.touches[0].x;
            this.knobY = event.touches[0].y;
            this.drawKnob();
          }
        })

        Text('Track: Summer Nights')
          .fontSize(AppTypographyTokens.titleSize)
          .fontWeight(AppTypographyTokens.titleWeight)
          .fontColor(AppColors.onSurface)

        Row() {
          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('Play')
              .fontSize(AppTypographyTokens.titleSize)
              .fontWeight(AppTypographyTokens.titleWeight)
              .fontColor(AppColors.onPrimary)
          }
          .width(120)
          .height(48)
          .borderRadius(AppShapes.medium)
          .backgroundColor(AppColors.primary)

          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('Pause')
              .fontSize(AppTypographyTokens.titleSize)
              .fontWeight(AppTypographyTokens.titleWeight)
              .fontColor(AppColors.onSecondary)
          }
          .width(120)
          .height(48)
          .borderRadius(AppShapes.medium)
          .backgroundColor(AppColors.secondary)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)

        Text(`Knob X:${Math.trunc(this.knobX)} Y:${Math.trunc(this.knobY)}`)
          .fontSize(AppTypographyTokens.labelSize)
          .fontWeight(AppTypographyTokens.labelWeight)
          .fontColor(AppColors.tertiary)

        Blank()
          .height(AppSpacing.xxl)
      }
      .layoutWeight(1)
      .width('100%')
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: AppSpacing.lg
      })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}