class ProductMarker {
  x: number;
  y: number;
  label: string;

  constructor(x: number, y: number, label: string) {
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

class ProductColors {
  static primary: string = '#111111';
  static secondary: string = '#333333';
  static tertiary: string = '#777777';
  static background: string = '#FFFFFF';
  static surface: string = '#F9F9F9';
  static surfaceVariant: string = '#E5E5E5';
  static outline: string = '#CCCCCC';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#FFFFFF';
  static onTertiary: string = '#111111';
  static onSurface: string = '#111111';
}

@Entry
@Component
struct Index {
  @State markers: ProductMarker[] = [
    new ProductMarker(120, 200, 'Store A'),
    new ProductMarker(360, 400, 'Store B')
  ];

  private addMarker() {
    let index: number = this.markers.length + 1;
    let x: number = 100 + ((index * 113) % 400);
    let y: number = 150 + ((index * 89) % 300);
    this.markers.push(new ProductMarker(x, y, 'New'));
  }

  @Builder
  ProductCard() {
    Column() {
      Text('')
        .width('100%')
        .height(160)
        .backgroundColor(ProductColors.surfaceVariant)
      Text('Monochrome Bag')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(ProductColors.onSurface)
        .lineHeight(24)
        .width('100%')
      Text('A minimalist and timeless design piece.')
        .fontSize(14)
        .fontColor(ProductColors.tertiary)
        .lineHeight(20)
        .width('100%')
      Text('$79.00')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(ProductColors.primary)
        .lineHeight(24)
        .width('100%')
      Button('Add to Cart')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(ProductColors.onPrimary)
        .width('100%')
        .height(48)
        .backgroundColor(ProductColors.primary)
        .borderRadius(10)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(ProductColors.surface)
    .borderRadius(14)
    .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 4 })
  }

  @Builder
  MarkerView(marker: ProductMarker) {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(28)
        .height(28)
        .fill(ProductColors.primary)
      Text('')
        .width(10)
        .height(10)
        .backgroundColor(ProductColors.surface)
        .borderRadius(5)
    }
    .width(32)
    .height(32)
    .position({ x: marker.x / 1.7, y: marker.y / 1.9 })
  }

  @Builder
  MapPanel() {
    Stack() {
      Text('')
        .width('100%')
        .height('100%')
        .backgroundColor(ProductColors.surfaceVariant)
      ForEach(this.markers, (marker: ProductMarker, index: number) => {
        this.MarkerView(marker)
      }, (marker: ProductMarker, index: number) => index.toString())
    }
    .width('100%')
    .height(240)
    .backgroundColor(ProductColors.surface)
    .borderRadius(14)
  }

  build() {
    Column() {
      Text('Product Detail')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(ProductColors.primary)
        .lineHeight(34)
        .width('100%')

      Column() {
        this.ProductCard()
      }
      .width('100%')
      .margin({ top: 16 })

      Column() {
        this.MapPanel()
      }
      .width('100%')
      .margin({ top: 16 })

      Row() {
        Button('Add Marker')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(ProductColors.onSecondary)
          .layoutWeight(1)
          .height(44)
          .backgroundColor(ProductColors.secondary)
          .borderRadius(10)
          .onClick(() => {
            this.addMarker();
          })
        Blank().width(12)
        Button('Clear')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(ProductColors.onTertiary)
          .layoutWeight(1)
          .height(44)
          .backgroundColor(ProductColors.tertiary)
          .borderRadius(10)
          .onClick(() => {
            this.markers = [];
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: 16 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor(ProductColors.background)
  }
}
