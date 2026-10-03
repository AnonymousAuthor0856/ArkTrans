const Colors = {
  primary: '#D7BBA8',
  secondary: '#A2C4C9',
  tertiary: '#B3C9A2',
  background: '#F0EBE3',
  surface: '#FFFFFF',
  surfaceVariant: '#E6E0D9',
  outline: '#DCD7CF',
  success: '#7EA87E',
  warning: '#D9B872',
  error: '#D98B8B',
  onPrimary: '#433E3A',
  onSecondary: '#433E3A',
  onTertiary: '#433E3A',
  onBackground: '#433E3A',
  onSurface: '#433E3A'
}

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24
}

interface Filter {
  id: string
  name: string
}

interface FilterItem {
  id: number
  name: string
  author: string
  price: string
  color: string
}

@Entry
@Component
struct Index {
  @State selectedFilter: string = 'vintage'
  @State filters: Filter[] = [
    { id: 'vintage', name: 'Vintage' },
    { id: 'grain', name: 'Grain' },
    { id: 'b&w', name: 'B&W' },
    { id: 'neon', name: 'Neon' }
  ]
  @State items: FilterItem[] = [
    { id: 1, name: 'Redscale', author: 'by UserA', price: '$4.99', color: Colors.error },
    { id: 2, name: 'Sepia Tone', author: 'by UserB', price: '$2.99', color: Colors.primary },
    { id: 3, name: 'Aqua', author: 'by UserC', price: '$4.99', color: Colors.secondary },
    { id: 4, name: 'Forest', author: 'by UserD', price: '$3.99', color: Colors.tertiary },
    { id: 5, name: 'Golden Hour', author: 'by UserE', price: '$5.99', color: Colors.warning },
    { id: 6, name: 'Monochrome', author: 'by UserF', price: '$1.99', color: Colors.outline }
  ]

  build() {
    Column() {
      Column({ space: Spacing.md }) {
        Text('Filter Shop')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground)

        Row({ space: Spacing.sm }) {
          ForEach(this.filters, (filter: Filter) => {
            Button(filter.name, { type: ButtonType.Normal })
              .backgroundColor(this.selectedFilter == filter.id ? Colors.primary : Colors.surface)
              .fontColor(this.selectedFilter == filter.id ? Colors.onPrimary : Colors.onBackground)
              .fontSize(12)
              .borderRadius(24)
              .border({ width: 2, color: this.selectedFilter == filter.id ? Colors.onBackground : Colors.outline })
              .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.sm, bottom: Spacing.sm })
              .onClick(() => { this.selectedFilter = filter.id })
          }, (filter: Filter) => filter.id)
        }
        .width('100%')
      }
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })

      Grid() {
        ForEach(this.items, (item: FilterItem) => {
          GridItem() {
            Column() {
              Stack()
                .width('100%')
                .aspectRatio(1)
                .borderRadius(16)
                .backgroundColor(item.color)

              Column({ space: Spacing.sm }) {
                Text(item.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Colors.onSurface)

                Text(item.author)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                  .opacity(0.6)

                Text(item.price)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Colors.primary)
              }
              .width('100%')
              .padding(Spacing.sm)
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .padding(Spacing.sm)
            .backgroundColor(Colors.surface)
            .borderRadius(24)
            .shadow({ radius: 8, color: '#14000000', offsetY: 2 })
          }
        }, (item: FilterItem) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(Spacing.md)
      .rowsGap(Spacing.md)
      .width('100%')
      .layoutWeight(1)
      .padding(Spacing.lg)

      Row() {
        Text('3 items in cart')
          .fontSize(14)
          .fontColor(Colors.onSurface)

        Button('Checkout', { type: ButtonType.Normal })
          .backgroundColor(Colors.primary)
          .fontColor(Colors.onPrimary)
          .fontSize(16)
          .borderRadius(24)
          .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.sm, bottom: Spacing.sm })
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
      .backgroundColor(Colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .shadow({ radius: 12, color: '#14000000', offsetY: 4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
