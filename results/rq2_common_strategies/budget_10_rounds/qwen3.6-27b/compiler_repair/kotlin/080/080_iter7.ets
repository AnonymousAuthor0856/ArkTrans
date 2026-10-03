import { BusinessError } from '@kit.BasicServicesKit';
import { common, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct CoffeeDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedSize: string = "M";

  build() {
    Column() {
      // Top Bar
      Row() {
        Button() {
          Image($r('app.media.ic_arrow_back'))
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        }
        .backgroundColor(Color.Transparent)
        .borderRadius(16)
        .onClick(() => {
          // Back action
        })

        Text("Details")
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ left: 16 })

        Blank()

        Button() {
          Image(this.isFavorite ? $r('app.media.ic_favorite_filled') : $r('app.media.ic_favorite_border'))
            .width(24)
            .height(24)
            .fillColor(this.isFavorite ? Color.Red : Color.Black)
        }
        .backgroundColor(Color.Transparent)
        .borderRadius(16)
        .onClick(() => {
          this.isFavorite = !this.isFavorite;
        })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .alignItems(VerticalAlign.Center)

      // Scrollable Content
      Scroll() {
        Column() {
          // Image Placeholder
          Row() {
            Image($r('app.media.ic_shopping_cart'))
              .width(80)
              .height(80)
              .fillColor('#E0E0E0')
          }
          .width('100%')
          .height(240)
          .backgroundColor('#F5F5F5')
          .borderRadius(32)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)

          Spacer()
            .height('24vp')

          // Title and Rating
          Text("Caramel Macchiato")
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)

          Row() {
            Image($r('app.media.ic_star'))
              .width(20)
              .height(20)
              .fillColor('#FFC107')
            
            Text("4.8")
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ left: 4 })

            Text("(230 reviews)")
              .fontSize(14)
              .fontColor(Color.Gray)
              .margin({ left: 4 })
          }
          .alignItems(VerticalAlign.Center)

          Spacer()
            .height('24vp')

          // Description
          Text("Description")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)

          Spacer()
            .height('12vp')

          Text("A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffee.")
            .fontSize(15)
            .lineHeight(22)
            .fontColor(Color.Gray)
            .maxLines(4)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Spacer()
            .height('24vp')

          // Size Selection
          Text("Size")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)

          Spacer()
            .height('16vp')

          Row() {
            SizeOptionComponent({ label: "S", isSelected: this.selectedSize === "S", onClick: () => {
              this.selectedSize = "S";
            }})
            SizeOptionComponent({ label: "M", isSelected: this.selectedSize === "M", onClick: () => {
              this.selectedSize = "M";
            }})
            SizeOptionComponent({ label: "L", isSelected: this.selectedSize === "L", onClick: () => {
              this.selectedSize = "L";
            }})
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          Spacer()
            .height('100vp')
        }
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)

      // Bottom Bar
      Row() {
        Column() {
          Text("Price")
            .fontSize(14)
            .fontColor(Color.Gray)
          
          Text("$ 4.50")
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#6F4E37')
        }
        .alignItems(HorizontalAlign.Start)

        Button("Add to Cart")
          .width(200)
          .height(56)
          .backgroundColor('#6F4E37')
          .fontColor(Color.White)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .borderRadius(16)
          .onClick(() => {
            // Add to cart action
          })
      }
      .width('100%')
      .padding(24)
      .backgroundColor(Color.White)
      .shadow({ radius: 16, color: '#1A000000', offsetY: -4 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct SizeOptionComponent {
  @Prop label: string;
  @Prop isSelected: boolean;
  @Prop onClick: () => void;

  build() {
    Column() {
      Text(this.label)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? '#6F4E37' : Color.Black)
    }
    .width(100)
    .height(48)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .borderRadius(12)
    .border({ width: 1, color: this.isSelected ? '#6F4E37' : '#E0E0E0' })
    .backgroundColor(this.isSelected ? '#FFF4E0' : Color.White)
    .onClick(() => {
      this.onClick();
    })
  }
}