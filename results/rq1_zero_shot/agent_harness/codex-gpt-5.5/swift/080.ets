@Entry
@Component
struct FurnitureDetailScreen {
  @Builder
  private HeaderBar() {
    Row() {
      Button('←')
        .fontSize(20)
        .fontColor(Color.Black)
        .width(48)
        .height(48)
        .backgroundColor(Color.Transparent)
        .border({ width: 1, color: '#E0E0E0' })
        .borderRadius(24)
      Blank()
      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color.Black)
      Blank()
      Button('♡')
        .fontSize(20)
        .fontColor(Color.Black)
        .width(48)
        .height(48)
        .backgroundColor(Color.Transparent)
        .border({ width: 1, color: '#E0E0E0' })
        .borderRadius(24)
    }
    .width('100%')
  }

  @Builder
  private ProductImagePlaceholder() {
    Stack() {
      Rect()
        .width('100%')
        .height(300)
        .fill('#F5F5F5')
        .radius(32)
      Text('🛒')
        .fontSize(72)
        .fontColor('#BDBDBD')
    }
    .height(300)
    .width('100%')
  }

  @Builder
  private ColorSelector(color: string, isSelected: boolean) {
    Stack() {
      Circle()
        .width(32)
        .height(32)
        .fill(color)
      if (isSelected) {
        Circle()
          .width(32)
          .height(32)
          .fill(Color.Transparent)
          .stroke('#80808080')
          .strokeWidth(2)
        Circle()
          .width(10)
          .height(10)
          .fill(Color.White)
      }
    }
    .width(32)
    .height(32)
  }

  @Builder
  private ProductInfoSection() {
    Column({ space: 0 }) {
      Row() {
        Column({ space: 8 }) {
          Text('Modern Lounge\nChair')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .lineHeight(32)
          Text('Minimalist Series')
            .fontSize(16)
            .fontColor('#808080')
        }
        .alignItems(HorizontalAlign.Start)
        Blank()
        Text('$1299')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .alignItems(VerticalAlign.Top)
      .width('100%')

      Blank().height(24)

      Row({ space: 0 }) {
        Text('★')
          .fontSize(20)
          .fontColor('#FFC107')
        Blank().width(4)
        Text('4.8')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Blank().width(8)
        Text('(238 Reviews)')
          .fontSize(14)
          .fontColor('#808080')
      }

      Blank().height(24)

      Text('Colors')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color.Black)
        .width('100%')
        .textAlign(TextAlign.Start)

      Blank().height(12)

      Row({ space: 12 }) {
        this.ColorSelector('#212121', true)
        this.ColorSelector('#795548', false)
        this.ColorSelector('#9E9E9E', false)
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  @Builder
  private BottomActionSection() {
    Row({ space: 16 }) {
      Button('Add to Cart')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .height(56)
        .layoutWeight(1)
        .backgroundColor(Color.Black)
        .borderRadius(16)
      Stack() {
        Rect()
          .width(56)
          .height(56)
          .fill('#F5F5F5')
          .radius(16)
        Text('♥')
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .width(56)
      .height(56)
    }
    .width('100%')
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        this.HeaderBar()
          .padding({ left: 24, right: 24, top: 16 })

        Scroll() {
          Column({ space: 0 }) {
            Blank().height(24)
            this.ProductImagePlaceholder()
            Blank().height(32)
            this.ProductInfoSection()
            Blank().height(24)
          }
          .padding({ left: 24, right: 24 })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)

        this.BottomActionSection()
          .padding({ left: 24, right: 24, bottom: 24 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
