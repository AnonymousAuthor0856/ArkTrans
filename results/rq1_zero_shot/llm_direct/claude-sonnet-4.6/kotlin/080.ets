import { router } from '@kit.ArkUI';

@Entry
@Component
struct CoffeeDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedSize: string = 'M';

  build() {
    Column() {
      // Top App Bar
      Row() {
        Button({ type: ButtonType.Circle }) {
          Text('<')
            .fontSize(18)
            .fontColor(Color.Black)
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.White)

        Text('Details')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button({ type: ButtonType.Circle }) {
          Text(this.isFavorite ? '♥' : '♡')
            .fontSize(20)
            .fontColor(this.isFavorite ? Color.Red : Color.Black)
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.White)
        .onClick(() => {
          this.isFavorite = !this.isFavorite;
        })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.SpaceBetween)
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
                .fontSize(20)
                .fontColor('#FFC107')

              Text('4.8')
                .fontWeight(FontWeight.Bold)
                .fontSize(16)
                .margin({ left: 4 })

              Text('(230 reviews)')
                .fontColor(Color.Gray)
                .fontSize(14)
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
              .margin({ top: 24 })

            Text('A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffee.')
              .fontColor(Color.Gray)
              .fontSize(15)
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
              .margin({ top: 24 })

            Row() {
              SizeOption({
                label: 'S',
                isSelected: this.selectedSize === 'S',
                onClick: () => {
                  this.selectedSize = 'S';
                }
              })

              SizeOption({
                label: 'M',
                isSelected: this.selectedSize === 'M',
                onClick: () => {
                  this.selectedSize = 'M';
                }
              })

              SizeOption({
                label: 'L',
                isSelected: this.selectedSize === 'L',
                onClick: () => {
                  this.selectedSize = 'L';
                }
              })
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
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Bar
      BottomBarAction()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct SizeOption {
  label: string = '';
  isSelected: boolean = false;
  onClick: () => void = () => {};

  build() {
    Stack() {
      Text(this.label)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? '#6F4E37' : Color.Black)
    }
    .width(100)
    .height(48)
    .borderRadius(12)
    .border({
      width: 1,
      color: this.isSelected ? '#6F4E37' : '#E0E0E0'
    })
    .backgroundColor(this.isSelected ? '#FFF4E0' : Color.White)
    .alignContent(Alignment.Center)
    .onClick(() => {
      this.onClick();
    })
  }
}

@Component
struct BottomBarAction {
  build() {
    Row() {
      Column() {
        Text('Price')
          .fontColor(Color.Gray)
          .fontSize(14)

        Text('$ 4.50')
          .fontColor('#6F4E37')
          .fontWeight(FontWeight.Bold)
          .fontSize(24)
      }
      .alignItems(HorizontalAlign.Start)

      Button('Add to Cart')
        .width(200)
        .height(56)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.White)
        .backgroundColor('#6F4E37')
        .borderRadius(16)
    }
    .width('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
    .shadow({
      radius: 16,
      color: '#1A000000',
      offsetX: 0,
      offsetY: -4
    })
  }
}