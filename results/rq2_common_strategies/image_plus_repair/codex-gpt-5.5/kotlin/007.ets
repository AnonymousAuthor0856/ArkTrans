interface CartItem {
  id: number
  name: string
  price: number
  color: string
}

class AppColors {
  static readonly primary: string = '#000000'
  static readonly secondary: string = '#FF6F00'
  static readonly tertiary: string = '#4CAF50'
  static readonly background: string = '#FFFFFF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#F5F5F5'
  static readonly outline: string = '#E0E0E0'
  static readonly error: string = '#F44336'
}

@Entry
@Component
struct ShoppingCartPage {
  private readonly items: CartItem[] = [
    { id: 1, name: 'Wireless\nHeadphones', price: 129.99, color: AppColors.secondary },
    { id: 2, name: 'Smartphone Case', price: 24.99, color: AppColors.primary },
    { id: 3, name: 'USB-C Cable', price: 19.99, color: AppColors.tertiary },
    { id: 4, name: 'Portable Charger', price: 49.99, color: AppColors.secondary }
  ]
  @State private quantities: number[] = [1, 1, 1, 1]
  private readonly shipping: number = 5.99
  private readonly tax: number = 18.50

  private money(value: number): string {
    return '$' + value.toFixed(2)
  }

  private subtotal(): number {
    let total = 0
    for (let i = 0; i < this.items.length; i++) {
      total += this.items[i].price * this.quantities[i]
    }
    return total
  }

  @Builder
  private Header() {
    Row() {
      Blank()
        .width(20)
        .height(20)
        .borderRadius(6)
        .backgroundColor(AppColors.primary)

      Text('Shopping Cart')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .lineHeight(28)
        .margin({ left: 4 })
    }
    .width('100%')
    .height(94)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.background)
  }

  @Builder
  private SwatchRow() {
    Row() {
      Blank().width(28).height(28).borderRadius(6).backgroundColor(AppColors.surfaceVariant)
      Blank().width(28).height(28).borderRadius(6).backgroundColor(AppColors.surfaceVariant)
      Blank().width(28).height(28).borderRadius(6).backgroundColor(AppColors.surfaceVariant)
    }
    .justifyContent(FlexAlign.Start)
    .alignItems(VerticalAlign.Center)
    .margin({ top: 7 })
  }

  @Builder
  private QuantityStepper(index: number) {
    Column() {
      Button('')
        .width(28)
        .height(28)
        .borderRadius(6)
        .backgroundColor(AppColors.surfaceVariant)
        .onClick(() => {
          if (this.quantities[index] < 10) {
            this.quantities[index] = this.quantities[index] + 1
          }
        })

      Text(this.quantities[index].toString())
        .width(28)
        .height(22)
        .textAlign(TextAlign.Center)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
        .lineHeight(18)
        .margin({ top: 4, bottom: 4 })

      Button('')
        .width(28)
        .height(28)
        .borderRadius(6)
        .backgroundColor(AppColors.surfaceVariant)
        .onClick(() => {
          if (this.quantities[index] > 1) {
            this.quantities[index] = this.quantities[index] - 1
          }
        })
    }
    .width(36)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  private CartRow(item: CartItem, index: number) {
    Row() {
      Blank()
        .width(60)
        .height(60)
        .borderRadius(8)
        .backgroundColor(item.color)
        .margin({ right: 8 })

      Column() {
        Text(item.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .lineHeight(18)
          .maxLines(2)

        Text(this.money(item.price))
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .lineHeight(24)
          .margin({ top: 1 })

        this.SwatchRow()
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      this.QuantityStepper(index)

      Button('Remove')
        .width(85)
        .height(36)
        .borderRadius(8)
        .backgroundColor(AppColors.error)
        .fontColor(Color.White)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .margin({ left: 8 })
    }
    .width('100%')
    .height(102)
    .padding(8)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 6, color: '#26000000', offsetX: 0, offsetY: 2 })
    .margin({ bottom: 8 })
  }

  @Builder
  private CouponChips() {
    Row() {
      this.Chip('Apply Coupon')
      this.Chip('Gift Wrap')
      this.Chip('Save for Later')
    }
    .width('100%')
    .height(32)
    .alignItems(VerticalAlign.Center)
    .margin({ top: 1, bottom: 16 })
  }

  @Builder
  private Chip(label: string) {
    Button(label)
      .height(28)
      .borderRadius(6)
      .padding({ left: 10, right: 10 })
      .backgroundColor(AppColors.surface)
      .fontColor(AppColors.primary)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .border({ width: 1, color: AppColors.outline })
      .margin({ right: 4 })
  }

  @Builder
  private SummaryRow(label: string, value: string, strong: boolean = false) {
    Row() {
      Text(label)
        .fontSize(strong ? 18 : 12)
        .fontWeight(strong ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(AppColors.primary)
        .lineHeight(strong ? 24 : 16)

      Text(value)
        .fontSize(strong ? 18 : 14)
        .fontWeight(strong ? FontWeight.Bold : FontWeight.Medium)
        .fontColor(AppColors.primary)
        .lineHeight(strong ? 24 : 18)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  private BottomSummary() {
    Column() {
      this.SummaryRow('Subtotal', this.money(this.subtotal()))
      this.SummaryRow('Shipping', this.money(this.shipping))
      this.SummaryRow('Tax', this.money(this.tax))
      this.SummaryRow('Total', this.money(this.subtotal() + this.shipping + this.tax), true)

      Button('Proceed to Checkout')
        .width('100%')
        .height(44)
        .borderRadius(12)
        .backgroundColor(AppColors.primary)
        .fontColor(Color.White)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ top: 8 })
    }
    .width('100%')
    .padding({ left: 8, right: 8, top: 12, bottom: 8 })
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 8, color: '#30000000', offsetX: 0, offsetY: -2 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.Header()

        Scroll() {
          Column() {
            ForEach(this.items, (item: CartItem, index: number) => {
              this.CartRow(item, index)
            }, (item: CartItem) => item.id.toString())

            this.CouponChips()
          }
          .width('100%')
          .padding({ left: 8, right: 8, top: 0, bottom: 170 })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      this.BottomSummary()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
