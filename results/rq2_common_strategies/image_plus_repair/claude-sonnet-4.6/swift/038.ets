// Data model for markers
class MarkerData {
  id: string = '';
  x: number = 0;
  y: number = 0;
  label: string = '';
}

// App Tokens - Colors
class AppColors {
  static readonly primary: string = '#06B6D4';
  static readonly secondary: string = '#3B82F6';
  static readonly tertiary: string = '#8B5CF6';
  static readonly background: string = '#F0F9FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E0F2FE';
  static readonly outline: string = '#BAE6FD';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#FACC15';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#0F172A';
}

// App Tokens - Typography
class AppTypography {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

// App Tokens - Shapes
class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 12;
  static readonly large: number = 20;
}

// App Tokens - Spacing
class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

@Entry
@Component
struct RootScreen {
  @State markers: MarkerData[] = (() => {
    const m1 = new MarkerData();
    m1.id = '1';
    m1.x = 120;
    m1.y = 200;
    m1.label = 'A1';

    const m2 = new MarkerData();
    m2.id = '2';
    m2.x = 300;
    m2.y = 400;
    m2.label = 'B2';

    const m3 = new MarkerData();
    m3.id = '3';
    m3.x = 520;
    m3.y = 600;
    m3.label = 'C3';

    return [m1, m2, m3];
  })();
  @State scanning: boolean = false;
  private canvasWidth: number = 0;
  private canvasHeight: number = 0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawCanvas() {
    const ctx = this.canvasContext;
    const width = this.canvasWidth;
    const height = this.canvasHeight;

    if (width === 0 || height === 0) return;

    ctx.clearRect(0, 0, width, height);

    // Draw background circle (surfaceVariant)
    const centerX = width / 2;
    const centerY = height / 2;
    const minDim = Math.min(width, height);
    const radius = minDim / 2.5;

    ctx.beginPath();
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2);
    ctx.fillStyle = AppColors.surfaceVariant;
    ctx.fill();

    // Draw markers
    for (const marker of this.markers) {
      ctx.beginPath();
      ctx.arc(marker.x, marker.y, 12, 0, Math.PI * 2);
      ctx.fillStyle = AppColors.primary;
      ctx.fill();
    }
  }

  build() {
    Column() {
      // Top Bar
      Text('Invoice Scanner')
        .fontSize(AppTypography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
        .backgroundColor(AppColors.background)

      // Main Content Area
      Column({ space: AppSpacing.lg }) {
        // Canvas Surface
        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.canvasWidth = this.canvasContext.width;
              this.canvasHeight = this.canvasContext.height;
              this.drawCanvas();
            })
            .onAreaChange((oldVal: Area, newVal: Area) => {
              this.canvasWidth = newVal.width as number;
              this.canvasHeight = newVal.height as number;
              this.drawCanvas();
            })
        }
        .width('100%')
        .height(400)
        .backgroundColor('#E6FFFFFF')
        .borderRadius(AppShapes.large)
        .shadow({
          radius: 8,
          color: '#2E000000',
          offsetX: 0,
          offsetY: 4,
        })
        .clip(true)

        // Scanning Active Row
        Row() {
          Text('Scanning Active')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .onChange((isOn: boolean) => {
              this.scanning = isOn;
            })
            .selectedColor(AppColors.secondary)
            .switchPointColor(AppColors.secondary)
            .width(50)
            .height(30)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // Add Marker Button
        Button('Add Marker')
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .width('100%')
          .height(48)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)
          .onClick(() => {
            if (this.scanning) {
              const newMarker = new MarkerData();
              newMarker.id = Date.now().toString();
              newMarker.x = Math.random() * (580 - 80) + 80;
              newMarker.y = Math.random() * (650 - 150) + 150;
              newMarker.label = `N${this.markers.length + 1}`;
              this.markers = [...this.markers, newMarker];
              this.drawCanvas();
            }
          })
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#4D3B82F6', 0.0],
          [AppColors.background, 0.5],
          ['#4D06B6D4', 1.0],
        ],
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}