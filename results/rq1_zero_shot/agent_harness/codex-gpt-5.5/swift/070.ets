class LeaseColors {
  static background: string = '#FBFBFE';
  static cardBg: string = '#F5F3FD';
  static headerCircle: string = '#EEE9FC';
  static purpleActive: string = '#8B5CF6';
  static purpleInactive: string = '#EBE7F6';
  static textInactive: string = '#1F2937';
  static buttonPink: string = '#F4AECF';
  static buttonText: string = '#2D0D1B';
  static textDark: string = '#111827';
  static textGray: string = '#6B7280';
  static border: string = '#C4B5FD';
}

@Entry
@Component
struct ContentView {
  @Builder
  private HeaderView() {
    Row() {
      Circle()
        .width(44)
        .height(44)
        .fill(LeaseColors.headerCircle)
      Blank()
      Column({ space: 2 }) {
        Text('LeaseWizard')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text('Guided handoff')
          .fontSize(13)
          .fontColor(LeaseColors.textGray)
      }
      Blank()
      Circle()
        .width(44)
        .height(44)
        .fill(LeaseColors.headerCircle)
    }
    .padding({ left: 20, right: 20 })
    .width('100%')
  }

  @Builder
  private StepRow(step: string, title: string, subtitle: string, btnText: string, isActive: boolean, isLast: boolean) {
    Row({ space: 16 }) {
      Column({ space: 0 }) {
        Stack() {
          Circle()
            .width(32)
            .height(32)
            .fill(isActive ? '#A07C01' : LeaseColors.purpleInactive)
          Text(step)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(isActive ? Color.Black : LeaseColors.textDark)
        }
        .width(32)
        .height(32)
        if (!isLast) {
          Rect()
            .width(2)
            .height(40)
            .fill(LeaseColors.headerCircle)
        }
      }
      .width(32)

      Column({ space: 2 }) {
        Text(title)
          .fontSize(17)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(LeaseColors.textDark)
          .margin({ top: 4 })
        Text(subtitle)
          .fontSize(15)
          .fontColor(LeaseColors.textGray)
        Blank()
          .height(24)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button(btnText)
        .width(60)
        .height(36)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(LeaseColors.buttonText)
        .backgroundColor(LeaseColors.buttonPink)
        .borderRadius(8)
        .margin({ top: 2 })
    }
    .alignItems(VerticalAlign.Top)
    .width('100%')
  }

  @Builder
  private CustomTextField(label: string, text: string) {
    Stack({ alignContent: Alignment.TopStart }) {
      Row() {
        Text(text)
          .fontSize(18)
          .fontColor(LeaseColors.textDark)
        Blank()
      }
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .width('100%')
      .border({ width: 1, color: LeaseColors.border })
      .borderRadius(12)

      Text(label)
        .fontSize(14)
        .fontColor(LeaseColors.textGray)
        .padding({ left: 4, right: 4 })
        .backgroundColor(LeaseColors.cardBg)
        .position({ x: 58, y: 0 })
    }
    .width('100%')
    .height(58)
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        this.HeaderView()
          .padding({ top: 10, bottom: 10 })

        Scroll() {
          Column({ space: 24 }) {
            Column({ space: 20 }) {
              Text('Steps')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(LeaseColors.textDark)
                .width('100%')
                .textAlign(TextAlign.Start)

              Column({ space: 0 }) {
                this.StepRow('1', 'Profile', 'Tenant basics', 'Edit', true, false)
                this.StepRow('2', 'Income', 'Proof details', 'Edit', true, false)
                this.StepRow('3', 'References', 'Upload letters', 'Go', false, false)
                this.StepRow('4', 'Summary', 'Confirm submission', 'Go', false, true)
              }
              .width('100%')
            }
            .alignItems(HorizontalAlign.Start)
            .padding(24)
            .width('100%')
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
            .alignItems(HorizontalAlign.Start)
            .padding(24)
            .width('100%')
            .backgroundColor(LeaseColors.cardBg)
            .borderRadius(24)
          }
          .padding({ left: 16, right: 16, bottom: 40 })
          .width('100%')
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(LeaseColors.background)
  }
}
