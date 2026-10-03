import { drawing } from '@kit.ArkGraphics2D';

// Design tokens
const AppColors = {
  primary: '#60A5FA',
  secondary: '#93C5FD',
  tertiary: '#A5B4FC',
  background: '#F9FAFB',
  surface: '#FFFFFF',
  surfaceVariant: '#EFF6FF',
  outline: '#D1D5DB',
  success: '#16A34A',
  warning: '#F59E0B',
  error: '#DC2626',
  onPrimary: '#FFFFFF',
  onSecondary: '#1E293B',
  onTertiary: '#1E1E2F',
  onBackground: '#111827',
  onSurface: '#111827',
};

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32,
};

const Shapes = {
  small: 8,
  medium: 16,
  large: 24,
};

interface MarkerPosition {
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  @State markerPosition: MarkerPosition = { x: 200, y: 400 };
  private canvasWidth: number = 0;
  private canvasHeight: number = 0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawMapCanvas() {
    const ctx = this.canvasContext;
    const w = this.canvasWidth;
    const h = this.canvasHeight;

    ctx.clearRect(0, 0, w, h);

    // Background gradient fill
    const bgGrad = ctx.createRadialGradient(w / 2, h / 2, 0, w / 2, h / 2, Math.max(w, h) / 2);
    bgGrad.addColorStop(0, 'rgba(255,255,255,0.8)');
    bgGrad.addColorStop(1, 'rgba(239,246,255,0.6)');
    ctx.fillStyle = bgGrad;
    ctx.fillRect(0, 0, w, h);

    // Inner circle 1
    ctx.beginPath();
    ctx.arc(w / 2, h / 2, 220, 0, Math.PI * 2);
    ctx.fillStyle = 'rgba(147,197,253,0.3)';
    ctx.fill();

    // Inner circle 2
    ctx.beginPath();
    ctx.arc(w / 2, h / 2, 340, 0, Math.PI * 2);
    ctx.fillStyle = 'rgba(147,197,253,0.2)';
    ctx.fill();

    // Marker dot
    ctx.beginPath();
    ctx.arc(this.markerPosition.x, this.markerPosition.y, 14, 0, Math.PI * 2);
    ctx.fillStyle = AppColors.primary;
    ctx.fill();

    // Marker ring
    ctx.beginPath();
    ctx.arc(this.markerPosition.x, this.markerPosition.y, 30, 0, Math.PI * 2);
    ctx.strokeStyle = 'rgba(96,165,250,0.3)';
    ctx.lineWidth = 3;
    ctx.stroke();
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Favorite Spots Map')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.background)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .padding({ left: Spacing.lg, right: Spacing.lg })

      // Main content
      Stack({ alignContent: Alignment.Bottom }) {
        // Map canvas container
        Stack({ alignContent: Alignment.Center }) {
          Canvas(this.canvasContext)
            .width('100%')
            .height(400)
            .borderRadius(Shapes.large)
            .onReady(() => {
              this.canvasWidth = this.canvasContext.width;
              this.canvasHeight = this.canvasContext.height;
              this.drawMapCanvas();
            })
            .onAreaChange((_oldVal, newVal) => {
              this.canvasWidth = newVal.width as number;
              this.canvasHeight = newVal.height as number;
              this.drawMapCanvas();
            })
        }
        .width('100%')
        .height(400)
        .borderRadius(Shapes.large)
        .border({ width: 1, color: AppColors.outline, radius: Shapes.large })
        .clip(true)

        // Bottom controls
        Column({ space: Spacing.md }) {
          Text(`Spot Coordinates: (${Math.round(this.markerPosition.x)}, ${Math.round(this.markerPosition.y)})`)
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onSurface)
            .textAlign(TextAlign.Center)

          Button('Save Marker')
            .width('100%')
            .height(48)
            .borderRadius(Shapes.medium)
            .backgroundColor(AppColors.primary)
            .fontColor(AppColors.onPrimary)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              // Save marker action
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .padding({ bottom: Spacing.md })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(Spacing.lg)
      .linearGradient({
        angle: 135,
        colors: [
          ['rgba(255,255,255,0.6)', 0.0],
          ['rgba(239,246,255,0.5)', 0.5],
          ['rgba(255,255,255,0.7)', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}