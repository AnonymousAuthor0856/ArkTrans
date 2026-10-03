import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - Design Tokens
class AppTokens {
  static Colors = {
    primary: '#6750A4', // rgb(0.404, 0.314, 0.643) approx hex
    onPrimary: '#FFFFFF',
    secondary: '#6CB85B', // rgb(0.424, 0.761, 0.290)
    onSecondary: '#0C0F0C',
    tertiary: '#FFB300', // rgb(1.000, 0.702, 0.000)
    onTertiary: '#1F1300',
    background: '#F6F8FC', // rgb(0.965, 0.969, 0.984)
    onBackground: '#0F172A',
    surface: '#FBFBFF', // rgb(0.988, 0.988, 1.000)
    onSurface: '#111827', // rgb(0.067, 0.094, 0.153)
    surfaceVariant: '#EFEFF5',
    outline: '#D0D7E2', // rgb(0.816, 0.835, 0.867)
    success: '#16A349',
    warning: '#F59E0B',
    error: '#DA3737'
  };

  static TypographyTokens = {
    display: { size: 22, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Bold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal },
    label: { size: 10, weight: FontWeight.Medium }
  };

  static Spacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  };

  static Shapes = {
    small: 4,
    medium: 8,
    large: 12
  };
}

// MARK: - Data Models
interface ProductUi {
  id: number;
  title: string;
  price: string;
  badge: string;
  rating: string;
  color: string;
}

@Entry
@Component
struct ContentView {
  @State selectedCategory: string = 'All';
  @State selectedFilters: Set<string> = new Set(['In Stock']);

  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy'];

  aboutToAppear() {
    // Initialization if needed
  }

  build() {
    Column() {
      NavPathStack({ navBarHidden: true }) {
        Stack({ alignContent: Alignment.Top }) {
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor(AppTokens.Colors.background)

          Column() {
            // Top Bar
            Text('Shop')
              .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
              .foregroundColor(AppTokens.Colors.onSurface)
              .padding({ top: AppTokens.Spacing.xxl, bottom: AppTokens.Spacing.xxl })
              .width('100%')
              .backgroundColor(AppTokens.Colors.background)

            // Content
            Scroll() {
              Column({ space: AppTokens.Spacing.xxxl }) {
                CategoryRow({
                  items: this.categories,
                  selected: this.selectedCategory,
                  onSelect: (item: string) => {
                    this.selectedCategory = item;
                  }
                })
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

                FilterRow({
                  selectedFilters: this.selectedFilters,
                  onToggle: (filter: string) => {
                    if (this.selectedFilters.has(filter)) {
                      this.selectedFilters.delete(filter);
                    } else {
                      this.selectedFilters.add(filter);
                    }
                  }
                })
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

                ProductGrid({ products: this.getProducts() })
                  .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
              }
              .padding({ bottom: 100 })
            }
            .layoutWeight(1)
            .backgroundColor(AppTokens.Colors.background)
          }
          .width('100%')
          .height('100%')

          // Bottom Action Bar
          Column() {
            Blank()
            BottomActionBar({ subtotal: '$129.96', actionLabel: 'Checkout', onAction: () => {} })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .height('100%')
      }
    }
  }

  getProducts(): ProductUi[] {
    const palette: string[] = [
      '#DEE5FF', // rgb(0.878, 0.906, 1.000)
      '#D1FBDB', // rgb(0.820, 0.980, 0.898)
      '#FFEBCC', // rgb(1.000, 0.929, 0.835)
      '#FFE68A'  // rgb(0.992, 0.902, 0.541)
    ];

    return [
      { id: 0, title: 'Product 1', price: '$14.99', badge: '', rating: '4.0', color: palette[0] },
      { id: 1, title: 'Product 2', price: '$35.99', badge: 'NEW', rating: '4.9', color: palette[1] },
      { id: 2, title: 'Product 3', price: '$12.00', badge: '', rating: '4.5', color: palette[2] },
      { id: 3, title: 'Product 4', price: '$29.00', badge: '', rating: '4.8', color: palette[3] }
    ];
  }
}

// MARK: - Category Row
@Component
struct CategoryRow {
  @Prop items: string[];
  @Prop selected: string;
  @Prop onSelect: (item: string) => void;

  build() {
    Scroll() {
      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.items, (item: string) => {
          Button({ type: ButtonType.Normal }) {
            Text(item)
              .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
              .foregroundColor(this.selected === item ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
              .padding({ left: AppTokens.Spacing.xl, right: AppTokens.Spacing.xl, top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
          }
          .onClick(() => {
            this.onSelect(item);
          })
          .backgroundColor(this.selected === item ? AppTokens.Colors.primary : AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.medium)
          .border({ width: 1, color: AppTokens.Colors.outline })
        }, (item: string) => item)
      }
      .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    }
    .height(50)
    .scrollBar(BarState.Off)
  }
}

// MARK: - Filter Row
@Component
struct FilterRow {
  @Prop selectedFilters: Set<string>;
  @Prop onToggle: (filter: string) => void;

  private filterOptions: string[] = ['In Stock', 'Under $20', 'Rating 4+'];

  build() {
    Scroll() {
      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.filterOptions, (filter: string) => {
          Button({ type: ButtonType.Normal }) {
            Text(filter)
              .font({ size: AppTokens.TypographyTokens.label.size, weight: AppTokens.TypographyTokens.label.weight })
              .foregroundColor(this.selectedFilters.has(filter) ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
              .padding({ left: AppTokens.Spacing.xl, right: AppTokens.Spacing.xl, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
          }
          .onClick(() => {
            this.onToggle(filter);
          })
          .backgroundColor(this.selectedFilters.has(filter) ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
        }, (filter: string) => filter)
      }
      .padding({ top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
    }
    .height(40)
    .scrollBar(BarState.Off)
  }
}

// MARK: - Product Grid
@Component
struct ProductGrid {
  @Prop products: ProductUi[];

  build() {
    GridContainer() {
      ForEach(this.products, (product: ProductUi) => {
        GridItem() {
          ProductCard({ product: product })
        }
      }, (product: ProductUi) => product.id.toString())
    }
    .columnsTemplate('1fr 1fr')
    .rowsTemplate('auto')
    .gutters({ row: AppTokens.Spacing.lg, column: AppTokens.Spacing.lg })
  }
}

// MARK: - Product Card
@Component
struct ProductCard {
  @Prop product: ProductUi;

  build() {
    Column({ space: AppTokens.Spacing.lg }) {
      // Product Image
      Stack() {
        Rect()
          .fill(this.product.color)
          .borderRadius(AppTokens.Shapes.medium)
        
        Text('Image')
          .font({ size: AppTokens.TypographyTokens.label.size, weight: AppTokens.TypographyTokens.label.weight })
          .opacity(0.7)
      }
      .aspectRatio(1.0)
      .width('100%')

      // Title and Badge
      Row() {
        Text(this.product.title)
          .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
          .foregroundColor(AppTokens.Colors.onSurface)
        
        Blank()

        if (this.product.badge !== '') {
          Text(this.product.badge)
            .font({ size: AppTokens.TypographyTokens.label.size, weight: AppTokens.TypographyTokens.label.weight })
            .foregroundColor(AppTokens.Colors.onTertiary)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(AppTokens.Shapes.small)
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      // Price
      Text(this.product.price)
        .font({ size: AppTokens.TypographyTokens.headline.size, weight: AppTokens.TypographyTokens.headline.weight })
        .foregroundColor(AppTokens.Colors.primary)

      // Rating
      Row({ space: AppTokens.Spacing.sm }) {
        Circle()
          .fill(AppTokens.Colors.warning)
          .width(8)
          .height(8)

        Text(`${this.product.rating} rating`)
          .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
          .opacity(0.7)
      }

      // Add to Cart Button
      Button({ type: ButtonType.Normal }) {
        Text('Add to Cart')
          .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
          .foregroundColor(AppTokens.Colors.onPrimary)
          .width('100%')
          .height(36)
      }
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.medium)
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 3, color: Color.Black.opacity(0.1), offsetY: 1 })
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

// MARK: - Bottom Action Bar
@Component
struct BottomActionBar {
  @Prop subtotal: string;
  @Prop actionLabel: string;
  @Prop onAction: () => void;

  build() {
    Column() {
      Divider()
        .color(AppTokens.Colors.outline)
        .strokeWidth(1)

      Row() {
        Column({ space: AppTokens.Spacing.xs }) {
          Text('Subtotal')
            .font({ size: AppTokens.TypographyTokens.label.size, weight: AppTokens.TypographyTokens.label.weight })
            .opacity(0.7)

          Text(this.subtotal)
            .font({ size: AppTokens.TypographyTokens.headline.size, weight: AppTokens.TypographyTokens.headline.weight })
            .foregroundColor(AppTokens.Colors.onSurface)
        }

        Blank()

        Button({ type: ButtonType.Normal }) {
          Text(this.actionLabel)
            .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
            .foregroundColor(AppTokens.Colors.onSecondary)
            .width(120)
            .height(40)
        }
        .onClick(() => {
          this.onAction();
        })
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(AppTokens.Shapes.large)
      }
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.surface)
    }
    .backgroundColor(AppTokens.Colors.surface)
  }
}