@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    { id: '1', x: 120, y: 200, label: 'Store A' },
    { id: '2', x: 360, y: 400, label: 'Store B' }
  ]

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.TopStart }
    // modifier: { width: '100%', height: '100%', backgroundColor: '#FFF' }
    // children: 1
    Stack({ alignContent: Alignment.TopStart }) {
      // === Column ===
      // props: { space: 16 }
      // modifier: { width: '100%', padding: 16 }
      // children: 4
      Column({ space: 16 }) {
        // === Text ===
        // props: { text: 'Product Detail' }
        // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, color: '#111111' }
        Text('Product Detail').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#111111')

        // === Column (Card) ===
        // props: { space: 12 }
        // modifier: { width: '100%', padding: 16, backgroundColor: '#F9F9F9', borderRadius: 14, shadow: { radius: 8, color: '#1F000000', offsetY: 4 } }
        // children: 5
        Column({ space: 12 }) {
          // === Image ===
          // modifier: { width: '100%', height: 160, backgroundColor: '#E5E5E5' }
          Image('').width('100%').height(160).backgroundColor('#E5E5E5')

          // === Text ===
          // props: { text: 'Monochrome Bag' }
          // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#111111' }
          Text('Monochrome Bag').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#111111')

          // === Text ===
          // props: { text: 'A minimalist and timeless design piece.' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#777777' }
          Text('A minimalist and timeless design piece.').fontSize(14).fontWeight(FontWeight.Normal).fontColor('#777777')

          // === Text ===
          // props: { text: '$79.00' }
          // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#111111' }
          Text('$79.00').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#111111')

          // === Button ===
          // modifier: { width: '100%', height: 48, backgroundColor: '#111111', fontColor: '#FFF', borderRadius: 10 }
          // children: 1
          Button() {
            // === Text ===
            // props: { text: 'Add to Cart' }
            // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#FFF' }
            Text('Add to Cart').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#FFF')
          }.width('100%').height(48).backgroundColor('#111111').borderRadius(10)
        }.width('100%').padding(16).backgroundColor('#F9F9F9').borderRadius(14).shadow({ radius: 8, color: '#1F000000', offsetY: 4 })

        // === Stack (Map Area) ===
        // props: { alignContent: Alignment.TopStart }
        // modifier: { width: '100%', height: 240, backgroundColor: '#F9F9F9', borderRadius: 14 }
        // children: 2
        Stack({ alignContent: Alignment.TopStart }) {
          // === Image ===
          // modifier: { width: '100%', height: '100%', backgroundColor: '#E5E5E5', margin: 16 }
          Image('').width('100%').height('100%').backgroundColor('#E5E5E5').margin(16)

          // === ForEach (Markers) ===
          ForEach(this.markers, (item: Marker) => {
            // === Circle ===
            // modifier: { width: 28, height: 28, backgroundColor: '#111111', position: { x: item.x - 14, y: item.y - 14 } }
            Circle().width(28).height(28).backgroundColor('#111111').position({ x: item.x - 14, y: item.y - 14 })
          })
        }.width('100%').height(240).backgroundColor('#F9F9F9').borderRadius(14)

        // === Row (Bottom Actions) ===
        // props: { space: 12 }
        // modifier: { width: '100%' }
        // children: 2
        Row({ space: 12 }) {
          // === Button ===
          // modifier: { layoutWeight: 1, height: 44, backgroundColor: '#333333', fontColor: '#FFF', borderRadius: 10 }
          // children: 1
          Button() {
            // === Text ===
            // props: { text: 'Add Marker' }
            // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#FFF' }
            Text('Add Marker').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#FFF')
          }.layoutWeight(1).height(44).backgroundColor('#333333').borderRadius(10)

          // === Button ===
          // modifier: { layoutWeight: 1, height: 44, backgroundColor: '#777777', fontColor: '#111111', borderRadius: 10 }
          // children: 1
          Button() {
            // === Text ===
            // props: { text: 'Clear' }
            // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#111111' }
            Text('Clear').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#111111')
          }.layoutWeight(1).height(44).backgroundColor('#777777').borderRadius(10)
        }.width('100%')
      }.width('100%').padding(16)
    }.width('100%').height('100%').backgroundColor('#FFF')
  }
}

interface Marker {
  id: string;
  x: number;
  y: number;
  label: string;
}