class AppTokens {
  static readonly Colors = {
    primary: '#FFD7BBA8',
    secondary: '#FFA2C4C9',
    tertiary: '#FFB3C9A2',
    background: '#FFF0EBE3',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE6E0D9',
    outline: '#FFDCD7CF',
    success: '#FF7EA87E',
    warning: '#FFD9B872',
    error: '#FFD98B8B',
    onPrimary: '#FF433E3A',
    onSecondary: '#FF433E3A',
    onTertiary: '#FF433E3A',
    onBackground: '#FF433E3A',
    onSurface: '#FF433E3A',
    onSurface60: '#99433E3A',
    onPrimary20: '#33433E3A'
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  }
}

class FilterItem {
  id: number
  name: string
  author: string
  price: string
  color: string

  constructor(id: number, name: string, author: string, price: string, color: string) {
    this.id = id
    this.name = name
    this.author = author
    this.price = price
    this.color = color
  }
}

@Component
struct FilterCard {
  @Prop name: string
  @Prop author: string
  @Prop price: string
  @Prop color: string

  build() {
    Column() {
      Row()
        .width('100%')
        .aspectRatio(1)
        .borderRadius(16)
        .backgroundColor(this.color)

      Column() {
        Text(this.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)

        Text(this.author)
          .fontSize(12)
          .fontColor(AppTokens.Colors.onSurface60)
          .margin({ top: 8 })

        Text(this.price)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Start)
      .padding(8)
    }
    .padding(8)
    .borderRadius(24)
    .backgroundColor(AppTokens.Colors.surface)
  }
}

@Entry
@Component
struct FilterShop {
  @State selectedFilter: string = 'vintage'

  private filterIds: string[] = ['vintage', 'grain', 'b&w', 'neon']
  private filterNames: string[] = ['Vintage', 'Grain', 'B&W', 'Neon']

  private items: FilterItem[] = [
    new FilterItem(1, 'Redscale', 'by UserA', '$4.99', AppTokens.Colors.error),
    new FilterItem(2, 'Sepia Tone', 'by UserB', '$2.99', AppTokens.Colors.primary),
    new FilterItem(3, 'Aqua', 'by UserC', '$4.99', AppTokens.Colors.secondary),
    new FilterItem(4, 'Forest', 'by UserD', '$3.99', AppTokens.Colors.tertiary),
    new FilterItem(5, 'Golden Hour', 'by UserE', '$5.99', AppTokens.Colors.warning),
    new FilterItem(6, 'Monochrome', 'by UserF', '$1.99', AppTokens.Colors.outline)
  ]

  build() {
    Column() {
      Column() {
        Text('Filter Shop')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)

        Row() {
          ForEach(this.filterNames, (name: string, index: number) => {
            Text(name)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.filterIds[index] === this.selectedFilter ? AppTokens.Colors.onPrimary : AppTokens.Colors.onBackground)
              .padding({ left: 12, right: 12, top: 8, bottom: 8 })
              .borderRadius(24)
              .backgroundColor(this.filterIds[index] === this.selectedFilter ? AppTokens.Colors.primary : AppTokens.Colors.surface)
              .border({ width: 2, color: this.filterIds[index] === this.selectedFilter ? '#1A433E3A' : AppTokens.Colors.outline })
              .onClick(() => {
                this.selectedFilter = this.filterIds[index]
              })
              .margin({ left: index === 0 ? 0 : 8 })
          })
        }
        .margin({ top: 12 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(AppTokens.Colors.background)

      Scroll() {
        Column() {
          Row() {
            FilterCard({ name: this.items[0].name, author: this.items[0].author, price: this.items[0].price, color: this.items[0].color })
              .layoutWeight(1)
              .margin({ right: 6 })
            FilterCard({ name: this.items[1].name, author: this.items[1].author, price: this.items[1].price, color: this.items[1].color })
              .layoutWeight(1)
              .margin({ left: 6 })
          }
          .width('100%')
          .margin({ bottom: 12 })

          Row() {
            FilterCard({ name: this.items[2].name, author: this.items[2].author, price: this.items[2].price, color: this.items[2].color })
              .layoutWeight(1)
              .margin({ right: 6 })
            FilterCard({ name: this.items[3].name, author: this.items[3].author, price: this.items[3].price, color: this.items[3].color })
              .layoutWeight(1)
              .margin({ left: 6 })
          }
          .width('100%')
          .margin({ bottom: 12 })

          Row() {
            FilterCard({ name: this.items[4].name, author: this.items[4].author, price: this.items[4].price, color: this.items[4].color })
              .layoutWeight(1)
              .margin({ right: 6 })
            FilterCard({ name: this.items[5].name, author: this.items[5].author, price: this.items[5].price, color: this.items[5].color })
              .layoutWeight(1)
              .margin({ left: 6 })
          }
          .width('100%')
        }
        .padding(16)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppTokens.Colors.background)

      Row() {
        Text('3 items in cart')
          .fontSize(14)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Button() {
          Row() {
            Row()
              .width(16)
              .height(16)
              .borderRadius(8)
              .backgroundColor(AppTokens.Colors.onPrimary20)
            Text('Checkout')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onPrimary)
              .margin({ left: 8 })
          }
        }
        .padding({ left: 24, right: 24, top: 8, bottom: 8 })
        .borderRadius(24)
        .backgroundColor(AppTokens.Colors.primary)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}