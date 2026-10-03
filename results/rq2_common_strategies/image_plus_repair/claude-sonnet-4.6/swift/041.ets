interface MarkerData {
  id: string;
  x: number;
  y: number;
  label: string;
}

class AppColorsClass {
  primary: string = '#FF111111';
  secondary: string = '#FF333333';
  tertiary: string = '#FF777777';
  background: string = '#FFFFFFFF';
  surface: string = '#FFF9F9F9';
  surfaceVariant: string = '#FFE5E5E5';
  outline: string = '#FFCCCCCC';
  success: string = '#FF16A34A';
  warning: string = '#FFF59E0B';
  error: string = '#FFDC2626';
  onPrimary: string = '#FFFFFFFF';
  onSecondary: string = '#FFFFFFFF';
  onTertiary: string = '#FF111111';
  onBackground: string = '#FF111111';
  onSurface: string = '#FF111111';
}

class AppSpacingClass {
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 32;
}

class AppShapesClass {
  smallCornerRadius: number = 6;
  mediumCornerRadius: number = 10;
  largeCornerRadius: number = 14;
}

const AppColors = new AppColorsClass();
const AppSpacing = new AppSpacingClass();
const AppShapes = new AppShapesClass();

@Entry
@Component
struct RootScreen {
  @State markers: MarkerData[] = [
    { id: '1', x: 120, y: 200, label: 'Store A' },
    { id: '2', x: 360, y: 400, label: 'Store B' },
  ];

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawMarkers() {
    const ctx = this.canvasContext;
    const width = ctx.width;
    const height = ctx.height;

    ctx.clearRect(0, 0, width, height);

    ctx.fillStyle = AppColors.surfaceVariant;
    ctx.fillRect(0, 0, width, height);

    for (const marker of this.markers) {
      ctx.beginPath();
      ctx.arc(marker.x, marker.y, 14, 0, Math.PI * 2);
      ctx.fillStyle = AppColors.primary;
      ctx.fill();
    }
  }

  build() {
    Scroll() {
      Column({ space: AppSpacing.lg }) {
        Text('Product Detail')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .alignSelf(ItemAlign.Start)

        Column({ space: AppSpacing.md }) {
          Row()
            .width('100%')
            .height(160)
            .backgroundColor(AppColors.surfaceVariant)

          Text('Monochrome Bag')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .alignSelf(ItemAlign.Start)

          Text('A minimalist and timeless design piece.')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.tertiary)
            .alignSelf(ItemAlign.Start)

          Text('$79.00')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)
            .alignSelf(ItemAlign.Start)

          Button('Add to Cart')
            .width('100%')
            .height(48)
            .backgroundColor(AppColors.primary)
            .fontColor(AppColors.onPrimary)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .borderRadius(AppShapes.mediumCornerRadius)
            .onClick(() => {
              console.log('Add to Cart tapped!');
            })
        }
        .padding(AppSpacing.lg)
        .width('100%')
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.largeCornerRadius)
        .shadow({
          color: '#1F000000',
          radius: 8,
          offsetX: 0,
          offsetY: 4,
        })

        Stack() {
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.largeCornerRadius)

          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .borderRadius(AppShapes.largeCornerRadius)
            .onReady(() => {
              this.drawMarkers();
            })
        }
        .width('100%')
        .height(240)
        .borderRadius(AppShapes.largeCornerRadius)
        .shadow({
          color: '#1A000000',
          radius: 4,
          offsetX: 0,
          offsetY: 2,
        })

        Row({ space: AppSpacing.md }) {
          Button('Add Marker')
            .layoutWeight(1)
            .height(44)
            .backgroundColor(AppColors.secondary)
            .fontColor(AppColors.onSecondary)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .borderRadius(AppShapes.mediumCornerRadius)
            .onClick(() => {
              const newMarker: MarkerData = {
                id: Date.now().toString(),
                x: Math.random() * 400 + 100,
                y: Math.random() * 300 + 150,
                label: 'New',
              };
              this.markers = [...this.markers, newMarker];
              this.drawMarkers();
            })

          Button('Clear')
            .layoutWeight(1)
            .height(44)
            .backgroundColor(AppColors.tertiary)
            .fontColor(AppColors.onTertiary)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .borderRadius(AppShapes.mediumCornerRadius)
            .onClick(() => {
              this.markers = [];
              this.drawMarkers();
            })
        }
        .width('100%')
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}