//  ECommerceApp
//  Created by hang on 2025/10/12.

// MARK: - Design Tokens
class AppTokens {
  static Colors: object = {
    primary: '#6750A4',
    onPrimary: '#FFFFFF',
    secondary: '#6CC24A',
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
    error: '#D92B20',
  };

  static Typography: object = {
    display: { size: 22, weight: FontWeight.Medium },
    headline: { size: 18, weight: FontWeight.Medium },
    title: { size: 14, weight: FontWeight.Normal },
    body: { size: 12, weight: FontWeight.Normal },
    label: { size: 10, weight: FontWeight.Normal },
  };

  static Spacing: object = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24,
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

  constructor(
    id: number,
    title: string,
    price: string,
    badge: string,
    rating: string,
    color: string
  ) {
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
  @State private selectedCategory: string = 'All';
  @State private selectedFilters: Set<string> = new Set<string>(['In Stock']);

  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy'];

  private products: ProductUi[] = [
    new ProductUi(0, 'Product 1', '$14.99', '', '4.0', '#E0E6FF'),
    new ProductUi(1, 'Product 2', '$35.99', 'NEW', '4.9', '#D1FAE5'),
    new ProductUi(2, 'Product 3', '$12.00', '', '4.5', '#FFEFD5'),
    new ProductUi(3, 'Product 4', '$29.00', '', '4.8', '#FDE68A'),
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background);

      // Content
      Column() {
        // Top Bar
        Text('Shop')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ top: AppTokens.Spacing.xxl, bottom: AppTokens.Spacing.xxl })
          .width('100%')
          .backgroundColor(AppTokens.Colors.background);

        // Scrollable Content
        Scroll() {
          Column() {
            // Category Row
            CategoryRow({
              items: this.categories,
              selected: this.selectedCategory,
              onSelect: (item: string) => {
                this.selectedCategory = item;
              },
            })
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg });

            // Filter Row
            FilterRow({
              selectedFilters: this.selectedFilters,
              onToggle: (filter: string) => {
                if (this.selectedFilters.has(filter)) {
                  this.selectedFilters.delete(filter);
                } else {
                  this.selectedFilters.add(filter);
                }
              },
            })
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg });

            // Product Grid
            ProductGrid({ products: this.products })
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg });
          }
          .alignItems(HorizontalAlign.Start)
          .padding({ bottom: 100 });
        }
        .layoutWeight(1)
        .backgroundColor(AppTokens.Colors.background);
      }
      .width('100%')
      .height('100%');

      // Bottom Action Bar
      Column() {
        Blank();
        BottomActionBar({ subtotal: '$129.96', actionLabel: 'Checkout', onAction: () => {} });
      }
      .width('100%')
      .height('100%');
    }
    .width('100%')
    .height('100%');
  }
}

// MARK: - Category Row
@Component
struct CategoryRow {
  let items: string[];
  let selected: string;
  onSelect: (item: string) => void;

  build() {
    Scroll() {
      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.items, (item: string) => {
          Button({ type: ButtonType.Normal }) {
            Text(item)
              .fontSize(AppTokens.Typography.body.size)
              .fontWeight(AppTokens.Typography.body.weight)
              .fontColor(this.selected === item ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
              .padding({
                left: AppTokens.Spacing.xl,
                right: AppTokens.Spacing.xl,
                top: AppTokens.Spacing.lg,
                bottom: AppTokens.Spacing.lg,
              });
          }
          .backgroundColor(this.selected === item ? AppTokens.Colors.primary : AppTokens.Colors.surface)
          .borderRadius(8)
          .border({ width: 1, color: AppTokens.Colors.outline });
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
  let selectedFilters: Set<string>;
  let onToggle: (filter: string) => void;

  private filterOptions: string[] = ['In Stock', 'Under $20', 'Rating 4+'];

  build() {
    Scroll() {
      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.filterOptions, (filter: string) => {
          Button({ type: ButtonType.Normal }) {
            Text(filter)
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(this.selectedFilters.has(filter) ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
              .padding({
                left: AppTokens.Spacing.xl,
                right: AppTokens.Spacing.xl,
                top: AppTokens.Spacing.md,
                bottom: AppTokens.Spacing.md,
              });
          }
          .backgroundColor(this.selectedFilters.has(filter) ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
          .borderRadius(4)
          .border({ width: 1, color: AppTokens.Colors.outline });
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
  let products: ProductUi[];

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
    .rowsGap(AppTokens.Spacing.lg)
    .padding({ bottom: AppTokens.Spacing.lg });
  }
}

// MARK: - Product Card
@Component
struct ProductCard {
  let product: ProductUi;

  build() {
    Column() {
      // Product Image
      Stack() {
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor(this.product.color)
          .borderRadius(8);

        Text('Image')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.7);
      }
      .aspectRatio(1)
      .width('100%');

      // Title and Badge
      Row() {
        Text(this.product.title)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1);

        if (this.product.badge !== '') {
          Text(this.product.badge)
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onTertiary)
            .padding({
              left: AppTokens.Spacing.md,
              right: AppTokens.Spacing.md,
              top: AppTokens.Spacing.xs,
              bottom: AppTokens.Spacing.xs,
            })
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(4);
        }
      }
      .width('100%')
      .padding({ top: AppTokens.Spacing.lg });

      // Price
      Text(this.product.price)
        .fontSize(AppTokens.Typography.headline.size)
        .fontWeight(AppTokens.Typography.headline.weight)
        .fontColor(AppTokens.Colors.primary)
        .padding({ top: AppTokens.Spacing.lg });

      // Rating
      Row({ space: AppTokens.Spacing.sm }) {
        Circle()
          .width(8)
          .height(8)
          .fill(AppTokens.Colors.warning);

        Text(`${this.product.rating} rating`)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.7);
      }
      .padding({ top: AppTokens.Spacing.sm });

      // Add to Cart Button
      Button({ type: ButtonType.Normal }) {
        Text('Add to Cart')
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onPrimary);
      }
      .width('100%')
      .height(36)
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(8)
      .margin({ top: AppTokens.Spacing.lg });
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 3, color: '#000000', offsetX: 0, offsetY: 1 });
  }
}

// MARK: - Bottom Action Bar
@Component
struct BottomActionBar {
  let subtotal: string;
  let actionLabel: string;
  onAction: () => void;

  build() {
    Column() {
      // Divider
      Divider()
        .color(AppTokens.Colors.outline)
        .strokeWidth(1)
        .width('100%');

      Row() {
        Column() {
          Text('Subtotal')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .opacity(0.7);

          Text(this.subtotal)
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(AppTokens.Colors.onSurface);
        }
        .alignItems(HorizontalAlign.Start);

        Blank();

        Button({ type: ButtonType.Normal }) {
          Text(this.actionLabel)
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSecondary);
        }
        .width(120)
        .height(40)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(12)
        .onClick(() => {
          this.onAction();
        });
      }
      .width('100%')
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.lg,
        bottom: AppTokens.Spacing.lg,
      })
      .backgroundColor(AppTokens.Colors.surface);
    }
    .backgroundColor(AppTokens.Colors.surface);
  }
}