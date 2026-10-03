@Entry
@Component
struct Index {
  @State cartItems: CartItem[] = [
    { id: '1', name: 'Wireless Headphones', price: 129.99, color: '#FF6D00' },
    { id: '2', name: 'Smartphone Case', price: 24.99, color: '#000000' },
    { id: '3', name: 'USB-C Cable', price: 19.99, color: '#4CAF50' },
    { id: '4', name: 'Portable Charger', price: 49.99, color: '#FF6D00' }
  ]

  build() {
    Stack() {
      Column() {
        // Header
        Row() {
          Text('Shopping Cart')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .width('100%')
        }
        .padding({ top: 40, bottom: 20 })

        // Scrollable List
        Scroll() {
          Column() {
            ForEach(this.cartItems, (item: CartItem) => {
              this.CartItemCard(item)
            }, (item: CartItem) => item.id)
          }
          .padding({ left: 16, right: 16, bottom: 200 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        // Bottom Summary Panel
        Column() {
          Row() {
            Text('Subtotal').fontColor('#000000').fontSize(16)
            Blank()
            Text('$224.96').fontColor('#000000').fontSize(16).fontWeight(FontWeight.Medium)
          }.width('100%').padding({ bottom: 12 })

          Row() {
            Text('Shipping').fontColor('#000000').fontSize(16)
            Blank()
            Text('$5.99').fontColor('#000000').fontSize(16).fontWeight(FontWeight.Medium)
          }.width('100%').padding({ bottom: 12 })

          Row() {
            Text('Tax').fontColor('#000000').fontSize(16)
            Blank()
            Text('$18.50').fontColor('#000000').fontSize(16).fontWeight(FontWeight.Medium)
          }.width('100%').padding({ bottom: 12 })

          Divider().color('#E0E0E0').margin({ bottom: 12 })

          Row() {
            Text('Total').fontColor('#000000').fontSize(24).fontWeight(FontWeight.Bold)
            Blank()
            Text('$249.45').fontColor('#000000').fontSize(24).fontWeight(FontWeight.Bold)
          }.width('100%').padding({ bottom: 20 })

          Button('Proceed to Checkout')
            .backgroundColor('#000000')
            .fontColor('#FFFFFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .borderRadius(16)
            .height(56)
            .width('100%')
        }
        .width('100%')
        .padding(20)
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 20, color: '#1A000000', offsetY: -5 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F2F2F7')
    }.width('100%').height('100%')
  }

  @Builder
  CartItemCard(item: CartItem) {
    Row() {
      // Image Placeholder
      Image($r('app.media.startIcon'))
        .width(80)
        .height(80)
        .borderRadius(12)
        .objectFit(ImageFit.Cover)
        .backgroundColor(item.color)
        .clip(true)

      Column() {
        // Name and Price
        Column() {
          Text(item.name)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('100%')
          
          Text(`$${item.price.toFixed(2)}`)
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
        
        // Color Swatches
        Row() {
          Circle().width(24).height(24).backgroundColor('#FFFFFF').border({ width: 1, color: '#CCCCCC' })
          Circle().width(24).height(24).backgroundColor('#F2F2F7').margin({ left: 8 })
          Circle().width(24).height(24).backgroundColor('#F2F2F7').margin({ left: 8 })
        }
        .margin({ top: 12 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })

      // Controls Column
      Column() {
        // Quantity Stepper
        Column() {
          Button('+')
            .backgroundColor('#F2F2F7')
            .borderRadius(12)
            .width(36)
            .height(36)
            .fontColor('#000000')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          
          Text('1')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .margin({ top: 4, bottom: 4 })
          
          Button('-')
            .backgroundColor('#F2F2F7')
            .borderRadius(12)
            .width(36)
            .height(36)
            .fontColor('#000000')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
        }
        .width(60)
        .height(90)
        .justifyContent(FlexAlign.SpaceBetween)
        .padding(4)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 4, color: '#0A000000' })

        // Remove Button
        Button('Remove')
          .backgroundColor('#FF4B4B')
          .fontColor('#FFFFFF')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(12)
          .height(40)
          .width(80)
          .margin({ top: 12 })
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .margin({ bottom: 16 })
    .shadow({ radius: 8, color: '#0A000000' })
  }
}

interface CartItem {
  id: string;
  name: string;
  price: number;
  color: string;
}