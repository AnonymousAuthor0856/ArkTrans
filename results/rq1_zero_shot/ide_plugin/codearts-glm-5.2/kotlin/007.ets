const AppColors = {
  primary: '#000000',
  secondary: '#FF6F00',
  tertiary: '#4CAF50',
  background: '#FFFFFF',
  surface: '#FFFFFF',
  surfaceVariant: '#F5F5F5',
  outline: '#E0E0E0',
  success: '#4CAF50',
  warning: '#FF9800',
  error: '#F44336',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#FFFFFF',
  onBackground: '#000000',
  onSurface: '#000000'
}

const AppSpacing = {
  xs: 2,
  sm: 4,
  md: 6,
  lg: 8,
  xl: 12,
  xxl: 16,
  xxxl: 24
}

interface CartItem {
  id: number
  name: string
  price: number
  color: string
}

@Component
struct CartItemView {
  private item: CartItem = { id: 0, name: '', price: 0, color: '' }
  @Prop quantity: number
  onIncrease: (id: number) => void = () => {}
  onDecrease: (id: number) => void = () => {}

  build() {
    Row({ space: AppSpacing.lg }) {
      Column()
        .width(60)
        .height(60)
        .backgroundColor(this.item.color)
        .borderRadius(8)

      Column({ space: AppSpacing.xs }) {
        Text(this.item.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(`$${this.item.price.toFixed(2)}`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Row({ space: AppSpacing.sm }) {
          Column().width(28).height(28).backgroundColor(AppColors.surfaceVariant).borderRadius(6)
          Column().width(28).height(28).backgroundColor(AppColors.surfaceVariant).borderRadius(6)
          Column().width(28).height(28).backgroundColor(AppColors.surfaceVariant).borderRadius(6)
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column({ space: AppSpacing.sm }) {
        Button('+')
          .type(ButtonType.Normal)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(6)
          .width(28)
          .height(28)
          .onClick(() => {
            this.onIncrease(this.item.id)
          })
        Text(`${this.quantity}`)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Button('-')
          .type(ButtonType.Normal)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(6)
          .width(28)
          .height(28)
          .onClick(() => {
            this.onDecrease(this.item.id)
          })
      }
      .alignItems(HorizontalAlign.Center)

      Button('Remove')
        .type(ButtonType.Normal)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.error)
        .borderRadius(8)
        .height(36)
        .width(85)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline, radius: 12 })
    .alignItems(VerticalAlign.Center)
  }
}

@Entry
@Component
struct Index {
  @State quantities: number[] = [1, 1, 1, 1]
  private shipping: number = 5.99
  private tax: number = 18.50
  private cartItems: CartItem[] = [
    { id: 1, name: 'Wireless Headphones', price: 129.99, color: '#FF6F00' },
    { id: 2, name: 'Smartphone Case', price: 24.99, color: '#000000' },
    { id: 3, name: 'USB-C Cable', price: 19.99, color: '#4CAF50' },
    { id: 4, name: 'Portable Charger', price: 49.99, color: '#FF6F00' }
  ]

  getSubtotal(): number {
    let sum: number = 0
    for (let i = 0; i < this.cartItems.length; i++) {
      sum += this.cartItems[i].price * this.quantities[i]
    }
    return sum
  }

  build() {
    Column() {
      Row({ space: AppSpacing.sm }) {
        Column()
          .width(20)
          .height(20)
          .backgroundColor(AppColors.primary)
          .borderRadius(6)
        Text('Shopping Cart')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .padding(16)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      List({ space: AppSpacing.lg }) {
        ForEach(this.cartItems, (item: CartItem) => {
          ListItem() {
            CartItemView({
              item: item,
              quantity: this.quantities[item.id - 1],
              onIncrease: (id: number) => {
                if (this.quantities[id - 1] < 10) {
                  this.quantities[id - 1] = this.quantities[id - 1] + 1
                }
              },
              onDecrease: (id: number) => {
                if (this.quantities[id - 1] > 1) {
                  this.quantities[id - 1] = this.quantities[id - 1] - 1
                }
              }
            })
          }
        }, (item: CartItem) => item.id.toString())

        ListItem() {
          Row({ space: AppSpacing.sm }) {
            Text('Apply Coupon')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
              .backgroundColor(AppColors.surface)
              .border({ width: 1, color: AppColors.outline, radius: 6 })
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            Text('Gift Wrap')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
              .backgroundColor(AppColors.surface)
              .border({ width: 1, color: AppColors.outline, radius: 6 })
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            Text('Save for Later')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
              .backgroundColor(AppColors.surface)
              .border({ width: 1, color: AppColors.outline, radius: 6 })
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }

        ListItem() {
          Blank().height(AppSpacing.xxxl)
        }
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.xxxl })
      .scrollBar(BarState.Off)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  BottomBar() {
    Column({ space: AppSpacing.md }) {
      Row() {
        Text('Subtotal')
          .fontSize(12)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)
        Text(`$${this.getSubtotal().toFixed(2)}`)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Row() {
        Text('Shipping')
          .fontSize(12)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)
        Text(`$${this.shipping.toFixed(2)}`)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Row() {
        Text('Tax')
          .fontSize(12)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)
        Text(`$${this.tax.toFixed(2)}`)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Row() {
        Text('Total')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)
        Text(`$${(this.getSubtotal() + this.shipping + this.tax).toFixed(2)}`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Button('Proceed to Checkout')
        .type(ButtonType.Normal)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(12)
        .width('100%')
        .height(44)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
  }
}