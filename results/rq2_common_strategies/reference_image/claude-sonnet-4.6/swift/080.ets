const COLOR_PLACEHOLDER_BG: string = '#F5F5F5';
const COLOR_BORDER: string = '#E0E0E0';
const COLOR_ICON_GRAY: string = '#BDBDBD';
const COLOR_STAR: string = '#FFC107';
const COLOR_TEXT_GRAY: string = '#808080';
const COLOR_RING: string = '#8C8C8C';

@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedColorIndex: number = 0;

  private readonly colorList: string[] = ['#212121', '#795548', '#9E9E9E'];
  private readonly scroller: Scroller = new Scroller();

  @Builder
  CircleIconButton(icon: string, action: () => void) {
    Text(icon)
      .fontSize(22)
      .fontColor(Color.Black)
      .textAlign(TextAlign.Center)
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: COLOR_BORDER })
      .onClick(action)
  }

  @Builder
  ColorSelector(color: string, selected: boolean, index: number) {
    Stack() {
      Circle()
        .width(32)
        .height(32)
        .fill(color)

      if (selected) {
        Circle()
          .width(32)
          .height(32)
          .fill(Color.Transparent)
          .fillOpacity(0)
          .stroke(COLOR_RING)
          .strokeWidth(2)

        Circle()
          .width(10)
          .height(10)
          .fill(Color.White)
      }
    }
    .width(32)
    .height(32)
    .onClick(() => {
      this.selectedColorIndex = index;
    })
  }

  @Builder
  HeaderBar() {
    Row() {
      this.CircleIconButton('\u2190', () => {
        // back action
      })

      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)

      this.CircleIconButton(this.isFavorite ? '\u2665' : '\u2661', () => {
        this.isFavorite = !this.isFavorite;
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding({ left: 24, right: 24, top: 16 })
  }

  @Builder
  ProductImagePlaceholder() {
    Column() {
      Text('\uD83D\uDED2')
        .fontSize(72)
        .fontColor(COLOR_ICON_GRAY)
    }
    .width('100%')
    .height(300)
    .borderRadius(32)
    .backgroundColor(COLOR_PLACEHOLDER_BG)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ProductInfoSection() {
    Column() {
      Row() {
        Column() {
          Text('Modern Lounge\nChair')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .lineHeight(32)
            .textAlign(TextAlign.Start)

          Text('Minimalist Series')
            .fontSize(16)
            .fontColor(COLOR_TEXT_GRAY)
            .margin({ top: 8 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text('$1299')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      Row() {
        Text('\u2605')
          .fontSize(20)
          .fontColor(COLOR_STAR)

        Text('4.8')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ left: 4 })

        Text('(238 Reviews)')
          .fontSize(14)
          .fontColor(COLOR_TEXT_GRAY)
          .margin({ left: 8 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: 24 })

      Text('Colors')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ top: 24 })

      Row({ space: 12 }) {
        ForEach(this.colorList, (item: string, index: number) => {
          this.ColorSelector(item, this.selectedColorIndex === index, index)
        }, (item: string, index: number) => `${index}-${item}`)
      }
      .width('100%')
      .margin({ top: 12 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  BottomActionSection() {
    Row({ space: 16 }) {
      Button('Add to Cart')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .backgroundColor(Color.Black)
        .height(56)
        .layoutWeight(1)
        .borderRadius(16)

      Stack() {
        Text('\u2665')
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .width(56)
      .height(56)
      .borderRadius(16)
      .backgroundColor(COLOR_PLACEHOLDER_BG)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Stack() {
      Column() {
        this.HeaderBar()

        Scroll(this.scroller) {
          Column() {
            this.ProductImagePlaceholder()

            Column() {
              this.ProductInfoSection()
            }
            .margin({ top: 32 })

            Blank().height(24)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
        .layoutWeight(1)
        .width('100%')

        Column() {
          this.BottomActionSection()
        }
        .width('100%')
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