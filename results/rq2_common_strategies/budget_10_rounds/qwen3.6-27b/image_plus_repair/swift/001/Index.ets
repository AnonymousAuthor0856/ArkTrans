import { FontWeight } from '@kit.ArkUI';

export class AppTokens {
  static readonly Colors: Record<string, string> = {
    primary: '#6750A4',
    onPrimary: '#FFFFFF',
    secondary: '#6CBB3B',
    onSecondary: '#0F0F0F',
    tertiary: '#FFB300',
    onTertiary: '#1F1200',
    background: '#F5F7FB',
    onBackground: '#0F172A',
    surface: '#FCFCFF',
    onSurface: '#111927',
    surfaceVariant: '#EFF1F8',
    outline: '#D0D5E0',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#DA291E'
  }

  static readonly Typography: Record<string, { size: number; weight: FontWeight }> = {
    display: { size: 22, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Bold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal },
    label: { size: 10, weight: FontWeight.Medium }
  }

  static readonly Spacing: Record<string, number> = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  }

  static readonly Shapes: Record<string, number> = {
    small: 4,
    medium: 8,
    large: 12
  }
}

export interface ProductUi {
  id: number;
  title: string;
  price: string;
  badge: string;
  rating: string;
  color: string;
}

@Component
export struct CategoryRow {
  @Link selectedCategory: string;
  items: string[] = [];

  build() {
    Row() {
      ForEach(this.items, (item: string) => {
        Button({ type: ButtonType.Capsule, stateEffect: true }) {
          Text(item)
            .font({ size: AppTokens.Typography.body.size, weight: AppTokens.Typography.body.weight })
            .fontColor(this.selectedCategory === item ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
            .padding({ left: AppTokens.Spacing.xl, right: AppTokens.Spacing.xl, top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        }
        .backgroundColor(this.selectedCategory === item ? AppTokens.Colors.primary : AppTokens.Colors.surface)
        .borderWidth(1)
        .borderColor(AppTokens.Colors.outline)
        .borderRadius(AppTokens.Shapes.medium)
        .margin({ right: AppTokens.Spacing.sm })
        .onClick(() => {
          this.selectedCategory = item;
        })
      })
    }
    .width('100%')
    .height(50)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
export struct FilterRow {
  @Link selectedFilters: Set<string>;
  
  private filterOptions: string[] = ["In Stock", "Under $20", "Rating 4+"];

  build() {
    Row() {
      ForEach(this.filterOptions, (filter: string) => {
        Button({ type: ButtonType.Capsule, stateEffect: true }) {
          Text(filter)
            .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
            .fontColor(this.selectedFilters.has(filter) ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
            .padding({ left: AppTokens.Spacing.xl, right: AppTokens.Spacing.xl, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .backgroundColor(this.selectedFilters.has(filter) ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
        .borderWidth(1)
        .borderColor(AppTokens.Colors.outline)
        .borderRadius(AppTokens.Shapes.small)
        .margin({ right: AppTokens.Spacing.sm })
        .onClick(() => {
          if (this.selectedFilters.has(filter)) {
            this.selectedFilters.delete(filter);
          } else {
            this.selectedFilters.add(filter);
          }
        })
      })
    }
    .width('100%')
    .height(40)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
export struct ProductCard {
  product!: ProductUi;

  build() {
    Column() {
      // Image Placeholder
      Stack() {
        Text("Image")
          .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
          .fontColor('#00000099')
      }
      .width('100%')
      .aspectRatio(1)
      .backgroundColor(this.product.color)
      .borderRadius(AppTokens.Shapes.medium)

      // Title and Badge
      Row() {
        Text(this.product.title)
          .font({ size: AppTokens.Typography.title.size, weight: AppTokens.Typography.title.weight })
          .fontColor(AppTokens.Colors.onSurface)
        
        Blank()
        
        if (this.product.badge !== "") {
          Text(this.product.badge)
            .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
            .fontColor(AppTokens.Colors.onTertiary)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(AppTokens.Shapes.small)
        }
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.lg })

      // Price
      Text(this.product.price)
        .font({ size: AppTokens.Typography.headline.size, weight: AppTokens.Typography.headline.weight })
        .fontColor(AppTokens.Colors.primary)
        .margin({ top: AppTokens.Spacing.sm })

      // Rating
      Row() {
        Circle()
          .width(8)
          .height(8)
          .fill(AppTokens.Colors.warning)
        
        Text(`${this.product.rating} rating`)
          .font({ size: AppTokens.Typography.body.size, weight: AppTokens.Typography.body.weight })
          .fontColor('#00000099')
          .margin({ left: AppTokens.Spacing.sm })
      }
      .margin({ top: AppTokens.Spacing.sm })

      // Add to Cart Button
      Button({ type: ButtonType.Capsule, stateEffect: true }) {
        Text("Add to Cart")
          .font({ size: AppTokens.Typography.title.size, weight: AppTokens.Typography.title.weight })
          .fontColor(AppTokens.Colors.onPrimary)
      }
      .width('100%')
      .height(36)
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.medium)
      .margin({ top: AppTokens.Spacing.lg })
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 3, color: '#0000001A', offsetY: 1 })
  }
}

type ActionCallback = () => void;

@Component
export struct BottomActionBar {
  @Prop subtotal: string = "";
  @Prop actionLabel: string = "";
  @Prop onAction: ActionCallback = () => {};

  build() {
    Column() {
      Divider().color(AppTokens.Colors.outline).strokeWidth(1)
      
      Row() {
        Column() {
          Text("Subtotal")
            .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
            .fontColor('#00000099')
          
          Text(this.subtotal)
            .font({ size: AppTokens.Typography.headline.size, weight: AppTokens.Typography.headline.weight })
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
        
        Blank()
        
        Button({ type: ButtonType.Capsule, stateEffect: true }) {
          Text(this.actionLabel)
            .font({ size: AppTokens.Typography.title.size, weight: AppTokens.Typography.title.weight })
            .fontColor(AppTokens.Colors.onSecondary)
        }
        .width(120)
        .height(40)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(AppTokens.Shapes.large)
        .onClick(() => {
          this.onAction();
        })
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
    }
    .backgroundColor(AppTokens.Colors.surface)
  }
}

@Entry
@Component
struct ContentView {
  @State selectedCategory: string = "All";
  @State selectedFilters: Set<string> = new Set(["In Stock"]);
  
  private categories: string[] = ["All", "Snacks", "Drinks", "Fruits", "Bakery", "Dairy"];
  
  private products: ProductUi[] = [
    { id: 0, title: "Product 1", price: "$14.99", badge: "", rating: "4.0", color: '#DEE6FF' },
    { id: 1, title: "Product 2", price: "$35.99", badge: "NEW", rating: "4.9", color: '#D1FAE5' },
    { id: 2, title: "Product 3", price: "$12.00", badge: "", rating: "4.5", color: '#FEF3C7' },
    { id: 3, title: "Product 4", price: "$29.00", badge: "", rating: "4.8", color: '#FDE68A' }
  ];

  build() {
    Column() {
      // Top Bar
      Text("Shop")
        .font({ size: AppTokens.Typography.display.size, weight: AppTokens.Typography.display.weight })
        .fontColor(AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: AppTokens.Spacing.xxl, bottom: AppTokens.Spacing.xxl })

      // Content Scrollable Area
      Scroll() {
        Column() {
          // Category Row
          CategoryRow({ selectedCategory: $selectedCategory, items: this.categories })
            .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          
          // Filter Row
          FilterRow({ selectedFilters: $selectedFilters })
            .margin({ top: AppTokens.Spacing.xxxl, left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          
          // Product Grid
          ProductGrid({ products: this.products })
            .margin({ top: AppTokens.Spacing.xxxl, left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            
          // Spacer for bottom bar
          Blank().height(100)
        }
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Action Bar
      BottomActionBar({ 
        subtotal: "$129.96", 
        actionLabel: "Checkout", 
        onAction: () => {} 
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct ProductGrid {
  products!: ProductUi[];

  build() {
    Grid() {
      ForEach(this.products, (product: ProductUi) => {
        GridItem() {
          ProductCard({ product: product })
        }
      })
    }
    .columnsTemplate('1fr 1fr')
    .rowsGap(AppTokens.Spacing.lg)
    .columnsGap(AppTokens.Spacing.lg)
  }
}