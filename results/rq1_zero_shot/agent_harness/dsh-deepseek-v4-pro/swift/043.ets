// MARK: - AppTokens (设计系统)
interface ColorTokens { [key: string]: string }
interface FontToken { size: number; weight: FontWeight }
interface TypographyTokens { [key: string]: FontToken }
interface NumberTokens { [key: string]: number }
interface ShadowSpec { radius: number; x: number; y: number; opacity: number }
interface ElevationTokens { [key: string]: ShadowSpec }

class AppTokens {
  static readonly Colors: ColorTokens = {
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
    onSurface: '#FFFFFF'
  }

  static readonly Typography: TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes: NumberTokens = {
    small: 6, medium: 10, large: 14
  }

  static readonly Spacing: NumberTokens = {
    sm: 6, md: 10, lg: 14, xl: 20, xxl: 28
  }

  static readonly ElevationMapping: ElevationTokens = {
    level1: { radius: 4, x: 0, y: 2, opacity: 0.15 },
    level2: { radius: 8, x: 0, y: 4, opacity: 0.18 },
    level3: { radius: 12, x: 0, y: 6, opacity: 0.2 }
  }
}

// MARK: - CartItem 数据模型
class CartItem {
  id: number
  name: string
  price: number

  constructor(id: number = 0, name: string = '', price: number = 0) {
    this.id = id
    this.name = name
    this.price = price
  }
}

// MARK: - RootScreen 视图
@Entry
@Component
struct Index {
  items: CartItem[] = [
    new CartItem(1, 'Neon Keyboard', 89.99),
    new CartItem(2, 'Wireless Mouse', 49.99),
    new CartItem(3, 'Gaming Headset', 109.99)
  ]

  @State promo: string = ''

  @Builder
  cartItemCard(item: CartItem) {
    Row() {
      Column({ space: 4 }) {
        Text(item.name)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
        Text('$' + item.price.toFixed(2))
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.secondary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button('Remove')
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .onClick(() => {})
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: 'rgba(10, 10, 10, 0.15)',
      offsetX: AppTokens.ElevationMapping.level1.x,
      offsetY: AppTokens.ElevationMapping.level1.y
    })
  }

  build() {
    Stack() {
      // 背景渐变
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [
            ['#0A0A0A', 0.0],
            ['#1E1E1E', 1.0]
          ]
        })

      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          Text('Your Cart')
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.primary)
            .width('100%')
            .textAlign(TextAlign.Start)

          // 购物车商品列表
          ForEach(this.items, (item: CartItem) => {
            this.cartItemCard(item)
          }, (item: CartItem) => item.id.toString())

          Blank().height(AppTokens.Spacing.md)

          // 促销码输入框
          Row() {
            TextInput({ placeholder: 'Promo Code', text: this.promo })
              .fontSize(AppTokens.Typography.body.size)
              .fontWeight(AppTokens.Typography.body.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .placeholderColor('rgba(255, 255, 255, 0.5)')
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .border({ width: 1, color: AppTokens.Colors.outline })
              .onChange((v: string) => {
                this.promo = v
              })
          }
          .width('100%')

          Blank().height(AppTokens.Spacing.md)

          // 总结卡片
          Column({ space: AppTokens.Spacing.sm }) {
            Row() {
              Text('Items:')
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
              Blank()
              Text(this.items.length.toString())
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .fontColor(AppTokens.Colors.primary)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

            Row() {
              Text('Total:')
                .fontSize(AppTokens.Typography.title.size)
                .fontWeight(AppTokens.Typography.title.weight)
                .fontColor(AppTokens.Colors.onSurface)
              Blank()
              Text('$' + this.items.reduce((s, i) => s + i.price, 0).toFixed(2))
                .fontSize(AppTokens.Typography.title.size)
                .fontWeight(AppTokens.Typography.title.weight)
                .fontColor(AppTokens.Colors.primary)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('100%')
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ElevationMapping.level1.radius,
            color: 'rgba(10, 10, 10, 0.15)',
            offsetX: AppTokens.ElevationMapping.level1.x,
            offsetY: AppTokens.ElevationMapping.level1.y
          })

          // 结账按钮
          Button('Checkout')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .width('100%')
            .height(56)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
            .onClick(() => {})
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
      }
      .scrollable(ScrollDirection.Vertical)
    }
    .width('100%')
    .height('100%')
  }
}
