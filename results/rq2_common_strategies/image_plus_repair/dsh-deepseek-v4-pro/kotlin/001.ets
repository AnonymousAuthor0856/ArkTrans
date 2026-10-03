interface ProductUi {
  id: number;
  title: string;
  price: string;
  badge: string;
  rating: string;
  color: string;
}

class AppColors {
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
  static readonly error: string = '#D92D20';
}

function buildProducts(): ProductUi[] {
  const palette: string[] = ['#E0E7FF', '#D1FAE5', '#FFEDD5', '#FDE68A', '#EDE9FE', '#FFE4E6', '#E2E8F0', '#FFFBEB'];
  const result: ProductUi[] = [];
  for (let i = 0; i < 8; i++) {
    const priceVal: number = 9 + ((i * 7) % 41);
    const ratingMajor: number = 4 + (i % 2);
    const ratingMinor: number = (i * 3) % 10;
    let badge: string = '';
    if (i % 3 === 0) {
      badge = 'NEW';
    } else if (i % 4 === 0) {
      badge = 'SALE';
    }
    const p: ProductUi = {
      id: i,
      title: 'Product ' + (i + 1),
      price: '$' + priceVal + '.99',
      badge: badge,
      rating: ratingMajor + '.' + ratingMinor,
      color: palette[i % palette.length]
    };
    result.push(p);
  }
  return result;
}

@Entry
@Component
struct EcommerceList {
  @State selected: string = 'All';
  @State filters: string[] = ['In Stock'];
  @State products: ProductUi[] = [];
  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy'];
  private filterLabels: string[] = ['In Stock', 'Under $20', 'Rating 4+'];

  aboutToAppear(): void {
    this.products = buildProducts();
  }

  private hasFilter(label: string): boolean {
    return this.filters.indexOf(label) >= 0;
  }

  private toggleFilter(label: string): void {
    const idx: number = this.filters.indexOf(label);
    if (idx >= 0) {
      this.filters = this.filters.filter((f: string): boolean => f !== label);
    } else {
      this.filters = this.filters.concat([label]);
    }
  }

  @Builder
  CategoryChip(label: string) {
    Text(label)
      .fontSize(this.selected === label ? 14 : 12)
      .fontWeight(this.selected === label ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(this.selected === label ? AppColors.onPrimary : AppColors.onSurface)
      .backgroundColor(this.selected === label ? AppColors.primary : AppColors.surface)
      .borderRadius(8)
      .border({ width: 1, color: AppColors.outline })
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .onClick(() => {
        this.selected = label;
      })
  }

  @Builder
  FilterChip(label: string) {
    Text(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.hasFilter(label) ? AppColors.onSecondary : AppColors.onSurface)
      .backgroundColor(this.hasFilter(label) ? AppColors.secondary : AppColors.surface)
      .borderRadius(4)
      .border({ width: 1, color: AppColors.outline })
      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      .onClick(() => {
        this.toggleFilter(label);
      })
  }

  @Builder
  ProductCard(p: ProductUi) {
    Column({ space: 6 }) {
      Stack() {
        Text('Image')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .aspectRatio(1.2)
      .backgroundColor(p.color)
      .borderRadius(8)

      Row() {
        Text(p.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        if (p.badge !== '') {
          Text(p.badge)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onTertiary)
            .backgroundColor(AppColors.tertiary)
            .borderRadius(4)
            .padding({ left: 4, right: 4, top: 2, bottom: 2 })
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Text(p.price)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)

      Row() {
        Row()
          .width(10)
          .height(10)
          .backgroundColor(AppColors.warning)
          .borderRadius(4)
        Text(p.rating + ' rating')
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)
          .margin({ left: 4 })
      }
      .alignItems(VerticalAlign.Center)

      Button('Add to Cart')
        .width('100%')
        .height(40)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(8)
    }
    .width('100%')
    .constraintSize({ minHeight: 200 })
    .padding(8)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  BottomActionBar() {
    Row() {
      Column({ space: 2 }) {
        Text('Subtotal')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text('$129.96')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Button('Checkout')
        .height(44)
        .width(140)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(12)
    }
    .width('100%')
    .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 6, color: '#29000000', offsetX: 0, offsetY: 1.5 })
  }

  build() {
    Column() {
      Row() {
        Text('Shop')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.surface)

      Scroll() {
        Column() {
          Row({ space: 4 }) {
            ForEach(this.categories, (label: string) => {
              this.CategoryChip(label)
            }, (label: string) => label)
          }
          .width('100%')
          .constraintSize({ minHeight: 36 })
          .alignItems(VerticalAlign.Center)

          Row()
            .height(6)

          Row({ space: 4 }) {
            ForEach(this.filterLabels, (label: string) => {
              this.FilterChip(label)
            }, (label: string) => label)
          }
          .width('100%')
          .constraintSize({ minHeight: 32 })
          .alignItems(VerticalAlign.Center)

          Row()
            .height(8)

          Grid() {
            ForEach(this.products, (p: ProductUi) => {
              GridItem() {
                this.ProductCard(p)
              }
            }, (p: ProductUi) => p.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(8)
          .rowsGap(8)
          .width('100%')

          Row()
            .height(24)
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6 })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .width('100%')
      .align(Alignment.Top)
      .scrollBar(BarState.Auto)

      this.BottomActionBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
