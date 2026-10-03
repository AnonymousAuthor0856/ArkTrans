// entry/src/main/ets/pages/Index.ets
import { window } from '@kit.ArkUI';

@Entry
@Component
struct FurnitureDetailScreen {
  @State selectedColor: number = 0;

  private readonly colorList: string[] = ['#212121', '#795548', '#9E9E9E'];

  aboutToAppear(): void {
    // Immersive full-screen: hide status/navigation bars, keep swipe-to-show bars.
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    }).catch(() => {
    });
  }

  @Builder
  HeaderBar() {
    Row() {
      Stack() {
        SymbolGlyph($r('sys.symbol.arrow_left'))
          .fontSize(22)
          .fontColor([Color.Black])
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: '#E0E0E0' })
      .onClick(() => {
      })

      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Stack() {
        SymbolGlyph($r('sys.symbol.heart'))
          .fontSize(22)
          .fontColor([Color.Black])
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: '#E0E0E0' })
      .onClick(() => {
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  ProductImagePlaceholder() {
    Stack() {
      SymbolGlyph($r('sys.symbol.cart'))
        .fontSize(80)
        .fontColor(['#BDBDBD'])
    }
    .width('100%')
    .height(300)
    .borderRadius(32)
    .clip(true)
    .backgroundColor('#F5F5F5')
    .margin({ top: 24, bottom: 32 })
  }

  @Builder
  ColorSelector(color: string, isSelected: boolean) {
    Stack() {
      if (isSelected) {
        Column()
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
    .border(isSelected
      ? { width: 2, color: '#BDBDBD' }
      : { width: 0, color: Color.Transparent })
    .onClick(() => {
    })
  }

  @Builder
  ProductInfoSection() {
    Column() {
      Row() {
        Column() {
          Text('Modern Lounge Chair')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .lineHeight(32)
          Text('Minimalist Series')
            .fontSize(16)
            .fontColor('#9E9E9E')
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
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)

      Row() {
        SymbolGlyph($r('sys.symbol.star_fill'))
          .fontSize(20)
          .fontColor(['#FFC107'])
        Text('4.8')
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ left: 4 })
        Text('(238 Reviews)')
          .fontSize(14)
          .fontColor('#9E9E9E')
          .margin({ left: 8 })
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: 24 })

      Text('Colors')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ top: 24 })

      Row({ space: 12 }) {
        ForEach(this.colorList, (item: string, index: number) => {
          this.ColorSelector(item, this.selectedColor === index)
        }, (item: string) => item)
      }
      .margin({ top: 12 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  BottomActionSection() {
    Row({ space: 16 }) {
      Button() {
        Text('Add to Cart')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .type(ButtonType.Normal)
      .height(56)
      .layoutWeight(1)
      .backgroundColor(Color.Black)
      .borderRadius(16)

      Stack() {
        SymbolGlyph($r('sys.symbol.heart_fill'))
          .fontSize(22)
          .fontColor([Color.Black])
      }
      .width(56)
      .height(56)
      .borderRadius(16)
      .backgroundColor('#F5F5F5')
      .onClick(() => {
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      this.HeaderBar()

      this.ProductImagePlaceholder()

      this.ProductInfoSection()

      Blank()

      this.BottomActionSection()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
  }
}