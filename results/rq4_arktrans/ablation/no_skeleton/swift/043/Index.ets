@Entry
@Component
struct RootScreen {
  @State promo: string = ''

  // Data Model
  private items: CartItem[] = [
    { id: 1, name: 'Neon Keyboard', price: 89.99 },
    { id: 2, name: 'Wireless Mouse', price: 49.99 },
    { id: 3, name: 'Gaming Headset', price: 109.99 }
  ]

  get total(): number {
    return this.items.reduce((acc, item) => acc + item.price, 0)
  }

  build() {
    // === Stack (ZStack) ===
    // props: {}
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Stack() {
      // === Column (Background Gradient) ===
      // props: {}
      // modifier: { width: '100%', height: '100%', linearGradient: { angle: 180, colors: [['#0A0A0A', 0], ['#1E1E1E', 1]] } }
      // children: 0
      Column() {}

      // === Scroll (ScrollView) ===
      // props: {}
      // modifier: { width: '100%', height: '100%' }
      // children: 1
      Scroll() {
        // === Column (Content Container) ===
        // props: { space: 10 }
        // modifier: { width: '100%', padding: 14 }
        // children: 6
        Column({ space: 10 }) {
          // === Text (Title) ===
          // props: { text: 'Your Cart' }
          // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, fontColor: '#00E5FF', textAlign: TextAlign.Start }
          Text('Your Cart').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#00E5FF').textAlign(TextAlign.Start)

          // === ForEach (Cart Items) ===
          ForEach(this.items, (item: CartItem) => {
            // === Row (Card) ===
            // props: { space: 10 }
            // modifier: { width: '100%', padding: 10, backgroundColor: '#121212', borderRadius: 14, shadow: { radius: 4, color: '#26000000', offsetY: 2 } }
            // children: 2
            Row({ space: 10 }) {
              // === Column (Info) ===
              // props: { space: 4 }
              // modifier: { layoutWeight: 1 }
              // children: 2
              Column({ space: 4 }) {
                // === Text (Name) ===
                // props: { text: item.name }
                // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: '#FFF' }
                Text(item.name).fontSize(18).fontWeight(FontWeight.Medium).fontColor('#FFF')
                // === Text (Price) ===
                // props: { text: '$' + item.price.toFixed(2) }
                // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, fontColor: '#00BFA5' }
                Text('$' + item.price.toFixed(2)).fontSize(14).fontWeight(FontWeight.Normal).fontColor('#00BFA5')
              }.layoutWeight(1)

              // === Button (Remove) ===
              // modifier: { backgroundColor: '#00E5FF', borderRadius: 10, margin: { left: 10, right: 10, top: 6, bottom: 6 } }
              // children: 1
              Button() {
                // === Text ===
                // props: { text: 'Remove' }
                // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#0A0A0A' }
                Text('Remove').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#0A0A0A')
              }.backgroundColor('#00E5FF').borderRadius(10).margin({ left: 10, right: 10, top: 6, bottom: 6 })
            }.width('100%').padding(10).backgroundColor('#121212').borderRadius(14).shadow({ radius: 4, color: '#26000000', offsetY: 2 })
          }, (item: CartItem) => item.id.toString())

          // === Blank (Spacer) ===
          // modifier: { height: 10 }
          Blank().height(10)

          // === TextInput (Promo Code) ===
          // props: { placeholder: 'Promo Code' }
          // modifier: { width: '100%', height: 44, backgroundColor: '#1E1E1E', borderRadius: 10, borderColor: '#2C2C2C', borderWidth: 1, padding: 10, fontColor: '#FFF', placeholderColor: '#80FFFFFF' }
          TextInput({ placeholder: 'Promo Code' }).width('100%').height(44).backgroundColor('#1E1E1E').borderRadius(10).borderColor('#2C2C2C').borderWidth(1).padding(10).fontColor('#FFF').placeholderColor('#80FFFFFF')

          // === Blank (Spacer) ===
          // modifier: { height: 10 }
          Blank().height(10)

          // === Column (Summary Card) ===
          // props: { space: 6 }
          // modifier: { width: '100%', padding: 14, backgroundColor: '#1E1E1E', borderRadius: 14, shadow: { radius: 4, color: '#26000000', offsetY: 2 } }
          // children: 2
          Column({ space: 6 }) {
            // === Row (Items Count) ===
            // props: {}
            // modifier: { width: '100%' }
            // children: 2
            Row() {
              // === Text ===
              // props: { text: 'Items:' }
              // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, fontColor: '#FFF' }
              Text('Items:').fontSize(14).fontWeight(FontWeight.Normal).fontColor('#FFF')
              // === Blank ===
              Blank()
              // === Text ===
              // props: { text: String(this.items.length) }
              // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, fontColor: '#00E5FF' }
              Text(String(this.items.length)).fontSize(14).fontWeight(FontWeight.Normal).fontColor('#00E5FF')
            }.width('100%')

            // === Row (Total Price) ===
            // props: {}
            // modifier: { width: '100%' }
            // children: 2
            Row() {
              // === Text ===
              // props: { text: 'Total:' }
              // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: '#FFF' }
              Text('Total:').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#FFF')
              // === Blank ===
              Blank()
              // === Text ===
              // props: { text: '$' + this.total.toFixed(2) }
              // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: '#00E5FF' }
              Text('$' + this.total.toFixed(2)).fontSize(18).fontWeight(FontWeight.Medium).fontColor('#00E5FF')
            }.width('100%')
          }.width('100%').padding(14).backgroundColor('#1E1E1E').borderRadius(14).shadow({ radius: 4, color: '#26000000', offsetY: 2 })

          // === Button (Checkout) ===
          // modifier: { width: '100%', height: 56, backgroundColor: '#00BFA5', borderRadius: 14 }
          // children: 1
          Button() {
            // === Text ===
            // props: { text: 'Checkout' }
            // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: '#0A0A0A' }
            Text('Checkout').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#0A0A0A')
          }.width('100%').height(56).backgroundColor('#00BFA5').borderRadius(14)
        }.width('100%').padding(14)
      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }
}

interface CartItem {
  id: number;
  name: string;
  price: number;
}