// Colors
const LWBackground = '#FBFBFE'
const LWCardBg = '#F5F3FD'
const LWHeaderCircle = '#EEE9FC'
const LWPurpleActive = '#8B5CF6'
const LWPurpleInactive = '#EBE7F6'
const LWTextInactive = '#1F2937'
const LWButtonPink = '#F4AECF'
const LWButtonText = '#2D0D1B'
const LWTextDark = '#111827'
const LWTextGray = '#6B7280'
const LWBorder = '#C4B5FD'
const LWPurpleActiveLight = '#A07CFF'

@Entry
@Component
struct LeaseWizardApp {
  build() {
    Stack() {
      Column({ space: 0 }) {
        HeaderView()
          .padding({ top: 10, bottom: 10 })

        Scroll() {
          Column({ space: 24 }) {
            // Steps Section
            Column() {
              Text('Steps')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(LWTextDark)
                .width('100%')
                .textAlign(TextAlign.Start)
                .margin({ bottom: 20 })

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
            .padding(24)
            .backgroundColor(LWCardBg)
            .borderRadius(24)
            .width('100%')

            // Form Section
            Column() {
              Text('Form')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(LWTextDark)
                .width('100%')
                .textAlign(TextAlign.Start)
                .margin({ bottom: 25 })

              CustomTextField({ label: 'Full name', text: 'Avery Tenant' })
              CustomTextField({ label: 'Contact', text: 'avery@example.com' })

              Column() {}.height(10)
            }
            .padding(24)
            .backgroundColor(LWCardBg)
            .borderRadius(24)
            .width('100%')
          }
          .padding({ left: 16, right: 16, bottom: 40 })
          .width('100%')
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
    .backgroundColor(LWBackground)
  }
}

@Component
struct HeaderView {
  build() {
    Row() {
      Circle({ width: 44, height: 44 })
        .fill(LWHeaderCircle)

      Blank()

      Column({ space: 2 }) {
        Text('LeaseWizard')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text('Guided handoff')
          .fontSize(13)
          .fontWeight(FontWeight.Regular)
          .fontColor(LWTextGray)
      }

      Blank()

      Circle({ width: 44, height: 44 })
        .fill(LWHeaderCircle)
    }
    .padding({ left: 20, right: 20 })
    .width('100%')
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
    Row() {
      // Indicator Column
      Column({ space: 0 }) {
        Stack() {
          Circle({ width: 32, height: 32 })
            .fill(this.isActive ? LWPurpleActiveLight : LWPurpleInactive)
          Text(this.step)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isActive ? '#000000' : LWTextDark)
        }
        .width(32)
        .height(32)

        if (!this.isLast) {
          Rect({ width: 2, height: 40 })
            .fill(LWHeaderCircle)
        }
      }
      .width(32)
      .alignItems(HorizontalAlign.Center)

      // Text Content
      Column({ space: 2 }) {
        Text(this.title)
          .fontSize(17)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(LWTextDark)
          .margin({ top: 4 })
        Text(this.subtitle)
          .fontSize(15)
          .fontWeight(FontWeight.Regular)
          .fontColor(LWTextGray)
        Column() {}.height(24)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })
      .layoutWeight(1)

      // Action Button
      Button(this.btnText)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(LWButtonText)
        .width(60)
        .height(36)
        .backgroundColor(LWButtonPink)
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
          .fontColor(LWTextDark)
        Blank()
      }
      .padding({ top: 16, bottom: 16, left: 16, right: 16 })
      .border({ width: 1, color: LWBorder, radius: 12 })
      .width('100%')

      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(LWTextGray)
        .padding({ left: 4, right: 4 })
        .backgroundColor(LWCardBg)
        .margin({ left: 12, top: -10 })
    }
    .width('100%')
  }
}
