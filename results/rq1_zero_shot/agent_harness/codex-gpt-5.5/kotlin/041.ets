const NAME: string = '055*ProductDetail*en';
const UI_TYPE: string = 'ECommerce';
const STYLE_THEME: string = 'Monochrome';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#111111';
  static readonly secondary: string = '#333333';
  static readonly tertiary: string = '#777777';
  static readonly background: string = '#FFFFFF';
  static readonly surface: string = '#F9F9F9';
  static readonly surfaceVariant: string = '#E5E5E5';
  static readonly outline: string = '#CCCCCC';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#DC2626';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#111111';
  static readonly onBackground: string = '#111111';
  static readonly onSurface: string = '#111111';
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class Marker {
  x: number;
  y: number;
  label: string;
  constructor(x: number, y: number, label: string) { this.x = x; this.y = y; this.label = label; }
}

@Entry
@Component
struct MainActivity {
  @State markers: Marker[] = [new Marker(120, 200, 'Store A'), new Marker(360, 400, 'Store B')];

  addMarker(): void {
    const x = 100 + ((this.markers.length * 113) % 400);
    const y = 150 + ((this.markers.length * 151) % 300);
    this.markers = [...this.markers, new Marker(x, y, 'New')];
  }

  @Builder
  ProductCard(): void {
    Column({ space: AppSpacing.md }) {
      Rect().width('100%').height(160).fill(AppColors.surfaceVariant);
      Text('Monochrome Bag')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
      Text('A minimalist and timeless design piece.')
        .fontSize(14)
        .fontColor(AppColors.tertiary);
      Text('$79.00')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary);
      Button('Add to Cart')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(10)
        .width('100%')
        .height(48);
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(14)
    .shadow({ radius: 8, color: '#1F000000', offsetY: 4 })
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  StoreMap(): void {
    Stack() {
      Rect().width('100%').height('100%').fill(AppColors.surfaceVariant);
      ForEach(this.markers, (marker: Marker, index: number) => {
        Circle()
          .width(28)
          .height(28)
          .fill(AppColors.primary)
          .position({ x: marker.x / 2, y: marker.y / 2 });
      }, (_marker: Marker, index: number) => index.toString())
    }
    .width('100%')
    .height(240)
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(14)
    .alignContent(Alignment.Center);
  }

  build() {
    Column({ space: AppSpacing.lg }) {
      Text('Product Detail')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary);
      this.ProductCard();
      this.StoreMap();
      Row() {
        Button('Add Marker')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .backgroundColor(AppColors.secondary)
          .borderRadius(10)
          .layoutWeight(1)
          .height(44)
          .onClick(() => {
            this.addMarker();
          });
        Blank().width(AppSpacing.md);
        Button('Clear')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onTertiary)
          .backgroundColor(AppColors.tertiary)
          .borderRadius(10)
          .layoutWeight(1)
          .height(44)
          .onClick(() => {
            this.markers = [];
          });
      }
      .width('100%')
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.background);
  }
}
