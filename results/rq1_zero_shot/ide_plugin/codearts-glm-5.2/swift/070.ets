class LwColors {
  static readonly background: string = '#FFFBFBFE'
  static readonly cardBg: string = '#FFF5F3FD'
  static readonly headerCircle: string = '#FFEEE9FC'
  static readonly purpleActive: string = '#FF8B5CF6'
  static readonly purpleInactive: string = '#FFEBE7F6'
  static readonly textInactive: string = '#FF1F2937'
  static readonly buttonPink: string = '#FFF4AECF'
  static readonly buttonText: string = '#FF2D0D1B'
  static readonly textDark: string = '#FF111827'
  static readonly textGray: string = '#FF6B7280'
  static readonly border: string = '#FFC4B5FD'
  static readonly purpleActiveCircle: string = '#FFA07CFF'
}

@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        HeaderView()

        Scroll() {
          Column() {
            Column() {
              Text('Steps')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(LwColors.textDark)
                .margin({ bottom: 20 })

              StepRow({ step: '1', title: 'Profile', subtitle: 'Tenant basics', btnText: 'Edit', isActive: true, isLast: false })
              StepRow({ step: '2', title: 'Income', subtitle: 'Proof details', btnText: 'Edit', isActive: true, isLast: false })
              StepRow({ step: '3', title: 'References', subtitle: 'Upload letters', btnText: 'Go', isActive: false, isLast: false })
              StepRow({ step: '4', title: 'Summary', subtitle: 'Confirm submission', btnText: 'Go', isActive: false, isLast: true })
            }
            .padding(24)
            .backgroundColor(LwColors.cardBg)
            .borderRadius(24)
            .alignItems(HorizontalAlign.Start)
            .margin({ bottom: 24 })

            Column() {
              Text('Form')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(LwColors.textDark)
                .margin({ bottom: 25 })

              CustomTextField({ label: 'Full name', text: 'Avery Tenant' })
              CustomTextField({ label: 'Contact', text: 'avery@example.com' })

              Blank().height(10)
            }
            .padding(24)
            .backgroundColor(LwColors.cardBg)
            .borderRadius(24)
            .alignItems(HorizontalAlign.Start)
          }
          .padding({ left: 16, right: 16, bottom: 40 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
    }
    .backgroundColor(LwColors.background)
    .width('100%')
    .height('100%')
  }
}

@Component
struct HeaderView {
  build() {
    Row() {
      Circle({ width: 44, height: 44 })
        .fill(LwColors.headerCircle)

      Blank()

      Column() {
        Text('LeaseWizard')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF000000')
        Text('Guided handoff')
          .fontSize(13)
          .fontColor(LwColors.textGray)
      }
      .margin({ top: 2, bottom: 2 })

      Blank()

      Circle({ width: 44, height: 44 })
        .fill(LwColors.headerCircle)
    }
    .padding({ left: 20, right: 20 })
    .margin({ top: 10, bottom: 10 })
  }
}

@Component
struct StepRow {
  @Prop step: string = ''
  @Prop title: string = ''
  @Prop subtitle: string = ''
  @Prop btnText: string = ''
  @Prop isActive: boolean = false
  @Prop isLast: boolean = false

  build() {
    Row() {
      Column() {
        Stack() {
          Circle({ width: 32, height: 32 })
            .fill(this.isActive ? LwColors.purpleActiveCircle : LwColors.purpleInactive)
          Text(this.step)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isActive ? '#FF000000' : LwColors.textDark)
        }
        .width(32)
        .height(32)

        if (!this.isLast) {
          Column() {
            Blank()
          }
          .width(2)
          .height(40)
          .backgroundColor(LwColors.headerCircle)
          .margin({ top: 0 })
        }
      }
      .width(32)

      Column() {
        Text(this.title)
          .fontSize(17)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(LwColors.textDark)
          .margin({ top: 4 })

        Text(this.subtitle)
          .fontSize(15)
          .fontColor(LwColors.textGray)
          .margin({ top: 2 })

        Blank().height(24)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text(this.btnText)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(LwColors.buttonText)
        .width(60)
        .height(36)
        .textAlign(TextAlign.Center)
        .backgroundColor(LwColors.buttonPink)
        .borderRadius(8)
        .margin({ top: 2 })
    }
    .alignItems(VerticalAlign.Top)
    .margin({ left: 0, right: 0 })
  }
}

@Component
struct CustomTextField {
  @Prop label: string = ''
  @Prop text: string = ''

  build() {
    Stack() {
      Row() {
        Text(this.text)
          .fontSize(18)
          .fontColor(LwColors.textDark)
        Blank()
      }
      .padding({ top: 16, bottom: 16, left: 16, right: 16 })
      .border({ width: 1, color: LwColors.border, radius: 12 })

      Text(this.label)
        .fontSize(14)
        .fontColor(LwColors.textGray)
        .padding({ left: 4, right: 4 })
        .backgroundColor(LwColors.cardBg)
        .borderRadius(2)
        .margin({ left: 12, top: -10 })
    }
    .alignContent(Alignment.TopStart)
    .margin({ top: 10 })
  }
}