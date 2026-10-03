/**
 * ContentView.ets
 * HarmonyOS ArkTS (ArkUI declarative) conversion of the SwiftUI e-commerce screen.
 * Target path: entry/src/main/ets/pages/ContentView.ets
 */

// MARK: - Design Tokens
const C_PRIMARY: string = '#6750A4';
const C_ON_PRIMARY: string = '#FFFFFF';
const C_SECONDARY: string = '#6CC24A';
const C_ON_SECONDARY: string = '#0A0F0A';
const C_TERTIARY: string = '#FFB300';
const C_ON_TERTIARY: string = '#1F1400';
const C_BACKGROUND: string = '#F6F7FB';
const C_ON_BACKGROUND: string = '#0F172A';
const C_SURFACE: string = '#FCFCFF';
const C_ON_SURFACE: string = '#111827';
const C_SURFACE_VARIANT: string = '#EEF0F6';
const C_OUTLINE: string = '#D0D5DD';
const C_SUCCESS: string = '#16A34A';
const C_WARNING: string = '#F59E0B';
const C_ERROR: string = '#D92D20';

// Spacing scale: xs 2 / sm 4 / md 6 / lg 8 / xl 12 / xxl 16 / xxxl 24

// MARK: - Data Model
interface ProductUi {
  id: number;
  title: string;
  price: string;
  badge: string;
  rating: string;
  color: string;
}

// MARK: - Product Card
@Component
struct ProductCard {
  product: ProductUi = { id: 0, title: '', price: '', badge: '', rating: '', color: '#FFFFFF' };

  build() {
    Column({ space: 8 }) {
      // Product image placeholder
      Column() {
        Text('Image')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)
          .opacity(0.7)
      }
      .width('100%')
      .aspectRatio(1)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(this.product.color)
      .borderRadius(8)

      // Title + badge
      Row() {
        Text(this.product.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)
          .layoutWeight(1)

        if (this.product.badge.length > 0) {
          Text(this.product.badge)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(C_ON_TERTIARY)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .backgroundColor(C_TERTIARY)
            .borderRadius(4)
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      // Price
      Text(this.product.price)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(C_PRIMARY)

      // Rating
      Row({ space: 4 }) {
        Circle({ width: 8, height: 8 })
          .fill(C_WARNING)

        Text(`${this.product.rating} rating`)
          .fontSize(12)
          .fontColor(C_ON_SURFACE)
          .opacity(0.7)
      }
      .alignItems(VerticalAlign.Center)

      // Add to cart
      Button('Add to Cart')
        .type(ButtonType.Normal)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(C_ON_PRIMARY)
        .backgroundColor(C_PRIMARY)
        .borderRadius(8)
        .width('100%')
        .height(36)
        .onClick(() => {
        })
    }
    .padding(8)
    .width('100%')
    .backgroundColor(C_SURFACE)
    .borderRadius(12)
    .borderWidth(1)
    .borderColor(C_OUTLINE)
    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
  }
}

// MARK: - Bottom Action Bar
@Component
struct BottomActionBar {
  @Prop subtotal: string = '';
  @Prop actionLabel: string = '';
  onAction: () => void = () => {
  };

  build() {
    Column() {
      Divider()
        .strokeWidth(1)
        .color(C_OUTLINE)

      Row() {
        Column({ space: 2 }) {
          Text('Subtotal')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(C_ON_SURFACE)
            .opacity(0.7)

          Text(this.subtotal)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(C_ON_SURFACE)
        }
        .alignItems(HorizontalAlign.Start)

        Button(this.actionLabel)
          .type(ButtonType.Normal)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SECONDARY)
          .backgroundColor(C_SECONDARY)
          .borderRadius(12)
          .width(120)
          .height(40)
          .onClick(() => {
            this.onAction();
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 8, right: 8, top: 8, bottom: 8 })
    }
    .width('100%')
    .backgroundColor(C_SURFACE)
  }
}

// MARK: - Main Content View
@Entry
@Component
struct ContentView {
  @State selectedCategory: string = 'All';
  @State selectedFilters: string[] = ['In Stock'];

  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy'];
  private filterOptions: string[] = ['In Stock', 'Under $20', 'Rating 4+'];
  private subtotal: string = '$129.96';

  private products: ProductUi[] = [
    { id: 0, title: 'Product 1', price: '$14.99', badge: '', rating: '4.0', color: '#E0E7FF' },
    { id: 1, title: 'Product 2', price: '$35.99', badge: 'NEW', rating: '4.9', color: '#D1FAE5' },
    { id: 2, title: 'Product 3', price: '$12.00', badge: '', rating: '4.5', color: '#FFEDD5' },
    { id: 3, title: 'Product 4', price: '$29.00', badge: '', rating: '4.8', color: '#FDE68A' }
  ];

  // Two cards per row
  private productRows(): ProductUi[][] {
    const rows: ProductUi[][] = [];
    for (let i = 0; i < this.products.length; i += 2) {
      rows.push(this.products.slice(i, i + 2));
    }
    return rows;
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // MARK: Top Bar
        Text('Shop')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(C_ON_SURFACE)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 16, bottom: 16 })
          .backgroundColor(C_BACKGROUND)

        // MARK: Scrollable Content
        Scroll() {
          Column({ space: 24 }) {
            // Category Row
            Scroll() {
              Row({ space: 4 }) {
                ForEach(this.categories, (item: string) => {
                  Text(item)
                    .fontSize(12)
                    .fontWeight(FontWeight.Normal)
                    .fontColor(this.selectedCategory === item ? C_ON_PRIMARY : C_ON_SURFACE)
                    .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                    .backgroundColor(this.selectedCategory === item ? C_PRIMARY : C_SURFACE)
                    .borderRadius(8)
                    .borderWidth(1)
                    .borderColor(C_OUTLINE)
                    .onClick(() => {
                      this.selectedCategory = item;
                    })
                }, (item: string) => item)
              }
              .padding({ top: 4, bottom: 4 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .height(50)

            // Filter Row
            Scroll() {
              Row({ space: 4 }) {
                ForEach(this.filterOptions, (filter: string) => {
                  Text(filter)
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.selectedFilters.includes(filter) ? C_ON_SECONDARY : C_ON_SURFACE)
                    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                    .backgroundColor(this.selectedFilters.includes(filter) ? C_SECONDARY : C_SURFACE)
                    .borderRadius(4)
                    .borderWidth(1)
                    .borderColor(C_OUTLINE)
                    .onClick(() => {
                      const index: number = this.selectedFilters.indexOf(filter);
                      if (index >= 0) {
                        this.selectedFilters.splice(index, 1);
                      } else {
                        this.selectedFilters.push(filter);
                      }
                    })
                }, (filter: string) => filter)
              }
              .padding({ top: 2, bottom: 2 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .height(40)

            // Product Grid (2 columns)
            Column({ space: 8 }) {
              ForEach(this.productRows(), (row: ProductUi[], index: number) => {
                Row({ space: 8 }) {
                  ForEach(row, (item: ProductUi) => {
                    ProductCard({ product: item })
                      .layoutWeight(1)
                  }, (item: ProductUi) => item.id.toString())

                  if (row.length % 2 === 1) {
                    Column()
                      .layoutWeight(1)
                  }
                }
                .width('100%')
                .alignItems(VerticalAlign.Top)
              }, (row: ProductUi[], index: number) => index.toString())
            }
            .width('100%')
          }
          .width('100%')
          .padding({ bottom: 100 }) // space for the floating bottom bar
        }
        .layoutWeight(1)
        .width('100%')
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
        .padding({ left: 8, right: 8 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(C_BACKGROUND)

      // MARK: Bottom Action Bar
      BottomActionBar({
        subtotal: this.subtotal,
        actionLabel: 'Checkout',
        onAction: () => {
          // Checkout action
        }
      })
    }
    .width('100%')
    .height('100%')
  }
}