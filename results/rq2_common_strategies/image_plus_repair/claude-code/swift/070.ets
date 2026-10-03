@Entry
@Component
struct LeaseWizardPage {
  @State fullName: string = 'Avery Tenant'
  @State contact: string = 'avery@example.com'

  build() {
    Stack() {
      // Global Background
      Column() {
        // Header
        HeaderView()
          .margin({ top: 10, bottom: 10 })

        Scroll() {
          Column() {
            // Section 1: Steps Container
            Column() {
              Text('Steps')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor('#111827')
                .width('100%')

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
            .padding(24)
            .backgroundColor('#F5F3FD')
            .borderRadius(24)
            .width('100%')

            // Section 2: Form Container
            Column() {
              Text('Form')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor('#111827')
                .width('100%')

              CustomTextField({ label: 'Full name', text: this.fullName })

              CustomTextField({ label: 'Contact', text: this.contact })

              Blank()
                .height(10)
            }
            .padding(24)
            .backgroundColor('#F5F3FD')
            .borderRadius(24)
            .width('100%')
            .margin({ top: 24 })
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 40 })
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .backgroundColor('#FBFBFE')
    .width('100%')
    .height('100%')
  }
}

@Component
struct HeaderView {
  build() {
    Row() {
      // Left Circle
      Circle({ width: 44, height: 44 })
        .fill('#EEE9FC')

      Blank()

      // Title Block
      Column() {
        Text('LeaseWizard')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Text('Guided handoff')
          .fontSize(13)
          .fontWeight(FontWeight.Regular)
          .fontColor('#6B7280')
      }
      .alignItems(HorizontalAlign.Center)

      Blank()

      // Right Circle
      Circle({ width: 44, height: 44 })
        .fill('#EEE9FC')
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

  private get circleColor(): ResourceColor {
    return this.isActive ? '#A07CFF' : '#EBE7F6'
  }

  build() {
    Row() {
      // Indicator Column
      Column() {
        Stack() {
          Circle({ width: 32, height: 32 })
            .fill(this.circleColor)

          Text(this.step)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isActive ? Color.Black : '#1F2937')
        }
        .width(32)
        .height(32)

        // Vertical Connecting Line
        if (!this.isLast) {
          Rect()
            .fill('#EEE9FC')
            .width(2)
            .layoutWeight(1)
        }
      }
      .width(32)
      .alignItems(HorizontalAlign.Center)

      // Text Content
      Column() {
        Text(this.title)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .margin({ top: 4 })

        Text(this.subtitle)
          .fontSize(15)
          .fontWeight(FontWeight.Regular)
          .fontColor('#6B7280')

        Blank()
          .height(24)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })
      .layoutWeight(1)

      // Action Button
      Button(this.btnText)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#2D0D1B')
        .width(60)
        .height(36)
        .backgroundColor('#F4AECF')
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
    Stack() {
      // The Input Field Box
      Row() {
        Text(this.text)
          .fontSize(18)
          .fontWeight(FontWeight.Regular)
          .fontColor('#111827')

        Blank()
      }
      .width('100%')
      .padding({ top: 16, bottom: 16, left: 16, right: 16 })
      .border({ width: 1, color: '#C4B5FD', radius: 12 })

      // The Floating Label
      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor('#6B7280')
        .padding({ left: 4, right: 4 })
        .backgroundColor('#F5F3FD')
        .position({ x: 12, y: -10 })
    }
    .width('100%')
    .alignContent(Alignment.TopStart)
  }
}
