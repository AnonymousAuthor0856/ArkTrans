// entry/src/main/ets/pages/ReceiptPage.ets
// Register in resources/base/profile/main_pages.json as "pages/ReceiptPage"
// SymbolGlyph + sys.symbol.* requires API 11+; swap for $r('app.media.*') images if needed.

import window from '@ohos.window';
import { BusinessError } from '@ohos.base';

@Entry
@Component
struct ReceiptPage {
  aboutToAppear(): void {
    this.enableImmersiveMode();
  }

  /** Hides status bar + navigation bar, swipe down to reveal transiently. */
  private enableImmersiveMode(): void {
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      })
      .catch((err: BusinessError) => {
        console.error(`Immersive mode failed: ${err.code} ${err.message}`);
      });
  }

  @Builder
  SuccessBadge() {
    Stack() {
      SymbolGlyph($r('sys.symbol.checkmark'))
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .fontColor(['#2E7D32'])
    }
    .width(72)
    .height(72)
    .borderRadius(36)
    .backgroundColor('#E8F5E9')
  }

  @Builder
  DetailRow(icon: Resource, label: string, value: string) {
    Row() {
      Row() {
        SymbolGlyph(icon)
          .fontSize(18)
          .fontColor(['#9E9E9E'])
        Text(label)
          .fontSize(14)
          .fontColor('#9E9E9E')
          .margin({ left: 8 })
      }

      Blank()

      Text(value)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  PlainRow(label: string, value: string) {
    Row() {
      Text(label)
        .fontSize(14)
        .fontColor('#9E9E9E')

      Blank()

      Text(value)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      // ---------------- Header ----------------
      this.SuccessBadge()

      Text('Payment Success')
        .fontSize(16)
        .fontColor('#8A8A8E')
        .margin({ top: 16 })

      Text('$1,249.00')
        .fontSize(46)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ top: 4 })

      // ---------------- Receipt card ----------------
      Column({ space: 16 }) {
        this.DetailRow($r('sys.symbol.info_circle'), 'To Merchant', 'TechSpace Solutions')

        Divider()
          .strokeWidth(1)
          .color('#E0E0E0')

        this.DetailRow($r('sys.symbol.calendar'), 'Date', 'Dec 02, 2025 - 11:30 PM')

        Divider()
          .strokeWidth(1)
          .color('#E0E0E0')

        this.PlainRow('Ref Number', '009281-XX-99')

        this.PlainRow('Payment Method', 'Credit Card •••• 4242')
      }
      .width('100%')
      .padding(20)
      .backgroundColor('#F8F9FA')
      .borderRadius(12)
      .border({ width: 1, color: '#EEEEEE' })
      .margin({ top: 32 })

      // Pushes the action buttons to the bottom
      Blank()

      // ---------------- Actions ----------------
      Button('Done')
        .type(ButtonType.Capsule)
        .width('100%')
        .height(50)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .backgroundColor(Color.Black)
        .borderRadius(8)
        .onClick(() => {
        })

      Button({ type: ButtonType.Normal }) {
        Row() {
          SymbolGlyph($r('sys.symbol.share'))
            .fontSize(18)
            .fontColor([Color.Black])

          Text('Share Receipt')
            .fontSize(16)
            .fontColor(Color.Black)
            .margin({ left: 8 })
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.Transparent)
      .borderRadius(8)
      .border({ width: 1, color: '#DDDDDD' })
      .margin({ top: 12 })
      .onClick(() => {
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}