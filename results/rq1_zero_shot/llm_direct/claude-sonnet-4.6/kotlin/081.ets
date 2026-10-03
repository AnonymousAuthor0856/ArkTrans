import { LengthMetrics } from '@kit.ArkUI';

@Entry
@Component
struct FurnitureDetailScreen {
  build() {
    Column({ space: 0 }) {
      HeaderBar()

      Blank().height(24)

      ProductImagePlaceholder()

      Blank().height(32)

      ProductInfoSection()

      Blank().layoutWeight(1)

      BottomActionSection()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
  }
}

@Component
struct HeaderBar {
  build() {
    Row() {
      Button({ type: ButtonType.Circle }) {
        Image($r('sys.media.ohos_ic_back'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
      .border({ width: 1, color: '#E0E0E0', radius: 24 })

      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)

      Button({ type: ButtonType.Circle }) {
        Image($r('sys.media.ohos_ic_public_heart'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
      .border({ width: 1, color: '#E0E0E0', radius: 24 })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct ProductImagePlaceholder {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Image($r('sys.media.ohos_ic_public_add'))
        .width(80)
        .height(80)
        .fillColor('#BDBDBD')
    }
    .width('100%')
    .height(300)
    .backgroundColor('#F5F5F5')
    .borderRadius(32)
  }
}

@Component
struct ProductInfoSection {
  build() {
    Column({ space: 0 }) {
      Row() {
        Column({ space: 0 }) {
          Text('Modern Lounge Chair')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .lineHeight(32)

          Blank().height(8)

          Text('Minimalist Series')
            .fontSize(16)
            .fontColor(Color.Gray)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text('$1299')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)

      Blank().height(24)

      Row({ space: 0 }) {
        Image($r('sys.media.ohos_ic_public_highlights'))
          .width(20)
          .height(20)
          .fillColor('#FFC107')

        Blank().width(4)

        Text('4.8')
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Blank().width(8)

        Text('(238 Reviews)')
          .fontColor(Color.Gray)
          .fontSize(14)
      }
      .alignItems(VerticalAlign.Center)

      Blank().height(24)

      Text('Colors')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)

      Blank().height(12)

      Row({ space: 12 }) {
        ColorSelector({ color: '#212121', isSelected: true })
        ColorSelector({ color: '#795548', isSelected: false })
        ColorSelector({ color: '#9E9E9E', isSelected: false })
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ColorSelector {
  color: string = '#000000'
  isSelected: boolean = false

  build() {
    Stack({ alignContent: Alignment.Center }) {
      if (this.isSelected) {
        Circle()
          .width(10)
          .height(10)
          .fill(Color.White)
      }
    }
    .width(32)
    .height(32)
    .borderRadius(16)
    .backgroundColor(this.color)
    .border(this.isSelected ? { width: 2, color: '#D3D3D3', radius: 16 } : { width: 0, color: Color.Transparent, radius: 16 })
  }
}

@Component
struct BottomActionSection {
  build() {
    Row({ space: 16 }) {
      Button('Add to Cart')
        .height(56)
        .layoutWeight(1)
        .backgroundColor(Color.Black)
        .fontColor(Color.White)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .borderRadius(16)

      Stack({ alignContent: Alignment.Center }) {
        Image($r('sys.media.ohos_ic_public_heart'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(56)
      .height(56)
      .borderRadius(16)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
  }
}