import { window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

const LW_BACKGROUND: string = '#FBFBFE';
const LW_CARD_BG: string = '#F5F3FD';
const LW_HEADER_CIRCLE: string = '#EEE9FC';
const LW_PURPLE_ACTIVE: string = '#A07CFF';
const LW_PURPLE_INACTIVE: string = '#EBE7F6';
const LW_TEXT_DARK: string = '#111827';
const LW_TEXT_GRAY: string = '#6B7280';
const LW_BUTTON_PINK: string = '#F4AECF';
const LW_BUTTON_TEXT: string = '#2D0D1B';
const LW_BORDER: string = '#C4B5FD';

@Entry
@Component
struct ContentView {
  aboutToAppear(): void {
    const context = getContext(this) as common.UIAbilityContext;
    window.getLastWindow(context).then((win: window.Window) => {
      win.setWindowSystemBarEnable([]);
      win.setWindowLayoutFullScreen(true);
      win.setWindowBackgroundColor(LW_BACKGROUND);
    }).catch(() => {
    });
  }

  build() {
    Stack() {
      Column() {
        HeaderView()
          .padding({ top: 10, bottom: 10 })

        Scroll() {
          Column({ space: 24 }) {
            Column({ space: 20 }) {
              Text('Steps')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(LW_TEXT_DARK)

              Column() {
                StepRow({
                  step: '1',
                  title: 'Profile',
                  subtitle: 'Tenant basics',
                  btnText: 'Edit',
                  isActive: true,
                  isLast: false
                })

                StepRow({
                  step: '2',
                  title: 'Income',
                  subtitle: 'Proof details',
                  btnText: 'Edit',
                  isActive: true,
                  isLast: false
                })

                StepRow({
                  step: '3',
                  title: 'References',
                  subtitle: 'Upload letters',
                  btnText: 'Go',
                  isActive: false,
                  isLast: false
                })

                StepRow({
                  step: '4',
                  title: 'Summary',
                  subtitle: 'Confirm submission',
                  btnText: 'Go',
                  isActive: false,
                  isLast: true
                })
              }
              .width('100%')
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding(24)
            .backgroundColor(LW_CARD_BG)
            .borderRadius(24)

            Column({ space: 25 }) {
              Text('Form')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(LW_TEXT_DARK)

              CustomTextField({
                label: 'Full name',
                text: 'Avery Tenant'
              })

              CustomTextField({
                label: 'Contact',
                text: 'avery@example.com'
              })

              Blank()
                .height(10)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding(24)
            .backgroundColor(LW_CARD_BG)
            .borderRadius(24)
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 40 })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(LW_BACKGROUND)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

@Component
struct HeaderView {
  build() {
    Row() {
      Blank()
        .width(44)
        .height(44)
        .borderRadius(22)
        .backgroundColor(LW_HEADER_CIRCLE)

      Blank()
        .layoutWeight(1)

      Column({ space: 2 }) {
        Text('LeaseWizard')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Text('Guided handoff')
          .fontSize(13)
          .fontWeight(FontWeight.Regular)
          .fontColor(LW_TEXT_GRAY)
      }

      Blank()
        .layoutWeight(1)

      Blank()
        .width(44)
        .height(44)
        .borderRadius(22)
        .backgroundColor(LW_HEADER_CIRCLE)
    }
    .width('100%')
    .padding({ left: 20, right: 20 })
  }
}

@Component
struct StepRow {
  step: string = '';
  title: string = '';
  subtitle: string = '';
  btnText: string = '';
  isActive: boolean = false;
  isLast: boolean = false;

  build() {
    Row({ space: 16 }) {
      Column() {
        Stack() {
          Text(this.step)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isActive ? '#000000' : LW_TEXT_DARK)
        }
        .width(32)
        .height(32)
        .borderRadius(16)
        .backgroundColor(this.isActive ? LW_PURPLE_ACTIVE : LW_PURPLE_INACTIVE)

        if (!this.isLast) {
          Blank()
            .width(2)
            .height(40)
            .backgroundColor(LW_HEADER_CIRCLE)
        }
      }
      .width(32)
      .alignItems(HorizontalAlign.Center)

      Column({ space: 2 }) {
        Text(this.title)
          .fontSize(17)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(LW_TEXT_DARK)
          .padding({ top: 4 })

        Text(this.subtitle)
          .fontSize(15)
          .fontWeight(FontWeight.Regular)
          .fontColor(LW_TEXT_GRAY)

        Blank()
          .height(24)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button(this.btnText, { type: ButtonType.Normal, stateEffect: false })
        .width(60)
        .height(36)
        .padding(0)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(LW_BUTTON_TEXT)
        .backgroundColor(LW_BUTTON_PINK)
        .borderRadius(8)
        .margin({ top: 2 })
        .onClick(() => {
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct CustomTextField {
  label: string = '';
  text: string = '';

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Row() {
        Text(this.text)
          .fontSize(18)
          .fontWeight(FontWeight.Regular)
          .fontColor(LW_TEXT_DARK)
          .maxLines(1)

        Blank()
          .layoutWeight(1)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .border({
        width: 1,
        color: LW_BORDER,
        radius: 12
      })

      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(LW_TEXT_GRAY)
        .backgroundColor(LW_CARD_BG)
        .padding({ left: 4, right: 4 })
        .translate({ x: 12, y: -10 })
    }
    .width('100%')
    .height(56)
  }
}