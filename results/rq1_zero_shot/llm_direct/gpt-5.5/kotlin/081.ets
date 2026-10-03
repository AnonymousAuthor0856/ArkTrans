import window from '@ohos.window';

@Entry
@Component
struct FurnitureDetailScreen {
  aboutToAppear(): void {
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      })
      .catch(() => {
      });
  }

  build() {
    Column() {
      this.headerBar()

      Blank().height(24)

      this.productImagePlaceholder()

      Blank().height(32)

      this.productInfoSection()

      Blank().layoutWeight(1)

      this.bottomActionSection()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
  }

  @Builder
  headerBar() {
    Row() {
      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Text('‹')
          .fontSize(34)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Normal)
          .translate({ y: -2 })
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#E0E0E0', radius: 24 })

      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)

      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Text('♡')
          .fontSize(26)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#E0E0E0', radius: 24 })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  productImagePlaceholder() {
    Stack({ alignContent: Alignment.Center }) {
      Text('🛒')
        .fontSize(70)
        .fontColor('#BDBDBD')
    }
    .width('100%')
    .height(300)
    .borderRadius(32)
    .backgroundColor('#F5F5F5')
  }

  @Builder
  productInfoSection() {
    Column() {
      Row() {
        Column() {
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
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Text('$1299')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)

      Blank().height(24)

      Row() {
        Text('★')
          .fontSize(20)
          .fontColor('#FFC107')

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
        this.colorSelector('#212121', true)
        this.colorSelector('#795548', false)
        this.colorSelector('#9E9E9E', false)
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  colorSelector(color: ResourceColor, isSelected: boolean) {
    Stack({ alignContent: Alignment.Center }) {
      if (isSelected) {
        Circle()
          .width(10)
          .height(10)
          .fill(Color.White)
      }
    }
    .width(32)
    .height(32)
    .borderRadius(16)
    .backgroundColor(color)
    .border({
      width: isSelected ? 2 : 0,
      color: isSelected ? Color.LightGray : '#00000000',
      radius: 16
    })
  }

  @Builder
  bottomActionSection() {
    Row({ space: 16 }) {
      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Add to Cart')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .height(56)
      .layoutWeight(1)
      .backgroundColor(Color.Black)
      .borderRadius(16)

      Stack({ alignContent: Alignment.Center }) {
        Text('♥')
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .width(56)
      .height(56)
      .borderRadius(16)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
  }
}