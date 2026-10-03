import { LengthMetrics } from '@kit.ArkUI'

// Design Tokens
const AppColors = {
  primary: '#00E5FF',
  secondary: '#00BFA5',
  tertiary: '#69F0AE',
  background: '#0A0A0A',
  surface: '#121212',
  surfaceVariant: '#1E1E1E',
  outline: '#2C2C2C',
  success: '#00C853',
  warning: '#FFD600',
  error: '#D50000',
  onPrimary: '#0A0A0A',
  onSecondary: '#0A0A0A',
  onBackground: '#FFFFFF',
  onSurface: '#FFFFFF',
}

interface CartItem {
  id: number
  name: string
  price: number
}

@Entry
@Component
struct RootScreen {
  @State promoCode: string = ''

  private items: CartItem[] = [
    { id: 1, name: 'Neon Keyboard', price: 89.99 },
    { id: 2, name: 'Wireless Mouse', price: 49.99 },
    { id: 3, name: 'Gaming Headset', price: 109.99 },
  ]

  private get total(): number {
    return this.items.reduce((sum, item) => sum + item.price, 0)
  }

  @Builder
  CartItemCard(item: CartItem) {
    Row() {
      Column() {
        Text(item.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(`$${item.price.toFixed(2)}`)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.secondary)
      }
      .alignItems(HorizontalAlign.Start)

      Button('Remove')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(10)
        .height(36)
        .padding({ left: 14, right: 14 })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding(10)
    .backgroundColor(AppColors.surface)
    .borderRadius(14)
    .shadow({
      radius: 4,
      color: '#26000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  @Builder
  SummaryCard() {
    Column({ space: 6 }) {
      Row() {
        Text('Items:')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)
        Text(`${this.items.length}`)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
        Text('Total:')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(`$${this.total.toFixed(2)}`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(14)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(14)
    .shadow({
      radius: 4,
      color: '#26000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  build() {
    Scroll() {
      Column({ space: 10 }) {
        Text('Your Cart')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .width('100%')

        ForEach(this.items, (item: CartItem) => {
          this.CartItemCard(item)
        }, (item: CartItem) => item.id.toString())

        Blank().height(10)

        TextInput({ placeholder: 'Promo Code', text: this.promoCode })
          .placeholderColor('#80FFFFFF')
          .placeholderFont({ size: 14 })
          .fontSize(14)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(10)
          .borderWidth(1)
          .borderColor(AppColors.outline)
          .width('100%')
          .height(52)
          .onChange((value: string) => {
            this.promoCode = value
          })

        Blank().height(10)

        this.SummaryCard()

        Button('Checkout')
          .width('100%')
          .height(56)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .backgroundColor(AppColors.secondary)
          .borderRadius(14)
      }
      .width('100%')
      .padding(14)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [0xFF0A0A0A, 0.0],
          [0xFF1E1E1E, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .scrollBar(BarState.Off)
  }
}