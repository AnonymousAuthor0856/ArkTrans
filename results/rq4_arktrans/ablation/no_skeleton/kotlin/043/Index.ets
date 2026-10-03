@Entry
@Component
struct ShoppingCart {
  @State promoCode: string = ''

  build() {
    Column() {
      Text('Your Cart')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00E5FF')
        .margin({ bottom: 10 })

      // Item 1
      Row() {
        Column() {
          Text('Neon Keyboard').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#FFFFFF')
          Text('$89.99').fontSize(14).fontColor('#00BFA5')
        }
        Blank()
        Button('Remove')
          .backgroundColor('#00E5FF')
          .fontColor('#0A0A0A')
          .borderRadius(10)
          .height(36)
          .width(100)
      }
      .width('100%')
      .padding(14)
      .backgroundColor('#121212')
      .borderRadius(14)
      .margin({ bottom: 10 })

      // Item 2
      Row() {
        Column() {
          Text('Wireless Mouse').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#FFFFFF')
          Text('$49.99').fontSize(14).fontColor('#00BFA5')
        }
        Blank()
        Button('Remove')
          .backgroundColor('#00E5FF')
          .fontColor('#0A0A0A')
          .borderRadius(10)
          .height(36)
          .width(100)
      }
      .width('100%')
      .padding(14)
      .backgroundColor('#121212')
      .borderRadius(14)
      .margin({ bottom: 10 })

      // Item 3
      Row() {
        Column() {
          Text('Gaming Headset').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#FFFFFF')
          Text('$109.99').fontSize(14).fontColor('#00BFA5')
        }
        Blank()
        Button('Remove')
          .backgroundColor('#00E5FF')
          .fontColor('#0A0A0A')
          .borderRadius(10)
          .height(36)
          .width(100)
      }
      .width('100%')
      .padding(14)
      .backgroundColor('#121212')
      .borderRadius(14)
      .margin({ bottom: 10 })

      // Promo Code Input
      TextInput({ placeholder: 'Promo Code' })
        .placeholderColor('#808080')
        .backgroundColor('#1E1E1E')
        .borderRadius(10)
        .height(48)
        .margin({ bottom: 10 })
        .onChange((value: string) => {
          this.promoCode = value
        })

      // Summary Card
      Column() {
        Row() {
          Text('Items:').fontSize(14).fontColor('#FFFFFF')
          Blank()
          Text('3').fontSize(14).fontColor('#00E5FF')
        }.width('100%')
        
        Row() {
          Text('Total:').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#FFFFFF')
          Blank()
          Text('$249.97').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#00E5FF')
        }.width('100%')
      }
      .width('100%')
      .padding(14)
      .backgroundColor('#1E1E1E')
      .borderRadius(14)
      .margin({ bottom: 10 })

      // Checkout Button
      Button('Checkout')
        .width('100%')
        .height(56)
        .backgroundColor('#00BFA5')
        .fontColor('#0A0A0A')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .borderRadius(14)
    }
    .width('100%')
    .padding(14)
    .backgroundColor('#0A0A0A')
  }
}