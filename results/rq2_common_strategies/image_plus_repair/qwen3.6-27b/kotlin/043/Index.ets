// App.ets
import { router } from '@kit.ArkUI';

@Entry
@Component
struct ShoppingCartPage {
  @State items: CartItem[] = [
    new CartItem(1, "Neon Keyboard", 89.99),
    new CartItem(2, "Wireless Mouse", 49.99),
    new CartItem(3, "Gaming Headset", 109.99)
  ];
  
  @State promoCode: string = '';
  
  build() {
    Column() {
      // Header
      Text('Your Cart')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00E5FF')
        .margin({ bottom: 16 })
      
      // Cart Items
      ForEach(this.items, (item: CartItem) => {
        this.CartItemCard(item)
      })
      
      // Promo Code Input
      TextInput({ placeholder: 'Promo Code' })
        .width('100%')
        .height(48)
        .backgroundColor('#1E1E1E')
        .borderRadius(10)
        .margin({ top: 16, bottom: 16 })
        .placeholderColor('#80FFFFFF')
        .onChange((value: string) => {
          this.promoCode = value;
        })
      
      // Summary Card
      this.SummaryCard()
      
      // Checkout Button
      Button('Checkout')
        .width('100%')
        .height(56)
        .backgroundColor('#00BFA5')
        .fontColor('#0A0A0A')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .borderRadius(14)
        .margin({ top: 16 })
        .onClick(() => {
          // Handle checkout
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#0A0A0A')
  }
  
  @Builder
  CartItemCard(item: CartItem) {
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
      
      Blank()
      
      Button('Remove')
        .backgroundColor('#00E5FF')
        .fontColor('#0A0A0A')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .borderRadius(10)
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .onClick(() => {
          // Remove item logic
          const index = this.items.findIndex(i => i.id === item.id);
          if (index > -1) {
            this.items.splice(index, 1);
          }
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .backgroundColor('#121212')
    .borderRadius(14)
    .margin({ bottom: 12 })
  }
  
  @Builder
  SummaryCard() {
    Column() {
      Row() {
        Text('Items:')
          .fontSize(14)
          .fontColor('#FFFFFF')
        
        Blank()
        
        Text(`${this.items.length}`)
          .fontSize(14)
          .fontColor('#00E5FF')
      }
      .width('100%')
      .margin({ bottom: 8 })
      
      Row() {
        Text('Total:')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
        
        Blank()
        
        Text(`$${this.calculateTotal().toFixed(2)}`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#00E5FF')
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#1E1E1E')
    .borderRadius(14)
  }
  
  private calculateTotal(): number {
    return this.items.reduce((sum, item) => sum + item.price, 0);
  }
}

class CartItem {
  id: number;
  name: string;
  price: number;
  
  constructor(id: number, name: string, price: number) {
    this.id = id;
    this.name = name;
    this.price = price;
  }
}