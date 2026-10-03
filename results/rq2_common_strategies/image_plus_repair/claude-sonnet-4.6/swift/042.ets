// AppTokens
const primaryColor: string = '#0EA5E9';
const secondaryColor: string = '#38BDF8';
const tertiaryColor: string = '#7DD3FC';
const backgroundColor: string = '#F0F9FF';
const surfaceColor: string = '#FFFFFF';
const surfaceVariantColor: string = '#E0F2FE';
const onPrimaryColor: string = '#FFFFFF';
const onSurfaceColor: string = '#0F172A';
const onBackgroundColor: string = '#0F172A';

const spacingSm: number = 6;
const spacingMd: number = 10;
const spacingLg: number = 14;
const spacingXxl: number = 28;

const shapesSmall: number = 6;
const shapesMedium: number = 10;
const shapesLarge: number = 16;

class Product {
  id: number = 0;
  name: string = '';
  price: string = '';
  store: string = '';

  constructor(id: number, name: string, price: string, store: string) {
    this.id = id;
    this.name = name;
    this.price = price;
    this.store = store;
  }
}

const products: Product[] = [
  new Product(1, 'Wireless Earbuds', '$59.99', 'ShopA'),
  new Product(2, 'Smart Watch', '$129.99', 'ShopB'),
  new Product(3, 'Laptop Stand', '$39.99', 'ShopC'),
  new Product(4, 'Mechanical Keyboard', '$89.99', 'ShopA'),
  new Product(5, 'Noise Cancel Headset', '$149.99', 'ShopB'),
  new Product(6, 'Ergo Mouse', '$45.99', 'ShopC'),
];

@Component
struct ProductCard {
  product: Product = new Product(0, '', '', '');

  build() {
    Column({ space: spacingSm }) {
      Stack() {
      }
      .width(100)
      .height(100)
      .backgroundColor(surfaceVariantColor)
      .borderRadius(shapesMedium)

      Text(this.product.name)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(onSurfaceColor)
        .textAlign(TextAlign.Center)

      Text(this.product.price)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(primaryColor)

      Text(this.product.store)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(tertiaryColor)

      Button('Compare')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(onPrimaryColor)
        .backgroundColor(primaryColor)
        .borderRadius(shapesMedium)
        .width('100%')
        .height(36)
    }
    .padding(spacingMd)
    .backgroundColor(surfaceColor)
    .borderRadius(shapesLarge)
    .shadow({
      radius: 4,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 2,
    })
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct PriceUpdateLogItem {
  product: Product = new Product(0, '', '', '');

  build() {
    Row() {
      Text(`${this.product.name} (${this.product.store})`)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(onSurfaceColor)
        .layoutWeight(1)

      Text(this.product.price)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(secondaryColor)
    }
    .padding(spacingMd)
    .backgroundColor(surfaceColor)
    .borderRadius(shapesSmall)
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Entry
@Component
struct RootScreen {
  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            ['#4038BDF8', 0.0],
            ['#F0F9FF', 0.5],
            ['#400EA5E9', 1.0],
          ]
        })

      Scroll() {
        Column({ space: spacingLg }) {
          Text('Cold Gradient Price Compare')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(onBackgroundColor)
            .width('100%')

          GridRow({
            columns: 2,
            gutter: { x: spacingMd, y: spacingMd }
          }) {
            ForEach(products, (p: Product) => {
              GridCol() {
                ProductCard({ product: p })
              }
            }, (p: Product) => p.id.toString())
          }
          .width('100%')
          .padding({ bottom: spacingXxl })

          Text('Price Update Log')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(primaryColor)
            .width('100%')

          Column({ space: spacingSm }) {
            ForEach(products, (p: Product) => {
              PriceUpdateLogItem({ product: p })
            }, (p: Product) => p.id.toString())
          }
          .width('100%')
          .padding({ bottom: 48 })
        }
        .padding(spacingLg)
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}