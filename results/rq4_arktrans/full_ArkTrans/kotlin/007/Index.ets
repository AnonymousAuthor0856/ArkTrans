@Entry
@Component
struct Index {
  @State quantities: number[] = [1, 1, 1, 1]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === LazyColumn (List) ===
      List({ space: 8 }) {
        ListItem() {
          // === Card 1: Wireless Headphones ===
          Column() {
            Row({ space: 8 }) {
              // Image Placeholder
              Stack({ alignContent: Alignment.Center }) {
                Text('')
              }.width(60).height(60).backgroundColor('#FF6D00').borderRadius(12)

              // Info Column
              Column({ space: 2 }) {
                Text('Wireless\nHeadphones').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
                Text('$129.99').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#000000')
                
                // Color Options
                Row({ space: 4 }) {
                  Stack({ alignContent: Alignment.Center }).width(28).height(28).backgroundColor('#F5F5F5').borderRadius(8)
                  Stack({ alignContent: Alignment.Center }).width(28).height(28).backgroundColor('#F5F5F5').borderRadius(8)
                  Stack({ alignContent: Alignment.Center }).width(28).height(28).backgroundColor('#F5F5F5').borderRadius(8)
                }
              }.layoutWeight(1).alignItems(HorizontalAlign.Start)

              // Quantity Controls
              Column({ space: 4 }) {
                Button() { Text('+').fontColor('#000000') }.width(28).height(28).backgroundColor('#F5F5F5').borderRadius(8)
                Text(this.quantities[0].toString()).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
                Button() { Text('-').fontColor('#000000') }.width(28).height(28).backgroundColor('#F5F5F5').borderRadius(8)
              }.alignItems(HorizontalAlign.Center)

              // Remove Button
              Button() {
                Text('Remove').fontColor('#FFFFFF')
              }.width(85).height(36).backgroundColor('#F44336').borderRadius(12)
            }.alignItems(VerticalAlign.Center).width('100%').padding(8)
          }.width('100%').backgroundColor('#FFFFFF').borderRadius(16).shadow({ radius: 4, color: '#1A000000' })
        }

        ListItem() {
          // === Card 2: Smartphone Case ===
          Column() {
            Row({ space: 8 }) {
              Stack({ alignContent: Alignment.Center }) {
                Text('')
              }.width(60).height(60).backgroundColor('#000000').borderRadius(12)

              Column({ space: 2 }) {
                Text('Smartphone Case').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
                Text('$24.99').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#000000')
                Row({ space: 4 }) {
                  Stack({ alignContent: Alignment.Center }).width(28).height(28).backgroundColor('#F5F5F5').borderRadius(8)
                  Stack({ alignContent: Alignment.Center }).width(28).height(28).backgroundColor('#F5F5F5').borderRadius(8)
                  Stack({ alignContent: Alignment.Center }).width(28).height(28).backgroundColor('#F5F5F5').borderRadius(8)
                }
              }.layoutWeight(1).alignItems(HorizontalAlign.Start)

              Column({ space: 4 }) {
                Button() { Text('+').fontColor('#000000') }.width(28).height(28).backgroundColor('#F5F5F5').borderRadius(8)
                Text(this.quantities[1].toString()).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
                Button() { Text('-').fontColor('#000000') }.width(28).height(28).backgroundColor('#F5F5F5').borderRadius(8)
              }.alignItems(HorizontalAlign.Center)

              Button() {
                Text('Remove').fontColor('#FFFFFF')
              }.width(85).height(36).backgroundColor('#F44336').borderRadius(12)
            }.alignItems(VerticalAlign.Center).width('100%').padding(8)
          }.width('100%').backgroundColor('#FFFFFF').borderRadius(16).shadow({ radius: 4, color: '#1A000000' })
        }

        ListItem() {
          // === Card 3: USB-C Cable ===
          Column() {
            Row({ space: 8 }) {
              Stack({ alignContent: Alignment.Center }) {
                Text('')
              }.width(60).height(60).backgroundColor('#4CAF50').borderRadius(12)

              Column({ space: 2 }) {
                Text('USB-C Cable').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
                Text('$19.99').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#000000')
                Row({ space: 4 }) {
                  Stack({ alignContent: Alignment.Center }).width(28).height(28).backgroundColor('#F5F5F5').borderRadius(8)
                  Stack({ alignContent: Alignment.Center }).width(28).height(28).backgroundColor('#F5F5F5').borderRadius(8)
                  Stack({ alignContent: Alignment.Center }).width(28).height(28).backgroundColor('#F5F5F5').borderRadius(8)
                }
              }.layoutWeight(1).alignItems(HorizontalAlign.Start)

              Column({ space: 4 }) {
                Button() { Text('+').fontColor('#000000') }.width(28).height(28).backgroundColor('#F5F5F5').borderRadius(8)
                Text(this.quantities[2].toString()).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
                Button() { Text('-').fontColor('#000000') }.width(28).height(28).backgroundColor('#F5F5F5').borderRadius(8)
              }.alignItems(HorizontalAlign.Center)

              Button() {
                Text('Remove').fontColor('#FFFFFF')
              }.width(85).height(36).backgroundColor('#F44336').borderRadius(12)
            }.alignItems(VerticalAlign.Center).width('100%').padding(8)
          }.width('100%').backgroundColor('#FFFFFF').borderRadius(16).shadow({ radius: 4, color: '#1A000000' })
        }

        ListItem() {
          // === Card 4: Portable Charger ===
          Column() {
            Row({ space: 8 }) {
              Stack({ alignContent: Alignment.Center }) {
                Text('')
              }.width(60).height(60).backgroundColor('#FF6D00').borderRadius(12)

              Column({ space: 2 }) {
                Text('Portable Charger').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
                Text('$49.99').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#000000')
                Row({ space: 4 }) {
                  Stack({ alignContent: Alignment.Center }).width(28).height(28).backgroundColor('#F5F5F5').borderRadius(8)
                  Stack({ alignContent: Alignment.Center }).width(28).height(28).backgroundColor('#F5F5F5').borderRadius(8)
                  Stack({ alignContent: Alignment.Center }).width(28).height(28).backgroundColor('#F5F5F5').borderRadius(8)
                }
              }.layoutWeight(1).alignItems(HorizontalAlign.Start)

              Column({ space: 4 }) {
                Button() { Text('+').fontColor('#000000') }.width(28).height(28).backgroundColor('#F5F5F5').borderRadius(8)
                Text(this.quantities[3].toString()).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
                Button() { Text('-').fontColor('#000000') }.width(28).height(28).backgroundColor('#F5F5F5').borderRadius(8)
              }.alignItems(HorizontalAlign.Center)

              Button() {
                Text('Remove').fontColor('#FFFFFF')
              }.width(85).height(36).backgroundColor('#F44336').borderRadius(12)
            }.alignItems(VerticalAlign.Center).width('100%').padding(8)
          }.width('100%').backgroundColor('#FFFFFF').borderRadius(16).shadow({ radius: 4, color: '#1A000000' })
        }
      }.width('100%').layoutWeight(1).padding({ left: 16, right: 16, top: 16, bottom: 200 })

      // === Top App Bar ===
      Row({ space: 4 }) {
        Stack({ alignContent: Alignment.Center }) {
          Text('')
        }.width(20).height(20).backgroundColor('#000000').borderRadius(4)
        Text('Shopping Cart').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#000000')
      }.alignItems(VerticalAlign.Center).justifyContent(FlexAlign.Center).width('100%').height(56)

      // === Bottom Summary Surface ===
      Column() {
        Column({ space: 6 }) {
          Row({ space: 0 }) {
            Text('Subtotal').fontSize(16).fontColor('#000000')
            Blank()
            Text('$224.96').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
          }.width('100%')
          
          Row({ space: 0 }) {
            Text('Shipping').fontSize(16).fontColor('#000000')
            Blank()
            Text('$5.99').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
          }.width('100%')
          
          Row({ space: 0 }) {
            Text('Tax').fontSize(16).fontColor('#000000')
            Blank()
            Text('$18.50').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
          }.width('100%')
          
          Row({ space: 0 }) {
            Text('Total').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#000000')
            Blank()
            Text('$249.45').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#000000')
          }.width('100%')
          
          Button() {
            Text('Proceed to Checkout').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#FFFFFF')
          }.width('100%').height(44).backgroundColor('#000000').borderRadius(16)
        }.width('100%').padding(16)
      }.width('100%').backgroundColor('#EAEAEA').shadow({ radius: 4, color: '#1A000000' }).position({ x: 0, y: 'auto' }).margin({ bottom: 0 })
    }.width('100%').height('100%').backgroundColor('#FFFFFF')
  }
}