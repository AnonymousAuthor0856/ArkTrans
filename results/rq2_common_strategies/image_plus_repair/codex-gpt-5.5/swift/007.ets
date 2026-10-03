interface ColorPalette {
  primary: string
  orange: string
  green: string
  background: string
  surfaceVariant: string
  outline: string
  error: string
}

const Colors: ColorPalette = {
  primary: '#000000',
  orange: '#FF6F00',
  green: '#4CAF50',
  background: '#FFFFFF',
  surfaceVariant: '#F5F5F5',
  outline: '#E0E0E0',
  error: '#F44336'
}

interface CartItem {
  id: number
  name: string
  price: number
  color: string
}

@Entry
@Component
struct ShoppingCartApp {
  private readonly cartItems: CartItem[] = [
    { id: 1, name: 'Wireless Headphones', price: 129.99, color: Colors.orange },
    { id: 2, name: 'Smartphone Case', price: 24.99, color: Colors.primary },
    { id: 3, name: 'USB-C Cable', price: 19.99, color: Colors.green },
    { id: 4, name: 'Portable Charger', price: 49.99, color: Colors.orange }
  ]

  @State private quantities: number[] = [1, 1, 1, 1]
  @State private visibleItems: CartItem[] = []
  private readonly shipping: number = 5.99
  private readonly tax: number = 18.50

  aboutToAppear(): void {
    this.visibleItems = this.cartItems.slice()
  }

  private subtotal(): number {
    let result = 0
    this.visibleItems.forEach((item: CartItem) => {
      const originalIndex = this.cartItems.findIndex((source: CartItem) => source.id === item.id)
      result += item.price * (originalIndex >= 0 ? this.quantities[originalIndex] : 1)
    })
    return result
  }

  private total(): number {
    return this.subtotal() + this.shipping + this.tax
  }

  private money(value: number): string {
    return '$' + value.toFixed(2)
  }

  private quantityFor(item: CartItem): number {
    const index = this.cartItems.findIndex((source: CartItem) => source.id === item.id)
    return index >= 0 ? this.quantities[index] : 1
  }

  private changeQuantity(item: CartItem, delta: number): void {
    const index = this.cartItems.findIndex((source: CartItem) => source.id === item.id)
    if (index < 0) {
      return
    }
    const next = Math.max(1, Math.min(10, this.quantities[index] + delta))
    const nextQuantities = this.quantities.slice()
    nextQuantities[index] = next
    this.quantities = nextQuantities
  }

  private removeItem(item: CartItem): void {
    this.visibleItems = this.visibleItems.filter((current: CartItem) => current.id !== item.id)
  }

  @Builder
  private quantityButton(symbol: string, item: CartItem, delta: number) {
    Button(symbol)
      .width(56)
      .height(56)
      .fontSize(24)
      .fontColor(Colors.primary)
      .backgroundColor(Colors.surfaceVariant)
      .borderRadius(10)
      .shadow({ radius: 8, color: '#22000000', offsetX: 0, offsetY: 2 })
      .onClick(() => this.changeQuantity(item, delta))
  }

  @Builder
  private featureBoxes() {
    Row({ space: 8 }) {
      ForEach([1, 2, 3], (value: number) => {
        Blank()
          .width(56)
          .height(56)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(10)
      }, (value: number) => value.toString())
    }
  }

  @Builder
  private cartCard(item: CartItem) {
    Row({ space: 16 }) {
      Blank()
        .width(120)
        .height(120)
        .backgroundColor(item.color)
        .borderRadius(16)

      Column({ space: 2 }) {
        Text(item.name)
          .fontSize(29)
          .fontColor(Colors.primary)
          .fontWeight(FontWeight.Medium)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width(270)
          .textAlign(TextAlign.Start)

        Text(this.money(item.price))
          .fontSize(34)
          .fontColor(Colors.primary)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 2, bottom: 6 })

        this.featureBoxes()
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column({ space: 8 }) {
        this.quantityButton('+', item, 1)
        Text(this.quantityFor(item).toString())
          .fontSize(29)
          .fontColor(Colors.primary)
          .height(38)
          .textAlign(TextAlign.Center)
        this.quantityButton('-', item, -1)
      }
      .alignItems(HorizontalAlign.Center)

      Button('Remove')
        .width(170)
        .height(72)
        .fontSize(20)
        .fontColor('#FFFFFF')
        .backgroundColor(Colors.error)
        .borderRadius(16)
        .onClick(() => this.removeItem(item))
    }
    .width('100%')
    .padding(16)
    .height(204)
    .backgroundColor(Colors.background)
    .borderRadius(24)
    .border({ width: 2, color: Colors.outline })
    .shadow({ radius: 8, color: '#26000000', offsetX: 0, offsetY: 2 })
  }

  @Builder
  private chipsRow() {
    Row({ space: 8 }) {
      ForEach(['Apply Coupon', 'Gift Wrap', 'Save for Later'], (label: string) => {
        Button(label)
          .fontSize(16)
          .fontColor(Colors.primary)
          .backgroundColor(Colors.background)
          .border({ width: 1, color: Colors.outline })
          .borderRadius(10)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
      }, (label: string) => label)
    }
    .width('100%')
  }

  @Builder
  private summaryRow(title: string, value: number, emphasize: boolean = false) {
    Row() {
      Text(title)
        .fontSize(emphasize ? 31 : 24)
        .fontColor(Colors.primary)
        .fontWeight(emphasize ? FontWeight.Bold : FontWeight.Regular)
      Blank().layoutWeight(1)
      Text(this.money(value))
        .fontSize(emphasize ? 31 : 27)
        .fontColor(Colors.primary)
        .fontWeight(emphasize ? FontWeight.Bold : FontWeight.Medium)
    }
    .width('100%')
    .height(emphasize ? 42 : 38)
  }

  @Builder
  private bottomSummary() {
    Column({ space: 4 }) {
      this.summaryRow('Subtotal', this.subtotal())
      this.summaryRow('Shipping', this.shipping)
      this.summaryRow('Tax', this.tax)
      this.summaryRow('Total', this.total(), true)
      Button('Proceed to Checkout')
        .width('100%')
        .height(72)
        .fontSize(26)
        .fontColor('#FFFFFF')
        .backgroundColor(Colors.primary)
        .borderRadius(18)
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Colors.background)
    .borderRadius(24)
    .shadow({ radius: 10, color: '#30000000', offsetX: 0, offsetY: 2 })
    .width('calc(100% - 32vp)')
    .margin({ bottom: 16 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row({ space: 10 }) {
          Blank()
            .width(40)
            .height(40)
            .backgroundColor(Colors.primary)
            .borderRadius(10)
          Text('Shopping Cart')
            .fontSize(43)
            .fontColor(Colors.primary)
            .fontWeight(FontWeight.Bold)
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .height(132)
        .padding({ top: 28, bottom: 20 })

        Scroll() {
          Column({ space: 16 }) {
            ForEach(this.visibleItems, (item: CartItem) => {
              this.cartCard(item)
            }, (item: CartItem) => item.id.toString())
            this.chipsRow()
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 8, bottom: 252 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      this.bottomSummary()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
