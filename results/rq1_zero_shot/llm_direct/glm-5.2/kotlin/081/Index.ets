// FurnitureDetailPage.ets
import { Theme } from 'app/Theme';

@Entry
@Component
struct FurnitureDetailPage {
  build() {
    Column() {
      Column() {
        this.HeaderBar()
        Blank(24)
        this.ProductImagePlaceholder()
        Blank(32)
        this.ProductInfoSection()
        Blank()
        this.BottomActionSection()
      }
      .width('100%')
      .height('100%')
      .padding(24)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder HeaderBar() {
    Row() {
      Row() {
        Image($r('app.media.ic_arrow_back'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: '#E0E0E0' })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)

      Row() {
        Image($r('app.media.ic_favorite_border'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: '#E0E0E0' })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder ProductImagePlaceholder() {
    Row() {
      Image($r('app.media.ic_shopping_cart'))
        .width(80)
        .height(80)
        .fillColor('#BDBDBD')
    }
    .width('100%')
    .height(300)
    .borderRadius(32)
    .backgroundColor('#F5F5F5')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }

  @Builder ProductInfoSection() {
    Column() {
      Row() {
        Column() {
          Text('Modern Lounge Chair')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          Blank(8)
          Text('Minimalist Series')
            .fontSize(16)
            .fontColor(Color.Gray)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Text('$1299')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ left: 12 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      Blank(24)

      Row() {
        Image($r('app.media.ic_star'))
          .width(20)
          .height(20)
          .fillColor('#FFC107')
        Blank(4)
        Text('4.8')
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Blank(8)
        Text('(238 Reviews)')
          .fontColor(Color.Gray)
          .fontSize(14)
      }
      .alignItems(VerticalAlign.Center)

      Blank(24)

      Text('Colors')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)

      Blank(12)

      Row() {
        this.ColorSelector('#212121', true)
        this.ColorSelector('#795548', false)
        this.ColorSelector('#9E9E9E', false)
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder ColorSelector(color: string, isSelected: boolean) {
    Stack() {
      if (isSelected) {
        Row()
          .width(10)
          .height(10)
          .borderRadius(5)
          .backgroundColor(Color.White)
      }
    }
    .width(32)
    .height(32)
    .borderRadius(16)
    .backgroundColor(color)
    .border({ width: isSelected ? 2 : 0, color: Color.LightGray })
    .alignContent(Alignment.Center)
  }

  @Builder BottomActionSection() {
    Row() {
      Button('Add to Cart', { type: ButtonType.Capsule })
        .width('100%')
        .height(56)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .backgroundColor(Color.Black)
        .borderRadius(16)
        .layoutWeight(1)
        .margin({ right: 16 })

      Row() {
        Image($r('app.media.ic_favorite'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(56)
      .height(56)
      .borderRadius(16)
      .backgroundColor('#F5F5F5')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
  }
}