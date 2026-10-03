interface ColorPalette {
  primary: string
  secondary: string
  tertiary: string
  background: string
  surface: string
  text: string
  outline: string
  warning: string
}

const COLORS: ColorPalette = {
  primary: '#6750A4',
  secondary: '#6CC24A',
  tertiary: '#FFB300',
  background: '#F6F7FB',
  surface: '#FCFCFF',
  text: '#111827',
  outline: '#D0D5DD',
  warning: '#F59E0B'
}

interface Product {
  title: string
  price: string
  badge: string
  rating: string
  imageColor: string
}

@Entry
@Component
struct ShopPage {
  @State selectedCategory: string = 'All'
  @State activeFilters: string[] = ['In Stock']

  private categories: string[] = ['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy']
  private products: Product[] = [
    { title: 'Product 1', price: '$14.99', badge: 'NEW', rating: '4.0', imageColor: '#E0E7FF' },
    { title: 'Product 2', price: '$35.99', badge: '', rating: '4.9', imageColor: '#D1FAE5' },
    { title: 'Product 3', price: '$24.99', badge: '', rating: '4.7', imageColor: '#FFEDD5' },
    { title: 'Product 4', price: '$19.99', badge: '', rating: '4.5', imageColor: '#FDE68A' },
    { title: 'Product 5', price: '$29.99', badge: 'SALE', rating: '4.8', imageColor: '#EDE9FE' },
    { title: 'Product 6', price: '$12.99', badge: 'NEW', rating: '4.2', imageColor: '#FFE4E6' },
    { title: 'Product 7', price: '$39.99', badge: '', rating: '4.6', imageColor: '#E2E8F0' },
    { title: 'Product 8', price: '$9.99', badge: '', rating: '4.1', imageColor: '#FFFBEB' }
  ]

  build() {
    Column() {
      this.header()
      Scroll() {
        Column() {
          this.categoryRow()
          this.filterRow()
          this.productGrid()
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      this.checkoutBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }

  @Builder
  header() {
    Row() {
      Text('Shop')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.text)
    }
    .width('100%')
    .height(96)
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#FCFCFF')
  }

  @Builder
  categoryRow() {
    Scroll() {
      Row({ space: 8 }) {
        ForEach(this.categories, (category: string) => {
          Button(category)
            .fontSize(18)
            .fontColor(this.selectedCategory === category ? '#FFFFFF' : COLORS.text)
            .fontWeight(this.selectedCategory === category ? FontWeight.Bold : FontWeight.Normal)
            .backgroundColor(this.selectedCategory === category ? COLORS.primary : COLORS.surface)
            .border({
              width: 1,
              color: COLORS.outline,
              radius: 14
            })
            .height(64)
            .padding({ left: 20, right: 20 })
            .onClick(() => {
              this.selectedCategory = category
            })
        }, (category: string) => category)
      }
    }
    .width('100%')
    .height(76)
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .align(Alignment.Center)
    .margin({ bottom: 12 })
  }

  @Builder
  filterRow() {
    Row({ space: 8 }) {
      this.filterButton('In Stock')
      this.filterButton('Under $20')
      this.filterButton('Rating 4+')
    }
    .width('100%')
    .height(52)
    .margin({ bottom: 16 })
  }

  @Builder
  filterButton(label: string) {
    Button(label)
      .fontSize(17)
      .fontColor(this.activeFilters.indexOf(label) >= 0 ? '#0A0F0A' : COLORS.text)
      .backgroundColor(this.activeFilters.indexOf(label) >= 0 ? COLORS.secondary : COLORS.surface)
      .border({
        width: 1,
        color: COLORS.outline,
        radius: 8
      })
      .height(48)
      .padding({ left: 20, right: 20 })
      .onClick(() => {
        const index: number = this.activeFilters.indexOf(label)
        if (index >= 0) {
          this.activeFilters.splice(index, 1)
        } else {
          this.activeFilters.push(label)
        }
      })
  }

  @Builder
  productGrid() {
    Grid() {
      ForEach(this.products, (product: Product) => {
        GridItem() {
          this.productCard(product)
        }
      }, (product: Product) => product.title)
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(16)
    .rowsGap(16)
    .width('100%')
  }

  @Builder
  productCard(product: Product) {
    Column() {
      Stack() {
        Text('Image')
          .fontSize(17)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.text)
      }
      .width('100%')
      .height(253)
      .backgroundColor(product.imageColor)
      .borderRadius(15)
      .alignContent(Alignment.Center)

      Row() {
        Text(product.title)
          .fontSize(27)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.text)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .layoutWeight(1)
        if (product.badge.length > 0) {
          Text(product.badge)
            .fontSize(16)
            .fontColor('#1F1400')
            .backgroundColor(COLORS.tertiary)
            .borderRadius(8)
            .padding({ left: 8, right: 8, top: 5, bottom: 5 })
        }
      }
      .width('100%')
      .margin({ top: 12 })
      .alignItems(VerticalAlign.Center)

      Text(product.price)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.primary)
        .width('100%')
        .margin({ top: 8 })

      Row() {
        Text('')
          .width(20)
          .height(20)
          .backgroundColor(COLORS.warning)
          .borderRadius(6)
        Text(`${product.rating} rating`)
          .fontSize(18)
          .fontColor(COLORS.text)
          .margin({ left: 8 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: 10 })

      Button('Add to Cart')
        .fontSize(21)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .backgroundColor(COLORS.primary)
        .borderRadius(16)
        .height(80)
        .width('100%')
        .margin({ top: 12 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(COLORS.surface)
    .border({
      width: 1,
      color: COLORS.outline,
      radius: 22
    })
    .shadow({
      radius: 5,
      color: '#26000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  @Builder
  checkoutBar() {
    Row() {
      Column() {
        Text('Subtotal')
          .fontSize(18)
          .fontColor(COLORS.text)
        Text('$129.96')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.text)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Button('Checkout')
        .fontSize(25)
        .fontColor('#000000')
        .backgroundColor(COLORS.secondary)
        .borderRadius(25)
        .height(88)
        .width(280)
    }
    .width('100%')
    .height(116)
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#F0F0FA')
    .shadow({
      radius: 8,
      color: '#22000000',
      offsetX: 0,
      offsetY: -2
    })
  }
}
