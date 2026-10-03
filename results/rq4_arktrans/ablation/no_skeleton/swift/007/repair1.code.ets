@Entry
@Component
struct ShoppingCartAppView {
  @State quantities: number[] = [1, 1, 1, 1]

  private readonly cartItems: CartItem[] = [
    { id: 1, name: "Wireless Headphones", price: 129.99, color: '#FF6F00' },
    { id: 2, name: "Smartphone Case", price: 24.99, color: '#000000' },
    { id: 3, name: "USB-C Cable", price: 19.99, color: '#4CAF50' },
    { id: 4, name: "Portable Charger", price: 49.99, color: '#FF6F00' }
  ]

  private readonly shipping: number = 5.99
  private readonly tax: number = 18.50

  get subtotal(): number {
    return this.cartItems.reduce((acc, item, index) => acc + (item.price * this.quantities[index]), 0)
  }

  get total(): number {
    return this.subtotal + this.shipping + this.tax
  }

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Bottom }
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Stack({ alignContent: Alignment.Bottom }) {
      // === Column ===
      // props: { space: 0 }
      // modifier: { width: '100%' }
      // children: 2
      Column() {
        // === Row ===
        // props: { space: 4 }
        // modifier: { width: '100%', padding: { top: 30, bottom: 20 } }
        // children: 2
        Row() {
          // === Image ===
          // modifier: { width: 20, height: 20, borderRadius: 6, backgroundColor: '#000000' }
          Image($r('app.media.startIcon')).width(20).height(20).borderRadius(6).backgroundColor('#000000')
          // === Text ===
          // props: { text: 'Shopping Cart' }
          // modifier: { fontSize: 22, fontWeight: FontWeight.Semibold, fontColor: '#000000' }
          Text('Shopping Cart').fontSize(22).fontWeight(FontWeight.Bold).fontColor('#000000')
        }.width('100%').padding({ top: 30, bottom: 20 })

        // === List ===
        // props: { space: 8 }
        // modifier: { width: '100%', layoutWeight: 1, padding: { left: 8, right: 8, top: 6, bottom: 228 } }
        // children: 7
        List() {
          ListItem() {
            // === Row ===
            // props: { space: 8 }
            // modifier: { width: '100%', minHeight: 100, padding: 8, backgroundColor: '#FFF', borderRadius: 12, shadow: { radius: 4, offsetY: 1, color: '#24000000' }, borderColor: '#E0E0E0', borderWidth: 1 }
            // children: 4
            Row() {
              // === Image ===
              // modifier: { width: 60, height: 60, borderRadius: 8, backgroundColor: '#FF6F00' }
              Image('').width(60).height(60).borderRadius(8).backgroundColor('#FF6F00')

              // === Column ===
              // props: { space: 2 }
              // modifier: { layoutWeight: 1, alignItems: ItemAlign.Start }
              // children: 3
              Column() {
                // === Text ===
                // props: { text: 'Wireless Headphones' }
                // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: '#000000', maxWidth: 120, lineHeight: 20, maxHeight: 40 }
                Text('Wireless Headphones').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000').maxLines(1).lineHeight(20).maxHeight(40)

                // === Text ===
                // props: { text: '$129.99' }
                // modifier: { fontSize: 18, fontWeight: FontWeight.Semibold, fontColor: '#000000' }
                Text('$129.99').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#000000')

                // === Row ===
                // props: { space: 4 }
                // modifier: { width: '100%' }
                // children: 3
                Row() {
                  // === Image ===
                  // modifier: { width: 28, height: 28, borderRadius: 6, backgroundColor: '#F5F5F5' }
                  Image('').width(28).height(28).borderRadius(6).backgroundColor('#F5F5F5')
                  // === Image ===
                  // modifier: { width: 28, height: 28, borderRadius: 6, backgroundColor: '#F5F5F5' }
                  Image('').width(28).height(28).borderRadius(6).backgroundColor('#F5F5F5')
                  // === Image ===
                  // modifier: { width: 28, height: 28, borderRadius: 6, backgroundColor: '#F5F5F5' }
                  Image('').width(28).height(28).borderRadius(6).backgroundColor('#F5F5F5')
                }.width('100%')
              }.layoutWeight(1).alignItems(HorizontalAlign.Start)

              // === Column ===
              // props: { space: 4 }
              // modifier: { width: 28 }
              // children: 3
              Column() {
                // === Button ===
                // modifier: { width: 28, height: 28, backgroundColor: '#F5F5F5', borderRadius: 6, fontColor: '#000000' }
                // children: 1
                Button() {
                  // === Text ===
                  // props: { text: '+' }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Medium }
                  Text('+').fontSize(14).fontWeight(FontWeight.Medium)
                }.width(28).height(28).backgroundColor('#F5F5F5').borderRadius(6).fontColor('#000000')

                // === Text ===
                // props: { text: '1' }
                // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: '#000000' }
                Text('1').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000')

                // === Button ===
                // modifier: { width: 28, height: 28, backgroundColor: '#F5F5F5', borderRadius: 6, fontColor: '#000000' }
                // children: 1
                Button() {
                  // === Text ===
                  // props: { text: '-' }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Medium }
                  Text('-').fontSize(14).fontWeight(FontWeight.Medium)
                }.width(28).height(28).backgroundColor('#F5F5F5').borderRadius(6).fontColor('#000000')
              }.width(28)

              // === Button ===
              // modifier: { width: 85, height: 36, backgroundColor: '#F44336', borderRadius: 8, fontColor: '#FFF' }
              // children: 1
              Button() {
                // === Text ===
                // props: { text: 'Remove' }
                // modifier: { fontSize: 10, fontWeight: FontWeight.Medium }
                Text('Remove').fontSize(10).fontWeight(FontWeight.Medium)
              }.width(85).height(36).backgroundColor('#F44336').borderRadius(8).fontColor('#FFF')
            }.width('100%').height(100).padding(8).backgroundColor('#FFF').borderRadius(12).shadow({ radius: 4, offsetY: 1, color: '#24000000' }).border({ width: 1, color: '#E0E0E0' })
          }
          ListItem() {
            // === Row ===
            // props: { space: 8 }
            // modifier: { width: '100%', minHeight: 100, padding: 8, backgroundColor: '#FFF', borderRadius: 12, shadow: { radius: 4, offsetY: 1, color: '#24000000' }, borderColor: '#E0E0E0', borderWidth: 1 }
            // children: 4
            Row() {
              // === Image ===
              // modifier: { width: 60, height: 60, borderRadius: 8, backgroundColor: '#000000' }
              Image('').width(60).height(60).borderRadius(8).backgroundColor('#000000')

              // === Column ===
              // props: { space: 2 }
              // modifier: { layoutWeight: 1, alignItems: ItemAlign.Start }
              // children: 3
              Column() {
                // === Text ===
                // props: { text: 'Smartphone Case' }
                // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: '#000000', maxWidth: 120, lineHeight: 20, maxHeight: 40 }
                Text('Smartphone Case').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000').maxLines(1).lineHeight(20).maxHeight(40)

                // === Text ===
                // props: { text: '$24.99' }
                // modifier: { fontSize: 18, fontWeight: FontWeight.Semibold, fontColor: '#000000' }
                Text('$24.99').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#000000')

                // === Row ===
                // props: { space: 4 }
                // modifier: { width: '100%' }
                // children: 3
                Row() {
                  // === Image ===
                  // modifier: { width: 28, height: 28, borderRadius: 6, backgroundColor: '#F5F5F5' }
                  Image('').width(28).height(28).borderRadius(6).backgroundColor('#F5F5F5')
                  // === Image ===
                  // modifier: { width: 28, height: 28, borderRadius: 6, backgroundColor: '#F5F5F5' }
                  Image('').width(28).height(28).borderRadius(6).backgroundColor('#F5F5F5')
                  // === Image ===
                  // modifier: { width: 28, height: 28, borderRadius: 6, backgroundColor: '#F5F5F5' }
                  Image('').width(28).height(28).borderRadius(6).backgroundColor('#F5F5F5')
                }.width('100%')
              }.layoutWeight(1).alignItems(HorizontalAlign.Start)

              // === Column ===
              // props: { space: 4 }
              // modifier: { width: 28 }
              // children: 3
              Column() {
                // === Button ===
                // modifier: { width: 28, height: 28, backgroundColor: '#F5F5F5', borderRadius: 6, fontColor: '#000000' }
                // children: 1
                Button() {
                  // === Text ===
                  // props: { text: '+' }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Medium }
                  Text('+').fontSize(14).fontWeight(FontWeight.Medium)
                }.width(28).height(28).backgroundColor('#F5F5F5').borderRadius(6).fontColor('#000000')

                // === Text ===
                // props: { text: '1' }
                // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: '#000000' }
                Text('1').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000')

                // === Button ===
                // modifier: { width: 28, height: 28, backgroundColor: '#F5F5F5', borderRadius: 6, fontColor: '#000000' }
                // children: 1
                Button() {
                  // === Text ===
                  // props: { text: '-' }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Medium }
                  Text('-').fontSize(14).fontWeight(FontWeight.Medium)
                }.width(28).height(28).backgroundColor('#F5F5F5').borderRadius(6).fontColor('#000000')
              }.width(28)

              // === Button ===
              // modifier: { width: 85, height: 36, backgroundColor: '#F44336', borderRadius: 8, fontColor: '#FFF' }
              // children: 1
              Button() {
                // === Text ===
                // props: { text: 'Remove' }
                // modifier: { fontSize: 10, fontWeight: FontWeight.Medium }
                Text('Remove').fontSize(10).fontWeight(FontWeight.Medium)
              }.width(85).height(36).backgroundColor('#F44336').borderRadius(8).fontColor('#FFF')
            }.width('100%').height(100).padding(8).backgroundColor('#FFF').borderRadius(12).shadow({ radius: 4, offsetY: 1, color: '#24000000' }).border({ width: 1, color: '#E0E0E0' })
          }
          ListItem() {
            // === Row ===
            // props: { space: 8 }
            // modifier: { width: '100%', minHeight: 100, padding: 8, backgroundColor: '#FFF', borderRadius: 12, shadow: { radius: 4, offsetY: 1, color: '#24000000' }, borderColor: '#E0E0E0', borderWidth: 1 }
            // children: 4
            Row() {
              // === Image ===
              // modifier: { width: 60, height: 60, borderRadius: 8, backgroundColor: '#4CAF50' }
              Image('').width(60).height(60).borderRadius(8).backgroundColor('#4CAF50')

              // === Column ===
              // props: { space: 2 }
              // modifier: { layoutWeight: 1, alignItems: ItemAlign.Start }
              // children: 3
              Column() {
                // === Text ===
                // props: { text: 'USB-C Cable' }
                // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: '#000000', maxWidth: 120, lineHeight: 20, maxHeight: 40 }
                Text('USB-C Cable').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000').maxLines(1).lineHeight(20).maxHeight(40)

                // === Text ===
                // props: { text: '$19.99' }
                // modifier: { fontSize: 18, fontWeight: FontWeight.Semibold, fontColor: '#000000' }
                Text('$19.99').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#000000')

                // === Row ===
                // props: { space: 4 }
                // modifier: { width: '100%' }
                // children: 3
                Row() {
                  // === Image ===
                  // modifier: { width: 28, height: 28, borderRadius: 6, backgroundColor: '#F5F5F5' }
                  Image('').width(28).height(28).borderRadius(6).backgroundColor('#F5F5F5')
                  // === Image ===
                  // modifier: { width: 28, height: 28, borderRadius: 6, backgroundColor: '#F5F5F5' }
                  Image('').width(28).height(28).borderRadius(6).backgroundColor('#F5F5F5')
                  // === Image ===
                  // modifier: { width: 28, height: 28, borderRadius: 6, backgroundColor: '#F5F5F5' }
                  Image('').width(28).height(28).borderRadius(6).backgroundColor('#F5F5F5')
                }.width('100%')
              }.layoutWeight(1).alignItems(HorizontalAlign.Start)

              // === Column ===
              // props: { space: 4 }
              // modifier: { width: 28 }
              // children: 3
              Column() {
                // === Button ===
                // modifier: { width: 28, height: 28, backgroundColor: '#F5F5F5', borderRadius: 6, fontColor: '#000000' }
                // children: 1
                Button() {
                  // === Text ===
                  // props: { text: '+' }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Medium }
                  Text('+').fontSize(14).fontWeight(FontWeight.Medium)
                }.width(28).height(28).backgroundColor('#F5F5F5').borderRadius(6).fontColor('#000000')

                // === Text ===
                // props: { text: '1' }
                // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: '#000000' }
                Text('1').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000')

                // === Button ===
                // modifier: { width: 28, height: 28, backgroundColor: '#F5F5F5', borderRadius: 6, fontColor: '#000000' }
                // children: 1
                Button() {
                  // === Text ===
                  // props: { text: '-' }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Medium }
                  Text('-').fontSize(14).fontWeight(FontWeight.Medium)
                }.width(28).height(28).backgroundColor('#F5F5F5').borderRadius(6).fontColor('#000000')
              }.width(28)

              // === Button ===
              // modifier: { width: 85, height: 36, backgroundColor: '#F44336', borderRadius: 8, fontColor: '#FFF' }
              // children: 1
              Button() {
                // === Text ===
                // props: { text: 'Remove' }
                // modifier: { fontSize: 10, fontWeight: FontWeight.Medium }
                Text('Remove').fontSize(10).fontWeight(FontWeight.Medium)
              }.width(85).height(36).backgroundColor('#F44336').borderRadius(8).fontColor('#FFF')
            }.width('100%').height(100).padding(8).backgroundColor('#FFF').borderRadius(12).shadow({ radius: 4, offsetY: 1, color: '#24000000' }).border({ width: 1, color: '#E0E0E0' })
          }
          ListItem() {
            // === Row ===
            // props: { space: 8 }
            // modifier: { width: '100%', minHeight: 100, padding: 8, backgroundColor: '#FFF', borderRadius: 12, shadow: { radius: 4, offsetY: 1, color: '#24000000' }, borderColor: '#E0E0E0', borderWidth: 1 }
            // children: 4
            Row() {
              // === Image ===
              // modifier: { width: 60, height: 60, borderRadius: 8, backgroundColor: '#FF6F00' }
              Image('').width(60).height(60).borderRadius(8).backgroundColor('#FF6F00')

              // === Column ===
              // props: { space: 2 }
              // modifier: { layoutWeight: 1, alignItems: ItemAlign.Start }
              // children: 3
              Column() {
                // === Text ===
                // props: { text: 'Portable Charger' }
                // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: '#000000', maxWidth: 120, lineHeight: 20, maxHeight: 40 }
                Text('Portable Charger').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000').maxLines(1).lineHeight(20).maxHeight(40)

                // === Text ===
                // props: { text: '$49.99' }
                // modifier: { fontSize: 18, fontWeight: FontWeight.Semibold, fontColor: '#000000' }
                Text('$49.99').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#000000')

                // === Row ===
                // props: { space: 4 }
                // modifier: { width: '100%' }
                // children: 3
                Row() {
                  // === Image ===
                  // modifier: { width: 28, height: 28, borderRadius: 6, backgroundColor: '#F5F5F5' }
                  Image('').width(28).height(28).borderRadius(6).backgroundColor('#F5F5F5')
                  // === Image ===
                  // modifier: { width: 28, height: 28, borderRadius: 6, backgroundColor: '#F5F5F5' }
                  Image('').width(28).height(28).borderRadius(6).backgroundColor('#F5F5F5')
                  // === Image ===
                  // modifier: { width: 28, height: 28, borderRadius: 6, backgroundColor: '#F5F5F5' }
                  Image('').width(28).height(28).borderRadius(6).backgroundColor('#F5F5F5')
                }.width('100%')
              }.layoutWeight(1).alignItems(HorizontalAlign.Start)

              // === Column ===
              // props: { space: 4 }
              // modifier: { width: 28 }
              // children: 3
              Column() {
                // === Button ===
                // modifier: { width: 28, height: 28, backgroundColor: '#F5F5F5', borderRadius: 6, fontColor: '#000000' }
                // children: 1
                Button() {
                  // === Text ===
                  // props: { text: '+' }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Medium }
                  Text('+').fontSize(14).fontWeight(FontWeight.Medium)
                }.width(28).height(28).backgroundColor('#F5F5F5').borderRadius(6).fontColor('#000000')

                // === Text ===
                // props: { text: '1' }
                // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: '#000000' }
                Text('1').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000')

                // === Button ===
                // modifier: { width: 28, height: 28, backgroundColor: '#F5F5F5', borderRadius: 6, fontColor: '#000000' }
                // children: 1
                Button() {
                  // === Text ===
                  // props: { text: '-' }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Medium }
                  Text('-').fontSize(14).fontWeight(FontWeight.Medium)
                }.width(28).height(28).backgroundColor('#F5F5F5').borderRadius(6).fontColor('#000000')
              }.width(28)

              // === Button ===
              // modifier: { width: 85, height: 36, backgroundColor: '#F44336', borderRadius: 8, fontColor: '#FFF' }
              // children: 1
              Button() {
                // === Text ===
                // props: { text: 'Remove' }
                // modifier: { fontSize: 10, fontWeight: FontWeight.Medium }
                Text('Remove').fontSize(10).fontWeight(FontWeight.Medium)
              }.width(85).height(36).backgroundColor('#F44336').borderRadius(8).fontColor('#FFF')
            }.width('100%').height(100).padding(8).backgroundColor('#FFF').borderRadius(12).shadow({ radius: 4, offsetY: 1, color: '#24000000' }).border({ width: 1, color: '#E0E0E0' })
          }
          ListItem() {
            // === Row ===
            // props: { space: 4 }
            // modifier: { width: '100%', justifyContent: FlexAlign.Start }
            // children: 3
            Row() {
              // === Button ===
              // modifier: { backgroundColor: '#FFF', borderRadius: 6, borderColor: '#E0E0E0', borderWidth: 1, fontColor: '#000000', padding: { left: 12, right: 12, top: 4, bottom: 4 } }
              // children: 1
              Button() {
                // === Text ===
                // props: { text: 'Apply Coupon' }
                // modifier: { fontSize: 10, fontWeight: FontWeight.Medium }
                Text('Apply Coupon').fontSize(10).fontWeight(FontWeight.Medium)
              }.backgroundColor('#FFF').borderRadius(6).border({ width: 1, color: '#E0E0E0' }).fontColor('#000000').padding({ left: 12, right: 12, top: 4, bottom: 4 })

              // === Button ===
              // modifier: { backgroundColor: '#FFF', borderRadius: 6, borderColor: '#E0E0E0', borderWidth: 1, fontColor: '#000000', padding: { left: 12, right: 12, top: 4, bottom: 4 } }
              // children: 1
              Button() {
                // === Text ===
                // props: { text: 'Gift Wrap' }
                // modifier: { fontSize: 10, fontWeight: FontWeight.Medium }
                Text('Gift Wrap').fontSize(10).fontWeight(FontWeight.Medium)
              }.backgroundColor('#FFF').borderRadius(6).border({ width: 1, color: '#E0E0E0' }).fontColor('#000000').padding({ left: 12, right: 12, top: 4, bottom: 4 })

              // === Button ===
              // modifier: { backgroundColor: '#FFF', borderRadius: 6, borderColor: '#E0E0E0', borderWidth: 1, fontColor: '#000000', padding: { left: 12, right: 12, top: 4, bottom: 4 } }
              // children: 1
              Button() {
                // === Text ===
                // props: { text: 'Save for Later' }
                // modifier: { fontSize: 10, fontWeight: FontWeight.Medium }
                Text('Save for Later').fontSize(10).fontWeight(FontWeight.Medium)
              }.backgroundColor('#FFF').borderRadius(6).border({ width: 1, color: '#E0E0E0' }).fontColor('#000000').padding({ left: 12, right: 12, top: 4, bottom: 4 })
            }.width('100%').justifyContent(FlexAlign.Start)
          }
        }.width('100%').layoutWeight(1).padding({ left: 8, right: 8, top: 6, bottom: 228 })
      }.width('100%')

      // === Column ===
      // props: { space: 6 }
      // modifier: { width: '100%', padding: 8, backgroundColor: '#FFF', borderRadius: 12, shadow: { radius: 6, offsetY: 1.5, color: '#29000000' }, margin: { left: 8, right: 8, bottom: 6 } }
      // children: 5
      Column() {
        // === Row ===
        // modifier: { width: '100%', justifyContent: FlexAlign.SpaceBetween }
        // children: 2
        Row() {
          // === Text ===
          // props: { text: 'Subtotal' }
          // modifier: { fontSize: 12, fontWeight: FontWeight.Regular, fontColor: '#000000' }
          Text('Subtotal').fontSize(12).fontWeight(FontWeight.Normal).fontColor('#000000')
          // === Blank ===
          Blank()
          // === Text ===
          // props: { text: '$224.96' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: '#000000' }
          Text('$224.96').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000')
        }.width('100%').justifyContent(FlexAlign.SpaceBetween)

        // === Row ===
        // modifier: { width: '100%', justifyContent: FlexAlign.SpaceBetween }
        // children: 2
        Row() {
          // === Text ===
          // props: { text: 'Shipping' }
          // modifier: { fontSize: 12, fontWeight: FontWeight.Regular, fontColor: '#000000' }
          Text('Shipping').fontSize(12).fontWeight(FontWeight.Normal).fontColor('#000000')
          // === Blank ===
          Blank()
          // === Text ===
          // props: { text: '$5.99' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: '#000000' }
          Text('$5.99').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000')
        }.width('100%').justifyContent(FlexAlign.SpaceBetween)

        // === Row ===
        // modifier: { width: '100%', justifyContent: FlexAlign.SpaceBetween }
        // children: 2
        Row() {
          // === Text ===
          // props: { text: 'Tax' }
          // modifier: { fontSize: 12, fontWeight: FontWeight.Regular, fontColor: '#000000' }
          Text('Tax').fontSize(12).fontWeight(FontWeight.Normal).fontColor('#000000')
          // === Blank ===
          Blank()
          // === Text ===
          // props: { text: '$18.50' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: '#000000' }
          Text('$18.50').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000')
        }.width('100%').justifyContent(FlexAlign.SpaceBetween)

        // === Row ===
        // modifier: { width: '100%', justifyContent: FlexAlign.SpaceBetween }
        // children: 2
        Row() {
          // === Text ===
          // props: { text: 'Total' }
          // modifier: { fontSize: 18, fontWeight: FontWeight.Semibold, fontColor: '#000000' }
          Text('Total').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#000000')
          // === Blank ===
          Blank()
          // === Text ===
          // props: { text: '$249.45' }
          // modifier: { fontSize: 18, fontWeight: FontWeight.Semibold, fontColor: '#000000' }
          Text('$249.45').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#000000')
        }.width('100%').justifyContent(FlexAlign.SpaceBetween)

        // === Button ===
        // modifier: { width: '100%', height: 44, backgroundColor: '#000000', borderRadius: 12, fontColor: '#FFF' }
        // children: 1
        Button() {
          // === Text ===
          // props: { text: 'Proceed to Checkout' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Medium }
          Text('Proceed to Checkout').fontSize(14).fontWeight(FontWeight.Medium)
        }.width('100%').height(44).backgroundColor('#000000').borderRadius(12).fontColor('#FFF')
      }.width('100%').padding(8).backgroundColor('#FFF').borderRadius(12).shadow({ radius: 6, offsetY: 1.5, color: '#29000000' }).margin({ left: 8, right: 8, bottom: 6 })
    }.width('100%').height('100%')
  }
}

interface CartItem {
  id: number
  name: string
  price: number
  color: string
}