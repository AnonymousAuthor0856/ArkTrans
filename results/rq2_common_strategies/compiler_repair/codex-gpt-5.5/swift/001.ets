class CategoryItem {
  label: string

  constructor(label: string) {
    this.label = label
  }
}

class ProductUi {
  id: number
  title: string
  price: string
  badge: string
  rating: string
  color: string

  constructor(id: number, title: string, price: string, badge: string, rating: string, color: string) {
    this.id = id
    this.title = title
    this.price = price
    this.badge = badge
    this.rating = rating
    this.color = color
  }
}

@Entry
@Component
struct Index {
  @State selectedCategory: string = 'All'
  @State inStock: boolean = true
  @State under20: boolean = false
  @State rating4: boolean = false

  private categories: CategoryItem[] = [
    new CategoryItem('All'),
    new CategoryItem('Snacks'),
    new CategoryItem('Drinks'),
    new CategoryItem('Fruits'),
    new CategoryItem('Bakery'),
    new CategoryItem('Dairy')
  ]

  private products: ProductUi[] = [
    new ProductUi(0, 'Product 1', '$14.99', '', '4.0', '#E0E7FF'),
    new ProductUi(1, 'Product 2', '$35.99', 'NEW', '4.9', '#D1FAE5'),
    new ProductUi(2, 'Product 3', '$12.00', '', '4.5', '#FFEDD5'),
    new ProductUi(3, 'Product 4', '$29.00', '', '4.8', '#FDE68A')
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Text('Shop')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 16, bottom: 16 })
          .backgroundColor('#F6F7FB')

        Scroll() {
          Column() {
            this.CategoryRow()
            this.FilterRow()
            this.ProductGrid()
          }
          .width('100%')
          .padding({ bottom: 100 })
        }
        .layoutWeight(1)
        .backgroundColor('#F6F7FB')
      }
      .width('100%')
      .height('100%')

      this.BottomActionBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F6F7FB')
  }

  @Builder
  CategoryRow() {
    Scroll() {
      Row() {
        ForEach(this.categories, (item: CategoryItem) => {
          Text(item.label)
            .fontSize(12)
            .fontColor(this.selectedCategory === item.label ? Color.White : '#111827')
            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
            .border({ width: 1, color: '#D1D5DB', radius: 8 })
            .backgroundColor(this.selectedCategory === item.label ? '#6750A4' : '#FCFCFF')
            .margin({ right: 4 })
            .onClick(() => {
              this.selectedCategory = item.label
            })
        })
      }
      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
    }
    .width('100%')
    .height(50)
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .margin({ top: 24 })
  }

  @Builder
  FilterRow() {
    Scroll() {
      Row() {
        this.FilterChip('In Stock', this.inStock)
        this.FilterChip('Under $20', this.under20)
        this.FilterChip('Rating 4+', this.rating4)
      }
      .padding({ left: 8, right: 8, top: 2, bottom: 2 })
    }
    .width('100%')
    .height(40)
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .margin({ top: 24 })
  }

  @Builder
  FilterChip(label: string, selected: boolean) {
    Text(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(selected ? '#0A0F0A' : '#111827')
      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      .border({ width: 1, color: '#D1D5DB', radius: 4 })
      .backgroundColor(selected ? '#6CC24A' : '#FCFCFF')
      .margin({ right: 4 })
      .onClick(() => {
        if (label === 'In Stock') {
          this.inStock = !this.inStock
        } else if (label === 'Under $20') {
          this.under20 = !this.under20
        } else {
          this.rating4 = !this.rating4
        }
      })
  }

  @Builder
  ProductGrid() {
    Grid() {
      ForEach(this.products, (product: ProductUi) => {
        GridItem() {
          this.ProductCard(product)
        }
      })
    }
    .columnsTemplate('1fr 1fr')
    .rowsGap(8)
    .columnsGap(8)
    .width('100%')
    .height(560)
    .padding({ left: 8, right: 8 })
    .margin({ top: 24 })
  }

  @Builder
  ProductCard(product: ProductUi) {
    Column() {
      Stack() {
        Rect()
          .width('100%')
          .height('100%')
          .radius(8)
          .fill(product.color)
        Text('Image')
          .fontSize(10)
          .fontColor('rgba(17,24,39,0.7)')
      }
      .width('100%')
      .aspectRatio(1)

      Row() {
        Text(product.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111827')
        if (product.badge !== '') {
          Text(product.badge)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1F1400')
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .borderRadius(4)
            .backgroundColor('#FFB300')
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)

      Text(product.price)
        .width('100%')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#6750A4')

      Row() {
        Circle()
          .width(8)
          .height(8)
          .fill('#F59E0B')
        Text(product.rating + ' rating')
          .fontSize(12)
          .fontColor('rgba(17,24,39,0.7)')
          .margin({ left: 4 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Button('Add to Cart')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.White)
        .width('100%')
        .height(36)
        .borderRadius(8)
        .backgroundColor('#6750A4')
        .padding(0)
    }
    .width('100%')
    .padding(8)
    .border({ width: 1, color: '#D1D5DB', radius: 12 })
    .backgroundColor('#FCFCFF')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  BottomActionBar() {
    Column() {
      Divider().color('#D1D5DB')
      Row() {
        Column() {
          Text('Subtotal')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('rgba(17,24,39,0.7)')
          Text('$129.96')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#111827')
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)

        Button('Checkout')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0A0F0A')
          .width(120)
          .height(40)
          .borderRadius(12)
          .backgroundColor('#6CC24A')
          .padding(0)
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 8, bottom: 8 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FCFCFF')
    }
    .width('100%')
    .backgroundColor('#FCFCFF')
  }
}
