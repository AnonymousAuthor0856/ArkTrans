import { ColorFilter, ImageFit, VerticalAlign, FlexAlign, FontWeight, TextOverflow } from '@kit.ArkUI'

@Entry
@Component
struct CoffeeDetailScreen {
  @State isFavorite: boolean = false
  @State selectedSize: string = "M"

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // === Scrollable Content Column ===
      // props: { space: 24 }
      // modifier: { width: '100%', height: '100%', padding: { left: 24, right: 24 }, backgroundColor: '#FFF' }
      // children: 5
      Column({ space: 24 }) {
        // === Spacer (Top) ===
        // modifier: { height: 16 }
        Blank().height(16)

        // === Image Placeholder Box ===
        // props: { alignContent: Alignment.Center }
        // modifier: { width: '100%', height: 240, borderRadius: 32, backgroundColor: '#F5F5F5' }
        // children: 1
        Stack({ alignContent: Alignment.Center }) {
          // === Icon (ShoppingCart) ===
          // modifier: { width: 80, height: 80, color: '#E0E0E0' }
          Image($r('app.media.startIcon')).width(80).height(80).objectFit(ImageFit.Contain).colorFilter(ColorFilter.srcIn('#E0E0E0'))
        }.width('100%').height(240).borderRadius(32).backgroundColor('#F5F5F5')

        // === Title & Rating Section ===
        // props: { space: 8 }
        // children: 2
        Column({ space: 8 }) {
          // === Text (Title) ===
          // props: { text: 'Caramel Macchiato' }
          // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, color: '#000' }
          Text('Caramel Macchiato').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#000')

          // === Row (Rating) ===
          // props: { space: 4, verticalAlignment: Alignment.Center }
          // children: 3
          Row({ space: 4 }) {
            // === Icon (Star) ===
            // modifier: { width: 20, height: 20, color: '#FFC107' }
            Image($r('app.media.startIcon')).width(20).height(20).objectFit(ImageFit.Contain).colorFilter(ColorFilter.srcIn('#FFC107'))
            
            // === Text (Score) ===
            // props: { text: '4.8' }
            // modifier: { fontSize: 16, fontWeight: FontWeight.Bold }
            Text('4.8').fontSize(16).fontWeight(FontWeight.Bold)
            
            // === Text (Reviews) ===
            // props: { text: '(230 reviews)' }
            // modifier: { fontSize: 14, color: '#999' }
            Text('(230 reviews)').fontSize(14).fontColor('#999')
          }.alignItems(VerticalAlign.Center)
        }

        // === Description Section ===
        // props: { space: 12 }
        // children: 2
        Column({ space: 12 }) {
          // === Text (Header) ===
          // props: { text: 'Description' }
          // modifier: { fontSize: 18, fontWeight: FontWeight.SemiBold }
          Text('Description').fontSize(18).fontWeight(FontWeight.Medium)

          // === Text (Body) ===
          // props: { text: 'A Caramel Macchiato...' }
          // modifier: { fontSize: 15, lineHeight: 22, color: '#999', maxLines: 4, overflow: TextOverflow.Ellipsis }
          Text('A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffee.')
            .fontSize(15)
            .lineHeight(22)
            .fontColor('#999')
            .maxLines(4)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }

        // === Size Selection Section ===
        // props: { space: 16 }
        // children: 2
        Column({ space: 16 }) {
          // === Text (Header) ===
          // props: { text: 'Size' }
          // modifier: { fontSize: 18, fontWeight: FontWeight.SemiBold }
          Text('Size').fontSize(18).fontWeight(FontWeight.Medium)

          // === Row (Options) ===
          // props: { justifyContent: FlexAlign.SpaceBetween }
          // modifier: { width: '100%' }
          // children: 3
          Row() {
            this.SizeOption('S', this.selectedSize === 'S', () => { this.selectedSize = 'S' })
            this.SizeOption('M', this.selectedSize === 'M', () => { this.selectedSize = 'M' })
            this.SizeOption('L', this.selectedSize === 'L', () => { this.selectedSize = 'L' })
          }.width('100%').justifyContent(FlexAlign.SpaceBetween)
        }

        // === Spacer (Bottom for scroll) ===
        // modifier: { height: 100 }
        Blank().height(100)
      }

      // === Bottom Bar Action ===
      // modifier: { width: '100%', shadow: { radius: 16, color: '#1F000000' }, margin: { top: -24 } }
      // children: 1
      Column() {
        // === Row (Content) ===
        // props: { space: 16, verticalAlignment: Alignment.Center, justifyContent: FlexAlign.SpaceBetween }
        // modifier: { width: '100%', padding: 24, backgroundColor: '#FFF' }
        // children: 2
        Row({ space: 16 }) {
          // === Column (Price) ===
          // props: { space: 4 }
          // children: 2
          Column({ space: 4 }) {
            // === Text (Label) ===
            // props: { text: 'Price' }
            // modifier: { fontSize: 14, color: '#999' }
            Text('Price').fontSize(14).fontColor('#999')
            
            // === Text (Value) ===
            // props: { text: '$ 4.50' }
            // modifier: { fontSize: 24, fontWeight: FontWeight.Bold, color: '#6F4E37' }
            Text('$ 4.50').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#6F4E37')
          }

          // === Button (Add to Cart) ===
          // modifier: { width: 200, height: 56, backgroundColor: '#6F4E37', borderRadius: 16 }
          // children: 1
          Button() {
            // === Text ===
            // props: { text: 'Add to Cart' }
            // modifier: { fontSize: 18, fontWeight: FontWeight.SemiBold, fontColor: '#FFF' }
            Text('Add to Cart').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#FFF')
          }.width(200).height(56).backgroundColor('#6F4E37').borderRadius(16)
        }.width('100%').padding(24).backgroundColor('#FFF').alignItems(VerticalAlign.Center).justifyContent(FlexAlign.SpaceBetween)
      }.width('100%').shadow({ radius: 16, color: '#1F000000' }).margin({ top: -24 })
    }.width('100%').height('100%')
  }

  @Builder
  SizeOption(label: string, isSelected: boolean, onClick: () => void) {
    // Logic derived from Compose SizeOption
    const borderColor = isSelected ? '#6F4E37' : '#E0E0E0'
    const containerColor = isSelected ? '#FFF4E0' : '#FFF'
    const textColor = isSelected ? '#6F4E37' : '#000'

    // === Box (Button) ===
    // modifier: { width: 100, height: 48, borderRadius: 12, border: { width: 1, color: borderColor }, backgroundColor: containerColor }
    // children: 1
    Column() {
      // === Text ===
      // props: { text: label }
      // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: textColor }
      Text(label).fontSize(16).fontWeight(FontWeight.Medium).fontColor(textColor)
    }
    .width(100)
    .height(48)
    .borderRadius(12)
    .border({ width: 1, color: borderColor })
    .backgroundColor(containerColor)
    .onClick(onClick)
  }
}