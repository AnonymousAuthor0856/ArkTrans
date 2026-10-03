// ECommerceApp.ets
// Converted from SwiftUI to ArkTS

// MARK: - Design Tokens
interface AppColors {
  primary: ResourceColor;
  onPrimary: ResourceColor;
  secondary: ResourceColor;
  onSecondary: ResourceColor;
  tertiary: ResourceColor;
  onTertiary: ResourceColor;
  background: ResourceColor;
  onBackground: ResourceColor;
  surface: ResourceColor;
  onSurface: ResourceColor;
  surfaceVariant: ResourceColor;
  outline: ResourceColor;
  success: ResourceColor;
  warning: ResourceColor;
  error: ResourceColor;
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

class AppTokens {
  static Colors: AppColors = {
    primary: '#6750A4',
    onPrimary: '#FFFFFF',
    secondary: '#6CC14A',
    onSecondary: '#0A0F0A',
    tertiary: '#FFB300',
    onTertiary: '#1F1400',
    background: '#F7F8FB',
    onBackground: '#0F1729',
    surface: '#FCFCFF',
    onSurface: '#111827',
    surfaceVariant: '#EEF0F6',
    outline: '#D1D5DD',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#D92E20'
  };

  static Spacing: AppSpacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  };
}

// MARK: - Data Models
interface ProductUi {
  id: number;
  title: string;
  price: string;
  badge: string;
  rating: string;
  color: ResourceColor;
}

// MARK: - Main Content View
@Entry
@Component
struct ContentView {
  @State selectedCategory: string = 'All';
  @State selectedFilters: Set<string> = new Set(['In Stock']);
  
  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy'];
  
  private products: ProductUi[] = [
    { id: 0, title: 'Product 1', price: '$14.99', badge: '', rating: '4.0', color: '#E0E7FF' },
    { id: 1, title: 'Product 2', price: '$35.99', badge: 'NEW', rating: '4.9', color: '#D1FAE5' },
    { id: 2, title: 'Product 3', price: '$12.00', badge: '', rating: '4.5', color: '#FEF3C7' },
    { id: 3, title: 'Product 4', price: '$29.00', badge: '', rating: '4.8', color: '#FDE68A' }
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Bar
        Text('Shop')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ top: AppTokens.Spacing.xxl, bottom: AppTokens.Spacing.xxl })
          .width('100%')
          .backgroundColor(AppTokens.Colors.background);

        // Content
        Scroll() {
          Column({ space: AppTokens.Spacing.xxxl }) {
            // Category Row
            CategoryRow({
              items: this.categories,
              selected: this.selectedCategory,
              onSelect: (item: string): void => {
                this.selectedCategory = item;
              }
            })
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg });

            // Filter Row
            FilterRow({
              selectedFilters: this.selectedFilters,
              onToggle: (filter: string): void => {
                if (this.selectedFilters.has(filter)) {
                  this.selectedFilters.delete(filter);
                } else {
                  this.selectedFilters.add(filter);
                }
                // Force re-render by creating a new Set
                this.selectedFilters = new Set(this.selectedFilters);
              }
            })
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg });

            // Product Grid
            ProductGrid({ products: this.products })
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg });
          }
          .padding({ bottom: 100 });
        }
        .backgroundColor(AppTokens.Colors.background)
        .layoutWeight(1);
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background);

      // Bottom Action Bar
      BottomActionBar({ subtotal: '$129.96', actionLabel: 'Checkout' });
    }
    .width('100%')
    .height('100%');
  }
}

// MARK: - Category Row
@Component
struct CategoryRow {
  private items: string[] = [];
  private selected: string = '';
  private onSelect: (item: string) => void = () => {};

  build() {
    Scroll() {
      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.items, (item: string) => {
          Button() {
            Text(item)
              .fontSize(12)
              .fontColor(this.selected === item ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
              .padding({
                left: AppTokens.Spacing.xl,
                right: AppTokens.Spacing.xl,
                top: AppTokens.Spacing.lg,
                bottom: AppTokens.Spacing.lg
              });
          }
          .backgroundColor(this.selected === item ? AppTokens.Colors.primary : AppTokens.Colors.surface)
          .borderRadius(8)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .onClick(() => { this.onSelect(item); });
        }, (item: string) => item);
      }
      .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm });
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .height(50);
  }
}

// MARK: - Filter Row
@Component
struct FilterRow {
  private selectedFilters: Set<string> = new Set();
  private onToggle: (filter: string) => void = () => {};
  
  private filterOptions: string[] = ['In Stock', 'Under $20', 'Rating 4+'];

  build() {
    Scroll() {
      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.filterOptions, (filter: string) => {
          Button() {
            Text(filter)
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedFilters.has(filter) ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
              .padding({
                left: AppTokens.Spacing.xl,
                right: AppTokens.Spacing.xl,
                top: AppTokens.Spacing.md,
                bottom: AppTokens.Spacing.md
              });
          }
          .backgroundColor(this.selectedFilters.has(filter) ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
          .borderRadius(4)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .onClick(() => { this.onToggle(filter); });
        }, (filter: string) => filter);
      }
      .padding({ top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs });
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .height(40);
  }
}

// MARK: - Product Grid
@Component
struct ProductGrid {
  private products: ProductUi[] = [];

  build() {
    Grid() {
      ForEach(this.products, (product: ProductUi) => {
        GridItem() {
          ProductCard({ product: product });
        }
      }, (product: ProductUi) => product.id.toString());
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(AppTokens.Spacing.lg)
    .rowsGap(AppTokens.Spacing.lg);
  }
}

// MARK: - Product Card
@Component
struct ProductCard {
  private product: ProductUi = { id: 0, title: '', price: '', badge: '', rating: '', color: Color.White };

  build() {
    Column({ space: AppTokens.Spacing.lg }) {
      // Product Image
      Stack() {
        Text('Image')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111827B3');
      }
      .width('100%')
      .aspectRatio(1)
      .backgroundColor(this.product.color)
      .borderRadius(8);

      // Title and Badge
      Row() {
        Text(this.product.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1);

        if (this.product.badge !== '') {
          Text(this.product.badge)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onTertiary)
            .padding({
              left: AppTokens.Spacing.md,
              right: AppTokens.Spacing.md,
              top: AppTokens.Spacing.xs,
              bottom: AppTokens.Spacing.xs
            })
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(4);
        }
      }
      .width('100%');

      // Price
      Text(this.product.price)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.primary);

      // Rating
      Row({ space: AppTokens.Spacing.sm }) {
        Circle({ width: 8, height: 8 })
          .fill(AppTokens.Colors.warning);

        Text(`${this.product.rating} rating`)
          .fontSize(12)
          .fontColor('#111827B3');
      }
      .width('100%');

      // Add to Cart Button
      Button('Add to Cart')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .width('100%')
        .height(36)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(8);
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 3, color: '#0000001A', offsetX: 0, offsetY: 1 });
  }
}

// MARK: - Bottom Action Bar
@Component
struct BottomActionBar {
  private subtotal: string = '';
  private actionLabel: string = '';
  private onAction: () => void = () => {};

  build() {
    Column() {
      Divider()
        .color(AppTokens.Colors.outline)
        .strokeWidth(1);

      Row() {
        Column({ space: AppTokens.Spacing.xs }) {
          Text('Subtotal')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#111827B3');

          Text(this.subtotal)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onSurface);
        }
        .alignItems(HorizontalAlign.Start);

        Blank();

        Button(this.actionLabel)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .width(120)
          .height(40)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(12)
          .onClick(() => { this.onAction(); });
      }
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.lg,
        bottom: AppTokens.Spacing.lg
      })
      .backgroundColor(AppTokens.Colors.surface)
      .width('100%');
    }
    .backgroundColor(AppTokens.Colors.surface)
    .width('100%');
  }
}