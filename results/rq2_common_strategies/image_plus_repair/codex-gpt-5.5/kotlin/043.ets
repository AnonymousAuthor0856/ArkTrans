interface CartItem {
  id: number;
  name: string;
  price: number;
}

class AppColors {
  static readonly primary: string = '#00E5FF';
  static readonly secondary: string = '#00BFA5';
  static readonly background: string = '#0A0A0A';
  static readonly surface: string = '#121212';
  static readonly surfaceVariant: string = '#1E1E1E';
  static readonly outline: string = '#2C2C2C';
  static readonly onPrimary: string = '#0A0A0A';
  static readonly onSecondary: string = '#0A0A0A';
  static readonly onSurface: string = '#FFFFFF';
  static readonly placeholder: string = '#8F8F8F';
}

@Entry
@Component
struct ShoppingCart {
  @State promo: string = ''

  items: CartItem[] = [
    { id: 1, name: 'Neon Keyboard', price: 89.99 },
    { id: 2, name: 'Wireless Mouse', price: 49.99 },
    { id: 3, name: 'Gaming Headset', price: 109.99 }
  ]

  total(): number {
    let amount: number = 0
    this.items.forEach((item: CartItem) => {
      amount += item.price
    })
    return amount
  }

  priceText(value: number): string {
    return `$${value.toFixed(2)}`
  }

  @Builder
  CartRow(item: CartItem) {
    Row() {
      Column() {
        Text(item.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.priceText(item.price))
          .fontSize(14)
          .fontColor(AppColors.secondary)
          .margin({ top: 1 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Remove')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(10)
        .width(92)
        .height(40)
    }
    .width('100%')
    .height(68)
    .padding({ left: 10, right: 10 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(14)
    .shadow({
      radius: 4,
      color: '#26000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  build() {
    Column() {
      Text('Your Cart')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .width('100%')
        .margin({ bottom: 20 })

      ForEach(this.items, (item: CartItem) => {
        Column() {
          this.CartRow(item)
        }
        .width('100%')
          .margin({ bottom: 10 })
      }, (item: CartItem) => item.id.toString())

      Blank()
        .height(10)

      TextInput({ text: this.promo, placeholder: 'Promo Code' })
        .fontSize(16)
        .fontColor(AppColors.onSurface)
        .placeholderColor(AppColors.placeholder)
        .caretColor(AppColors.primary)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(10)
        .border({
          width: { bottom: 1 },
          color: AppColors.outline
        })
        .height(56)
        .width('100%')
        .padding({ left: 16, right: 16 })
        .onChange((value: string) => {
          this.promo = value
        })
        .margin({ bottom: 20 })

      Column() {
        Row() {
          Text('Items:')
            .fontSize(14)
            .fontColor(AppColors.onSurface)

          Text(this.items.length.toString())
            .fontSize(14)
            .fontColor(AppColors.primary)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('Total:')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Text(this.priceText(this.total()))
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 6 })
      }
      .width('100%')
      .padding(14)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(14)
      .shadow({
        radius: 4,
        color: '#26000000',
        offsetX: 0,
        offsetY: 2
      })
      .margin({ bottom: 20 })

      Button('Checkout')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(14)
        .width('100%')
        .height(56)
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .padding({ left: 14, right: 14, top: 20, bottom: 0 })
    .backgroundColor(AppColors.background)
    .linearGradient({
      angle: 180,
      colors: [[AppColors.background, 0.0], [AppColors.surfaceVariant, 1.0]]
    })
  }
}
