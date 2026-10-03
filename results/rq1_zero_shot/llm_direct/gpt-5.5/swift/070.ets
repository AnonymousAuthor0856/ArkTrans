import window from '@ohos.window'

class LWColor {
  static readonly background: string = '#FBFBFE'
  static readonly cardBg: string = '#F5F3FD'
  static readonly headerCircle: string = '#EEE9FC'

  static readonly purpleActive: string = '#A07CFF'
  static readonly purpleInactive: string = '#EBE7F6'
  static readonly textInactive: string = '#1F2937'
  static readonly buttonPink: string = '#F4AECF'
  static readonly buttonText: string = '#2D0D1B'

  static readonly textDark: string = '#111827'
  static readonly textGray: string = '#6B7280'
  static readonly border: string = '#C4B5FD'
}

@Entry
@Component
struct LeaseWizardApp {
  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setWindowSystemBarEnable(['navigation'])
      win.setWindowBackgroundColor(LWColor.background)
    })
  }

  build() {
    ContentView()
  }
}

@Component
struct ContentView {
  build() {
    Stack() {
      Column({ space: 0 }) {
        HeaderView()
          .padding({ top: 10, bottom: 10 })

        Scroll() {
          Column({ space: 24 }) {
            Column({ space: 20 }) {
              Text('Steps')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(LWColor.textDark)

              Column({ space: 0 }) {
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
            .backgroundColor(LWColor.cardBg)
            .borderRadius(24)

            Column({ space: 25 }) {
              Text('Form')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(LWColor.textDark)

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
            .backgroundColor(LWColor.cardBg)
            .borderRadius(24)
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 40 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(LWColor.background)
  }
}

@Component
struct HeaderView {
  build() {
    Row() {
      Circle()
        .width(44)
        .height(44)
        .fill(LWColor.headerCircle)

      Blank()
        .layoutWeight(1)

      Column({ space: 2 }) {
        Text('LeaseWizard')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Text('Guided handoff')
          .fontSize(13)
          .fontWeight(FontWeight.Regular)
          .fontColor(LWColor.textGray)
      }

      Blank()
        .layoutWeight(1)

      Circle()
        .width(44)
        .height(44)
        .fill(LWColor.headerCircle)
    }
    .width('100%')
    .padding({ left: 20, right: 20 })
  }
}

@Component
struct StepRow {
  step: string = ''
  title: string = ''
  subtitle: string = ''
  btnText: string = ''
  isActive: boolean = false
  isLast: boolean = false

  build() {
    Row({ space: 16 }) {
      Column({ space: 0 }) {
        Stack() {
          Circle()
            .width(32)
            .height(32)
            .fill(this.isActive ? LWColor.purpleActive : LWColor.purpleInactive)

          Text(this.step)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isActive ? Color.Black : LWColor.textDark)
        }
        .width(32)
        .height(32)

        if (!this.isLast) {
          Blank()
            .width(2)
            .height(40)
            .backgroundColor(LWColor.headerCircle)
        }
      }
      .width(32)

      Column({ space: 2 }) {
        Text(this.title)
          .fontSize(17)
          .fontWeight(FontWeight.Medium)
          .fontColor(LWColor.textDark)
          .padding({ top: 4 })

        Text(this.subtitle)
          .fontSize(15)
          .fontWeight(FontWeight.Regular)
          .fontColor(LWColor.textGray)

        Blank()
          .height(24)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Button({ type: ButtonType.Normal }) {
        Text(this.btnText)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(LWColor.buttonText)
      }
      .width(60)
      .height(36)
      .padding(0)
      .backgroundColor(LWColor.buttonPink)
      .borderRadius(8)
      .margin({ top: 2 })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct CustomTextField {
  label: string = ''
  text: string = ''

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Row() {
        Text(this.text)
          .fontSize(18)
          .fontWeight(FontWeight.Regular)
          .fontColor(LWColor.textDark)

        Blank()
      }
      .width('100%')
      .padding({ top: 16, bottom: 16, left: 16, right: 16 })
      .border({
        width: 1,
        color: LWColor.border,
        radius: 12
      })

      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(LWColor.textGray)
        .padding({ left: 4, right: 4 })
        .backgroundColor(LWColor.cardBg)
        .translate({ x: 12, y: -10 })
    }
    .width('100%')
  }
}