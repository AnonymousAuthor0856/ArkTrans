@Entry
@Component
struct Index {
  @State selectedFilter: string = 'Pending'

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Header
        Column() {
          Text('Approval Flow')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1C1B1F')
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .padding({ top: 48, bottom: 24 })

        // Filter Tabs
        Scroll() {
          Row({ space: 12 }) {
            ForEach(['Pending', 'Approved'], (item: string) => {
              Button() {
                Text(item)
                  .fontSize(this.selectedFilter === item ? 16 : 14)
                  .fontWeight(this.selectedFilter === item ? FontWeight.Medium : FontWeight.Normal)
                  .fontColor(this.selectedFilter === item ? '#FFFFFF' : '#49454F')
              }
              .type(ButtonType.Normal)
              .backgroundColor(this.selectedFilter === item ? '#1C1B1F' : '#FFFFFF')
              .borderWidth(1)
              .borderColor('#E0E0E0')
              .borderRadius(8)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .onClick(() => {
                this.selectedFilter = item
              })
            })
          }
        }
        .width('100%')
        .height(44)
        .scrollable(ScrollDirection.Horizontal)
        .padding({ left: 24, right: 24 })

        // Main Content Area
        Column() {
          // Grid Background
          Column() {
            // Vertical lines
            Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
              ForEach([0, 1, 2, 3, 4], () => {
                Column().width(1).height('100%').backgroundColor('#E0E0E0')
              })
            }
            .width('100%')
            .height('100%')

            // Horizontal lines
            Column({ space: 1 }) {
              ForEach([0, 1, 2, 3, 4, 5, 6], () => {
                Row().width('100%').height(1).backgroundColor('#E0E0E0')
              })
            }
            .position({ x: 0, y: 0 })
            .width('100%')
            .height('100%')
          }
          .width('100%')
          .aspectRatio(0.75)
          .borderRadius(24)
          .backgroundColor('#FFFFFF')
          .shadow({ radius: 10, color: '#0000001A', offsetY: 4 })

          // Floating Label 1
          Row() {
            Circle().width(24).height(24).fill('#BC8A00')
            Text('Purchase Order #1042')
              .fontSize(14)
              .fontColor('#1C1B1F')
              .backgroundColor('#FFFFFF')
              .padding({ left: 12, right: 12, top: 8, bottom: 8 })
              .borderRadius(8)
              .shadow({ radius: 8, color: '#0000001A', offsetX: 0, offsetY: 2 })
          }
          .alignItems(VerticalAlign.Center)
          .position({ x: '50%', y: '70%' })
          .translate({ x: -60, y: -12 })

          // Floating Label 2
          Row() {
            Circle().width(24).height(24).fill('#BA1A1A')
            Text('Budget Change #09')
              .fontSize(14)
              .fontColor('#1C1B1F')
              .backgroundColor('#FFFFFF')
              .padding({ left: 12, right: 12, top: 8, bottom: 8 })
              .borderRadius(8)
              .shadow({ radius: 8, color: '#0000001A', offsetX: 0, offsetY: 2 })
          }
          .alignItems(VerticalAlign.Center)
          .position({ x: '60%', y: '95%' })
          .translate({ x: -60, y: -12 })
        }
        .layoutWeight(1)
        .padding({ left: 24, right: 24, top: 24 })

        Blank()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')

      // Bottom Action Bar
      Column() {
        Row() {
          Button('Reject')
            .type(ButtonType.Normal)
            .backgroundColor('#F5F5F5')
            .fontColor('#757575')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .borderRadius(12)
            .height(56)
            .layoutWeight(1)
            .margin({ right: 12 })

          Button('Approve')
            .type(ButtonType.Normal)
            .backgroundColor('#757575')
            .fontColor('#FFFFFF')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .borderRadius(12)
            .height(56)
            .layoutWeight(1)
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 24 })
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .align(Alignment.End)
    }
    .width('100%')
    .height('100%')
  }
}