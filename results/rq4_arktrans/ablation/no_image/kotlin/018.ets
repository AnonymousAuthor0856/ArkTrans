@Entry
@Component
struct Index {
  @State item: string = '0'
  @State selectedFilter: string = '0'
  @State filters: FilterItem[] = [
    { name: 'All', isSelected: true },
    { name: 'Fiction', isSelected: false },
    { name: 'Non-Fiction', isSelected: false }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === LazyVerticalGrid (Simulated with Grid) ===
      Grid() {
        // === FilterCard ===
        GridItem() {
          Column() {
            Column({ space: 0 }) {
              // === Box (Image Placeholder) ===
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.startIcon'))
                  .width('100%')
                  .height('100%')
                  .objectFit(ImageFit.Cover)
              }
              .width('100%')
              .aspectRatio(1)
              .borderRadius(8)
              .backgroundColor('#E0E0E0')

              // === Column (Details) ===
              Column({ space: 0 }) {
                // === Text (Name) ===
                Text(this.item)
                  .fontWeight(FontWeight.Bold)
                  .fontSize(16)
                  .fontColor('#433E3A')

                // === Text (Author) ===
                Text('item.author')
                  .fontSize(12)
                  .fontColor('#433E3A')

                // === Spacer ===
                Blank().height(16)

                // === Text (Price) ===
                Text('item.price')
                  .fontWeight(FontWeight.Bold)
                  .fontSize(16)
                  .fontColor('#D7BBA8')
              }
              .padding(12)
            }
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000' })
          .width('100%')
        }
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(12)
      .rowsGap(12)
      .padding(16)
      .width('100%')
      .layoutWeight(1)

      // === TopBarSection ===
      Column({ space: 0 }) {
        // === Text (Title) ===
        Text('Filter Shop')
          .fontSize(24)
          .fontColor('#433E3A')

        // === Spacer ===
        Blank().height(12)

        // === Row (Filters) ===
        Row({ space: 8 }) {
          ForEach(this.filters, (filter: FilterItem) => {
            Stack({ alignContent: Alignment.Center }) {
              Text(filter.name)
                .fontSize(14)
                .fontColor(filter.isSelected ? '#FFFFFF' : '#433E3A')
            }
            .backgroundColor(filter.isSelected ? '#6750A4' : '#FFFFFF')
            .borderWidth(1)
            .borderColor('#E0E0E0')
            .borderRadius(20)
            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
            .onClick(() => {
              this.selectedFilter = filter.name
            })
          })
        }
        .width('100%')
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor('#F0EBE3')

      // === BottomBarSection ===
      Column() {
        Row({ space: 0 }) {
          // === Text (Cart Info) ===
          Text('3 items in cart')
            .fontSize(14)
            .fontColor('#433E3A')

          Blank()

          // === Button (Checkout) ===
          Button() {
            Row({ space: 8 }) {
              // === Box (Icon Placeholder) ===
              Stack({ alignContent: Alignment.Center }) {
                Circle().width(16).height(16).fill('#FFFFFF').opacity(0.2)
              }
              .width(16)
              .height(16)
              .borderRadius(8)
              .backgroundColor('#FFFFFF')
              .opacity(0.2)

              // === Text (Label) ===
              Text('Checkout')
                .fontSize(16)
                .fontColor('#FFFFFF')
            }
            .alignItems(VerticalAlign.Center)
          }
          .backgroundColor('#6750A4')
          .borderRadius(20)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      }
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 4, color: '#1A000000' })
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0EBE3')
  }
}

interface FilterItem {
  name: string
  isSelected: boolean
}