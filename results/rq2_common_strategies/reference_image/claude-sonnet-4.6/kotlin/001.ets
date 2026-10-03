/**
 * Index.ets — ArkTS / ArkUI (HarmonyOS NEXT, API 12+)
 * 001_EcommerceList_en • E-commerce Product List with Filters • Material-You vivid
 * Baseline 1280x720 (360 x 640 vp portrait)
 */

/* ---------------- Design tokens ---------------- */

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
const C_WARNING: string = '#F59E0B';

const SP_XS: number = 2;
const SP_SM: number = 4;
const SP_MD: number = 6;
const SP_LG: number = 8;
const SP_XL: number = 12;
const SP_XXL: number = 16;
const SP_XXXL: number = 24;

const RADIUS_SM: number = 4;
const RADIUS_MD: number = 8;
const RADIUS_LG: number = 12;

const SHADOW_L2: ShadowOptions = { radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 };
const SHADOW_L3: ShadowOptions = { radius: 6, color: '#29000000', offsetX: 0, offsetY: -1.5 };

/* ---------------- Model ---------------- */

interface ProductUi {
  id: number;
  title: string;
  price: string;
  badge: string;
  rating: string;
  color: string;
}

const CATEGORIES: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy'];

const FILTER_LABELS: string[] = ['In Stock', 'Under $20', 'Rating 4+'];

const PRODUCTS: ProductUi[] = [
  { id: 0, title: 'Product 1', price: '$14.99', badge: 'NEW', rating: '4.0', color: '#E0E7FF' },
  { id: 1, title: 'Product 2', price: '$35.99', badge: '', rating: '4.9', color: '#D1FAE5' },
  { id: 2, title: 'Product 3', price: '$22.49', badge: '', rating: '4.3', color: '#FFEDD5' },
  { id: 3, title: 'Product 4', price: '$9.99', badge: 'NEW', rating: '4.7', color: '#FDE68A' },
  { id: 4, title: 'Product 5', price: '$41.99', badge: 'SALE', rating: '4.2', color: '#EDE9FE' },
  { id: 5, title: 'Product 6', price: '$18.99', badge: '', rating: '4.8', color: '#FFE4E6' },
  { id: 6, title: 'Product 7', price: '$27.99', badge: 'NEW', rating: '4.1', color: '#E2E8F0' },
  { id: 7, title: 'Product 8', price: '$12.99', badge: '', rating: '4.6', color: '#FFFBEB' }
];

function buildRows(items: ProductUi[]): ProductUi[][] {
  const rows: ProductUi[][] = [];
  for (let i = 0; i < items.length; i += 2) {
    const pair: ProductUi[] = [];
    pair.push(items[i]);
    if (i + 1 < items.length) {
      pair.push(items[i + 1]);
    }
    rows.push(pair);
  }
  return rows;
}

/* ---------------- Screen ---------------- */

@Entry
@Component
struct EcommerceListPage {
  @State selectedCategory: string = 'All';
  @State activeFilters: string[] = ['In Stock'];

  private rows: ProductUi[][] = buildRows(PRODUCTS);

  private toggleFilter(label: string): void {
    const idx: number = this.activeFilters.indexOf(label);
    if (idx >= 0) {
      const next: string[] = this.activeFilters.slice();
      next.splice(idx, 1);
      this.activeFilters = next;
    } else {
      this.activeFilters = this.activeFilters.concat([label]);
    }
  }

  /* ------- pieces ------- */

  @Builder
  TopBar() {
    Row() {
      Text('Shop')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(C_ON_SURFACE)
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(C_BACKGROUND)
  }

  @Builder
  CategoryChip(label: string) {
    Text(label)
      .fontSize(this.selectedCategory === label ? 14 : 12)
      .fontWeight(this.selectedCategory === label ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(this.selectedCategory === label ? C_ON_PRIMARY : C_ON_SURFACE)
      .backgroundColor(this.selectedCategory === label ? C_PRIMARY : C_SURFACE)
      .borderRadius(RADIUS_MD)
      .border({ width: 1, color: C_OUTLINE })
      .padding({ left: SP_XL, right: SP_XL, top: SP_MD, bottom: SP_MD })
      .onClick(() => {
        this.selectedCategory = label;
      })
  }

  @Builder
  FilterChip(label: string) {
    Text(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.activeFilters.includes(label) ? C_ON_SECONDARY : C_ON_SURFACE)
      .backgroundColor(this.activeFilters.includes(label) ? C_SECONDARY : C_SURFACE)
      .borderRadius(RADIUS_SM)
      .border({ width: 1, color: C_OUTLINE })
      .padding({ left: SP_XL, right: SP_XL, top: SP_MD, bottom: SP_MD })
      .onClick(() => {
        this.toggleFilter(label);
      })
  }

  @Builder
  ProductCard(p: ProductUi) {
    Column({ space: SP_MD }) {
      /* product image placeholder */
      Column() {
        Text('Image')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)
      }
      .width('100%')
      .aspectRatio(1.2)
      .backgroundColor(p.color)
      .borderRadius(RADIUS_MD)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      /* title + badge */
      Row() {
        Text(p.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)
          .layoutWeight(1)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        if (p.badge.length > 0) {
          Text(p.badge)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(C_ON_TERTIARY)
            .backgroundColor(C_TERTIARY)
            .borderRadius(RADIUS_SM)
            .padding({ left: SP_SM, right: SP_SM, top: SP_XS, bottom: SP_XS })
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      /* price */
      Text(p.price)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(C_PRIMARY)

      /* rating */
      Row({ space: SP_SM }) {
        Column()
          .width(10)
          .height(10)
          .backgroundColor(C_WARNING)
          .borderRadius(5)

        Text(p.rating + ' rating')
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor(C_ON_SURFACE)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)

      /* CTA */
      Button('Add to Cart')
        .type(ButtonType.Normal)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(C_ON_PRIMARY)
        .backgroundColor(C_PRIMARY)
        .borderRadius(RADIUS_MD)
        .height(40)
        .width('100%')
    }
    .layoutWeight(1)
    .padding(SP_LG)
    .backgroundColor(C_SURFACE)
    .borderRadius(RADIUS_LG)
    .border({ width: 1, color: C_OUTLINE })
    .shadow(SHADOW_L2)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  ProductRow(row: ProductUi[]) {
    Row({ space: SP_LG }) {
      ForEach(row, (p: ProductUi) => {
        this.ProductCard(p)
      }, (p: ProductUi) => p.id.toString())

      if (row.length === 1) {
        Column().layoutWeight(1)
      }
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  BottomActionBar() {
    Row() {
      Column({ space: SP_XS }) {
        Text('Subtotal')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)

        Text('$129.96')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(C_ON_SURFACE)
      }
      .alignItems(HorizontalAlign.Start)

      Button('Checkout')
        .type(ButtonType.Normal)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(C_ON_SECONDARY)
        .backgroundColor(C_SECONDARY)
        .borderRadius(RADIUS_LG)
        .height(44)
        .width(140)
    }
    .width('100%')
    .padding({ left: SP_LG, right: SP_LG, top: SP_MD, bottom: SP_MD })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(C_SURFACE)
    .shadow(SHADOW_L3)
  }

  /* ------- screen ------- */

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: SP_LG }) {
          Scroll() {
            Row({ space: SP_SM }) {
              ForEach(CATEGORIES, (label: string) => {
                this.CategoryChip(label)
              }, (label: string) => label)
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Row({ space: SP_SM }) {
            ForEach(FILTER_LABELS, (label: string) => {
              this.FilterChip(label)
            }, (label: string) => label)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          ForEach(this.rows, (row: ProductUi[], index: number) => {
            this.ProductRow(row)
          }, (row: ProductUi[], index: number) => index.toString())

          Column().height(SP_XXXL)
        }
        .width('100%')
        .padding({ left: SP_LG, right: SP_LG, top: SP_MD, bottom: 0 })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      this.BottomActionBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(C_BACKGROUND)
  }
}