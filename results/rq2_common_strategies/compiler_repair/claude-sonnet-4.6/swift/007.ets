// Design tokens
const primaryColor: string = '#000000'
const secondaryColor: string = '#FF6F00'
const tertiaryColor: string = '#4CAF50'
const backgroundColor: string = '#FFFFFF'
const surfaceColor: string = '#FFFFFF'
const surfaceVariantColor: string = '#F5F5F5'
const outlineColor: string = '#E0E0E0'
const errorColor: string = '#F44336'
const onPrimaryColor: string = '#FFFFFF'
const onSurfaceColor: string = '#000000'

const spacingXs: number = 2
const spacingSm: number = 4
const spacingMd: number = 6
const spacingLg: number = 8
const spacingXl: number = 12
const spacingXxl: number = 16

const shapeSmall: number = 6
const shapeMedium: number = 8
const shapeLarge: number = 12

interface CartItemData {
  id: number
  name: string
  price: number
  color: string
}

@Entry
@Component
struct ShoppingCartAppView {
  private cartItems: CartItemData[] = [
    { id: 1, name: 'Wireless Headphones', price: 129.99, color: secondaryColor } as CartItemData,
    { id: 2, name: 'Smartphone Case', price: 24.99, color: primaryColor } as CartItemData,
    { id: 3, name: 'USB-C Cable', price: 19.99, color: tertiaryColor } as CartItemData,
    { id: 4, name: 'Portable Charger', price: 49.99, color: secondaryColor } as CartItemData,
  ]

  @State quantities: number[] = [1, 1, 1, 1]

  private shipping: number = 5.99
  private tax: number = 18.50

  private getSubtotal(): number {
    let total = 0
    for (let i = 0; i < this.cartItems.length; i++) {
      total += this.cartItems[i].price * this.quantities[i]
    }
    return total
  }

  private getTotal(): number {
    return this.getSubtotal() + this.shipping + this.tax
  }

  @Builder
  TopBar() {
    Row({ space: spacingSm }) {
      Column()
        .width(20)
        .height(20)
        .backgroundColor(primaryColor)
        .borderRadius(shapeSmall)

      Text('Shopping Cart')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(onSurfaceColor)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: spacingXxl, bottom: spacingMd })
  }

  @Builder
  FeatureBox() {
    Column()
      .width(28)
      .height(28)
      .backgroundColor(surfaceVariantColor)
      .borderRadius(shapeSmall)
  }

  @Builder
  QuantityButton(symbol: string, index: number) {
    Button(symbol)
      .width(28)
      .height(28)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(onSurfaceColor)
      .backgroundColor(surfaceVariantColor)
      .borderRadius(shapeSmall)
      .onClick(() => {
        if (symbol === '+') {
          if (this.quantities[index] < 10) {
            let newQty: number[] = [...this.quantities]
            newQty[index] += 1
            this.quantities = newQty
          }
        } else {
          if (this.quantities[index] > 1) {
            let newQty: number[] = [...this.quantities]
            newQty[index] -= 1
            this.quantities = newQty
          }
        }
      })
  }

  @Builder
  CartItemCard(item: CartItemData, index: number) {
    Row({ space: spacingLg }) {
      Column()
        .width(60)
        .height(60)
        .backgroundColor(item.color)
        .borderRadius(shapeMedium)

      Column({ space: spacingXs }) {
        Text(item.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(onSurfaceColor)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width(110)

        Text('$' + item.price.toFixed(2))
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(onSurfaceColor)

        Row({ space: spacingSm }) {
          this.FeatureBox()
          this.FeatureBox()
          this.FeatureBox()
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column({ space: spacingSm }) {
        this.QuantityButton('+', index)

        Text('' + this.quantities[index])
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(onSurfaceColor)

        this.QuantityButton('-', index)
      }
      .alignItems(HorizontalAlign.Center)

      Button('Remove')
        .width(70)
        .height(36)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(onPrimaryColor)
        .backgroundColor(errorColor)
        .borderRadius(shapeMedium)
    }
    .padding(spacingLg)
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .backgroundColor(surfaceColor)
    .borderRadius(shapeLarge)
    .border({ width: 1, color: outlineColor, radius: shapeLarge })
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  ChipsRow() {
    Row({ space: spacingSm }) {
      ForEach(['Apply Coupon', 'Gift Wrap', 'Save for Later'], (label: string) => {
        Button(label)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(onSurfaceColor)
          .backgroundColor(surfaceColor)
          .borderRadius(shapeSmall)
          .border({ width: 1, color: outlineColor, radius: shapeSmall })
          .padding({ left: spacingXl, right: spacingXl, top: spacingSm, bottom: spacingSm })
          .height(30)
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  SummaryRow(title: string, value: number, emphasize: boolean) {
    Row() {
      Text(title)
        .fontSize(emphasize ? 18 : 12)
        .fontWeight(emphasize ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(onSurfaceColor)

      Blank()

      Text('$' + value.toFixed(2))
        .fontSize(emphasize ? 18 : 14)
        .fontWeight(emphasize ? FontWeight.Bold : FontWeight.Medium)
        .fontColor(onSurfaceColor)
    }
    .width('100%')
  }

  @Builder
  BottomSummary() {
    Column({ space: spacingMd }) {
      this.SummaryRow('Subtotal', this.getSubtotal(), false)
      this.SummaryRow('Shipping', this.shipping, false)
      this.SummaryRow('Tax', this.tax, false)
      this.SummaryRow('Total', this.getTotal(), true)

      Button('Proceed to Checkout')
        .width('100%')
        .height(44)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(onPrimaryColor)
        .backgroundColor(primaryColor)
        .borderRadius(shapeLarge)
    }
    .padding(spacingLg)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(surfaceColor)
    .borderRadius(shapeLarge)
    .shadow({ radius: 6, color: '#29000000', offsetX: 0, offsetY: 2 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()

        Scroll() {
          Column({ space: spacingLg }) {
            ForEach(this.cartItems, (item: CartItemData, index: number) => {
              this.CartItemCard(item, index)
            }, (item: CartItemData) => item.id.toString())

            this.ChipsRow()

            Column().height(240)
          }
          .padding({
            left: spacingLg,
            right: spacingLg,
            top: spacingMd,
            bottom: spacingLg
          })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(backgroundColor)

      Column() {
        this.BottomSummary()
      }
      .padding({
        left: spacingLg,
        right: spacingLg,
        bottom: spacingMd
      })
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(backgroundColor)
  }
}