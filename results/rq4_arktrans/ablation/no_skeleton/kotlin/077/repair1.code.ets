@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false
  @State selectedColorIndex: number = 0
  @State quantity: number = 1

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Bottom }
    // children: 2
    Stack({ alignContent: Alignment.Bottom }) {
      // === Column (Scrollable Content) ===
      // modifier: { width: '100%', height: '100%', backgroundColor: '#F5F5F7' }
      // children: 2
      Column() {
        // === Scroll (Vertical) ===
        // modifier: { width: '100%', layoutWeight: 1, padding: { bottom: 80 } }
        // children: 2
        Scroll() {
          // === Column (Inner Content) ===
          // modifier: { width: '100%' }
          // children: 2
          Column() {
            // === Image Placeholder (Top Section) ===
            // modifier: { width: '100%', height: 400, borderRadius: { bottomLeft: 40, bottomRight: 40 }, backgroundColor: '#E8E8E8' }
            // children: 3
            Stack() {
              // Background placeholder
              Image('').width('100%').height('100%').objectFit(ImageFit.Cover).borderRadius({ bottomLeft: 40, bottomRight: 40 }).backgroundColor('#E8E8E8')

              // Center Icon Circle
              // modifier: { width: 200, height: 200, backgroundColor: '#FFF', borderRadius: 100, shadow: { radius: 20, color: '#1A000000' } }
              // children: 1
              Column() {
                Image($r('app.media.startIcon')).width(100).height(100).objectFit(ImageFit.Contain)
              }.width(200).height(200).backgroundColor('#FFF').borderRadius(100).shadow({ radius: 20, color: '#1A000000' }).alignRules({ horizontal: HorizontalAlign.Center, vertical: VerticalAlign.Center })

              // Top Left Button (Back)
              // modifier: { width: 42, height: 42, backgroundColor: '#FFF', borderRadius: 21, margin: { left: 24, top: 24 } }
              // children: 1
              Row() {
                Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
              }.width(42).height(42).backgroundColor('#FFF').borderRadius(21).margin({ left: 24, top: 24 }).onClick(() => {})

              // Top Right Button (Favorite)
              // modifier: { width: 42, height: 42, backgroundColor: '#FFF', borderRadius: 21, margin: { right: 24, top: 24 } }
              // children: 1
              Row() {
                Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
              }.width(42).height(42).backgroundColor('#FFF').borderRadius(21).margin({ right: 24, top: 24 }).onClick(() => { this.isFavorite = !this.isFavorite })
            }.width('100%').height(400)

            // === Column (Details) ===
            // modifier: { width: '100%', padding: 24 }
            // children: 6
            Column() {
              // === Row (Title & Rating) ===
              // props: { space: 12 }
              // modifier: { width: '100%', justifyContent: FlexAlign.SpaceBetween }
              // children: 2
              Row({ space: 12 }) {
                // === Text ===
                // props: { text: 'Modern Lounge' }
                // modifier: { fontSize: 26, fontWeight: FontWeight.Bold, color: '#333333' }
                Text('Modern Lounge').fontSize(26).fontWeight(FontWeight.Bold).fontColor('#333333')

                // === Row (Rating) ===
                // props: { space: 4 }
                // children: 2
                Row({ space: 4 }) {
                  // === Image (Star) ===
                  // modifier: { width: 20, height: 20 }
                  Image($r('app.media.startIcon')).width(20).height(20)
                  // === Text ===
                  // props: { text: '4.8' }
                  // modifier: { fontSize: 16, fontWeight: FontWeight.Bold }
                  Text('4.8').fontSize(16).fontWeight(FontWeight.Bold)
                }
              }.width('100%').justifyContent(FlexAlign.SpaceBetween)

              // === Text ===
              // props: { text: 'Armchair' }
              // modifier: { fontSize: 20, fontWeight: FontWeight.Lighter, color: '#999999', marginTop: -4 }
              Text('Armchair').fontSize(20).fontWeight(FontWeight.Lighter).fontColor('#999999').margin({ top: -4 })

              // === Blank ===
              // modifier: { height: 24 }
              Blank().height(24)

              // === Text ===
              // props: { text: 'Description' }
              // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#000000' }
              Text('Description').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#000000')

              // === Blank ===
              // modifier: { height: 8 }
              Blank().height(8)

              // === Text ===
              // props: { text: 'Experience the ultimate comfort...' }
              // modifier: { fontSize: 14, color: '#999999', lineHeight: 22 }
              Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.').fontSize(14).fontColor('#999999').lineHeight(22)
            }.width('100%').padding(24)
          }.width('100%')
        }.width('100%').layoutWeight(1).scrollBar(BarState.Off).edgeEffect(EdgeEffect.Spring)

        // === Blank (Spacer for bottom sheet overlap) ===
        // modifier: { height: 80 }
        Blank().height(80)
      }.width('100%').height('100%').backgroundColor('#F5F5F7')

      // === Column (Bottom Sheet) ===
      // modifier: { width: '100%', backgroundColor: '#FFF', borderRadius: { topLeft: 24, topRight: 24 }, shadow: { radius: 16, color: '#1A000000' }, padding: 24 }
      // children: 1
      Column() {
        // === Row ===
        // props: { space: 12 }
        // modifier: { width: '100%', justifyContent: FlexAlign.SpaceBetween }
        // children: 2
        Row({ space: 12 }) {
          // === Column (Price) ===
          // children: 2
          Column() {
            // === Text ===
            // props: { text: 'Total Price' }
            // modifier: { fontSize: 14, color: '#999999' }
            Text('Total Price').fontSize(14).fontColor('#999999')
            // === Text ===
            // props: { text: '$245' }
            // modifier: { fontSize: 24, fontWeight: FontWeight.Bold, color: '#000000' }
            Text('$245').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#000000')
          }

          // === Button ===
          // modifier: { width: 160, height: 50, backgroundColor: '#333333', borderRadius: 16 }
          // children: 1
          Button() {
            // === Row (Icon & Text) ===
            Row() {
              // === Image ===
              // modifier: { width: 20, height: 20 }
              Image($r('app.media.startIcon')).width(20).height(20)
              // === Text ===
              // props: { text: 'Add to Cart' }
              // modifier: { fontSize: 16, color: '#FFF', marginLeft: 8 }
              Text('Add to Cart').fontSize(16).fontColor('#FFF').margin({ left: 8 })
            }
          }.width(160).height(50).backgroundColor('#333333').borderRadius(16)
        }.width('100%').justifyContent(FlexAlign.SpaceBetween)
      }.width('100%').backgroundColor('#FFF').borderRadius({ topLeft: 24, topRight: 24 }).shadow({ radius: 16, color: '#1A000000' }).padding(24)
    }.width('100%').height('100%')
  }
}