// 文件：entry/src/main/ets/pages/Index.ets
// 购物车页面 —— 由 SwiftUI 版本转换而来（ArkTS / ArkUI 声明式范式）

// MARK: - AppTokens（设计令牌）

class AppTokens {
  // Colors
  static readonly primary: string = '#00E5FF';
  static readonly secondary: string = '#00BFA5';
  static readonly tertiary: string = '#69F0AE';
  static readonly background: string = '#0A0A0A';
  static readonly surface: string = '#121212';
  static readonly surfaceVariant: string = '#1E1E1E';
  static readonly outline: string = '#2C2C2C';
  static readonly success: string = '#00C853';
  static readonly warning: string = '#FFD600';
  static readonly error: string = '#D50000';
  static readonly onPrimary: string = '#0A0A0A';
  static readonly onSecondary: string = '#0A0A0A';
  static readonly onBackground: string = '#FFFFFF';
  static readonly onSurface: string = '#FFFFFF';
  static readonly onSurface50: string = '#80FFFFFF';

  // Shapes
  static readonly shapeSmall: number = 6;
  static readonly shapeMedium: number = 10;
  static readonly shapeLarge: number = 14;

  // Spacing
  static readonly spaceSm: number = 6;
  static readonly spaceMd: number = 10;
  static readonly spaceLg: number = 14;
  static readonly spaceXl: number = 20;
  static readonly spaceXxl: number = 28;

  // Elevation mapping（近似 Android elevation）
  static readonly elevation1: ShadowOptions = {
    radius: 4,
    color: '#26000000',
    offsetX: 0,
    offsetY: 2
  };
  static readonly elevation2: ShadowOptions = {
    radius: 8,
    color: '#2E000000',
    offsetX: 0,
    offsetY: 4
  };
  static readonly elevation3: ShadowOptions = {
    radius: 12,
    color: '#33000000',
    offsetX: 0,
    offsetY: 6
  };
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

// MARK: - RootScreen / Index 页面

@Entry
@Component
struct Index {
  @State items: CartItem[] = [
    new CartItem(1, 'Neon Keyboard', 89.99),
    new CartItem(2, 'Wireless Mouse', 49.99),
    new CartItem(3, 'Gaming Headset', 109.99)
  ];
  @State promo: string = '';

  // 计算总价
  private total(): number {
    let sum: number = 0;
    for (let i = 0; i < this.items.length; i++) {
      sum += this.items[i].price;
    }
    return sum;
  }

  // 格式化价格，保留两位小数
  private money(value: number): string {
    return '$' + value.toFixed(2);
  }

  // MARK: - 购物车商品卡片
  @Builder
  cartItemCard(item: CartItem, index: number) {
    Row() {
      Column() {
        Text(item.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.onSurface)
        Text(this.money(item.price))
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.secondary)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Remove')
        .type(ButtonType.Normal)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onPrimary)
        .backgroundColor(AppTokens.primary)
        .borderRadius(AppTokens.shapeMedium)
        .padding({
          left: AppTokens.spaceMd,
          right: AppTokens.spaceMd,
          top: AppTokens.spaceSm,
          bottom: AppTokens.spaceSm
        })
        .height(34)
        .onClick(() => {
          this.items = this.items.filter((value: CartItem) => value.id !== item.id);
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(AppTokens.spaceMd)
    .backgroundColor(AppTokens.surface)
    .borderRadius(AppTokens.shapeLarge)
    .shadow(AppTokens.elevation1)
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Scroll() {
        Column({ space: AppTokens.spaceMd }) {
          // 标题
          Text('Your Cart')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.primary)
            .width('100%')
            .textAlign(TextAlign.Start)

          // 商品列表
          ForEach(this.items, (item: CartItem, index: number) => {
            this.cartItemCard(item, index);
          }, (item: CartItem) => item.id.toString())

          // 顶部间隔
          Row().height(AppTokens.spaceMd)

          // 促销码输入框
          TextInput({ placeholder: 'Promo Code', text: this.promo })
            .placeholderColor(AppTokens.onSurface50)
            .fontSize(14)
            .fontColor(AppTokens.onSurface)
            .placeholderFont({ size: 14, weight: FontWeight.Normal })
            .height(46)
            .padding({ left: AppTokens.spaceMd, right: AppTokens.spaceMd })
            .backgroundColor(AppTokens.surfaceVariant)
            .borderRadius(AppTokens.shapeMedium)
            .border({ width: 1, color: AppTokens.outline })
            .onChange((value: string) => {
              this.promo = value;
            })

          // 中间间隔
          Row().height(AppTokens.spaceMd)

          // 总结卡片
          Column({ space: AppTokens.spaceSm }) {
            Row() {
              Text('Items:')
                .fontSize(14)
                .fontColor(AppTokens.onSurface)
              Blank()
              Text(this.items.length.toString())
                .fontSize(14)
                .fontColor(AppTokens.primary)
            }
            .width('100%')

            Row() {
              Text('Total:')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.onSurface)
              Blank()
              Text(this.money(this.total()))
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.primary)
            }
            .width('100%')
          }
          .width('100%')
          .padding(AppTokens.spaceLg)
          .backgroundColor(AppTokens.surfaceVariant)
          .borderRadius(AppTokens.shapeLarge)
          .shadow(AppTokens.elevation1)

          // 结账按钮
          Button('Checkout')
            .type(ButtonType.Normal)
            .width('100%')
            .height(56)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.onSecondary)
            .backgroundColor(AppTokens.secondary)
            .borderRadius(AppTokens.shapeLarge)
            .onClick(() => {
              // 结账逻辑占位
            })
        }
        .width('100%')
        .padding(AppTokens.spaceLg)
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [
        [AppTokens.background, 0.0],
        [AppTokens.surfaceVariant, 1.0]
      ]
    })
  }
}