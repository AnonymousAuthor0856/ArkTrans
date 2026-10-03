@Entry
@Component
struct Index {
  @State selectedSize: string = 'S'
  @State isFavorite: boolean = false

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === LazyColumn (List) ===
      List() {
        ListItem() { 
          Column() {
            Blank().height(16)
          }
        }

        ListItem() {
          // === Box (Image Placeholder) ===
          Stack({ alignContent: Alignment.Center }) {
            Image($r('app.media.startIcon'))
              .width(80)
              .height(80)
              .objectFit(ImageFit.Contain)
              .opacity(0.2)
          }
          .width('100%')
          .height(240)
          .backgroundColor('#F5F5F5')
          .borderRadius(32)
        }

        ListItem() { 
          Column() {
            Blank().height(24)
          }
        }

        ListItem() {
          Text('Caramel Macchiato')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }

        ListItem() { 
          Column() {
            Blank().height(8)
          }
        }

        ListItem() {
          Row({ space: 4 }) {
            // Star Icon
            Image($r('app.media.startIcon'))
              .width(20)
              .height(20)
              .fillColor('#FFC107')

            Text('4.8')
              .fontWeight(FontWeight.Bold)
              .fontSize(16)
              .fontColor(Color.Black)

            Text('(230 reviews)')
              .fontColor('#9E9E9E')
              .fontSize(14)
          }
          .alignItems(VerticalAlign.Center)
        }

        ListItem() { 
          Column() {
            Blank().height(24)
          }
        }

        ListItem() {
          Text('Description')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
        }

        ListItem() { 
          Column() {
            Blank().height(12)
          }
        }

        ListItem() {
          Text('A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffee.')
            .fontColor('#9E9E9E')
            .fontSize(15)
            .lineHeight(22)
            .maxLines(4)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }

        ListItem() { 
          Column() {
            Blank().height(24)
          }
        }

        ListItem() {
          Text('Size')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
        }

        ListItem() { 
          Column() {
            Blank().height(16)
          }
        }

        ListItem() {
          Row({ space: 0 }) {
            this.SizeOption('S')
            this.SizeOption('M')
            this.SizeOption('L')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }

        ListItem() { 
          Column() {
            Blank().height(100)
          }
        }
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 24, right: 24 })

      // === TopAppBar ===
      Row() {
        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor(Color.Black)
            .rotate({ angle: 90 })
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)

        Text('Details')
          .fontWeight(FontWeight.Bold)
          .fontSize(18)
          .fontColor(Color.Black)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)

        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor(this.isFavorite ? Color.Red : Color.Black)
            .onClick(() => {
              this.isFavorite = !this.isFavorite
            })
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
      }
      .width('100%')
      .height(56)
      .padding({ left: 24, right: 24 })
      .position({ x: 0, y: 0 })

      // === BottomBarAction ===
      Column() {
        Row({ space: 0 }) {
          Column({ space: 0 }) {
            Text('Price')
              .fontColor('#9E9E9E')
              .fontSize(14)
            
            Text('$ 4.50')
              .fontColor('#6F4E37')
              .fontWeight(FontWeight.Bold)
              .fontSize(24)
          }

          Button() {
            Text('Add to Cart')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
          }
          .width(200)
          .height(56)
          .backgroundColor('#6F4E37')
          .borderRadius(16)
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
        .padding(24)
        .width('100%')
      }
      .backgroundColor(Color.White)
      .shadow({ radius: 4, color: '#1A000000', offsetY: -2 })
      .width('100%')
      .position({ x: 0, y: 0 })
      .alignSelf(ItemAlign.Bottom)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  SizeOption(label: string) {
    Stack({ alignContent: Alignment.Center }) {
      Text(label)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedSize === label ? Color.White : '#6F4E37')
    }
    .width(100)
    .height(48)
    .borderRadius(12)
    .border({ width: 1, color: this.selectedSize === label ? '#6F4E37' : '#E0E0E0' })
    .backgroundColor(this.selectedSize === label ? '#6F4E37' : Color.White)
    .onClick(() => {
      this.selectedSize = label
    })
  }
}