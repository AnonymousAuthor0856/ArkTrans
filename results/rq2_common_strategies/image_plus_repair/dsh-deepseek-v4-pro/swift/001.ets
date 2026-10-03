//
//  ContentView.ets
//  ECommerceApp
//
//  Created by hang on 2025/10/12.
//  Translated from SwiftUI to ArkTS (HarmonyOS ArkUI).
//

// MARK: - Design Tokens
// SwiftUI `Color(red:green:blue:)` values are converted to ARGB hex strings.
class Colors {
  static readonly primary: string = '#6750A4';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly secondary: string = '#6CC24A';
  static readonly onSecondary: string = '#0A0F0A';
  static readonly tertiary: string = '#FFB300';
  static readonly onTertiary: string = '#1F1400';
  static readonly background: string = '#F6F7FB';
  static readonly onBackground: string = '#0F172A';
  static readonly surface: string = '#FCFCFF';
  static readonly onSurface: string = '#111827';
  static readonly surfaceVariant: string = '#EEF0F6';
  static readonly outline: string = '#D0D5DD';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#D92D1F';
}

// SwiftUI `Font.system(size:weight:)` tokens are stored as size/weight pairs.
class Typography {
  // display = Font.system(size: 22, weight: .semibold)
  static readonly displaySize: number = 22;
  static readonly displayWeight: number = 600;
  // headline = Font.system(size: 18, weight: .semibold)
  static readonly headlineSize: number = 18;
  static readonly headlineWeight: number = 600;
  // title = Font.system(size: 14, weight: .medium)
  static readonly titleSize: number = 14;
  static readonly titleWeight: number = 500;
  // body = Font.system(size: 12, weight: .regular)
  static readonly bodySize: number = 12;
  static readonly bodyWeight: number = 400;
  // label = Font.system(size: 10, weight: .medium)
  static readonly labelSize: number = 10;
  static readonly labelWeight: number = 500;
}

class Spacing {
  static readonly xs: number = 2;
  static readonly sm: number = 4;
  static readonly md: number = 6;
  static readonly lg: number = 8;
  static readonly xl: number = 12;
  static readonly xxl: number = 16;
  static readonly xxxl: number = 24;
}

// SwiftUI `RoundedRectangle(cornerRadius:)` shapes are stored as corner radii.
class Shapes {
  static readonly small: number = 4;
  static readonly medium: number = 8;
  static readonly large: number = 12;
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

// Palette used to build the product list.
const productPalette: string[] = ['#E0E7FF', '#D1FAE5', '#FFEDD5', '#FDE68A'];

// MARK: - Main Content View
@Entry
@Component
struct ContentView {
  @State selectedCategory: string = 'All';
  // SwiftUI `Set<String>` is represented as a string array for ArkTS compatibility.
  @State selectedFilters: string[] = ['In Stock'];

  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy'];

  private products: ProductUi[] = [
    new ProductUi(0, 'Product 1', '$14.99', '', '4.0', productPalette[0]),
    new ProductUi(1, 'Product 2', '$35.99', 'NEW', '4.9', productPalette[1]),
    new ProductUi(2, 'Product 3', '$12.00', '', '4.5', productPalette[2]),
    new ProductUi(3, 'Product 4', '$29.00', '', '4.8', productPalette[3])
  ];

  build() {
    // SwiftUI `NavigationView { ZStack { ... } }` with the navigation bar hidden
    // is rendered as a single Stack.
    Stack({ alignContent: Alignment.TopStart }) {
      // Background color that ignores the safe area.
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(Colors.background)

      // Content
      Column({ space: 0 }) {
        // Top Bar
        Text('Shop')
          .fontSize(Typography.displaySize)
          .fontWeight(Typography.displayWeight)
          .fontColor(Colors.onSurface)
          .padding({ top: Spacing.xxl, bottom: Spacing.xxl })
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor(Colors.background)

        // Content
        Scroll() {
          Column({ space: Spacing.xxxl }) {
            // Category Row
            CategoryRow({
              items: this.categories,
              selected: this.selectedCategory,
              onSelect: (item: string) => {
                this.selectedCategory = item;
              }
            })
              .padding({ left: Spacing.lg, right: Spacing.lg })

            // Filter Row
            FilterRow({
              selectedFilters: this.selectedFilters,
              onToggle: (filter: string) => {
                const index = this.selectedFilters.indexOf(filter);
                if (index !== -1) {
                  this.selectedFilters.splice(index, 1);
                } else {
                  this.selectedFilters.push(filter);
                }
              }
            })
              .padding({ left: Spacing.lg, right: Spacing.lg })

            // Product Grid
            ProductGrid({ products: this.products })
              .padding({ left: Spacing.lg, right: Spacing.lg })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ bottom: 100 }) // Space for bottom bar
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(Colors.background)
      }
      .width('100%')
      .height('100%')

      // Bottom Action Bar
      Column() {
        Blank()
        BottomActionBar({
          subtotal: '$129.96',
          actionLabel: 'Checkout',
          onAction: () => {
            // Checkout action
          }
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Category Row
@Component
struct CategoryRow {
  items: string[] = [];
  selected: string = '';
  onSelect: (item: string) => void = () => {};

  build() {
    Scroll() {
      Row({ space: Spacing.sm }) {
        ForEach(this.items, (item: string) => {
          Button() {
            Text(item)
              .fontSize(Typography.bodySize)
              .fontWeight(Typography.bodyWeight)
              .fontColor(this.selected === item ? Colors.onPrimary : Colors.onSurface)
              .padding({ left: Spacing.xl, right: Spacing.xl, top: Spacing.lg, bottom: Spacing.lg })
          }
          .backgroundColor(this.selected === item ? Colors.primary : Colors.surface)
          .borderRadius(Shapes.medium)
          .border({ width: 1, color: Colors.outline })
          .onClick(() => {
            this.onSelect(item);
          })
        }, (item: string) => item)
      }
      .padding({ top: Spacing.sm, bottom: Spacing.sm })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
    .height(50)
  }
}

// MARK: - Filter Row
@Component
struct FilterRow {
  selectedFilters: string[] = [];
  onToggle: (filter: string) => void = () => {};

  private filterOptions: string[] = ['In Stock', 'Under $20', 'Rating 4+'];

  build() {
    Scroll() {
      Row({ space: Spacing.sm }) {
        ForEach(this.filterOptions, (filter: string) => {
          Button() {
            Text(filter)
              .fontSize(Typography.labelSize)
              .fontWeight(Typography.labelWeight)
              .fontColor(this.selectedFilters.includes(filter) ? Colors.onSecondary : Colors.onSurface)
              .padding({ left: Spacing.xl, right: Spacing.xl, top: Spacing.md, bottom: Spacing.md })
          }
          .backgroundColor(this.selectedFilters.includes(filter) ? Colors.secondary : Colors.surface)
          .borderRadius(Shapes.small)
          .border({ width: 1, color: Colors.outline })
          .onClick(() => {
            this.onToggle(filter);
          })
        }, (filter: string) => filter)
      }
      .padding({ top: Spacing.xs, bottom: Spacing.xs })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
    .height(40)
  }
}

// MARK: - Product Grid
@Component
struct ProductGrid {
  products: ProductUi[] = [];

  build() {
    Grid() {
      ForEach(this.products, (product: ProductUi) => {
        GridItem() {
          ProductCard({ product: product })
        }
      }, (product: ProductUi) => product.id.toString())
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(Spacing.lg)
    .rowsGap(Spacing.lg)
    .width('100%')
  }
}

// MARK: - Product Card
@Component
struct ProductCard {
  product: ProductUi = new ProductUi(0, '', '', '', '', '#FFFFFF');

  build() {
    Column({ space: Spacing.lg }) {
      // Product Image
      Stack() {
        Text('Image')
          .fontSize(Typography.labelSize)
          .fontWeight(Typography.labelWeight)
          .fontColor('#B2111827') // onSurface.opacity(0.7)
      }
      .width('100%')
      .aspectRatio(1)
      .backgroundColor(this.product.color)
      .borderRadius(Shapes.medium)

      // Title and Badge
      Row() {
        Text(this.product.title)
          .fontSize(Typography.titleSize)
          .fontWeight(Typography.titleWeight)
          .fontColor(Colors.onSurface)

        Blank()

        if (this.product.badge !== '') {
          Text(this.product.badge)
            .fontSize(Typography.labelSize)
            .fontWeight(Typography.labelWeight)
            .fontColor(Colors.onTertiary)
            .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.xs, bottom: Spacing.xs })
            .backgroundColor(Colors.tertiary)
            .borderRadius(Shapes.small)
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      // Price
      Text(this.product.price)
        .fontSize(Typography.headlineSize)
        .fontWeight(Typography.headlineWeight)
        .fontColor(Colors.primary)

      // Rating
      Row({ space: Spacing.sm }) {
        Circle()
          .width(8)
          .height(8)
          .fill(Colors.warning)

        Text(`${this.product.rating} rating`)
          .fontSize(Typography.bodySize)
          .fontWeight(Typography.bodyWeight)
          .fontColor('#B2111827') // onSurface.opacity(0.7)
      }

      // Add to Cart Button
      Button() {
        Text('Add to Cart')
          .fontSize(Typography.titleSize)
          .fontWeight(Typography.titleWeight)
          .fontColor(Colors.onPrimary)
          .width('100%')
          .height(36)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(36)
      .backgroundColor(Colors.primary)
      .borderRadius(Shapes.medium)
    }
    .width('100%')
    .padding(Spacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Colors.surface)
    .borderRadius(Shapes.large)
    .border({ width: 1, color: Colors.outline })
    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
  }
}

// MARK: - Bottom Action Bar
@Component
struct BottomActionBar {
  subtotal: string = '';
  actionLabel: string = '';
  onAction: () => void = () => {};

  build() {
    Column({ space: 0 }) {
      Rect()
        .fill(Colors.outline)
        .width('100%')
        .height(1)

      Row() {
        Column({ space: Spacing.xs }) {
          Text('Subtotal')
            .fontSize(Typography.labelSize)
            .fontWeight(Typography.labelWeight)
            .fontColor('#B2111827') // onSurface.opacity(0.7)

          Text(this.subtotal)
            .fontSize(Typography.headlineSize)
            .fontWeight(Typography.headlineWeight)
            .fontColor(Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button() {
          Text(this.actionLabel)
            .fontSize(Typography.titleSize)
            .fontWeight(Typography.titleWeight)
            .fontColor(Colors.onSecondary)
            .width(120)
            .height(40)
            .textAlign(TextAlign.Center)
        }
        .width(120)
        .height(40)
        .backgroundColor(Colors.secondary)
        .borderRadius(Shapes.large)
        .onClick(() => {
          this.onAction();
        })
      }
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.lg, bottom: Spacing.lg })
      .backgroundColor(Colors.surface)
    }
    .width('100%')
    .backgroundColor(Colors.surface)
  }
}

// MARK: - Preview
// SwiftUI `PreviewProvider` is development-only and has no ArkTS runtime equivalent.
// struct ContentView_Previews: PreviewProvider {
//   static var previews: some View {
//     ContentView()
//       .previewDevice("iPhone SE (3rd generation)")
//   }
// }
