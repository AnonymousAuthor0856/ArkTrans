@Entry
@Component
struct ShoppingCartAppView {
  private cartItems: CartItem[] = [
    { id: 1, name: 'Wireless Headphones', price: 129.99, color: '#FF6F00' },
    { id: 2, name: 'Smartphone Case', price: 24.99, color: '#000000' },
    { id: 3, name: 'USB-C Cable', price: 19.99, color: '#4CAF50' },
    { id: 4, name: 'Portable Charger', price: 49.99, color: '#FF6F00' }
  ]

  @State private quantities: number[] = [1, 1, 1, 1]

  private shipping: number = 5.99
  private tax: number = 18.50
  private bottomBarHeight: number = 220

  private get subtotal(): number {
    let sum = 0.0
    for (let i = 0; i < this.cartItems.length; i++) {
      sum += this.cartItems[i].price * this.quantities[i]
    }
    return sum
  }

  private get total(): number {
    return this.subtotal + this.shipping + this.tax
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')

      // Main content
      Column({ space: 0 }) {
        // Top bar
        Row({ space: 4 }) {
          Image('')
            .width(20)
            .height(20)
            .backgroundColor('#000000')
            .borderRadius(6)
          Text('Shopping Cart')
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')
        .padding({ top: 30, bottom: 20 })

        // Scrollable list
        List({ space: 8 }) {
          // Cart item cards
          ForEach(this.cartItems, (item: CartItem, index: number) => {
            ListItem() {
              CartItemCard({
                item: item,
                index: index,
                quantity: this.quantities[index],
                onIncrease: () => {
                  if (this.quantities[index] < 10) {
                    let newQ = [...this.quantities]
                    newQ[index] += 1
                    this.quantities = newQ
                  }
                },
                onDecrease: () => {
                  if (this.quantities[index] > 1) {
                    let newQ = [...this.quantities]
                    newQ[index] -= 1
                    this.quantities = newQ
                  }
                }
              })
            }
          })

          // Chips row
          ListItem() {
            ChipsRow()
          }

          // Bottom spacer
          ListItem() {
            Column()
              .height(this.bottomBarHeight)
          }
        }
        .padding({ left: 16, right: 16, top: 8 })
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')

      // Bottom summary bar – wrapped in Column for modifiers
      Column({ space: 0 }) {
        BottomSummary({
          subtotal: this.subtotal,
          shipping: this.shipping,
          tax: this.tax,
          total: this.total
        })
      }
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 16 })
    }
    .width('100%')
    .height('100%')
  }
}

@Builder
function CartItemCard(params: CartItemCardParams) {
  Row({ space: 8 }) {
    // Color square
    Column()
      .width(60)
      .height(60)
      .backgroundColor(params.item.color)
      .borderRadius(8)

    // Item info
    Column({ space: 2 }) {
      Text(params.item.name)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .width(120)
        .textAlign(TextAlign.Start)
        .maxLines(2)

      Text('$' + params.item.price.toFixed(2))
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')

      Row({ space: 4 }) {
        FeatureBox()
        FeatureBox()
        FeatureBox()
      }
    }
    .layoutWeight(1)

    // Quantity controls
    Column({ space: 4 }) {
      QuantityButton({ symbol: '+', onClick: params.onIncrease })
      Text(params.quantity.toString())
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
      QuantityButton({ symbol: '-', onClick: params.onDecrease })
    }

    // Remove button
    Button({ type: ButtonType.Normal }) {
      Text('Remove')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
    }
    .width(85)
    .height(36)
    .backgroundColor('#F44336')
    .borderRadius(8)
  }
  .padding(8)
  .width('100%')
  .backgroundColor('#FFFFFF')
  .borderRadius(12)
  .border({ width: 1, color: '#E0E0E0' })
  .shadow({ radius: 4, color: '#24000000', offsetY: 1 })
}

@Builder
function FeatureBox() {
  Column()
    .width(28)
    .height(28)
    .backgroundColor('#F5F5F5')
    .borderRadius(6)
}

@Builder
function QuantityButton(params: QuantityButtonParams) {
  Button({ type: ButtonType.Normal }) {
    Text(params.symbol)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor('#000000')
  }
  .width(28)
  .height(28)
  .backgroundColor('#F5F5F5')
  .borderRadius(6)
  .onClick(params.onClick)
}

@Builder
function ChipsRow() {
  Row({ space: 4 }) {
    ForEach(['Apply Coupon', 'Gift Wrap', 'Save for Later'], (label: string) => {
      Button({ type: ButtonType.Normal }) {
        Text(label)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .padding({ left: 24, right: 24, top: 4, bottom: 4 })
      }
      .backgroundColor('#FFFFFF')
      .borderRadius(6)
      .border({ width: 1, color: '#E0E0E0' })
    })
  }
  .width('100%')
}

@Builder
function BottomSummary(params: BottomSummaryParams) {
  Column({ space: 8 }) {
    SummaryRow({ title: 'Subtotal', value: '$' + params.subtotal.toFixed(2), emphasize: false })
    SummaryRow({ title: 'Shipping', value: '$' + params.shipping.toFixed(2), emphasize: false })
    SummaryRow({ title: 'Tax', value: '$' + params.tax.toFixed(2), emphasize: false })
    SummaryRow({ title: 'Total', value: '$' + params.total.toFixed(2), emphasize: true })

    Button({ type: ButtonType.Normal }) {
      Text('Proceed to Checkout')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
    }
    .width('100%')
    .height(44)
    .backgroundColor('#000000')
    .borderRadius(12)
  }
  .padding(8)
  .width('100%')
  .backgroundColor('#FFFFFF')
  .borderRadius(12)
  .shadow({ radius: 6, color: '#2A000000', offsetY: 1.5 })
}

@Builder
function SummaryRow(params: SummaryRowParams) {
  Row() {
    Text(params.title)
      .fontSize(params.emphasize ? 18 : 12)
      .fontWeight(params.emphasize ? FontWeight.Medium : FontWeight.Regular)
      .fontColor('#000000')
    Blank()
    Text(params.value)
      .fontSize(params.emphasize ? 18 : 14)
      .fontWeight(params.emphasize ? FontWeight.Medium : FontWeight.Medium)
      .fontColor('#000000')
  }
}

// Interfaces
interface CartItem {
  id: number
  name: string
  price: number
  color: string
}

interface CartItemCardParams {
  item: CartItem
  index: number
  quantity: number
  onIncrease: () => void
  onDecrease: () => void
}

interface QuantityButtonParams {
  symbol: string
  onClick: () => void
}

interface BottomSummaryParams {
  subtotal: number
  shipping: number
  tax: number
  total: number
}

interface SummaryRowParams {
  title: string
  value: string
  emphasize: boolean
}