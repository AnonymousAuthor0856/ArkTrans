// Color constants
const lwBackground = '#FBFBFE';
const lwCardBg = '#F5F3FD';
const lwHeaderCircle = '#EEE9FC';
const lwPurpleInactive = '#EBE7F6';
const lwButtonPink = '#F4AECF';
const lwButtonText = '#2D0D1B';
const lwTextDark = '#111827';
const lwTextGray = '#6B7280';
const lwBorder = '#C4B5FD';
const lwPurpleActiveDot = '#A07CFF';

@Entry
@Component
struct LeaseWizardApp {
  build() {
    Stack() {
      // Global Background
      Column() {}
      .width('100%')
      .height('100%')
      .backgroundColor(lwBackground)

      Column({ space: 0 }) {
        // Header
        HeaderView()
          .margin({ top: 10, bottom: 10 })

        // ScrollView
        Scroll() {
          Column({ space: 24 }) {
            // Section 1: Steps Container
            Column({ space: 20 }) {
              Text('Steps')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(lwTextDark)
                .alignSelf(ItemAlign.Start)

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
            .backgroundColor(lwCardBg)
            .borderRadius(24)
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            // Section 2: Form Container
            Column({ space: 25 }) {
              Text('Form')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(lwTextDark)
                .alignSelf(ItemAlign.Start)

              CustomTextField({ label: 'Full name', text: 'Avery Tenant' })
              CustomTextField({ label: 'Contact', text: 'avery@example.com' })

              // Bottom padding spacer
              Column() {}
              .height(10)
            }
            .padding(24)
            .backgroundColor(lwCardBg)
            .borderRadius(24)
            .width('100%')
            .alignItems(HorizontalAlign.Start)
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
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct HeaderView {
  build() {
    Row() {
      // Left Circle
      Column() {}
      .width(44)
      .height(44)
      .borderRadius(22)
      .backgroundColor(lwHeaderCircle)

      Blank()

      // Title Block
      Column({ space: 2 }) {
        Text('LeaseWizard')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text('Guided handoff')
          .fontSize(13)
          .fontWeight(FontWeight.Normal)
          .fontColor(lwTextGray)
      }
      .alignItems(HorizontalAlign.Center)

      Blank()

      // Right Circle
      Column() {}
      .width(44)
      .height(44)
      .borderRadius(22)
      .backgroundColor(lwHeaderCircle)
    }
    .width('100%')
    .padding({ left: 20, right: 20 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

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
        // Circle with step number
        Stack() {
          Column() {}
          .width(32)
          .height(32)
          .borderRadius(16)
          .backgroundColor(this.isActive ? lwPurpleActiveDot : lwPurpleInactive)

          Text(this.step)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isActive ? '#000000' : lwTextDark)
        }
        .width(32)
        .height(32)

        // Vertical Connecting Line
        if (!this.isLast) {
          Column() {}
          .width(2)
          .height(64)
          .backgroundColor(lwHeaderCircle)
        }
      }
      .width(32)
      .alignItems(HorizontalAlign.Center)

      // Text Content
      Column({ space: 2 }) {
        Text(this.title)
          .fontSize(17)
          .fontWeight(FontWeight.Medium)
          .fontColor(lwTextDark)
          .margin({ top: 4 })
          .alignSelf(ItemAlign.Start)

        Text(this.subtitle)
          .fontSize(15)
          .fontWeight(FontWeight.Normal)
          .fontColor(lwTextGray)
          .alignSelf(ItemAlign.Start)

        Column() {}
        .height(24)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Action Button
      Button(this.btnText)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(lwButtonText)
        .width(60)
        .height(36)
        .backgroundColor(lwButtonPink)
        .borderRadius(8)
        .margin({ top: 2 })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct CustomTextField {
  @Prop label: string = '';
  @Prop text: string = '';

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // The Input Field Box
      Row() {
        Text(this.text)
          .fontSize(18)
          .fontWeight(FontWeight.Normal)
          .fontColor(lwTextDark)
          .layoutWeight(1)
      }
      .width('100%')
      .padding({ top: 16, bottom: 16, left: 16, right: 16 })
      .border({
        width: 1,
        color: lwBorder,
        radius: 12,
        style: BorderStyle.Solid
      })

      // Floating Label
      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(lwTextGray)
        .padding({ left: 4, right: 4 })
        .backgroundColor(lwCardBg)
        .offset({ x: 12, y: -10 })
    }
    .width('100%')
    .margin({ top: 8 })
  }
}