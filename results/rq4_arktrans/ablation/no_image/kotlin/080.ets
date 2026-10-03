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
          // === Box (Image Container) ===
          Stack({ alignContent: Alignment.Center }) {
            Image($r('app.media.startIcon'))
              .width(80)
              .height(80)
              .objectFit(ImageFit.Contain)
              .opacity(0.5) // Simulating tint #E0E0E0 on white bg roughly, or just use placeholder
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
          Row({ space: 0 }) {
            Image($r('app.media.startIcon'))
              .width(20)
              .height(20)
              .fillColor('#FFC107') // Tint
            
            Blank().width(4)
            
            Text('4.8')
              .fontWeight(FontWeight.Bold)
              .fontSize(16)
            
            Blank().width(4)
            
            Text('(230 reviews)')
              .fontColor(Color.Gray)
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
        }

        ListItem() { 
          Column() {
            Blank().height(12)
          }
        }

        ListItem() {
          Text('A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffee.')
            .fontColor(Color.Gray)
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
        }

        ListItem() { 
          Column() {
            Blank().height(16)
          }
        }

        ListItem() {
          Row({ space: 0 }) {
            this.SizeOption('S', this.selectedSize === 'S')
            this.SizeOption('M', this.selectedSize === 'M')
            this.SizeOption('L', this.selectedSize === 'L')
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
      .layoutWeight(1)
      .padding({ left: 24, right: 24 })

      // === CenterAlignedTopAppBar ===
      Row() {
        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          // Back action
        })

        Text('Details')
          .fontWeight(FontWeight.Bold)
          .fontSize(18)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor(this.isFavorite ? Color.Red : Color.Black)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          this.isFavorite = !this.isFavorite
        })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // === BottomBarAction ===
      Column() {
        Row({ space: 0 }) {
          Column({ space: 0 }) {
            Text('Price')
              .fontColor(Color.Gray)
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
          .onClick(() => {
            // Add to cart action
          })
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
        .padding(24)
        .width('100%')
      }
      .width('100%')
      .backgroundColor(Color.White)
      .shadow({ radius: 4, color: '#1A000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  SizeOption(label: string, isSelected: boolean) {
    Stack({ alignContent: Alignment.Center }) {
      Text(label)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(isSelected ? Color.White : Color.Black)
    }
    .width(100)
    .height(48)
    .backgroundColor(isSelected ? '#6F4E37' : Color.White)
    .borderRadius(12)
    .border({ width: 1, color: isSelected ? '#6F4E37' : '#E0E0E0' })
    .onClick(() => {
      this.selectedSize = label
    })
  }
}