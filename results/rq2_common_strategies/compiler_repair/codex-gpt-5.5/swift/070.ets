class LeaseColors {
  static background: string = '#FBFBFE'
  static cardBg: string = '#F5F3FD'
  static headerCircle: string = '#EEE9FC'
  static purpleActive: string = '#8B5CF6'
  static purpleInactive: string = '#EBE7F6'
  static textInactive: string = '#1F2937'
  static buttonPink: string = '#F4AECF'
  static buttonText: string = '#2D0D1B'
  static textDark: string = '#111827'
  static textGray: string = '#6B7280'
  static border: string = '#C4B5FD'
}

class StepData {
  step: string
  title: string
  subtitle: string
  btnText: string
  isActive: boolean
  isLast: boolean

  constructor(step: string, title: string, subtitle: string, btnText: string, isActive: boolean, isLast: boolean) {
    this.step = step
    this.title = title
    this.subtitle = subtitle
    this.btnText = btnText
    this.isActive = isActive
    this.isLast = isLast
  }
}

@Entry
@Component
struct Index {
  private steps: StepData[] = [
    new StepData('1', 'Profile', 'Tenant basics', 'Edit', true, false),
    new StepData('2', 'Income', 'Proof details', 'Edit', true, false),
    new StepData('3', 'References', 'Upload letters', 'Go', false, false),
    new StepData('4', 'Summary', 'Confirm submission', 'Go', false, true)
  ]

  @Builder
  HeaderView() {
    Row() {
      Circle()
        .width(44)
        .height(44)
        .fill(LeaseColors.headerCircle)

      Blank()
        .layoutWeight(1)

      Column({ space: 2 }) {
        Text('LeaseWizard')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text('Guided handoff')
          .fontSize(13)
          .fontColor(LeaseColors.textGray)
      }
      .alignItems(HorizontalAlign.Center)

      Blank()
        .layoutWeight(1)

      Circle()
        .width(44)
        .height(44)
        .fill(LeaseColors.headerCircle)
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 10, bottom: 10 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  StepRow(item: StepData) {
    Row({ space: 16 }) {
      Column() {
        Stack() {
          Circle()
            .width(32)
            .height(32)
            .fill(item.isActive ? '#A07C01' : LeaseColors.purpleInactive)
          Text(item.step)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(item.isActive ? '#000000' : LeaseColors.textDark)
        }
        .width(32)
        .height(32)

        if (!item.isLast) {
          Rect()
            .width(2)
            .height(40)
            .fill(LeaseColors.headerCircle)
        }
      }
      .width(32)

      Column({ space: 2 }) {
        Text(item.title)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(LeaseColors.textDark)
          .margin({ top: 4 })
        Text(item.subtitle)
          .fontSize(15)
          .fontColor(LeaseColors.textGray)
        Blank()
          .height(24)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button(item.btnText)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(LeaseColors.buttonText)
        .width(60)
        .height(36)
        .backgroundColor(LeaseColors.buttonPink)
        .borderRadius(8)
        .margin({ top: 2 })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  CustomTextField(label: string, text: string) {
    Stack({ alignContent: Alignment.TopStart }) {
      Row() {
        Text(text)
          .fontSize(18)
          .fontColor(LeaseColors.textDark)
        Blank()
          .layoutWeight(1)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .border({ width: 1, color: LeaseColors.border, radius: 12 })

      Text(label)
        .fontSize(14)
        .fontColor(LeaseColors.textGray)
        .padding({ left: 4, right: 4 })
        .backgroundColor(LeaseColors.cardBg)
        .margin({ left: 12, top: -10 })
    }
    .width('100%')
  }

  build() {
    Stack() {
      Column() {
        this.HeaderView()

        Scroll() {
          Column({ space: 24 }) {
            Column({ space: 20 }) {
              Text('Steps')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(LeaseColors.textDark)
                .width('100%')
                .textAlign(TextAlign.Start)

              Column() {
                ForEach(this.steps, (item: StepData) => {
                  this.StepRow(item)
                })
              }
              .width('100%')
            }
            .width('100%')
            .padding(24)
            .backgroundColor(LeaseColors.cardBg)
            .borderRadius(24)

            Column({ space: 25 }) {
              Text('Form')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(LeaseColors.textDark)
                .width('100%')
                .textAlign(TextAlign.Start)

              this.CustomTextField('Full name', 'Avery Tenant')
              this.CustomTextField('Contact', 'avery@example.com')

              Blank()
                .height(10)
            }
            .width('100%')
            .padding(24)
            .backgroundColor(LeaseColors.cardBg)
            .borderRadius(24)
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 40 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(LeaseColors.background)
  }
}
