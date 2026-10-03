// MARK: - Color Palette
const LW = {
  background: '#FBFBFE',
  cardBg: '#F5F3FD',
  headerCircle: '#EEE9FC',
  purpleActive: '#8B5CF6',
  purpleInactive: '#EBE7F6',
  textInactive: '#1F2937',
  buttonPink: '#F4AECF',
  buttonText: '#2D0D1B',
  textDark: '#111827',
  textGray: '#6B7280',
  border: '#C4B5FD',
  activeCircle: '#A07C01'
};

// MARK: - ContentView
@Component
struct ContentView {
  build() {
    Stack() {
      Column({ space: 0 }) {
        HeaderView()
          .padding({ top: 10, bottom: 10 })

        Scroll() {
          Column({ space: 24 }) {
            // Section 1: Steps Container
            Column({ space: 20 }) {
              Text('Steps')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(LW.textDark)

              Column({ space: 0 }) {
                StepRow({ step: '1', title: 'Profile', subtitle: 'Tenant basics', btnText: 'Edit', isActive: true, isLast: false })
                StepRow({ step: '2', title: 'Income', subtitle: 'Proof details', btnText: 'Edit', isActive: true, isLast: false })
                StepRow({ step: '3', title: 'References', subtitle: 'Upload letters', btnText: 'Go', isActive: false, isLast: false })
                StepRow({ step: '4', title: 'Summary', subtitle: 'Confirm submission', btnText: 'Go', isActive: false, isLast: true })
              }
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding(24)
            .backgroundColor(LW.cardBg)
            .borderRadius(24)

            // Section 2: Form Container
            Column({ space: 25 }) {
              Text('Form')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(LW.textDark)

              CustomTextField({ label: 'Full name', text: 'Avery Tenant' })
              CustomTextField({ label: 'Contact', text: 'avery@example.com' })

              Row()
                .height(10)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding(24)
            .backgroundColor(LW.cardBg)
            .borderRadius(24)
          }
          .padding({ left: 16, right: 16, bottom: 40 })
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(LW.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.ALL])
  }
}

// MARK: - HeaderView
@Component
struct HeaderView {
  build() {
    Row() {
      Row()
        .width(44)
        .height(44)
        .backgroundColor(LW.headerCircle)
        .borderRadius(22)

      Blank()

      Column({ space: 2 }) {
        Text('LeaseWizard')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text('Guided handoff')
          .fontSize(13)
          .fontWeight(FontWeight.Regular)
          .fontColor(LW.textGray)
      }

      Blank()

      Row()
        .width(44)
        .height(44)
        .backgroundColor(LW.headerCircle)
        .borderRadius(22)
    }
    .alignItems(VerticalAlign.Center)
    .padding({ left: 20, right: 20 })
  }
}

// MARK: - StepRow
@Component
struct StepRow {
  @Prop step: string = '';
  @Prop title: string = '';
  @Prop subtitle: string = '';
  @Prop btnText: string = '';
  @Prop isActive: boolean = false;
  @Prop isLast: boolean = false;

  build() {
    Row({ space: 16 }) {
      // Indicator Column
      Column({ space: 0 }) {
        Stack() {
          Row()
            .width(32)
            .height(32)
            .backgroundColor(this.isActive ? LW.activeCircle : LW.purpleInactive)
            .borderRadius(16)

          Text(this.step)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isActive ? '#000000' : LW.textDark)
        }

        if (!this.isLast) {
          Row()
            .width(2)
            .height(40)
            .backgroundColor(LW.headerCircle)
        }
      }
      .width(32)

      // Text Content
      Column({ space: 2 }) {
        Text(this.title)
          .fontSize(17)
          .fontWeight(FontWeight.Semibold)
          .fontColor(LW.textDark)
          .padding({ top: 4 })
        Text(this.subtitle)
          .fontSize(15)
          .fontWeight(FontWeight.Regular)
          .fontColor(LW.textGray)
        Row()
          .height(24)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      // Action Button
      Button() {
        Text(this.btnText)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(LW.buttonText)
          .width(60)
          .height(36)
          .backgroundColor(LW.buttonPink)
          .borderRadius(8)
      }
      .onClick(() => {})
      .padding({ top: 2 })
    }
    .alignItems(VerticalAlign.Top)
    .width('100%')
  }
}

// MARK: - CustomTextField
@Component
struct CustomTextField {
  @Prop label: string = '';
  @Prop text: string = '';

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Row() {
        Text(this.text)
          .fontSize(18)
          .fontWeight(FontWeight.Regular)
          .fontColor(LW.textDark)
        Blank()
      }
      .width('100%')
      .padding({ top: 16, bottom: 16, left: 16, right: 16 })
      .borderRadius(12)
      .border({ width: 1, color: LW.border })

      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(LW.textGray)
        .padding({ left: 4, right: 4 })
        .backgroundColor(LW.cardBg)
        .offset({ x: 12, y: -10 })
    }
    .width('100%')
  }
}

// MARK: - LeaseWizardApp
@Entry
@Component
struct LeaseWizardApp {
  build() {
    ContentView()
  }
}
