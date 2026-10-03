const NAME: string = '001_EcommerceList_en';
const UI_TYPE: string = 'E-commerce Product List with Filters';
const STYLE_THEME: string = 'Material-You vivid';
const LANG: string = 'en';
const BASELINE_SIZE: string = '1280x720';

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

class AppSpacing {
  static readonly xs: number = 2;
  static readonly sm: number = 4;
  static readonly md: number = 6;
  static readonly lg: number = 8;
  static readonly xl: number = 12;
  static readonly xxl: number = 16;
  static readonly xxxl: number = 24;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 2, 0.5, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(2, 4, 1, 0.14);
  static readonly level3: ShadowSpec = new ShadowSpec(3, 6, 1.5, 0.16);
  static readonly level4: ShadowSpec = new ShadowSpec(4, 8, 2, 0.18);
  static readonly level5: ShadowSpec = new ShadowSpec(5, 10, 2.5, 0.2);
}

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

function buildProducts(): ProductUi[] {
  const palette: string[] = ['#E0E7FF', '#D1FAE5', '#FFEDD5', '#FDE68A', '#EDE9FE', '#FFE4E6', '#E2E8F0', '#FFFBEB'];
  const products: ProductUi[] = [];
  for (let i = 0; i < 8; i++) {
    const badge: string = i % 3 === 0 ? 'NEW' : (i % 4 === 0 ? 'SALE' : '');
    const price: string = `$${9 + ((i * 7) % 41)}.99`;
    const rating: string = `${4 + (i % 2)}.${(i * 3) % 10}`;
    products.push(new ProductUi(i, `Product ${i + 1}`, price, badge, rating, palette[i % palette.length]));
  }
  return products;
}

@Entry
@Component
struct MainActivity {
  @State selected: string = 'All';
  @State filters: string[] = ['In Stock'];
  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy'];
  private products: ProductUi[] = buildProducts();

  toggleFilter(label: string): void {
    if (this.filters.includes(label)) {
      this.filters = this.filters.filter((item: string) => item !== label);
    } else {
      this.filters = [...this.filters, label];
    }
  }

  @Builder
  CategoryRow(): void {
    Row({ space: AppSpacing.sm }) {
      ForEach(this.categories, (label: string) => {
        Button(label)
          .fontSize(label === this.selected ? 14 : 12)
          .fontWeight(label === this.selected ? FontWeight.Medium : FontWeight.Normal)
          .fontColor(label === this.selected ? AppColors.onPrimary : AppColors.onSurface)
          .backgroundColor(label === this.selected ? AppColors.primary : AppColors.surface)
          .border({ width: 1, color: AppColors.outline })
          .borderRadius(8)
          .padding({ left: 10, right: 10, top: 6, bottom: 6 })
          .height(36)
          .onClick(() => {
            this.selected = label;
          });
      }, (label: string) => label)
    }
    .width('100%')
    .height(40)
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  FilterChip(label: string): void {
    Button(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.filters.includes(label) ? AppColors.onSecondary : AppColors.onSurface)
      .backgroundColor(this.filters.includes(label) ? AppColors.secondary : AppColors.surface)
      .border({ width: 1, color: AppColors.outline })
      .borderRadius(4)
      .padding({ left: 10, right: 10, top: 5, bottom: 5 })
      .height(32)
      .onClick(() => {
        this.toggleFilter(label);
      });
  }

  @Builder
  FilterRow(): void {
    Row({ space: AppSpacing.sm }) {
      this.FilterChip('In Stock');
      this.FilterChip('Under $20');
      this.FilterChip('Rating 4+');
    }
    .width('100%')
    .height(36)
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  ProductCard(product: ProductUi): void {
    Column({ space: AppSpacing.md }) {
      Stack() {
        Text('Image')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
      }
      .width('100%')
      .aspectRatio(1.2)
      .backgroundColor(product.color)
      .borderRadius(8)
      .alignContent(Alignment.Center);

      Row() {
        Text(product.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Blank();
        if (product.badge.length > 0) {
          Text(product.badge)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onTertiary)
            .backgroundColor(AppColors.tertiary)
            .borderRadius(4)
            .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs });
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Center);

      Text(product.price)
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.primary);

      Row({ space: AppSpacing.sm }) {
        Circle()
          .width(10)
          .height(10)
          .fill(AppColors.warning);
        Text(`${product.rating} rating`)
          .fontSize(12)
          .fontColor(AppColors.onSurface);
      }
      .alignItems(VerticalAlign.Center);

      Button('Add to Cart')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(8)
        .width('100%')
        .height(40);
    }
    .width('100%')
    .constraintSize({ minHeight: 200 })
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline })
    .borderRadius(12)
    .shadow({ radius: AppElevation.level2.radius, color: '#24000000', offsetY: AppElevation.level2.dy });
  }

  @Builder
  ProductGrid(): void {
    Grid() {
      ForEach(this.products, (product: ProductUi) => {
        GridItem() {
          this.ProductCard(product);
        }
      }, (product: ProductUi) => product.id.toString())
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(AppSpacing.lg)
    .rowsGap(AppSpacing.lg)
    .padding({ bottom: AppSpacing.xxl })
    .layoutWeight(1);
  }

  @Builder
  BottomActionBar(): void {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('Subtotal')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Text('$129.96')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface);
      }
      .alignItems(HorizontalAlign.Start);

      Blank();

      Button('Checkout')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(12)
        .width(140)
        .height(44);
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.surface)
    .shadow({ radius: AppElevation.level3.radius, color: '#29000000', offsetY: AppElevation.level3.dy })
    .alignItems(VerticalAlign.Center);
  }

  build() {
    Column() {
      Text('Shop')
        .fontSize(22)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .height(56)
        .textAlign(TextAlign.Center)
        .backgroundColor(AppColors.surface);

      Column({ space: AppSpacing.md }) {
        this.CategoryRow();
        this.FilterRow();
        this.ProductGrid();
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.lg });

      this.BottomActionBar();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
