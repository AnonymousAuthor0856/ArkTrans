@Entry
@Component
struct Index {
  @State selectedFilter: string = 'Vintage'

  // Mock data to match the screenshot content
  private filters: string[] = ['Vintage', 'Grain', 'B&W', 'Neon']
  
  interface Item {
    name: string;
    author: string;
    price: string;
    color: string;
  }

  private items: Item[] = [
    { name: 'Redscale', author: 'UserA', price: '$4.99', color: '#D88E8E' },
    { name: 'Sepia Tone', author: 'UserB', price: '$2.99', color: '#D3BCA8' },
    { name: 'Aqua', author: 'UserC', price: '$4.00', color: '#9BBEC8' },
    { name: 'Forest', author: 'UserD', price: '$3.00', color: '#A8C59F' }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      
      // === TopBarSection ===
      Column() {
        Text('Filter Shop')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor('#433E3A')
          .margin({ bottom: 12 })

        Row({ space: 8 }) {
          ForEach(this.filters, (filterName: string) => {
            Stack({ alignContent: Alignment.Center }) {
              Text(filterName)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedFilter === filterName ? '#FFFFFF' : '#433E3A')
            }
            .width('auto')
            .height(36)
            .justifyContent(FlexAlign.Center)
            .padding({ left: 16, right: 16 })
            .borderRadius(20)
            .backgroundColor(this.selectedFilter === filterName ? '#CBAFA0' : '#FFFFFF')
            .border({ width: 1, color: '#E0DCD5' })
            .onClick(() => {
              this.selectedFilter = filterName
            })
          })
        }
        .width('100%')
        .margin({ top: 12, bottom: 16 })
      }
      .width('100%')
      .padding({ left: 16, right: 16 })

      // === LazyVerticalGrid (Product List) ===
      Grid() {
        ForEach(this.items, (item: Item) => {
          GridItem() {
            Column() {
              // Image Placeholder
              Stack({ alignContent: Alignment.Center }) {
                // Using a solid color block as per skeleton logic for item.color
              }
              .width('100%')
              .aspectRatio(1)
              .borderRadius(24)
              .backgroundColor(item.color)

              Column({ space: 4 }) {
                Text(item.name)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#433E3A')
                
                Text(`by ${item.author}`)
                  .fontSize(14)
                  .fontColor('#8C8580')
                
                Blank().height(8)
                
                Text(item.price)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#D7BBA8')
              }
              .alignItems(HorizontalAlign.Start)
              .margin({ top: 12 })
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(12)
      .rowsGap(12)
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 16, bottom: 80 }) // Bottom padding to account for fixed bar

      // === BottomBarSection ===
      Column() {
        Row() {
          Text('3 items in cart')
            .fontSize(16)
            .fontColor('#433E3A')
          
          Blank()

          Button() {
            Row({ space: 8 }) {
              Stack({ alignContent: Alignment.Center }) {
                // Icon placeholder
              }
              .width(16)
              .height(16)
              .borderRadius(8)
              .backgroundColor('#8C7A6B') // Darker version of primary for icon bg

              Text('Checkout')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
            }
            .alignItems(VerticalAlign.Center)
          }
          .backgroundColor('#CBAFA0')
          .borderRadius(24)
          .height(48)
          .padding({ left: 24, right: 24 })
          .shadow({ radius: 8, color: '#1A000000', offsetY: 4 })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .backgroundColor('#FFFFFF')
      .position({ x: 0, y: '100%' }) // Position at bottom
      .translate({ y: -80 }) // Pull up to overlap slightly or sit exactly on bottom depending on desired effect. 
                              // Based on screenshot, it sits on top of the background but below grid items visually? 
                              // Actually, standard scaffold usually overlays. Let's use absolute positioning relative to parent stack.
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0EBE3')
  }
}