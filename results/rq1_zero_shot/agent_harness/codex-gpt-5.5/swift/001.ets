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

@Entry
@Component
struct ContentView {
  @State private selectedCategory: string = 'All';
  @State private selectedFilters: string[] = ['In Stock'];

  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy'];
  private filterOptions: string[] = ['In Stock', 'Under $20', 'Rating 4+'];
  private products: ProductUi[] = [
    new ProductUi(0, 'Product 1', '$14.99', '', '4.0', '#E0E7FF'),
    new ProductUi(1, 'Product 2', '$35.99', 'NEW', '4.9', '#D1FAE5'),
    new ProductUi(2, 'Product 3', '$12.00', '', '4.5', '#FFEDD5'),
    new ProductUi(3, 'Product 4', '$29.00', '', '4.8', '#FDE68A')
  ];

  private hasFilter(filter: string): boolean {
    return this.selectedFilters.indexOf(filter) >= 0;
  }

  private toggleFilter(filter: string): void {
    if (this.hasFilter(filter)) {
      this.selectedFilters = this.selectedFilters.filter((item: string) => item !== filter);
    } else {
      this.selectedFilters = [...this.selectedFilters, filter];
    }
  }

  @Builder
  CategoryRow() {
    Scroll() {
      Row() {
        ForEach(this.categories, (item: string) => {
          Button(item)
            .fontSize(12)
            .fontColor(this.selectedCategory === item ? '#FFFFFF' : '#111827')
            .backgroundColor(this.selectedCategory === item ? '#6750A4' : '#FCFCFF')
            .border({ width: 1, color: '#D0D5DD', radius: 8 })
            .borderRadius(8)
            .padding({ left: 12, right: 12 })
            .height(34)
            .margin({ right: 4 })
            .onClick(() => {
              this.selectedCategory = item;
            })
        }, (item: string) => item)
      }
      .padding({ top: 4, bottom: 4 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .height(50)
  }

  @Builder
  FilterRow() {
    Scroll() {
      Row() {
        ForEach(this.filterOptions, (filter: string) => {
          Button(filter)
            .fontSize(10)
            .fontColor(this.hasFilter(filter) ? '#0A0F0A' : '#111827')
            .backgroundColor(this.hasFilter(filter) ? '#6CC24A' : '#FCFCFF')
            .border({ width: 1, color: '#D0D5DD', radius: 4 })
            .borderRadius(4)
            .padding({ left: 12, right: 12 })
            .height(28)
            .margin({ right: 4 })
            .onClick(() => {
              this.toggleFilter(filter);
            })
        }, (filter: string) => filter)
      }
      .padding({ top: 2, bottom: 2 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .height(40)
  }

  @Builder
  ProductCard(product: ProductUi) {
    Column() {
      Stack() {
        Rect()
          .width('100%')
          .height('100%')
          .fill(product.color)
          .radius(8)
        Text('Image')
          .fontSize(10)
          .fontColor('#666B76')
      }
      .width('100%')
      .aspectRatio(1)

      Row() {
        Text(product.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111827')
          .layoutWeight(1)
        if (product.badge !== '') {
          Text(product.badge)
            .fontSize(10)
            .fontColor('#1F1400')
            .backgroundColor('#FFB300')
            .borderRadius(4)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)
      .margin({ top: 8 })

      Text(product.price)
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#6750A4')
        .width('100%')
        .margin({ top: 8 })

      Row() {
        Circle()
          .width(8)
          .height(8)
          .fill('#F59E0B')
        Text(product.rating + ' rating')
          .fontSize(12)
          .fontColor('#666B76')
          .margin({ left: 4 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: 8 })

      Button('Add to Cart')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#6750A4')
        .width('100%')
        .height(36)
        .borderRadius(8)
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(8)
    .backgroundColor('#FCFCFF')
    .border({ width: 1, color: '#D0D5DD', radius: 12 })
    .borderRadius(12)
  }

  @Builder
  ProductGrid() {
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
    .width('100%')
  }

  @Builder
  BottomActionBar() {
    Column() {
      Divider()
        .color('#D0D5DD')
        .height(1)
      Row() {
        Column() {
          Text('Subtotal')
            .fontSize(10)
            .fontColor('#667085')
          Text('$129.96')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#111827')
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Button('Checkout')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0A0F0A')
          .backgroundColor('#6CC24A')
          .width(120)
          .height(40)
          .borderRadius(12)
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 8, bottom: 8 })
      .backgroundColor('#FCFCFF')
    }
    .width('100%')
    .backgroundColor('#FCFCFF')
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Text('Shop')
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#111827')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 16, bottom: 16 })
          .backgroundColor('#F6F7FB')

        Scroll() {
          Column() {
            this.CategoryRow()
            this.FilterRow()
              .margin({ top: 24 })
            this.ProductGrid()
              .margin({ top: 24 })
          }
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 8, right: 8, bottom: 100 })
        }
        .layoutWeight(1)
        .backgroundColor('#F6F7FB')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F6F7FB')

      this.BottomActionBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F6F7FB')
  }
}
