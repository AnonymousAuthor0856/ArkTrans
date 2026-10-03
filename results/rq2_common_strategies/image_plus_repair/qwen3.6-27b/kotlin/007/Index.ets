// App.ets
import { UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct ShoppingCartApp {
  @State cartItems: CartItem[] = [
    new CartItem(1, "Wireless Headphones", 129.99, '#FF6F00'),
    new CartItem(2, "Smartphone Case", 24.99, '#000000'),
    new CartItem(3, "USB-C Cable", 19.99, '#4CAF50'),
    new CartItem(4, "Portable Charger", 49.99, '#FF6F00')
  ];
  
  @State quantities: number[] = [1, 1, 1, 1];
  private shipping: number = 5.99;
  private tax: number = 18.50;
  
  build() {
    Column() {
      // Header
      Row() {
        Rect()
          .width(20)
          .height(20)
          .fill('#000000')
          .borderRadius(6)
        
        Text('Shopping Cart')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ left: 4 })
      }
      .width('100%')
      .padding({ top: 20, bottom: 16 })
      
      // Scrollable content
      Scroll() {
        Column() {
          ForEach(this.cartItems, (item: CartItem, index: number) => {
            this.CartItemCard(item, index)
          }, (item: CartItem) => item.id.toString())
          
          // Action chips
          Row() {
            this.ActionChip("Apply Coupon")
            this.ActionChip("Gift Wrap")
            this.ActionChip("Save for Later")
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)
          .margin({ top: 12 })
        }
      }
      .layoutWeight(1)
      
      // Bottom summary
      this.SummarySection()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
  
  @Builder
  CartItemCard(item: CartItem, index: number) {
    Column() {
      Row() {
        // Product image placeholder
        Rect()
          .width(60)
          .height(60)
          .fill(item.color)
          .borderRadius(8)
        
        // Product info
        Column() {
          Text(item.name)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          
          Text(`$${item.price.toFixed(2)}`)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .margin({ top: 2 })
          
          // Color options
          Row() {
            ForEach([0, 1, 2], () => {
              Rect()
                .width(28)
                .height(28)
                .fill('#F5F5F5')
                .borderRadius(6)
                .margin({ right: 4 })
            })
          }
          .margin({ top: 4 })
        }
        .layoutWeight(1)
        .margin({ left: 12 })
        
        // Quantity controls
        Column() {
          Button('+')
            .width(28)
            .height(28)
            .backgroundColor('#F5F5F5')
            .fontColor('#000000')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .borderRadius(6)
            .onClick(() => {
              if (this.quantities[index] < 10) {
                this.quantities[index]++;
              }
            })
          
          Text(`${this.quantities[index]}`)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .margin({ top: 4, bottom: 4 })
          
          Button('-')
            .width(28)
            .height(28)
            .backgroundColor('#F5F5F5')
            .fontColor('#000000')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .borderRadius(6)
            .onClick(() => {
              if (this.quantities[index] > 1) {
                this.quantities[index]--;
              }
            })
        }
        .alignItems(HorizontalAlign.Center)
        
        // Remove button
        Button('Remove')
          .width(85)
          .height(36)
          .backgroundColor('#F44336')
          .fontColor('#FFFFFF')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .borderRadius(8)
          .margin({ left: 12 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetY: 1 })
    .margin({ bottom: 12 })
  }
  
  @Builder
  ActionChip(text: string) {
    Text(text)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor('#000000')
      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      .border({ width: 1, color: '#E0E0E0' })
      .borderRadius(6)
      .backgroundColor('#FFFFFF')
      .margin({ right: 4 })
  }
  
  @Builder
  SummarySection() {
    Column() {
      // Subtotal
      Row() {
        Text('Subtotal')
          .fontSize(12)
          .fontColor('#000000')
        
        Text(`$${this.calculateSubtotal().toFixed(2)}`)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      
      // Shipping
      Row() {
        Text('Shipping')
          .fontSize(12)
          .fontColor('#000000')
        
        Text(`$${this.shipping.toFixed(2)}`)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 6 })
      
      // Tax
      Row() {
        Text('Tax')
          .fontSize(12)
          .fontColor('#000000')
        
        Text(`$${this.tax.toFixed(2)}`)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 6 })
      
      // Total
      Row() {
        Text('Total')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        
        Text(`$${this.calculateTotal().toFixed(2)}`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 6 })
      
      // Checkout button
      Button('Proceed to Checkout')
        .width('100%')
        .height(44)
        .backgroundColor('#000000')
        .fontColor('#FFFFFF')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .borderRadius(12)
        .margin({ top: 12 })
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#E0E0E0')
  }
  
  private calculateSubtotal(): number {
    return this.cartItems.reduce((sum, item, index) => {
      return sum + (item.price * this.quantities[index]);
    }, 0);
  }
  
  private calculateTotal(): number {
    return this.calculateSubtotal() + this.shipping + this.tax;
  }
}

class CartItem {
  id: number;
  name: string;
  price: number;
  color: string;
  
  constructor(id: number, name: string, price: number, color: string) {
    this.id = id;
    this.name = name;
    this.price = price;
    this.color = color;
  }
}