import { router } from '@kit.ArkUI';

// Color tokens
const Colors = {
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
  error: '#D92D20',
}

class ProductUi {
  id: number = 0;
  title: string = '';
  price: string = '';
  badge: string = '';
  rating: string = '';
  color: string = '';
}

function buildProducts(): ProductUi[] {
  const palette: string[] = [
    '#E0E7FF',
    '#D1FAE5',
    '#FFEDD5',
    '#FDE68A',
    '#EDE9FE',
    '#FFE4E6',
    '#E2E8F0',
    '#FFFBEB'
  ];
  const products: ProductUi[] = [];
  for (let i = 0; i < 8; i++) {
    const p = new ProductUi();
    p.id = i;
    p.title = `Product ${i + 1}`;
    const prices: string[] = ['$9.99', '$14.99', '$19.99', '$24.99', '$29.99', '$34.99', '$39.99', '$44.99', '$49.99'];
    p.price = prices[i % prices.length];
    p.badge = (i % 3 === 0) ? 'NEW' : (i % 4 === 0) ? 'SALE' : '';
    const ratings: string[] = ['4.0', '4.1', '4.2', '4.3', '4.4', '4.5', '4.6', '4.7', '4.8', '4.9', '5.0'];
    p.rating = ratings[i % ratings.length];
    p.color = palette[i % palette.length];
    products.push(p);
  }
  return products;
}

@Component
struct ProductCard {
  product: ProductUi = new ProductUi();

  build() {
    Column({ space: 6 }) {
      // Image placeholder
      Stack() {
        Text('Image')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .aspectRatio(1.2)
      .backgroundColor(this.product.color)
      .borderRadius(8)
      .alignContent(Alignment.Center)

      // Title and badge row
      Row() {
        Text(this.product.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .layoutWeight(1)

        if (this.product.badge !== '') {
          Text(this.product.badge)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onTertiary)
            .backgroundColor(Colors.tertiary)
            .borderRadius(4)
            .padding({ left: 4, right: 4, top: 2, bottom: 2 })
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Price
      Text(this.product.price)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.primary)

      // Rating row
      Row({ space: 4 }) {
        Text('★')
          .fontSize(12)
          .fontColor(Colors.warning)
        Text(`${this.product.rating} rating`)
          .fontSize(12)
          .fontColor(Colors.onSurface)
      }
      .alignItems(VerticalAlign.Center)

      // Add to Cart button
      Button('Add to Cart')
        .width('100%')
        .height(40)
        .backgroundColor(Colors.primary)
        .fontColor(Colors.onPrimary)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .borderRadius(8)
    }
    .width('100%')
    .padding(8)
    .backgroundColor(Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: Colors.outline })
    .shadow({ radius: 4, color: '#22000000', offsetX: 0, offsetY: 1 })
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct CategoryRow {
  categories: string[] = [];
  @State selected: string = 'All';

  build() {
    Scroll() {
      Row({ space: 4 }) {
        ForEach(this.categories, (label: string) => {
          Text(label)
            .fontSize(this.selected === label ? 14 : 12)
            .fontWeight(this.selected === label ? FontWeight.Medium : FontWeight.Normal)
            .fontColor(this.selected === label ? Colors.onPrimary : Colors.onSurface)
            .backgroundColor(this.selected === label ? Colors.primary : Colors.surface)
            .borderRadius(8)
            .border({ width: 1, color: Colors.outline })
            .padding({ left: 12, right: 12, top: 6, bottom: 6 })
            .onClick(() => {
              this.selected = label;
            })
        })
      }
      .padding({ top: 2, bottom: 2 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }
}

@Component
struct FilterRow {
  @State activeFilters: string[] = ['In Stock'];

  isActive(label: string): boolean {
    return this.activeFilters.indexOf(label) >= 0;
  }

  toggleFilter(label: string): void {
    const idx = this.activeFilters.indexOf(label);
    if (idx >= 0) {
      const newFilters: string[] = [];
      for (let i = 0; i < this.activeFilters.length; i++) {
        if (i !== idx) {
          newFilters.push(this.activeFilters[i]);
        }
      }
      this.activeFilters = newFilters;
    } else {
      this.activeFilters = [...this.activeFilters, label];
    }
  }

  build() {
    Row({ space: 4 }) {
      ForEach(['In Stock', 'Under $20', 'Rating 4+'], (label: string) => {
        Text(label)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isActive(label) ? Colors.onSecondary : Colors.onSurface)
          .backgroundColor(this.isActive(label) ? Colors.secondary : Colors.surface)
          .borderRadius(4)
          .border({ width: 1, color: Colors.outline })
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .onClick(() => {
            this.toggleFilter(label);
          })
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BottomActionBar {
  subtotal: string = '$129.96';
  actionLabel: string = 'Checkout';

  build() {
    Row() {
      Column({ space: 2 }) {
        Text('Subtotal')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        Text(this.subtotal)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Button(this.actionLabel)
        .height(44)
        .width(140)
        .backgroundColor(Colors.secondary)
        .fontColor(Colors.onSecondary)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .borderRadius(12)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    .backgroundColor(Colors.surface)
    .shadow({ radius: 6, color: '#28000000', offsetX: 0, offsetY: -2 })
  }
}

@Entry
@Component
struct Index {
  private products: ProductUi[] = buildProducts();
  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy'];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Shop')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Colors.surface)
      .shadow({ radius: 2, color: '#14000000', offsetX: 0, offsetY: 1 })

      // Main content
      Column({ space: 0 }) {
        // Category row
        CategoryRow({ categories: this.categories, selected: 'All' })
          .margin({ bottom: 6 })

        // Filter row
        FilterRow()
          .margin({ bottom: 8 })

        // Product grid
        Grid() {
          ForEach(this.products, (p: ProductUi) => {
            GridItem() {
              ProductCard({ product: p })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(8)
        .rowsGap(8)
        .layoutWeight(1)
        .padding({ bottom: 16 })
      }
      .layoutWeight(1)
      .padding({ left: 8, right: 8, top: 6 })
      .backgroundColor(Colors.background)

      // Bottom action bar
      BottomActionBar({ subtotal: '$129.96', actionLabel: 'Checkout' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}