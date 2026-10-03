// App.ets
import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
// 统一的UI设计系统，方便修改比例和控件大小

interface ColorMap {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyMap {
  display: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeMap {
  small: number;
  medium: number;
  large: number;
}

interface SpacingMap {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ElevationConfig {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationMap {
  level1: ElevationConfig;
  level2: ElevationConfig;
}

class AppTokens {
  static Colors: ColorMap = {
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

  static TypographyTokens: TypographyMap = {
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes: ShapeMap = {
    small: 6.0,
    medium: 10.0,
    large: 16.0
  };

  static Spacing: SpacingMap = {
    sm: 6.0,
    md: 10.0,
    lg: 14.0,
    xl: 20.0,
    xxl: 28.0
  };

  static ElevationMapping: ElevationMap = {
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
    Column() {
      Stack() {
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
          .zIndex(-1)

        // 整体内容可滚动
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            Text('Cold Gradient Price Compare')
              .fontSize(AppTokens.TypographyTokens.display.size)
              .fontWeight(AppTokens.TypographyTokens.display.weight)
              .fontColor(AppTokens.Colors.onBackground)
              .alignSelf(ItemAlign.Start)

            // 产品网格
            Grid() {
              ForEach(this.products, (product: Product) => {
                GridItem() {
                  ProductCard({ product: product })
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .rowsTemplate('auto auto auto')
            .itemSpacing({ row: AppTokens.Spacing.md, column: AppTokens.Spacing.md })
            .padding({ bottom: AppTokens.Spacing.xxl })

            Text('Price Update Log')
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.primary)
              .alignSelf(ItemAlign.Start)

            // 价格更新日志
            Column({ space: AppTokens.Spacing.sm }) {
              ForEach(this.products, (product: Product) => {
                PriceUpdateLogItem({ product: product })
              })
            }
            .padding({ bottom: 48 })
          }
          .padding(AppTokens.Spacing.lg)
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - ProductCard Component
@Component
struct ProductCard {
  @Prop product: Product;

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // 占位符Box
      Rect()
        .fill(AppTokens.Colors.surfaceVariant)
        .width(100)
        .height(100)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.product.name)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .alignSelf(ItemAlign.Start)

      Text(this.product.price)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.primary)
        .alignSelf(ItemAlign.Start)

      Text(this.product.store)
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .fontColor(AppTokens.Colors.tertiary)
        .alignSelf(ItemAlign.Start)

      // 按钮
      Button('Compare')
        .type(ButtonType.Capsule)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .width('100%')
        .height(36)
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: Color.Black.setAlpha(AppTokens.ElevationMapping.level1.opacity),
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }
}

// MARK: - PriceUpdateLogItem Component
@Component
struct PriceUpdateLogItem {
  @Prop product: Product;

  build() {
    Row() {
      Text(`${this.product.name} (${this.product.store})`)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
      
      Blank()
      
      Text(this.product.price)
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .fontColor(AppTokens.Colors.secondary)
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
    .width('100%')
  }
}

// MARK: - App Entry Point
@Entry
@Component
struct PriceCompareApp {
  build() {
    Column() {
      RootScreen()
    }
  }
}