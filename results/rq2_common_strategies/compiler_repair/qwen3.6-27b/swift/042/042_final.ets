import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
// Unified UI design system for easy modification of ratios and control sizes

interface ColorTokens {
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

interface TypographyTokens {
  display: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ElevationToken {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationMapping {
  level1: ElevationToken;
  level2: ElevationToken;
}

class AppTokens {
  static Colors: ColorTokens = {
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

  static TypographyTokens: TypographyTokens = {
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes: ShapeTokens = {
    small: 6.0,
    medium: 10.0,
    large: 16.0
  };

  static Spacing: SpacingTokens = {
    sm: 6.0,
    md: 10.0,
    lg: 14.0,
    xl: 20.0,
    xxl: 28.0
  };

  static ElevationMapping: ElevationMapping = {
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

// MARK: - ProductCard Component
@Component
struct ProductCard {
  @Prop product: Product;

  build() {
    Column() {
      // Placeholder Box
      Rect()
        .width(100)
        .height(100)
        .fill(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.product.name)
        .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
        .fontColor(AppTokens.Colors.onSurface)

      Text(this.product.price)
        .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
        .fontColor(AppTokens.Colors.primary)

      Text(this.product.store)
        .font({ size: AppTokens.TypographyTokens.label.size, weight: AppTokens.TypographyTokens.label.weight })
        .fontColor(AppTokens.Colors.tertiary)

      // Button
      Button('Compare')
        .type(ButtonType.Capsule)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .borderRadius(AppTokens.Shapes.medium)
        .width('100%')
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: Color.Black.withAlpha(AppTokens.ElevationMapping.level1.opacity),
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
        .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
        .fontColor(AppTokens.Colors.onSurface)
      
      Blank() // Spacer equivalent
      
      Text(this.product.price)
        .font({ size: AppTokens.TypographyTokens.label.size, weight: AppTokens.TypographyTokens.label.weight })
        .fontColor(AppTokens.Colors.secondary)
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
  }
}

// MARK: - RootScreen
@Component
struct RootScreen {
  // Simulating remember/data source initialization
  private products: Product[] = [
    { id: 1, name: 'Wireless Earbuds', price: '$59.99', store: 'ShopA' },
    { id: 2, name: 'Smart Watch', price: '$129.99', store: 'ShopB' },
    { id: 3, name: 'Laptop Stand', price: '$39.99', store: 'ShopC' },
    { id: 4, name: 'Mechanical Keyboard', price: '$89.99', store: 'ShopA' },
    { id: 5, name: 'Noise Cancel Headset', price: '$149.99', store: 'ShopB' },
    { id: 6, name: 'Ergo Mouse', price: '$45.99', store: 'ShopC' }
  ];

  build() {
    Stack() {
      // Background Gradient
      LinearGradient({
        colors: [
          `${AppTokens.Colors.secondary}40`, // Approximating 0.25 opacity using hex alpha (40 is ~25%)
          AppTokens.Colors.background,
          `${AppTokens.Colors.primary}40`
        ]
      })
      .width('100%')
      .height('100%')

      // Scrollable Content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          Text('Cold Gradient Price Compare')
            .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
            .fontColor(AppTokens.Colors.onBackground)

          // Grid Layout
          GridContainer() {
            ForEach(this.products, (product: Product) => {
              GridItem() {
                ProductCard({ product: product })
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .rowsTemplate('auto')
          .gutter({ row: AppTokens.Spacing.md, column: AppTokens.Spacing.md })
          .padding({ bottom: AppTokens.Spacing.xxl })

          Text('Price Update Log')
            .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
            .fontColor(AppTokens.Colors.primary)

          // List Layout
          List({ space: AppTokens.Spacing.sm }) {
            ForEach(this.products, (product: Product) => {
              ListItem() {
                PriceUpdateLogItem({ product: product })
              }
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