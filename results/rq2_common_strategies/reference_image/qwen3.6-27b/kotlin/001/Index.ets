// App.ets
import { router } from '@kit.ArkUI';

@Entry
@Component
struct MainView {
  @State selectedCategory: string = 'All'
  @State filters: string[] = ['In Stock']
  @State products: ProductUi[] = []
  
  aboutToAppear() {
    // Initialize products
    const palette = [
      '#E0E7FF', '#D1FAE5', '#FFEDD5', '#FDE68A', 
      '#EDE9FE', '#FFE4E6', '#E2E8F0', '#FFFBEB'
    ]
    
    for (let i = 0; i < 8; i++) {
      const price = Math.floor(Math.random() * 40) + 9
      const rating = `${Math.floor(Math.random() * 2) + 4}.${Math.floor(Math.random() * 10)}`
      let badge = ''
      if (i % 3 === 0) badge = 'NEW'
      else if (i % 4 === 0) badge = 'SALE'
      
      this.products.push({
        id: i,
        title: `Product ${i + 1}`,
        price: `$${price}.99`,
        badge: badge,
        rating: rating,
        color: palette[i % palette.length]
      })
    }
  }
  
  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Shop')
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#0F172A')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FCFCFF')
      
      // Category Row
      Scroll() {
        Row() {
          ForEach(['All', 'Snacks', 'Drinks', 'Fruits', 'Bakery', 'Dairy'], (item: string) => {
            CategoryChip(item, this.selectedCategory, (selected: string) => {
              this.selectedCategory = selected
            })
          })
        }
        .padding({ left: 16, right: 16 })
        .rowGap(4)
      }
      .width('100%')
      .height(40)
      .scrollable(ScrollDirection.Horizontal)
      .backgroundColor('#F6F7FB')
      
      // Filter Row
      Row() {
        FilterChip('In Stock', this.filters.includes('In Stock'), () => {
          this.toggleFilter('In Stock')
        })
        FilterChip('Under $20', this.filters.includes('Under $20'), () => {
          this.toggleFilter('Under $20')
        })
        FilterChip('Rating 4+', this.filters.includes('Rating 4+'), () => {
          this.toggleFilter('Rating 4+')
        })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 6, bottom: 6 })
      .rowGap(4)
      .backgroundColor('#F6F7FB')
      
      // Product Grid
      Scroll() {
        GridContainer() {
          ForEach(this.products, (product: ProductUi) => {
            GridItem() {
              ProductCard(product)
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(8)
        .columnsGap(8)
        .padding({ left: 16, right: 16, bottom: 24 })
      }
      .layoutWeight(1)
      .backgroundColor('#F6F7FB')
      
      // Bottom Action Bar
      BottomActionBar('$129.96', 'Checkout', () => {
        // Handle checkout
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F6F7FB')
  }
  
  private toggleFilter(filter: string): void {
    const index = this.filters.indexOf(filter)
    if (index > -1) {
      this.filters.splice(index, 1)
    } else {
      this.filters.push(filter)
    }
  }
}

interface ProductUi {
  id: number
  title: string
  price: string
  badge: string
  rating: string
  color: string
}

@Component
struct CategoryChip {
  @Prop label: string
  @Prop isSelected: boolean
  private onSelect: (string) => void
  
  build() {
    Button(this.label)
      .type(ButtonType.Normal)
      .backgroundColor(this.isSelected ? '#6750A4' : '#FCFCFF')
      .fontColor(this.isSelected ? '#FFFFFF' : '#111827')
      .fontSize(this.isSelected ? 14 : 12)
      .fontWeight(this.isSelected ? FontWeight.Medium : FontWeight.Normal)
      .borderRadius(8)
      .borderWidth(1)
      .borderColor('#D0D5DD')
      .margin({ right: 4 })
      .onClick(() => {
        this.onSelect(this.label)
      })
  }
}

@Component
struct FilterChip {
  @Prop label: string
  @Prop isActive: boolean
  private onToggle: () => void
  
  build() {
    Button(this.label)
      .type(ButtonType.Normal)
      .backgroundColor(this.isActive ? '#6CC24A' : '#FCFCFF')
      .fontColor(this.isActive ? '#0A0F0A' : '#111827')
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .borderRadius(4)
      .borderWidth(1)
      .borderColor('#D0D5DD')
      .margin({ right: 4 })
      .onClick(() => {
        this.onToggle()
      })
  }
}

@Component
struct ProductCard {
  @Prop product: ProductUi
  
  build() {
    Column() {
      // Image placeholder
      Row() {
        Text('Image')
          .fontSize(10)
          .fontColor('#111827')
      }
      .width('100%')
      .aspectRatio(1.2)
      .backgroundColor(this.product.color)
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)
      
      // Product info
      Column() {
        Row() {
          Text(this.product.title)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#111827')
          
          if (this.product.badge !== '') {
            Text(this.product.badge)
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1F1400')
              .backgroundColor('#FFB300')
              .borderRadius(4)
              .padding({ left: 4, right: 4, top: 2, bottom: 2 })
              .margin({ left: 8 })
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        
        Text(this.product.price)
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#6750A4')
          .margin({ top: 4 })
        
        Row() {
          Circle()
            .width(10)
            .height(10)
            .fill('#F59E0B')
          
          Text(`${this.product.rating} rating`)
            .fontSize(12)
            .fontColor('#111827')
            .margin({ left: 4 })
        }
        .margin({ top: 4 })
        
        Button('Add to Cart')
          .type(ButtonType.Normal)
          .backgroundColor('#6750A4')
          .fontColor('#FFFFFF')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(8)
          .height(40)
          .margin({ top: 8 })
      }
      .padding(8)
    }
    .width('100%')
    .backgroundColor('#FCFCFF')
    .borderRadius(12)
    .borderWidth(1)
    .borderColor('#D0D5DD')
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetY: 1 })
  }
}

@Component
struct BottomActionBar {
  @Prop subtotal: string
  @Prop actionLabel: string
  private onAction: () => void
  
  build() {
    Row() {
      Column() {
        Text('Subtotal')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111827')
        
        Text(this.subtotal)
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#111827')
      }
      
      Button(this.actionLabel)
        .type(ButtonType.Normal)
        .backgroundColor('#6CC24A')
        .fontColor('#0A0F0A')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .borderRadius(12)
        .height(44)
        .width(140)
        .onClick(() => {
          this.onAction()
        })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FCFCFF')
    .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetY: 1.5 })
  }
}