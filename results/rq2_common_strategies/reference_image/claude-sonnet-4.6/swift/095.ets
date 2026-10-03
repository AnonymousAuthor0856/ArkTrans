import { window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

const COLOR_SUCCESS_BG: string = '#E8F5E9';
const COLOR_SUCCESS_FG: string = '#2E7D32';
const COLOR_TEXT_GRAY: string = '#9E9E9E';
const COLOR_ICON_GRAY: string = '#BDBDBD';
const COLOR_CARD_BG: string = '#F8F9FA';
const COLOR_CARD_BORDER: string = '#EEEEEE';
const COLOR_DIVIDER: string = '#E0E0E0';
const COLOR_BUTTON_BORDER: string = '#DDDDDD';

@Entry
@Component
struct ReceiptScreen {
  aboutToAppear(): void {
    try {
      const context = getContext(this) as common.UIAbilityContext;
      window.getLastWindow(context).then((win: window.Window) => {
        win.setWindowSystemBarEnable([]);
      }).catch(() => {
        // Previewer / non-window environment: nothing to hide.
      });
    } catch (err) {
      // No host window available (e.g. preview): keep default system bars.
    }
  }

  build() {
    Column() {
      Row().height(20)

      SuccessIcon()

      Row().height(16)

      Text('Payment Success')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_TEXT_GRAY)

      Row().height(8)

      Text('$1,249.00')
        .fontSize(45)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Row().height(32)

      ReceiptDetailsCard()

      Blank()

      ActionButtons()

      Row().height(16)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Color.White)
  }
}

@Component
struct SuccessIcon {
  build() {
    Stack() {
      Circle()
        .width(72)
        .height(72)
        .fill(COLOR_SUCCESS_BG)

      Text('✓')
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_SUCCESS_FG)
    }
    .width(72)
    .height(72)
    .alignContent(Alignment.Center)
  }
}

@Component
struct ReceiptDetailsCard {
  build() {
    Column({ space: 16 }) {
      RowDetail({ label: 'To Merchant', value: 'TechSpace Solutions', iconType: 'info' })

      Divider()
        .strokeWidth(1)
        .color(COLOR_DIVIDER)

      RowDetail({ label: 'Date', value: 'Dec 02, 2025 - 11:30 PM', iconType: 'calendar' })

      Divider()
        .strokeWidth(1)
        .color(COLOR_DIVIDER)

      PlainDetail({ label: 'Ref Number', value: '009281-XX-99' })

      PlainDetail({ label: 'Payment Method', value: 'Credit Card •••• 4242' })
    }
    .width('100%')
    .padding(20)
    .backgroundColor(COLOR_CARD_BG)
    .borderRadius(12)
    .border({ width: 1, color: COLOR_CARD_BORDER })
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct RowDetail {
  @Prop label: string = '';
  @Prop value: string = '';
  @Prop iconType: string = 'info';

  build() {
    Row() {
      Row({ space: 8 }) {
        RowIcon({ type: this.iconType })

        Text(this.label)
          .fontSize(14)
          .fontColor(COLOR_TEXT_GRAY)
      }

      Blank()

      Text(this.value)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .textAlign(TextAlign.End)
        .constraintSize({ maxWidth: '70%' })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct PlainDetail {
  @Prop label: string = '';
  @Prop value: string = '';

  build() {
    Row() {
      Text(this.label)
        .fontSize(14)
        .fontColor(COLOR_TEXT_GRAY)

      Blank()

      Text(this.value)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .textAlign(TextAlign.End)
        .constraintSize({ maxWidth: '70%' })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct RowIcon {
  @Prop type: string = 'info';

  build() {
    if (this.type === 'calendar') {
      Column() {
        Row()
          .width('100%')
          .height(4)
          .backgroundColor(COLOR_ICON_GRAY)

        Row() {
          Text('• • •')
            .fontSize(7)
            .fontColor(COLOR_ICON_GRAY)
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width(18)
      .height(16)
      .borderRadius(3)
      .border({ width: 1.5, color: COLOR_ICON_GRAY })
      .clip(true)
    } else {
      Stack() {
        Circle()
          .width(18)
          .height(18)
          .fill(COLOR_ICON_GRAY)

        Text('i')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .width(18)
      .height(18)
      .alignContent(Alignment.Center)
    }
  }
}

@Component
struct ShareIcon {
  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column()
        .width(14)
        .height(10)
        .margin({ top: 8 })
        .border({
          width: { left: 1.5, right: 1.5, bottom: 1.5 },
          color: Color.Black
        })
        .borderRadius({ bottomLeft: 3, bottomRight: 3 })

      Text('↑')
        .fontSize(13)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
    }
    .width(18)
    .height(18)
  }
}

@Component
struct ActionButtons {
  build() {
    Column({ space: 12 }) {
      Button('Done')
        .type(ButtonType.Normal)
        .width('100%')
        .height(50)
        .backgroundColor(Color.Black)
        .fontColor(Color.White)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .borderRadius(8)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Row({ space: 8 }) {
          ShareIcon()

          Text('Share Receipt')
            .fontSize(16)
            .fontColor(Color.Black)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.Transparent)
      .borderRadius(8)
      .border({ width: 1, color: COLOR_BUTTON_BORDER })
    }
    .width('100%')
  }
}