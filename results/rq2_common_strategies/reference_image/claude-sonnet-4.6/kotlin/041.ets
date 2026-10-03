// Index.ets — ArkTS port of the Compose "Product Detail" screen.
// Design tokens, layout, canvas markers and both actions are preserved 1:1.

// ---------------------------------------------------------------- tokens
class Tokens {
  static readonly primary: string = '#111111';
  static readonly secondary: string = '#333333';
  static readonly tertiary: string = '#777777';
  static readonly background: string = '#FFFFFF';
  static readonly surface: string = '#F9F9F9';
  static readonly surfaceVariant: string = '#E5E5E5';
  static readonly outline: string = '#CCCCCC';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#111111';
  static readonly onSurface: string = '#111111';
}

class Type {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class Spacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class Radius {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
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
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.10);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.12);
  static readonly level3: ShadowSpec = new ShadowSpec(8, 12, 6, 0.15);
}

// ----------------------------------------------------------------- model
class Marker {
  x: number;
  y: number;
  label: string;

  constructor(x: number, y: number, label: string) {
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

// ------------------------------------------------------------------ view
@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    new Marker(120, 200, 'Store A'),
    new Marker(360, 400, 'Store B')
  ];

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  // Mirrors the Compose Canvas draw block: variant rect + one dot per marker.
  drawMarkers(): void {
    const w: number = this.ctx.width;
    const h: number = this.ctx.height;
    this.ctx.clearRect(0, 0, w, h);
    this.ctx.fillStyle = Tokens.surfaceVariant;
    this.ctx.fillRect(0, 0, w, h);
    this.ctx.fillStyle = Tokens.primary;
    for (let i = 0; i < this.markers.length; i++) {
      const m: Marker = this.markers[i];
      this.ctx.beginPath();
      this.ctx.arc(m.x, m.y, 14, 0, Math.PI * 2);
      this.ctx.fill();
    }
  }

  build() {
    Column() {
      // ---- header
      Text('Product Detail')
        .fontSize(Type.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(Tokens.primary)
        .width('100%')

      // ---- product card
      Column({ space: Spacing.md }) {
        // image placeholder (Box + background)
        Row()
          .width('100%')
          .height(160)
          .backgroundColor(Tokens.surfaceVariant)
          .borderRadius(Radius.small)

        Text('Monochrome Bag')
          .fontSize(Type.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(Tokens.onSurface)
          .width('100%')

        Text('A minimalist and timeless design piece.')
          .fontSize(Type.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(Tokens.tertiary)
          .width('100%')

        Text('$79.00')
          .fontSize(Type.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(Tokens.primary)
          .width('100%')

        Button('Add to Cart')
          .type(ButtonType.Normal)
          .fontSize(Type.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(Tokens.onPrimary)
          .backgroundColor(Tokens.primary)
          .borderRadius(Radius.medium)
          .width('100%')
          .height(48)
          .onClick(() => {
            // no-op in the Compose source as well
          })
      }
      .width('100%')
      .padding(Spacing.lg)
      .backgroundColor(Tokens.surface)
      .borderRadius(Radius.large)
      .shadow({
        radius: ElevationMapping.level2.radius,
        color: 'rgba(0,0,0,' + ElevationMapping.level2.opacity.toString() + ')',
        offsetX: 0,
        offsetY: ElevationMapping.level2.dy
      })

      // ---- marker map panel
      Stack() {
        Canvas(this.ctx)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawMarkers();
          })
      }
      .width('100%')
      .height(240)
      .padding(Spacing.lg)
      .backgroundColor(Tokens.surface)
      .borderRadius(Radius.large)

      // ---- actions
      Row() {
        Button('Add Marker')
          .type(ButtonType.Normal)
          .fontSize(Type.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(Tokens.onSecondary)
          .backgroundColor(Tokens.secondary)
          .borderRadius(Radius.medium)
          .layoutWeight(1)
          .height(44)
          .onClick(() => {
            const nx: number = Math.floor(Math.random() * 400) + 100;
            const ny: number = Math.floor(Math.random() * 300) + 150;
            this.markers.push(new Marker(nx, ny, 'New'));
            this.drawMarkers();
          })

        Row()
          .width(Spacing.md)
          .height(1)

        Button('Clear')
          .type(ButtonType.Normal)
          .fontSize(Type.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(Tokens.onTertiary)
          .backgroundColor(Tokens.tertiary)
          .borderRadius(Radius.medium)
          .layoutWeight(1)
          .height(44)
          .onClick(() => {
            this.markers = [];
            this.drawMarkers();
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(Spacing.lg)
    .backgroundColor(Tokens.background)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
  }
}