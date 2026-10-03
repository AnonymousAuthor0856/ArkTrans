// 001_EcommerceList_en.ets

// --- Design Tokens ---
class AppTokens {
  static readonly Colors = {
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
    error: '#D92D20'
  }
  static readonly Spacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  }
}

// --- Data Models ---
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

// --- Main Entry ---
@Entry
@Component
struct RootScreen {
  @State selectedCategory: string = 'All';
  @State filters: string[] = ['In Stock'];
  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy'];
  private products: ProductUi[] = [
    new ProductUi(0, 'Product 1', '$19.99', 'NEW', '4.5', '#E0E7FF'),
    new ProductUi(1, 'Product 2', '$29.99', '', '4.8', '#D1FAE5'),
    new ProductUi(2, 'Product 3', '$15.99', 'SALE', '4.2', '#FFEDD5'),
    new ProductUi(3, 'Product 4', '$39.99', '', '4.9', '#FDE68A'),
    new ProductUi(4, 'Product 5', '$12.99', 'NEW', '4.1', '#EDE9FE'),
    new ProductUi(5, 'Product 6', '$25.99', '', '4.7', '#FFE4E6'),
    new ProductUi(6, 'Product 7', '$34.99', '', '4.6', '#E2E8F0'),
    new ProductUi(7, 'Product 8', '$18.99', 'SALE', '4.3', '#FFFBEB')
  ];

  toggleFilter(label: string) {
    const index = this.filters.indexOf(label);
    if (index >= 0) {
      this.filters.splice(index, 1);
    } else {
      this.filters.push(label);
    }
  }

  build() {
    Column() {
      // Top App Bar
      Text('Shop')
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding(16)

      // Content Area
      Scroll() {
        Column() {
          // Category Row
          Row({ space: AppTokens.Spacing.sm }) {
            ForEach(this.categories, (label: string) => {
              Text(label)
                .fontSize(14)
                .fontWeight(this.selectedCategory === label ? FontWeight.Medium : FontWeight.Normal)
                .fontColor(this.selectedCategory === label ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                .backgroundColor(this.selectedCategory === label ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                .borderRadius(8)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                .onClick(() => { this.selectedCategory = label; })
            })
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })

          // Filter Row
          Row({ space: AppTokens.Spacing.sm }) {
            this.buildFilterChip('In Stock')
            this.buildFilterChip('Under $20')
            this.buildFilterChip('Rating 4+')
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })

          // Product Grid
          Grid() {
            ForEach(this.products, (p: ProductUi) => {
              GridItem() {
                this.ProductCard(p)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppTokens.Spacing.lg)
          .rowsGap(AppTokens.Spacing.lg)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.xxxl })
          .width('100%')
        }
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)

      // Bottom Action Bar
      this.BottomActionBar('$129.96', 'Checkout')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  buildFilterChip(label: string) {
    Text(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.filters.includes(label) ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .backgroundColor(this.filters.includes(label) ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
      .borderRadius(4)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      .onClick(() => { this.toggleFilter(label); })
  }

  @Builder
  ProductCard(p: ProductUi) {
    Column() {
      // Image Placeholder
      Stack() {
        Text('Image')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .aspectRatio(1.2)
      .backgroundColor(p.color)
      .borderRadius(8)

      // Title & Badge
      Row() {
        Text(p.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)

        if (p.badge.length > 0) {
          Text(p.badge)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onTertiary)
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(4)
            .padding({ left: 4, right: 4, top: 2, bottom: 2 })
            .margin({ left: 8 })
        }
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.md })

      // Price
      Text(p.price)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.primary)
        .margin({ top: AppTokens.Spacing.md })

      // Rating
      Row() {
        Stack() {
          Text('')
        }
        .width(10)
        .height(10)
        .backgroundColor(AppTokens.Colors.warning)
        .borderRadius(2)

        Text(`${p.rating} rating`)
          .fontSize(12)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ left: AppTokens.Spacing.sm })
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.md })

      // Add to Cart Button
      Button('Add to Cart')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(8)
        .width('100%')
        .height(40)
        .margin({ top: AppTokens.Spacing.md })
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetX: 0, offsetY: 1 })
  }

  @Builder
  BottomActionBar(subtotal: string, actionLabel: string) {
    Row() {
      Column() {
        Text('Subtotal')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Text(subtotal)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Button(actionLabel)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSecondary)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(12)
        .height(44)
        .width(140)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetX: 0, offsetY: -1 })
  }
}