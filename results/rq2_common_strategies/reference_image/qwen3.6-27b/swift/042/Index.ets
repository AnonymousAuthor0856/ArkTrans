// App.ets
import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
// 统一的UI设计系统，方便修改比例和控件大小
class AppTokens {
  static Colors = {
    primary: '#0EA5E9', // 0xFF0EA5E9
    secondary: '#38BDF8', // 0xFF38BDF8
    tertiary: '#7DD3FC', // 0xFF7DD3FC
    background: '#F0F9FF', // 0xFFF0F9FF
    surface: '#FFFFFF', // 0xFFFFFFFF
    surfaceVariant: '#E0F2FE', // 0xFFE0F2FE
    outline: '#BAE6FD', // 0xFFBAE6FD
    success: '#22C55E', // 0xFF22C55E
    warning: '#FACC15', // 0xFFFACC15
    error: '#EF4444', // 0xFFEF4444
    onPrimary: '#FFFFFF', // 0xFFFFFFFF
    onSecondary: '#1E1E1E', // 0xFF1E1E1E
    onTertiary: '#0F172A', // 0xFF0F172A
    onBackground: '#0F172A', // 0xFF0F172A
    onSurface: '#0F172A' // 0xFF0F172A
  };

  static TypographyTokens = {
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes = {
    small: 6.0,
    medium: 10.0,
    large: 16.0
  };

  static Spacing = {
    sm: 6.0,
    md: 10.0,
    lg: 14.0,
    xl: 20.0,
    xxl: 28.0
  };

  static ElevationMapping = {
    level1: { elevation: 2.0, radius: 4.0, dy: 2.0, opacity: 0.12 },
    level2: { elevation: 6.0, radius: 8.0, dy: 4.0, opacity: 0.18 }
  };
}

// MARK: - Data Model
interface Product {
  id: number;
  name: string;
  price: string;
  store: string;
}

// MARK: - RootScreen
@Component
export struct RootScreen {
  private products: Product[] = [
    { id: 1, name: 'Wireless Earbuds', price: '$59.99', store: 'ShopA' },
    { id: 2, name: 'Smart Watch', price: '$129.99', store: 'ShopB' },
    { id: 3, name: 'Laptop Stand', price: '$39.99', store: 'ShopC' },
    { id: 4, name: 'Mechanical Keyboard', price: '$89.99', store: 'ShopA' },
    { id: 5, name: 'Noise Cancel Headset', price: '$149.99', store: 'ShopB' },
    { id: 6, name: 'Ergo Mouse', price: '$45.99', store: 'ShopC' }
  ];

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // 背景渐变色
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 90,
          colors: [
            [AppTokens.Colors.secondary, 0.25],
            [AppTokens.Colors.background, 0.5],
            [AppTokens.Colors.primary, 0.25]
          ]
        })
        .position({ x: 0, y: 0 })
        .zIndex(-1);

      // 整体内容可滚动
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          Text('Cold Gradient Price Compare')
            .font-size(AppTokens.TypographyTokens.display.size)
            .fontWeight(AppTokens.TypographyTokens.display.weight)
            .fontColor(AppTokens.Colors.onBackground)
            .alignSelf(ItemAlign.Start);

          // 网格布局
          Grid() {
            ForEach(this.products, (product: Product) => {
              GridItem() {
                ProductCard({ product: product })
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(AppTokens.Spacing.md)
          .columnsGap(AppTokens.Spacing.md)
          .padding({ bottom: AppTokens.Spacing.xxl });

          Text('Price Update Log')
            .font-size(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.primary)
            .alignSelf(ItemAlign.Start);

          // 列表布局
          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.products, (product: Product) => {
              PriceUpdateLogItem({ product: product })
            })
          }
          .padding({ bottom: 48 });
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%');
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%');
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// MARK: - ProductCard Component
@Component
struct ProductCard {
  @Prop product: Product;

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // 占位符Box
      Rectangle()
        .fill(AppTokens.Colors.surfaceVariant)
        .width(100)
        .height(100)
        .borderRadius(AppTokens.Shapes.medium);

      Text(this.product.name)
        .font-size(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center);

      Text(this.product.price)
        .font-size(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.primary)
        .textAlign(TextAlign.Center);

      Text(this.product.store)
        .font-size(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .fontColor(AppTokens.Colors.tertiary)
        .textAlign(TextAlign.Center);

      // Button
      Button('Compare')
        .type(ButtonType.Capsule)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .font-size(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .width('100%')
        .height(36);
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: Color.Black.opacity(AppTokens.ElevationMapping.level1.opacity),
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    });
  }
}

// MARK: - PriceUpdateLogItem Component
@Component
struct PriceUpdateLogItem {
  @Prop product: Product;

  build() {
    Row() {
      Text(`${this.product.name} (${this.product.store})`)
        .font-size(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface);

      Blank();

      Text(this.product.price)
        .font-size(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .fontColor(AppTokens.Colors.secondary);
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
    .width('100%');
  }
}

// MARK: - App Entry Point
@Entry
@Component
struct PriceCompareApp {
  build() {
    RootScreen()
  }
}