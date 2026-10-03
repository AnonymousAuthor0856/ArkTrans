import { router } from '@kit.ArkUI';

interface ProductUi {
  id: number;
  title: string;
  price: string;
  badge: string;
  rating: string;
  color: string;
}

const PRIMARY_COLOR = '#FF6750A4';
const ON_PRIMARY_COLOR = '#FFFFFFFF';
const SECONDARY_COLOR = '#FF6CC24A';
const ON_SECONDARY_COLOR = '#FF0A0F0A';
const TERTIARY_COLOR = '#FFFFB300';
const ON_TERTIARY_COLOR = '#FF1F1400';
const BACKGROUND_COLOR = '#FFF6F7FB';
const ON_BACKGROUND_COLOR = '#FF0F172A';
const SURFACE_COLOR = '#FFFCFCFF';
const ON_SURFACE_COLOR = '#FF111827';
const SURFACE_VARIANT_COLOR = '#FFEEF0F6';
const OUTLINE_COLOR = '#FFD0D5DD';
const WARNING_COLOR = '#FFF59E0B';

const CATEGORIES: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy'];
const FILTER_LABELS: string[] = ['In Stock', 'Under $20', 'Rating 4+'];

const PALETTE: string[] = [
  '#FFE0E7FF',
  '#FFD1FAE5',
  '#FFFFEDD5',
  '#FFFDE68A',
  '#FFEDE9FE',
  '#FFFFE4E6',
  '#FFE2E8F0',
  '#FFFFFBEB'
];

const RATINGS: string[] = ['4.0', '4.3', '4.7', '4.1', '4.9', '4.5', '4.2', '4.8'];
const PRICES: string[] = ['$14.99', '$35.99', '$22.99', '$9.99', '$41.99', '$18.99', '$29.99', '$49.99'];

function makeProducts(): ProductUi[] {
  const result: ProductUi[] = [];
  for (let i = 0; i < 8; i++) {
    let badge = '';
    if (i % 3 === 0) {
      badge = 'NEW';
    } else if (i % 4 === 0) {
      badge = 'SALE';
    }
    const p: ProductUi = {
      id: i,
      title: `Product ${i + 1}`,
      price: PRICES[i % PRICES.length],
      badge: badge,
      rating: RATINGS[i % RATINGS.length],
      color: PALETTE[i % PALETTE.length]
    };
    result.push(p);
  }
  return result;
}

@Component
struct CategoryChip {
  label: string = '';
  active: boolean = false;
  onSelect: (label: string) => void = (_l: string) => {};

  build() {
    Text(this.label)
      .fontSize(this.active ? 14 : 12)
      .fontWeight(this.active ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(this.active ? ON_PRIMARY_COLOR : ON_SURFACE_COLOR)
      .backgroundColor(this.active ? PRIMARY_COLOR : SURFACE_COLOR)
      .borderRadius(8)
      .border({ width: 1, color: OUTLINE_COLOR })
      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      .onClick(() => {
        this.onSelect(this.label);
      })
  }
}

@Component
struct FilterChip {
  label: string = '';
  active: boolean = false;
  onToggle: (label: string) => void = (_l: string) => {};

  build() {
    Text(this.label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.active ? ON_SECONDARY_COLOR : ON_SURFACE_COLOR)
      .backgroundColor(this.active ? SECONDARY_COLOR : SURFACE_COLOR)
      .borderRadius(4)
      .border({ width: 1, color: OUTLINE_COLOR })
      .padding({ left: 10, right: 10, top: 5, bottom: 5 })
      .onClick(() => {
        this.onToggle(this.label);
      })
  }
}

@Component
struct ProductCard {
  product: ProductUi = {
    id: 0,
    title: '',
    price: '',
    badge: '',
    rating: '',
    color: '#FFE0E7FF'
  };

  build() {
    Column({ space: 6 }) {
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width('100%')
          .aspectRatio(1.2)
          .backgroundColor(this.product.color)
          .borderRadius(8)
        Text('Image')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_SURFACE_COLOR)
      }
      .width('100%')

      Row() {
        Text(this.product.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_SURFACE_COLOR)
          .layoutWeight(1)
        if (this.product.badge !== '') {
          Text(this.product.badge)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(ON_TERTIARY_COLOR)
            .backgroundColor(TERTIARY_COLOR)
            .borderRadius(4)
            .padding({ left: 4, right: 4, top: 2, bottom: 2 })
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Text(this.product.price)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(PRIMARY_COLOR)

      Row({ space: 4 }) {
        Column()
          .width(10)
          .height(10)
          .backgroundColor(WARNING_COLOR)
          .borderRadius(4)
        Text(`${this.product.rating} rating`)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor(ON_SURFACE_COLOR)
      }
      .alignItems(VerticalAlign.Center)

      Button('Add to Cart')
        .width('100%')
        .height(40)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(ON_PRIMARY_COLOR)
        .backgroundColor(PRIMARY_COLOR)
        .borderRadius(8)
    }
    .width('100%')
    .padding(8)
    .backgroundColor(SURFACE_COLOR)
    .borderRadius(12)
    .border({ width: 1, color: OUTLINE_COLOR })
    .shadow({ radius: 4, color: '#22000000', offsetX: 0, offsetY: 1 })
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct BottomActionBar {
  subtotal: string = '$129.96';
  actionLabel: string = 'Checkout';
  onAction: () => void = () => {};

  build() {
    Row() {
      Column({ space: 2 }) {
        Text('Subtotal')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_SURFACE_COLOR)
        Text(this.subtotal)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_SURFACE_COLOR)
      }
      .alignItems(HorizontalAlign.Start)

      Button(this.actionLabel)
        .height(44)
        .width(140)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(ON_SECONDARY_COLOR)
        .backgroundColor(SECONDARY_COLOR)
        .borderRadius(12)
        .onClick(() => {
          this.onAction();
        })
    }
    .width('100%')
    .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(SURFACE_COLOR)
    .shadow({ radius: 6, color: '#28000000', offsetX: 0, offsetY: -1 })
  }
}

@Entry
@Component
struct Index {
  @State selectedCategory: string = 'All';
  @State activeFilters: string[] = ['In Stock'];
  private products: ProductUi[] = makeProducts();

  isFilterActive(label: string): boolean {
    return this.activeFilters.indexOf(label) >= 0;
  }

  toggleFilter(label: string): void {
    const idx = this.activeFilters.indexOf(label);
    if (idx >= 0) {
      const next: string[] = [];
      for (let i = 0; i < this.activeFilters.length; i++) {
        if (i !== idx) {
          next.push(this.activeFilters[i]);
        }
      }
      this.activeFilters = next;
    } else {
      this.activeFilters = [...this.activeFilters, label];
    }
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Shop')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_SURFACE_COLOR)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(SURFACE_COLOR)

      // Scrollable content
      Scroll() {
        Column({ space: 0 }) {
          // Category Row
          Scroll() {
            Row({ space: 4 }) {
              ForEach(CATEGORIES, (cat: string) => {
                CategoryChip({
                  label: cat,
                  active: cat === this.selectedCategory,
                  onSelect: (l: string) => {
                    this.selectedCategory = l;
                  }
                })
              })
            }
            .padding({ left: 8, right: 8 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
          .padding({ top: 6, bottom: 6 })

          // Filter Row
          Row({ space: 4 }) {
            ForEach(FILTER_LABELS, (fl: string) => {
              FilterChip({
                label: fl,
                active: this.isFilterActive(fl),
                onToggle: (l: string) => {
                  this.toggleFilter(l);
                }
              })
            })
          }
          .width('100%')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })

          // Product Grid
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
          .padding({ left: 8, right: 8, top: 8, bottom: 24 })
          .width('100%')
          .layoutWeight(1)
        }
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(BACKGROUND_COLOR)

      // Bottom Action Bar
      BottomActionBar({
        subtotal: '$129.96',
        actionLabel: 'Checkout',
        onAction: () => {}
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_COLOR)
  }
}