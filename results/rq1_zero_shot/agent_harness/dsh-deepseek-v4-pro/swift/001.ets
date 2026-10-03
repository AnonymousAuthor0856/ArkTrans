//
//  ContentView.ets
//  ECommerceApp
//

// MARK: - Design Tokens
interface AppColors {
  primary: string;
  onPrimary: string;
  secondary: string;
  onSecondary: string;
  tertiary: string;
  onTertiary: string;
  background: string;
  onBackground: string;
  surface: string;
  onSurface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
}

interface FontSpec {
  size: number;
  weight: FontWeight;
}

interface AppTypography {
  display: FontSpec;
  headline: FontSpec;
  title: FontSpec;
  body: FontSpec;
  label: FontSpec;
}

interface AppSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface AppShapes {
  small: number;
  medium: number;
  large: number;
}

class AppTokens {
  static readonly Colors: AppColors = {
    primary: '#6750A4',
    onPrimary: '#FFFFFF',
    secondary: '#6CC24A',
    onSecondary: '#0A0F0A',
    tertiary: '#FFB300',
    onTertiary: '#1F1400',
    background: '#F6F7FB',
    onBackground: '#0F172A',
    surface: '#FCFCFF',
    onSurface: '#111827',
    surfaceVariant: '#EEF0F6',
    outline: '#D0D5DD',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#D92D20'
  };

  static readonly TypographyTokens: AppTypography = {
    display: { size: 22, weight: FontWeight.Semibold },
    headline: { size: 18, weight: FontWeight.Semibold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Regular },
    label: { size: 10, weight: FontWeight.Medium }
  };

  static readonly Spacing: AppSpacing = {
    xs: 2, sm: 4, md: 6, lg: 8, xl: 12, xxl: 16, xxxl: 24
  };

  static readonly Shapes: AppShapes = {
    small: 4, medium: 8, large: 12
  };
}

// MARK: - Data Models
class ProductUi {
  id: number;
  title: string;
  price: string;
  badge: string;
  rating: string;
  color: string;

  constructor(id: number, title: string, price: string, badge: string, rating: string, color: string) {
    this.id = id;
    this.title = title;
    this.price = price;
    this.badge = badge;
    this.rating = rating;
    this.color = color;
  }
}

// MARK: - Main Content View
@Entry
@Component
struct ContentView {
  @State selectedCategory: string = 'All';
  @State selectedFilters: string[] = ['In Stock'];

  categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy'];

  private getProducts(): ProductUi[] {
    const palette: string[] = ['#E0E7FF', '#D1FAE5', '#FFEDD5', '#FDE68A'];
    return [
      new ProductUi(0, 'Product 1', '$14.99', '', '4.0', palette[0]),
      new ProductUi(1, 'Product 2', '$35.99', 'NEW', '4.9', palette[1]),
      new ProductUi(2, 'Product 3', '$12.00', '', '4.5', palette[2]),
      new ProductUi(3, 'Product 4', '$29.00', '', '4.8', palette[3])
    ];
  }

  build() {
    Stack() {
      Column() {
        // Top Bar
        Text('Shop')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ top: AppTokens.Spacing.xxl, bottom: AppTokens.Spacing.xxl })
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor(AppTokens.Colors.background)

        // Content
        Scroll() {
          Column({ space: AppTokens.Spacing.xxxl }) {
            // Category Row
            CategoryRow({
              items: this.categories,
              selected: this.selectedCategory,
              onSelect: (item: string) => { this.selectedCategory = item; }
            })
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // Filter Row
            FilterRow({
              selectedFilters: this.selectedFilters,
              onToggle: (filter: string) => {
                if (this.selectedFilters.includes(filter)) {
                  this.selectedFilters = this.selectedFilters.filter((f: string) => f !== filter);
                } else {
                  this.selectedFilters = this.selectedFilters.concat([filter]);
                }
              }
            })
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // Product Grid
            ProductGrid({ products: this.getProducts() })
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          }
          .alignItems(HorizontalAlign.Start)
          .padding({ bottom: 100 }) // Space for bottom bar
        }
        .backgroundColor(AppTokens.Colors.background)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      // Bottom Action Bar
      Column() {
        Blank()
        BottomActionBar({ subtotal: '$129.96', actionLabel: 'Checkout', onAction: () => { /* Checkout action */ } })
      }
      .width('100%')
      .height('100%')
    }
  }
}

// MARK: - Category Row
@Component
struct CategoryRow {
  @Prop items: string[] = [];
  @Prop selected: string = '';
  onSelect: (item: string) => void = () => {};

  build() {
    Scroll() {
      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.items, (item: string) => {
          Button(item)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(this.selected === item ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
            .padding({ left: AppTokens.Spacing.xl, right: AppTokens.Spacing.xl, top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
            .backgroundColor(this.selected === item ? AppTokens.Colors.primary : AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.medium)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .onClick(() => { this.onSelect(item); })
        }, (item: string) => item)
      }
      .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .height(50)
  }
}

// MARK: - Filter Row
@Component
struct FilterRow {
  @Prop selectedFilters: string[] = [];
  onToggle: (filter: string) => void = () => {};

  filterOptions: string[] = ['In Stock', 'Under $20', 'Rating 4+'];

  build() {
    Scroll() {
      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.filterOptions, (filter: string) => {
          Button(filter)
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(this.selectedFilters.includes(filter) ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
            .padding({ left: AppTokens.Spacing.xl, right: AppTokens.Spacing.xl, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
            .backgroundColor(this.selectedFilters.includes(filter) ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.small)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .onClick(() => { this.onToggle(filter); })
        }, (filter: string) => filter)
      }
      .padding({ top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .height(40)
  }
}

// MARK: - Product Grid
@Component
struct ProductGrid {
  @Prop products: ProductUi[] = [];

  build() {
    Grid() {
      ForEach(this.products, (product: ProductUi) => {
        GridItem() {
          ProductCard({ product: product })
        }
      }, (product: ProductUi) => product.id.toString())
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(AppTokens.Spacing.lg)
    .rowsGap(AppTokens.Spacing.lg)
  }
}

// MARK: - Product Card
@Component
struct ProductCard {
  @Prop product: ProductUi = new ProductUi(0, '', '', '', '', '');

  build() {
    Column({ space: AppTokens.Spacing.lg }) {
      // Product Image
      Stack() {
        Text('Image')
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.7)
      }
      .width('100%')
      .aspectRatio(1.0)
      .backgroundColor(this.product.color)
      .borderRadius(AppTokens.Shapes.medium)

      // Title and Badge
      Row() {
        Text(this.product.title)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        if (this.product.badge !== '') {
          Text(this.product.badge)
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(AppTokens.Colors.onTertiary)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(AppTokens.Shapes.small)
        }
      }
      .alignItems(VerticalAlign.Top)

      // Price
      Text(this.product.price)
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .fontColor(AppTokens.Colors.primary)

      // Rating
      Row({ space: AppTokens.Spacing.sm }) {
        Circle()
          .width(8)
          .height(8)
          .fill(AppTokens.Colors.warning)

        Text(this.product.rating + ' rating')
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.7)
      }

      // Add to Cart Button
      Button('Add to Cart')
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .width('100%')
        .height(36)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .onClick(() => {})
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 3, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 1 })
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

// MARK: - Bottom Action Bar
@Component
struct BottomActionBar {
  @Prop subtotal: string = '';
  @Prop actionLabel: string = '';
  onAction: () => void = () => {};

  build() {
    Column({ space: 0 }) {
      Row()
        .width('100%')
        .height(1)
        .backgroundColor(AppTokens.Colors.outline)

      Row() {
        Column({ space: AppTokens.Spacing.xs }) {
          Text('Subtotal')
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .opacity(0.7)

          Text(this.subtotal)
            .fontSize(AppTokens.TypographyTokens.headline.size)
            .fontWeight(AppTokens.TypographyTokens.headline.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button(this.actionLabel)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onSecondary)
          .width(120)
          .height(40)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.large)
          .onClick(() => { this.onAction(); })
      }
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
  }
}
