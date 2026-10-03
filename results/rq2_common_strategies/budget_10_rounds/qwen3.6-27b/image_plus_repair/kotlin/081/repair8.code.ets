import { window } from '@kit.ArkUI';

@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false;

  build() {
    Column() {
      this.HeaderBar()

      Column() {
        .width('100%')
        .padding({ left: 24, right: 24 })
        .layoutWeight(1)

        Row() {
          .height(300)
          .backgroundColor('#F5F5F5')
          .borderRadius(32)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)

          Image($r('app.media.ic_shopping_cart')) // Placeholder for shopping cart icon
            .width(80)
            .height(80)
            .objectFit(ImageFit.Contain)
            .opacity(0.5)
        }
        .margin({ top: 24, bottom: 32 })

        Column() {
          .width('100%')

          Row() {
            Column() {
              Text("Modern Lounge Chair")
                .fontSize(26)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
                .lineHeight(32)
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })

              Text("Minimalist Series")
                .fontSize(16)
                .fontColor(Color.Gray)
                .margin({ top: 8 })
            }
            .layoutWeight(1)

            Text("$1299")
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
          }

          Row() {
            .alignItems(VerticalAlign.Center)
            .margin({ top: 24 })

            Image($r('app.media.ic_star')) // Placeholder for star icon
              .width(20)
              .height(20)
              .fillColor('#FFC107')

            Text("4.8")
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ left: 4 })

            Text("(238 Reviews)")
              .fontColor(Color.Gray)
              .fontSize(14)
              .margin({ left: 8 })
          }

          Text("Colors")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
            .margin({ top: 24 })

          Row() {
            .margin({ top: 12 })
            .columnGap(12)

            this.ColorSelector('#212121', true)
            this.ColorSelector('#795548', false)
            this.ColorSelector('#9E9E9E', false)
          }
        }
      }

      this.BottomActionSection()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  HeaderBar() {
    Row() {
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 24, right: 24 })

      Button() {
        Image($r('app.media.ic_arrow_back')) // Placeholder for back arrow icon
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: '#E0E0E0' })
      .onClick(() => {
        // Handle back action
      })

      Text("Details")
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)

      Button() {
        Image($r('app.media.ic_favorite_border')) // Placeholder for favorite border icon
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: '#E0E0E0' })
      .onClick(() => {
        this.isFavorite = !this.isFavorite;
      })
    }
  }

  @Builder
  ColorSelector(color: string, isSelected: boolean) {
    Stack() {
      Circle()
        .width(32)
        .height(32)
        .fill(new Color(color))

      if (isSelected) {
        Circle()
          .width(10)
          .height(10)
          .fill(Color.White)
      }
    }
    .border(isSelected ? { width: 2, color: '#D3D3D3' } : undefined)
  }

  @Builder
  BottomActionSection() {
    Row() {
      .width('100%')
      .padding({ left: 24, right: 24, bottom: 24 })
      .columnGap(16)

      Button("Add to Cart")
        .width('100%')
        .height(56)
        .backgroundColor(Color.Black)
        .fontColor(Color.White)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .borderRadius(16)
        .layoutWeight(1)
        .onClick(() => {
          // Handle add to cart action
        })

      Button() {
        Image($r('app.media.ic_favorite')) // Placeholder for favorite icon
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(56)
      .height(56)
      .borderRadius(16)
      .backgroundColor('#F5F5F5')
      .onClick(() => {
        this.isFavorite = !this.isFavorite;
      })
    }
  }
}