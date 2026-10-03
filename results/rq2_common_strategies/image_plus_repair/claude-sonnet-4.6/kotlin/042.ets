import { LengthMetrics } from '@kit.ArkUI';

interface Product {
  id: number;
  name: string;
  price: string;
  store: string;
}

const products: Product[] = [
  { id: 1, name: 'Wireless Earbuds', price: '$59.99', store: 'ShopA' },
  { id: 2, name: 'Smart Watch', price: '$129.99', store: 'ShopB' },
  { id: 3, name: 'Laptop Stand', price: '$39.99', store: 'ShopC' },
  { id: 4, name: 'Mechanical Keyboard', price: '$89.99', store: 'ShopA' },
  { id: 5, name: 'Noise Cancel Headset', price: '$149.99', store: 'ShopB' },
  { id: 6, name: 'Ergo Mouse', price: '$45.99', store: 'ShopC' },
];

@Entry
@Component
struct RootScreen {
  build() {
    Scroll() {
      Column({ space: 14 }) {
        Text('Cold Gradient Price Compare')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .width('100%')

        Grid() {
          ForEach(products, (p: Product) => {
            GridItem() {
              Column({ space: 6 }) {
                Stack() {}
                .width(100)
                .height(100)
                .backgroundColor('#E0F2FE')
                .borderRadius(10)

                Text(p.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0F172A')
                  .textAlign(TextAlign.Center)

                Text(p.price)
                  .fontSize(14)
                  .fontColor('#0EA5E9')

                Text(p.store)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#7DD3FC')

                Button('Compare')
                  .width('100%')
                  .height(36)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FFFFFF')
                  .backgroundColor('#0EA5E9')
                  .borderRadius(10)
              }
              .width('100%')
              .padding(10)
              .alignItems(HorizontalAlign.Center)
              .backgroundColor('#FFFFFF')
              .borderRadius(16)
              .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(10)
        .rowsGap(10)
        .width('100%')

        Text('Price Update Log')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0EA5E9')
          .width('100%')

        Column({ space: 6 }) {
          ForEach(products, (p: Product) => {
            Row() {
              Text(`${p.name} (${p.store})`)
                .fontSize(14)
                .fontColor('#0F172A')
                .layoutWeight(1)

              Text(p.price)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#38BDF8')
            }
            .width('100%')
            .padding(10)
            .justifyContent(FlexAlign.SpaceBetween)
            .backgroundColor('#FFFFFF')
            .borderRadius(6)
          })
        }
        .width('100%')
        .padding({ bottom: 48 })
      }
      .padding(14)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [
        ['#4038BDF8', 0.0],
        ['#FFF0F9FF', 0.5],
        ['#400EA5E9', 1.0]
      ]
    })
  }
}