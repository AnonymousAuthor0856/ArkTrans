import { router } from '@kit.ArkUI';

@Entry
@Component
struct CoffeeDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedSize: string = "M";

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row() {
          Text('<')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
        .width(40)
        .height(40)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .onClick(() => {})

        Text('Details')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Row() {
          Text(this.isFavorite ? '♥' : '♡')
            .fontSize(22)
            .fontColor(this.isFavorite ? Color.Red : Color.Black)
        }
        .width(40)
        .height(40)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .onClick(() => {
          this.isFavorite = !this.isFavorite;
        })
      }
      .width('100%')
      .height(56)
      .padding({ left: 8, right: 8 })
      .backgroundColor(Color.White)
      .alignItems(VerticalAlign.Center)

      // Scrollable Content
      Scroll() {
        Column() {
          // Coffee Image Placeholder
          Stack() {
            Column()
              .width('100%')
              .height(240)
              .borderRadius(32)
              .backgroundColor('#F5F5F5')

            Text('🛒')
              .fontSize(60)
              .fontColor('#E0E0E0')
          }
          .width('100%')
          .height(240)
          .margin({ top: 16 })

          // Title and Rating
          Column() {
            Text('Caramel Macchiato')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ top: 24 })

            Row() {
              Text('★')
                .fontSize(18)
                .fontColor('#FFC107')
              Text('4.8')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
                .margin({ left: 4 })
              Text('(230 reviews)')
                .fontSize(14)
                .fontColor(Color.Gray)
                .margin({ left: 4 })
            }
            .alignItems(VerticalAlign.Center)
            .margin({ top: 8 })
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')

          // Description
          Column() {
            Text('Description')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.Black)
              .margin({ top: 24 })

            Text('A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffee.')
              .fontSize(15)
              .fontColor(Color.Gray)
              .lineHeight(22)
              .maxLines(4)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .margin({ top: 12 })
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')

          // Size Selection
          Column() {
            Text('Size')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.Black)
              .margin({ top: 24 })

            Row() {
              this.SizeOption('S', this.selectedSize === 'S', () => { this.selectedSize = 'S'; })
              this.SizeOption('M', this.selectedSize === 'M', () => { this.selectedSize = 'M'; })
              this.SizeOption('L', this.selectedSize === 'L', () => { this.selectedSize = 'L'; })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: 16 })
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')

          // Bottom spacing
          Column()
            .height(100)
        }
        .padding({ left: 24, right: 24 })
        .alignItems(HorizontalAlign.Start)
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(Color.White)

      // Bottom Bar
      this.BottomBarAction()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  SizeOption(label: string, isSelected: boolean, onClick: () => void) {
    Text(label)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor(isSelected ? '#6F4E37' : Color.Black)
      .width(100)
      .height(48)
      .textAlign(TextAlign.Center)
      .borderRadius(12)
      .border({
        width: 1,
        color: isSelected ? '#6F4E37' : '#E0E0E0',
        style: BorderStyle.Solid
      })
      .backgroundColor(isSelected ? '#FFF4E0' : Color.White)
      .onClick(onClick)
  }

  @Builder
  BottomBarAction() {
    Row() {
      Column() {
        Text('Price')
          .fontSize(14)
          .fontColor(Color.Gray)
        Text('$ 4.50')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#6F4E37')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Button('Add to Cart')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.White)
        .width(200)
        .height(56)
        .borderRadius(16)
        .backgroundColor('#6F4E37')
        .onClick(() => {})
    }
    .width('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
    .shadow({
      radius: 16,
      color: '#22000000',
      offsetX: 0,
      offsetY: -4
    })
  }
}