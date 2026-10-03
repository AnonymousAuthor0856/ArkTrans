// ============================================================
// AppTokens.ets
// HarmonyOS / ArkTS 版本的 SwiftUI AppTokens 设计系统
// ============================================================

export class AppColors {
  // SwiftUI Color(red:green:blue:) 转换为 ARGB 十六进制字符串
  static readonly primary: string = '#0EA5E9';          // 0xFF0EA5E9
  static readonly secondary: string = '#38BDF8';        // 0xFF38BDF8
  static readonly tertiary: string = '#7DD3FC';         // 0xFF7DD3FC
  static readonly background: string = '#F0F9FF';       // 0xFFF0F9FF
  static readonly surface: string = '#FFFFFF';          // 0xFFFFFFFF
  static readonly surfaceVariant: string = '#E0F2FE';   // 0xFFE0F2FE
  static readonly outline: string = '#BAE6FD';          // 0xFFBAE6FD
  static readonly success: string = '#22C55E';          // 0xFF22C55E
  static readonly warning: string = '#FACC15';          // 0xFFFACC15
  static readonly error: string = '#EF4444';            // 0xFFEF4444
  static readonly onPrimary: string = '#FFFFFF';        // 0xFFFFFFFF
  static readonly onSecondary: string = '#1E1E1E';      // 0xFF1E1E1E
  static readonly onTertiary: string = '#0F172A';       // 0xFF0F172A
  static readonly onBackground: string = '#0F172A';     // 0xFF0F172A
  static readonly onSurface: string = '#0F172A';        // 0xFF0F172A

  // 渐变中使用的 25% 透明度版本（SwiftUI .opacity(0.25)）
  static readonly secondaryAlpha25: string = '#4038BDF8';
  static readonly primaryAlpha25: string = '#400EA5E9';

  // 阴影颜色（Swift 中 Color.black.opacity(x)）
  static readonly shadow12: string = '#1F000000';
  static readonly shadow18: string = '#2E000000';
}

export class AppTypography {
  // SwiftUI Font.system(size:weight:)
  static readonly display: number = 26; // .bold
  static readonly title: number = 18;   // .medium
  static readonly body: number = 14;    // .regular
  static readonly label: number = 12;   // .medium
}

export class AppShapes {
  static readonly small: number = 6.0;
  static readonly medium: number = 10.0;
  static readonly large: number = 16.0;
}

export class AppSpacing {
  static readonly sm: number = 6.0;
  static readonly md: number = 10.0;
  static readonly lg: number = 14.0;
  static readonly xl: number = 20.0;
  static readonly xxl: number = 28.0;
}

export class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

export class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2.0, 4.0, 2.0, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(6.0, 8.0, 4.0, 0.18);
}

// ============================================================
// Data Model
// ============================================================

export class Product {
  id: number;
  name: string;
  price: string;
  store: string;

  constructor(id: number, name: string, price: string, store: string) {
    this.id = id;
    this.name = name;
    this.price = price;
    this.store = store;
  }
}

// ============================================================
// RootScreen —— 对应 SwiftUI 的 RootScreen
// 需要在 main_pages.json 的 "src" 中注册该页面
// ============================================================

@Entry
@Component
struct RootScreen {
  // 对应 Swift 里的 let products = [...]
  private products: Product[] = [
    new Product(1, 'Wireless Earbuds', '$59.99', 'ShopA'),
    new Product(2, 'Smart Watch', '$129.99', 'ShopB'),
    new Product(3, 'Laptop Stand', '$39.99', 'ShopC'),
    new Product(4, 'Mechanical Keyboard', '$89.99', 'ShopA'),
    new Product(5, 'Noise Cancel Headset', '$149.99', 'ShopB'),
    new Product(6, 'Ergo Mouse', '$45.99', 'ShopC')
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // 背景渐变，对应 SwiftUI 的 LinearGradient(.top -> .bottom)
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [
            [AppColors.secondaryAlpha25, 0.0],
            [AppColors.background, 0.5],
            [AppColors.primaryAlpha25, 1.0]
          ]
        })

      // 整体内容可滚动，对应 ScrollView(.vertical, showsIndicators: false)
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Text('Cold Gradient Price Compare')
            .fontSize(AppTypography.display)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)
            .width('100%')
            .textAlign(TextAlign.Start)

          // 对应 LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())])
          Flex({
            wrap: FlexWrap.Wrap,
            justifyContent: FlexAlign.SpaceBetween,
            alignItems: ItemAlign.Start
          }) {
            ForEach(this.products, (item: Product) => {
              Column() {
                ProductCard({ product: item })
              }
              .width('48%')
              .margin({ bottom: AppSpacing.md })
            }, (item: Product) => item.id.toString())
          }
          .width('100%')
          .padding({ bottom: AppSpacing.xxl })

          Text('Price Update Log')
            .fontSize(AppTypography.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)
            .width('100%')
            .textAlign(TextAlign.Start)

          // 对应 LazyColumn
          Column({ space: AppSpacing.sm }) {
            ForEach(this.products, (item: Product) => {
              PriceUpdateLogItem({ product: item })
            }, (item: Product) => item.id.toString())
          }
          .width('100%')
          .padding({ bottom: 48 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(AppSpacing.lg)
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

// ============================================================
// ProductCard —— 对应 SwiftUI 的 ProductCard
// ============================================================

@Component
struct ProductCard {
  private product: Product = new Product(0, '', '', '');

  build() {
    Column({ space: AppSpacing.sm }) {
      // 占位符 Box：size(100.dp) + surfaceVariant + medium 圆角
      Column()
        .width(100)
        .height(100)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)

      Text(this.product.name)
        .fontSize(AppTypography.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .width('100%')

      Text(this.product.price)
        .fontSize(AppTypography.body)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.primary)
        .textAlign(TextAlign.Center)
        .width('100%')

      Text(this.product.store)
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.tertiary)
        .textAlign(TextAlign.Center)
        .width('100%')

      // 对应 Compose / SwiftUI 的 Button（fillMaxWidth + 8.dp 垂直内边距）
      Button('Compare')
        .type(ButtonType.Normal)
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .width('100%')
        .height(34)
        .padding({ top: 8, bottom: 8, left: 0, right: 0 })
        .onClick(() => {
          // 对应 SwiftUI 里的空 action {}
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: ElevationMapping.level1.radius,
      color: AppColors.shadow12,
      offsetX: 0,
      offsetY: ElevationMapping.level1.dy
    })
  }
}

// ============================================================
// PriceUpdateLogItem —— 对应 SwiftUI 的 PriceUpdateLogItem
// ============================================================

@Component
struct PriceUpdateLogItem {
  private product: Product = new Product(0, '', '', '');

  build() {
    Row() {
      Text(`${this.product.name} (${this.product.store})`)
        .fontSize(AppTypography.body)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Start)
        .layoutWeight(1)

      Text(this.product.price)
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.small)
  }
}

// 说明：ArkTS 没有 @main / App 协议，页面入口由 module.json5 的
// "pages": "$profile:main_pages" 指向 main_pages.json 中的
// "pages/RootScreen" 完成注册。截图需在 DevEco Studio 的 Previewer
// 或真机运行后查看，代码本身无法在此环境中渲染。