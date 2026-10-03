import { drawing } from '@kit.ArkGraphics2D';

class MarkerItem {
  x: number;
  y: number;
  label: string;

  constructor(x: number, y: number, label: string) {
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

const Colors = {
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
  onSurface: '#FF111111',
};

const Spacing = {
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32,
};

@Entry
@Component
struct Index {
  @State markers: MarkerItem[] = [
    new MarkerItem(120, 200, 'Store A'),
    new MarkerItem(360, 400, 'Store B'),
  ];

  addRandomMarker() {
    const x = Math.floor(Math.random() * 400) + 100;
    const y = Math.floor(Math.random() * 300) + 150;
    this.markers = [...this.markers, new MarkerItem(x, y, 'New')];
  }

  clearMarkers() {
    this.markers = [];
  }

  build() {
    Scroll() {
      Column({ space: Spacing.lg }) {
        Text('Product Detail')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.primary)
          .width('100%')

        Column({ space: Spacing.md }) {
          Row()
            .width('100%')
            .height(160)
            .backgroundColor(Colors.surfaceVariant)
            .borderRadius(14)

          Text('Monochrome Bag')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
            .width('100%')

          Text('A minimalist and timeless design piece.')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(Colors.tertiary)
            .width('100%')

          Text('$79.00')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.primary)
            .width('100%')

          Button('Add to Cart')
            .width('100%')
            .height(48)
            .backgroundColor(Colors.primary)
            .fontColor(Colors.onPrimary)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .borderRadius(10)
        }
        .width('100%')
        .padding(Spacing.lg)
        .backgroundColor(Colors.surface)
        .borderRadius(14)
        .shadow({ radius: 8, color: '#1A000000', offsetX: 0, offsetY: 4 })

        Stack() {
          Canvas(this.renderingContext)
            .width('100%')
            .height(240)
            .onReady(() => {
              this.drawMap();
            })
        }
        .width('100%')
        .height(240)
        .backgroundColor(Colors.surface)
        .borderRadius(14)

        Row({ space: Spacing.md }) {
          Button('Add Marker')
            .layoutWeight(1)
            .height(44)
            .backgroundColor(Colors.secondary)
            .fontColor(Colors.onSecondary)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .borderRadius(10)
            .onClick(() => {
              this.addRandomMarker();
              this.renderingContext.clearRect(0, 0, this.canvasWidth, 240);
              this.drawMap();
            })

          Button('Clear')
            .layoutWeight(1)
            .height(44)
            .backgroundColor(Colors.tertiary)
            .fontColor(Colors.onTertiary)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .borderRadius(10)
            .onClick(() => {
              this.clearMarkers();
              this.renderingContext.clearRect(0, 0, this.canvasWidth, 240);
              this.drawMap();
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .padding(Spacing.lg)
      .backgroundColor(Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }

  private renderingContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  );
  private canvasWidth: number = 720;

  drawMap() {
    const ctx = this.renderingContext;
    const w = ctx.width || this.canvasWidth;
    const h = 240;
    const pad = Spacing.lg;

    ctx.fillStyle = Colors.surfaceVariant;
    ctx.fillRect(pad, pad, w - pad * 2, h - pad * 2);

    this.markers.forEach((marker) => {
      ctx.beginPath();
      ctx.arc(marker.x, marker.y, 14, 0, Math.PI * 2);
      ctx.fillStyle = Colors.primary;
      ctx.fill();
      ctx.closePath();
    });
  }
}