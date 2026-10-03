// src/main/ets/view/MainPage.ets

@Entry
@Component
struct MainPage {
  @State selectedCategory: string = "All"
  @State filters: string[] = ["In Stock"]
  @State products: ProductUi[] = []

  aboutToAppear() {
    this.products = [
      new ProductUi(1, "Product 1", "$14.99", "NEW", "4.0", "#E0E7FF"),
      new ProductUi(2, "Product 2", "$35.99", "", "4.9", "#D1FAE5"),
      new ProductUi(3, "Product 3", "$22.50", "SALE", "4.5", "#EDE9FE"),
      new ProductUi(4, "Product 4", "$18.00", "", "4.2", "#FDE68A")
    ]
  }

  build() {
    Column() {
      // Header
      Row() {
        Text("Shop")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)

      // Category Chips (Horizontal Scroll)
      Scroll() {
        Row({ space: 8 }) {
          ForEach(["All", "Snacks", "Drinks", "Fruits", "Bakery"], (item: string) => {
            ChipButton({
              label: item,
              isSelected: this.selectedCategory === item,
              onSelect: () => {
                this.selectedCategory = item
              },
              activeBg: '#6750A4',
              inactiveBg: '#FFFFFF'
            })
          })
        }
        .padding({ left: 16, right: 16 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .height(50)

      // Filter Chips
      Row({ space: 8 }) {
        ForEach(["In Stock", "Under $20", "Rating 4+"], (item: string) => {
          ChipButton({
            label: item,
            isSelected: this.filters.includes(item),
            onSelect: () => {
              if (this.filters.includes(item)) {
                const index = this.filters.indexOf(item)
                this.filters.splice(index, 1)
              } else {
                this.filters.push(item)
              }
            },
            activeBg: '#6CC24A',
            inactiveBg: '#FFFFFF'
          })
        })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })

      // Product Grid
      GridContainer() {
        ForEach(this.products, (product: ProductUi) => {
          GridItem() {
            ProductCard({ product: product })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .rowsGap(12)
      .columnsGap(12)
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, bottom: 80 }) // Bottom padding for fixed bar

      // Bottom Action Bar
      BottomActionBar({ subtotal: "$129.96", actionLabel: "Checkout" })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F6F7FB')
  }
}

// --- Components ---

@Component
struct ChipButton {
  @Prop label: string
  @Prop isSelected: boolean
  @Prop activeBg: string
  @Prop inactiveBg: string
  @Prop onSelect?: () => void

  build() {
    Button() {
      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? '#FFFFFF' : '#0F172A')
    }
    .backgroundColor(this.isSelected ? this.activeBg : this.inactiveBg)
    .borderWidth(1)
    .borderColor('#D0D5DD')
    .borderRadius(8)
    .height(36)
    .onClick(() => {
      if (this.onSelect) {
        this.onSelect()
      }
    })
  }
}

@Component
struct ProductCard {
  @Prop product: ProductUi

  build() {
    Column() {
      // Image Placeholder
      Column() {
        Text("Image")
          .fontSize(12)
          .fontColor('#0F172A')
      }
      .width('100%')
      .aspectRatio(1.2)
      .backgroundColor(this.product.color)
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)

      Column({ space: 6 }) {
        // Title & Badge
        Row() {
          Text(this.product.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0F172A')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          
          Blank()

          if (this.product.badge !== "") {
            Text(this.product.badge)
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1F1400')
              .backgroundColor('#FFB300')
              .padding({ left: 4, right: 4, top: 2, bottom: 2 })
              .borderRadius(4)
          }
        }
        .width('100%')

        // Price
        Text(this.product.price)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#6750A4')

        // Rating
        Row({ space: 4 }) {
          Circle({ width: 10, height: 10 })
            .fill('#F59E0B')
          Text(`${this.product.rating} rating`)
            .fontSize(12)
            .fontColor('#0F172A')
        }

        // Add to Cart Button
        Button() {
          Text("Add to Cart")
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .width('100%')
        .height(40)
        .backgroundColor('#6750A4')
        .borderRadius(8)
        .margin({ top: 4 })
      }
      .width('100%')
      .padding(12)
    }
    .width('100%')
    .backgroundColor('#FCFCFF')
    .borderRadius(12)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
    .border({ width: 1, color: '#D0D5DD' })
  }
}

@Component
struct BottomActionBar {
  @Prop subtotal: string
  @Prop actionLabel: string

  build() {
    Row() {
      Column({ space: 2 }) {
        Text("Subtotal")
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0F172A')
        Text(this.subtotal)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
      }
      
      Button() {
        Text(this.actionLabel)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0A0F0A')
      }
      .width(140)
      .height(44)
      .backgroundColor('#6CC24A')
      .borderRadius(12)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor('#FCFCFF')
    .position({ x: 0, y: 0 }) // Relative positioning handled by parent stack or absolute
    .alignRules({
      bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
      left: { anchor: '__container__', align: HorizontalAlign.Start }
    })
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