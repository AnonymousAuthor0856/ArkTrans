import { router } from '@kit.ArkRouter'
import { webview } from '@kit.WebViewKit'

@Entry
@Component
struct ShoppingCartPage {
  @State cartItems: CartItem[] = [
    new CartItem(1, 'Neon Keyboard', 89.99),
    new CartItem(2, 'Wireless Mouse', 49.99),
    new CartItem(3, 'Gaming Headset', 109.99)
  ]
  @State promoCode: string = ''
  
  build() {
    Column() {
      // Header
      Text('Your Cart')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00E5FF')
        .margin({ top: 20 })
      
      // Cart Items List
      List({ space: 10 }) {
        ForEach(this.cartItems, (item: CartItem) => {
          ListItem() {
            Row() {
              Column() {
                Text(item.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FFFFFF')
                
                Text(`$${item.price.toFixed(2)}`)
                  .fontSize(14)
                  .fontColor('#00BFA5')
                  .margin({ top: 4 })
              }
              
              Button('Remove')
                .backgroundColor('#00E5FF')
                .fontColor('#0A0A0A')
                .borderRadius(10)
                .height(36)
                .onClick(() => {
                  this.removeItem(item.id)
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .padding(10)
            .backgroundColor('#121212')
            .borderRadius(14)
          }
        }, item => item.id.toString())
      }
      .layoutWeight(1)
      .margin({ top: 10 })
      
      // Promo Code Input
      TextInput({ placeholder: 'Promo Code' })
        .type(InputType.Normal)
        .backgroundColor('#1E1E1E')
        .borderRadius(10)
        .margin({ top: 10 })
        .onChange((value: string) => {
          this.promoCode = value
        })
      
      // Summary Card
      Column() {
        Row() {
          Text('Items:')
            .fontSize(14)
            .fontColor('#FFFFFF')
          
          Text(`${this.cartItems.length}`)
            .fontSize(14)
            .fontColor('#00E5FF')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        
        Row() {
          Text('Total:')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
          
          Text(`$${this.calculateTotal().toFixed(2)}`)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#00E5FF')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: 10 })
      }
      .width('100%')
      .padding(14)
      .backgroundColor('#1E1E1E')
      .borderRadius(14)
      .margin({ top: 10 })
      
      // Checkout Button
      Button('Checkout')
        .width('100%')
        .height(56)
        .backgroundColor('#00BFA5')
        .fontColor('#0A0A0A')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .borderRadius(14)
        .margin({ top: 10, bottom: 20 })
        .onClick(() => {
          // Handle checkout
        })
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .backgroundColor('#0A0A0A')
  }
  
  private removeItem(id: number): void {
    this.cartItems = this.cartItems.filter(item => item.id !== id)
  }
  
  private calculateTotal(): number {
    return this.cartItems.reduce((sum, item) => sum + item.price, 0)
  }
}

class CartItem {
  id: number
  name: string
  price: number
  
  constructor(id: number, name: string, price: number) {
    this.id = id
    this.name = name
    this.price = price
  }
}