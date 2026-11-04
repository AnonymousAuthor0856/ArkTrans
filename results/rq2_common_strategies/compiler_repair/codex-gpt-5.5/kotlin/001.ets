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

class AppColors {
  static primary: string = '#6750A4';
  static onPrimary: string = '#FFFFFF';
  static secondary: string = '#6CC24A';
  static onSecondary: string = '#0A0F0A';
  static tertiary: string = '#FFB300';
  static onTertiary: string = '#1F1400';
  static background: string = '#F6F7FB';
  static onBackground: string = '#0F172A';
  static surface: string = '#FCFCFF';
  static onSurface: string = '#111827';
  static surfaceVariant: string = '#EEF0F6';
  static outline: string = '#D0D5DD';
  static warning: string = '#F59E0B';
}

@Entry
@Component
struct Index {
  @State selectedCategory: string = 'All';
  @State stockSelected: boolean = true;
  @State underSelected: boolean = false;
  @State ratingSelected: boolean = false;

  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy'];
  private products: ProductUi[] = [
    new ProductUi(0, 'Product 1', '$12.99', 'NEW', '4.8', '#E0E7FF'),
    new ProductUi(1, 'Product 2', '$19.99', '', '4.3', '#D1FAE5'),
    new ProductUi(2, 'Product 3', '$24.99', '', '4.6', '#FFEDD5'),
    new ProductUi(3, 'Product 4', '$31.99', 'NEW', '5.0', '#FDE68A'),
    new ProductUi(4, 'Product 5', '$14.99', 'SALE', '4.1', '#EDE9FE'),
    new ProductUi(5, 'Product 6', '$39.99', '', '4.7', '#FFE4E6'),
    new ProductUi(6, 'Product 7', '$44.99', 'NEW', '4.4', '#E2E8F0'),
    new ProductUi(7, 'Product 8', '$9.99', '', '4.9', '#FFFBEB')
  ];

  @Builder
  CategoryChip(label: string) {
    Text(label)
      .fontSize(this.selectedCategory === label ? 14 : 12)
      .fontWeight(this.selectedCategory === label ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(this.selectedCategory === label ? AppColors.onPrimary : AppColors.onSurface)
      .lineHeight(this.selectedCategory === label ? 20 : 16)
      .padding({ left: 12, right: 12, top: 7, bottom: 7 })
      .backgroundColor(this.selectedCategory === label ? AppColors.primary : AppColors.surface)
      .border({ width: 1, color: AppColors.outline, radius: 8 })
      .onClick(() => {
        this.selectedCategory = label;
      })
  }

  @Builder
  FilterChip(label: string, active: boolean, action: () => void) {
    Text(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(active ? AppColors.onSecondary : AppColors.onSurface)
      .lineHeight(14)
      .padding({ left: 10, right: 10, top: 6, bottom: 6 })
      .backgroundColor(active ? AppColors.secondary : AppColors.surface)
      .border({ width: 1, color: AppColors.outline, radius: 4 })
      .onClick(action)
  }

  @Builder
  ProductCard(product: ProductUi) {
    Column({ space: 6 }) {
      Stack() {
        Text('Image')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .aspectRatio(1.2)
      .backgroundColor(product.color)
      .borderRadius(8)
      .alignContent(Alignment.Center)

      Row() {
        Text(product.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .lineHeight(20)
          .layoutWeight(1)

        if (product.badge.length > 0) {
          Text(product.badge)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onTertiary)
            .lineHeight(14)
            .padding({ left: 4, right: 4, top: 2, bottom: 2 })
            .backgroundColor(AppColors.tertiary)
            .borderRadius(4)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Text(product.price)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
        .lineHeight(24)

      Row() {
        Blank()
          .width(10)
          .height(10)
          .backgroundColor(AppColors.warning)
          .borderRadius(4)
        Text(product.rating + ' rating')
          .fontSize(12)
          .fontColor(AppColors.onSurface)
          .lineHeight(16)
          .margin({ left: 4 })
      }
      .alignItems(VerticalAlign.Center)

      Button('Add to Cart')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(8)
        .width('100%')
        .height(40)
    }
    .width('100%')
    .constraintSize({ minHeight: 200 })
    .padding(8)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline, radius: 12 })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })
  }

  build() {
    Column() {
      Text('Shop')
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .lineHeight(28)
        .width('100%')
        .height(56)
        .textAlign(TextAlign.Center)
        .backgroundColor(AppColors.surface)

      Column({ space: 8 }) {
        Row({ space: 4 }) {
          ForEach(this.categories, (category: string) => {
            this.CategoryChip(category)
          })
        }
        .width('100%')
        .height(36)
        .alignItems(VerticalAlign.Center)

        Row({ space: 4 }) {
          this.FilterChip('In Stock', this.stockSelected, () => {
            this.stockSelected = !this.stockSelected;
          })
          this.FilterChip('Under $20', this.underSelected, () => {
            this.underSelected = !this.underSelected;
          })
          this.FilterChip('Rating 4+', this.ratingSelected, () => {
            this.ratingSelected = !this.ratingSelected;
          })
        }
        .width('100%')
        .height(32)
        .alignItems(VerticalAlign.Center)

        Grid() {
          ForEach(this.products, (product: ProductUi) => {
            GridItem() {
              this.ProductCard(product)
            }
          }, (product: ProductUi) => product.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(8)
        .rowsGap(8)
        .layoutWeight(1)
        .width('100%')
      }
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .layoutWeight(1)
      .width('100%')

      Row() {
        Column({ space: 2 }) {
          Text('Subtotal')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .lineHeight(14)
          Text('$129.96')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .lineHeight(24)
        }
        Button('Checkout')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .backgroundColor(AppColors.secondary)
          .borderRadius(12)
          .width(140)
          .height(44)
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.surface)
      .shadow({ radius: 6, color: '#29000000', offsetX: 0, offsetY: -1 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
