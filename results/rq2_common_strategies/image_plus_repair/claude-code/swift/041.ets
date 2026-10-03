interface ColorTokens {
  primary: ResourceColor;
  secondary: ResourceColor;
  tertiary: ResourceColor;
  background: ResourceColor;
  surface: ResourceColor;
  surfaceVariant: ResourceColor;
  outline: ResourceColor;
  success: ResourceColor;
  warning: ResourceColor;
  error: ResourceColor;
  onPrimary: ResourceColor;
  onSecondary: ResourceColor;
  onTertiary: ResourceColor;
  onBackground: ResourceColor;
  onSurface: ResourceColor;
}

interface ShapeTokens {
  smallCornerRadius: number;
  mediumCornerRadius: number;
  largeCornerRadius: number;
}

interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

class AppTokens {
  static readonly Colors: ColorTokens = {
    primary: '#FF111111',
    secondary: '#FF333333',
    tertiary: '#FF777777',
    background: '#FFFFFFFF',
    surface: '#FFF9F9F9',
    surfaceVariant: '#FFE5E5E5',
    outline: '#FFCCCCCC',
    success: '#FF16A34A',
    warning: '#FFF59E0B',
    error: '#FFDC2626',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF111111',
    onBackground: '#FF111111',
    onSurface: '#FF111111'
  };

  static readonly Shapes: ShapeTokens = {
    smallCornerRadius: 6,
    mediumCornerRadius: 10,
    largeCornerRadius: 14
  };

  static readonly Spacing: SpacingTokens = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };
}

interface Marker {
  x: number;
  y: number;
  label: string;
}

@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    { x: 120, y: 200, label: 'Store A' },
    { x: 360, y: 400, label: 'Store B' }
  ];
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D();

  private drawMarkers(): void {
    this.canvasCtx.fillStyle = '#E5E5E5';
    this.canvasCtx.fillRect(0, 0, this.canvasCtx.width, this.canvasCtx.height);
    this.canvasCtx.fillStyle = '#111111';
    for (let i = 0; i < this.markers.length; i++) {
      this.canvasCtx.beginPath();
      this.canvasCtx.arc(this.markers[i].x, this.markers[i].y, 14, 0, Math.PI * 2);
      this.canvasCtx.fill();
    }
  }

  private onAddMarker(): void {
    this.markers.push({
      x: 100 + Math.random() * 400,
      y: 150 + Math.random() * 200,
      label: 'New'
    });
    this.drawMarkers();
  }

  private onClear(): void {
    this.markers = [];
    this.drawMarkers();
  }

  build() {
    Column() {
      Text('Product Detail')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.primary)
        .width('100%')
        .margin({ bottom: AppTokens.Spacing.lg })

      Column() {
        Row()
          .width('100%')
          .height(160)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .margin({ bottom: AppTokens.Spacing.md })

        Text('Monochrome Bag')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.sm })

        Text('A minimalist and timeless design piece.')
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppTokens.Colors.tertiary)
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.md })

        Text('$79.00')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.md })

        Button('Add to Cart')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.mediumCornerRadius)
          .width('100%')
          .height(48)
          .onClick(() => {
            console.info('Add to Cart tapped!');
          })
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.largeCornerRadius)
      .shadow({
        radius: 8,
        color: 'rgba(0, 0, 0, 0.12)',
        offsetX: 0,
        offsetY: 4
      })
      .margin({ bottom: AppTokens.Spacing.lg })

      Column() {
        Canvas(this.canvasCtx)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawMarkers();
          })
      }
      .width('100%')
      .height(240)
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.largeCornerRadius)
      .shadow({
        radius: 8,
        color: 'rgba(0, 0, 0, 0.12)',
        offsetX: 0,
        offsetY: 4
      })
      .margin({ bottom: AppTokens.Spacing.lg })

      Row() {
        Button('Add Marker')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.mediumCornerRadius)
          .layoutWeight(1)
          .height(44)
          .onClick(() => {
            this.onAddMarker();
          })

        Button('Clear')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onTertiary)
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Shapes.mediumCornerRadius)
          .layoutWeight(1)
          .height(44)
          .margin({ left: AppTokens.Spacing.md })
          .onClick(() => {
            this.onClear();
          })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.background)
    .alignItems(HorizontalAlign.Start)
  }
}
