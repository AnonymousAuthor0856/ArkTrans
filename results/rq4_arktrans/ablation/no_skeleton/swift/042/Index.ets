@Entry
@Component
struct RootScreen {
  @State products: Product[] = [
    { id: 1, name: 'Wireless Earbuds', price: '$59.99', store: 'ShopA' },
    { id: 2, name: 'Smart Watch', price: '$129.99', store: 'ShopB' },
    { id: 3, name: 'Laptop Stand', price: '$39.99', store: 'ShopC' },
    { id: 4, name: 'Mechanical Keyboard', price: '$89.99', store: 'ShopA' },
    { id: 5, name: 'Noise Cancel Headset', price: '$149.99', store: 'ShopB' },
    { id: 6, name: 'Ergo Mouse', price: '$45.99', store: 'ShopC' }
  ]

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.TopStart }
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Stack({ alignContent: Alignment.TopStart }) {
      // === LinearGradient ===
      // props: { angle: 90, colors: [[0.220, 0.741, 0.973, 0.25], [0.941, 0.976, 1.000, 1.0], [0.055, 0.647, 0.914, 0.25]] }
      // modifier: { width: '100%', height: '100%' }
      Rect()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 90,
          colors: [
            ['rgba(56, 189, 250, 0.25)', 0.0],
            ['rgba(240, 249, 255, 1.0)', 0.5],
            ['rgba(14, 165, 233, 0.25)', 1.0]
          ]
        })

      // === Scroll ===
      // props: { edgeEffect: new EdgeEffect.Spring(), scrollbarWidth: 0 }
      // modifier: { width: '100%', height: '100%' }
      // children: 1
      Scroll() {
        // === Column ===
        // props: { space: 14 }
        // modifier: { width: '100%', padding: 14, paddingBottom: 48 }
        // children: 3
        Column({ space: 14 }) {
          // === Text ===
          // props: { text: 'Cold Gradient Price Compare' }
          // modifier: { fontSize: 26, fontWeight: FontWeight.Bold, color: '#0F172A' }
          Text('Cold Gradient Price Compare').fontSize(26).fontWeight(FontWeight.Bold).fontColor('#0F172A')

          // === Grid ===
          // props: { columnsTemplate: '1fr 1fr', columnsGap: 10, rowsGap: 10 }
          // modifier: { width: '100%' }
          // children: 6
          Grid() {
            ForEach(this.products, (p: Product) => {
              // === GridItem ===
              // children: 1
              GridItem() {
                // === ProductCard ===
                // props: { product: p }
                ProductCard({ product: p })
              }
            })
          }.columnsTemplate('1fr 1fr').columnsGap(10).rowsGap(10).width('100%')

          // === Column ===
          // props: { space: 6 }
          // modifier: { width: '100%' }
          // children: 7
          Column({ space: 6 }) {
            // === Text ===
            // props: { text: 'Price Update Log' }
            // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#0EA5E9' }
            Text('Price Update Log').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#0EA5E9')

            ForEach(this.products, (p: Product) => {
              // === PriceUpdateLogItem ===
              // props: { product: p }
              PriceUpdateLogItem({ product: p })
            })
          }.width('100%')
        }.width('100%').padding(14).padding({ bottom: 48 })
      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }
}

// === Component: ProductCard ===
@Component
struct ProductCard {
  private product: Product = {} as Product

  build() {
    // === Column ===
    // props: { space: 6 }
    // modifier: { width: '100%', padding: 10, backgroundColor: '#FFF', borderRadius: 16, shadow: { radius: 4, color: '#1F000000', offsetY: 2 } }
    // children: 5
    Column({ space: 6 }) {
      // === Rectangle ===
      // modifier: { width: 100, height: 100, backgroundColor: '#E0F2FE', borderRadius: 10 }
      Rect().width(100).height(100).fill('#E0F2FE').borderRadius(10)

      // === Text ===
      // props: { text: this.product.name }
      // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#0F172A' }
      Text(this.product.name).fontSize(18).fontWeight(FontWeight.Medium).fontColor('#0F172A')

      // === Text ===
      // props: { text: this.product.price }
      // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#0EA5E9' }
      Text(this.product.price).fontSize(14).fontWeight(FontWeight.Normal).fontColor('#0EA5E9')

      // === Text ===
      // props: { text: this.product.store }
      // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#7DD3FC' }
      Text(this.product.store).fontSize(12).fontWeight(FontWeight.Medium).fontColor('#7DD3FC')

      // === Button ===
      // props: { type: ButtonType.Capsule }
      // modifier: { width: '100%', height: 32, backgroundColor: '#0EA5E9', fontColor: '#FFF', borderRadius: 10 }
      // children: 1
      Button() {
        // === Text ===
        // props: { text: 'Compare' }
        // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#FFF' }
        Text('Compare').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#FFF')
      }.type(ButtonType.Capsule).width('100%').height(32).backgroundColor('#0EA5E9').fontColor('#FFF').borderRadius(10)
    }.width('100%').padding(10).backgroundColor('#FFF').borderRadius(16).shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
  }
}

// === Component: PriceUpdateLogItem ===
@Component
struct PriceUpdateLogItem {
  private product: Product = {} as Product

  build() {
    // === Row ===
    // props: { space: 10 }
    // modifier: { width: '100%', padding: 10, backgroundColor: '#FFF', borderRadius: 6 }
    // children: 3
    Row({ space: 10 }) {
      // === Text ===
      // props: { text: `${this.product.name} (${this.product.store})` }
      // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#0F172A' }
      Text(`${this.product.name} (${this.product.store})`).fontSize(14).fontWeight(FontWeight.Normal).fontColor('#0F172A')

      // === Blank ===
      // modifier: { layoutWeight: 1 }
      Blank().layoutWeight(1)

      // === Text ===
      // props: { text: this.product.price }
      // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#38BDF8' }
      Text(this.product.price).fontSize(12).fontWeight(FontWeight.Medium).fontColor('#38BDF8')
    }.width('100%').padding(10).backgroundColor('#FFF').borderRadius(6)
  }
}

interface Product {
  id: number;
  name: string;
  price: string;
  store: string;
}