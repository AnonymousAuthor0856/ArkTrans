import window from '@ohos.window';

const NAME: string = '096_ParcelTracker_en';
const UI_TYPE: string = 'Tools Dashboard';
const STYLE_THEME: string = 'Monochrome';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: ResourceColor = '#111827';
  static readonly secondary: ResourceColor = '#374151';
  static readonly tertiary: ResourceColor = '#6B7280';
  static readonly background: ResourceColor = '#F9FAFB';
  static readonly surface: ResourceColor = '#FFFFFF';
  static readonly surfaceVariant: ResourceColor = '#E5E7EB';
  static readonly outline: ResourceColor = '#D1D5DB';
  static readonly onPrimary: ResourceColor = '#FFFFFF';
  static readonly onSecondary: ResourceColor = '#FFFFFF';
  static readonly onBackground: ResourceColor = '#111827';
  static readonly onSurface: ResourceColor = '#1F2937';
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 14;
  static readonly xl: number = 22;
}

interface ParcelPoint {
  x: number;
  y: number;
}

function createParcelPoints(): ParcelPoint[] {
  const points: ParcelPoint[] = [];
  for (let i = 0; i < 25; i++) {
    points.push({
      x: Math.random() * 400,
      y: Math.random() * 300
    });
  }
  return points;
}

@Entry
@Component
struct MainActivity {
  aboutToAppear(): void {
    this.hideSystemBars();
  }

  onPageShow(): void {
    this.hideSystemBars();
  }

  private hideSystemBars(): void {
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    });
  }

  build() {
    RootScreen()
      .width('100%')
      .height('100%')
  }
}

@Component
struct RootScreen {
  build() {
    Column({ space: AppSpacing.xl }) {
      Text('Parcel Tracker')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)

      ParcelCanvas()

      Text('Visualize parcel movements and positions.')
        .fontSize(12)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppColors.surfaceVariant, 0.0],
        [AppColors.background, 1.0]
      ]
    })
  }
}

@Component
struct ParcelCanvas {
  @State private dragX: number = 0;
  @State private dragY: number = 0;
  @State private canvasWidth: number = 0;
  @State private canvasHeight: number = 0;

  private points: ParcelPoint[] = createParcelPoints();
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private clamp(value: number, minValue: number, maxValue: number): number {
    return Math.max(minValue, Math.min(maxValue, value));
  }

  private drawCanvas(): void {
    this.context.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

    this.points.forEach((point: ParcelPoint) => {
      this.context.beginPath();
      this.context.fillStyle = AppColors.secondary.toString();
      this.context.arc(point.x, point.y, 4, 0, Math.PI * 2);
      this.context.fill();
    });

    this.context.beginPath();
    this.context.strokeStyle = AppColors.primary.toString();
    this.context.lineWidth = 3;
    this.context.arc(this.dragX, this.dragY, 20, 0, Math.PI * 2);
    this.context.stroke();
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .padding(10)
        .onReady(() => {
          this.drawCanvas();
        })
        .onAreaChange((oldValue: Area, newValue: Area) => {
          this.canvasWidth = Number(newValue.width);
          this.canvasHeight = Number(newValue.height);
          this.drawCanvas();
        })

      Text('Drag to locate parcel')
        .fontSize(12)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(300)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({
      width: 1,
      color: AppColors.outline,
      radius: AppShapes.large
    })
    .onTouch((event: TouchEvent) => {
      if ((event.type === TouchType.Down || event.type === TouchType.Move) && event.touches.length > 0) {
        this.dragX = this.clamp(event.touches[0].x, 0, this.canvasWidth);
        this.dragY = this.clamp(event.touches[0].y, 0, this.canvasHeight);
        this.drawCanvas();
      }
      return true;
    })
  }
}