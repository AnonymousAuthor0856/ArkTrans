// ArkTS 翻译：SwiftUI 购物车示例 (043.swift)
// MARK: - AppTokens (设计系统)

// 颜色令牌（使用十六进制 ARGB 字符串，对应 Swift 中的 Color(hex:) 扩展）
class Colors {
  static readonly primary: string = '#FF00E5FF';
  static readonly secondary: string = '#FF00BFA5';
  static readonly tertiary: string = '#FF69F0AE';
  static readonly background: string = '#FF0A0A0A';
  static readonly surface: string = '#FF121212';
  static readonly surfaceVariant: string = '#FF1E1E1E';
  static readonly outline: string = '#FF2C2C2C';
  static readonly success: string = '#FF00C853';
  static readonly warning: string = '#FFFFD600';
  static readonly error: string = '#FFD50000';
  static readonly onPrimary: string = '#FF0A0A0A';
  static readonly onSecondary: string = '#FF0A0A0A';
  static readonly onBackground: string = '#FFFFFFFF';
  static readonly onSurface: string = '#FFFFFFFF';
}

// 排版令牌
class TypographyTokens {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

// 形状令牌
class Shapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

// 间距令牌
class Spacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 14;
  static readonly xl: number = 20;
  static readonly xxl: number = 28;
}

// 阴影规范，用于近似 Android 的 elevation
class ShadowSpec {
  radius: number;  // 阴影模糊半径
  x: number;       // 阴影X轴偏移
  y: number;       // 阴影Y轴偏移
  opacity: number; // 阴影不透明度
  constructor(radius: number, x: number, y: number, opacity: number) {
    this.radius = radius;
    this.x = x;
    this.y = y;
    this.opacity = opacity;
  }
}

// 将 Android 的 elevation (dp) 近似映射到阴影属性
class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(4, 0, 2, 0.15);
  static readonly level2: ShadowSpec = new ShadowSpec(8, 0, 4, 0.18);
  static readonly level3: ShadowSpec = new ShadowSpec(12, 0, 6, 0.2);
}

// MARK: - CartItem 数据模型
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

// MARK: - RootScreen 视图
@Entry
@Component
struct RootScreen {
  private items: CartItem[] = [
    new CartItem(1, 'Neon Keyboard', 89.99),
    new CartItem(2, 'Wireless Mouse', 49.99),
    new CartItem(3, 'Gaming Headset', 109.99),
  ];

  @State promo: string = '';

  // 计算商品总价
  private getTotal(): number {
    let total: number = 0.0;
    this.items.forEach((item: CartItem) => {
      total += item.price;
    });
    return total;
  }

  // 购物车商品卡片
  @Builder
  cartItemCard(item: CartItem) {
    Row() {
      Column({ space: 4 }) {
        Text(item.name)
          .fontSize(TypographyTokens.titleSize)
          .fontWeight(TypographyTokens.titleWeight)
          .fontColor(Colors.onSurface)
        Text('$' + item.price.toFixed(2))
          .fontSize(TypographyTokens.bodySize)
          .fontWeight(TypographyTokens.bodyWeight)
          .fontColor(Colors.secondary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button('Remove')
        .fontSize(TypographyTokens.labelSize)
        .fontWeight(TypographyTokens.labelWeight)
        .fontColor(Colors.onPrimary)
        .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.sm, bottom: Spacing.sm })
        .backgroundColor(Colors.primary)
        .borderRadius(Shapes.medium)
        .onClick(() => {})
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .padding(Spacing.md)
    .backgroundColor(Colors.surface)
    .borderRadius(Shapes.large)
    .shadow({
      radius: ElevationMapping.level1.radius,
      offsetX: ElevationMapping.level1.x,
      offsetY: ElevationMapping.level1.y,
      color: '#260A0A0A'
    })
  }

  build() {
    Stack() {
      Scroll() {
        Column({ space: Spacing.md }) {
          Text('Your Cart')
            .fontSize(TypographyTokens.displaySize)
            .fontWeight(TypographyTokens.displayWeight)
            .fontColor(Colors.primary)
            .width('100%')
            .textAlign(TextAlign.Start)

          // 购物车商品列表
          ForEach(this.items, (item: CartItem) => {
            this.cartItemCard(item)
          }, (item: CartItem) => item.id.toString())

          Blank().height(Spacing.md)

          // 促销码输入框
          Row() {
            TextInput({ placeholder: 'Promo Code', text: this.promo })
              .fontSize(TypographyTokens.bodySize)
              .fontColor(Colors.onSurface)
              .placeholderColor('#80FFFFFF')
              .placeholderFont({ size: TypographyTokens.bodySize, weight: TypographyTokens.bodyWeight })
              .padding(Spacing.md)
              .backgroundColor(Colors.surfaceVariant)
              .borderRadius(Shapes.medium)
              .border({ width: 1, color: Colors.outline, radius: Shapes.medium })
              .layoutWeight(1)
              .onChange((value: string) => {
                this.promo = value;
              })
          }
          .width('100%')

          Blank().height(Spacing.md)

          // 总结卡片
          Column({ space: Spacing.sm }) {
            Row() {
              Text('Items:')
                .fontSize(TypographyTokens.bodySize)
                .fontWeight(TypographyTokens.bodyWeight)
                .fontColor(Colors.onSurface)
              Blank()
              Text(this.items.length.toString())
                .fontSize(TypographyTokens.bodySize)
                .fontWeight(TypographyTokens.bodyWeight)
                .fontColor(Colors.primary)
            }
            .width('100%')

            Row() {
              Text('Total:')
                .fontSize(TypographyTokens.titleSize)
                .fontWeight(TypographyTokens.titleWeight)
                .fontColor(Colors.onSurface)
              Blank()
              Text('$' + this.getTotal().toFixed(2))
                .fontSize(TypographyTokens.titleSize)
                .fontWeight(TypographyTokens.titleWeight)
                .fontColor(Colors.primary)
            }
            .width('100%')
          }
          .padding(Spacing.lg)
          .width('100%')
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(Shapes.large)
          .shadow({
            radius: ElevationMapping.level1.radius,
            offsetX: ElevationMapping.level1.x,
            offsetY: ElevationMapping.level1.y,
            color: '#260A0A0A'
          })

          // 结账按钮
          Button('Checkout')
            .fontSize(TypographyTokens.titleSize)
            .fontWeight(TypographyTokens.titleWeight)
            .fontColor(Colors.onSecondary)
            .width('100%')
            .height(56)
            .backgroundColor(Colors.secondary)
            .borderRadius(Shapes.large)
            .onClick(() => {})
        }
        .padding(Spacing.lg)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    // 背景渐变（对应 SwiftUI 的 LinearGradient）
    .linearGradient({
      angle: 180,
      colors: [[Colors.background, 0.0], [Colors.surfaceVariant, 1.0]]
    })
  }
}

// MARK: - 应用程序入口点 / 预览
// SwiftUI 中的 @main ShoppingCartApp、WindowGroup 与 PreviewProvider
// 在 ArkTS 单页应用中由 @Entry 标注的 RootScreen 表示。
