@Entry
@Component
struct LeaseWizardApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FBFBFE')
  }
}

@Component
struct ContentView {
  build() {
    Column({ space: 0 }) {
      HeaderView()
        .margin({ top: 10, bottom: 10 })

      Scroll() {
        Column({ space: 24 }) {
          // Section 1: Steps Container
          Column({ space: 20 }) {
            Text('Steps')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#111827')
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
          }
          .padding(24)
          .backgroundColor('#F5F3FD')
          .borderRadius(24)
          .width('100%')
          .alignItems(HorizontalAlign.Start)

          // Section 2: Form Container
          Column({ space: 25 }) {
            Text('Form')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#111827')
              .alignSelf(ItemAlign.Start)

            CustomTextField({ label: 'Full name', text: 'Avery Tenant' })
            CustomTextField({ label: 'Contact', text: 'avery@example.com' })

            Blank().height(10)
          }
          .padding(24)
          .backgroundColor('#F5F3FD')
          .borderRadius(24)
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .padding({ left: 16, right: 16, bottom: 40 })
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FBFBFE')
  }
}

@Component
struct HeaderView {
  build() {
    Row() {
      // Left Circle
      Circle()
        .fill('#EEE9FC')
        .width(44)
        .height(44)

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
          .fontColor('#6B7280')
      }

      Blank()

      // Right Circle
      Circle()
        .fill('#EEE9FC')
        .width(44)
        .height(44)
    }
    .width('100%')
    .padding({ left: 20, right: 20 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
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
      // Indicator Column
      Column({ space: 0 }) {
        Stack() {
          Circle()
            .fill(this.isActive ? '#A07CFF' : '#EBE7F6')
            .width(32)
            .height(32)

          Text(this.step)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isActive ? '#000000' : '#1F2937')
        }
        .width(32)
        .height(32)

        if (!this.isLast) {
          Column()
            .width(2)
            .height(40)
            .backgroundColor('#EEE9FC')
        }
      }
      .width(32)
      .alignItems(HorizontalAlign.Center)

      // Text Content
      Column({ space: 2 }) {
        Text(this.title)
          .fontSize(17)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1F2937')
          .margin({ top: 4 })
          .alignSelf(ItemAlign.Start)

        Text(this.subtitle)
          .fontSize(15)
          .fontWeight(FontWeight.Normal)
          .fontColor('#6B7280')
          .alignSelf(ItemAlign.Start)

        Blank().height(24)
      }
      .alignItems(HorizontalAlign.Start)
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
    Stack({ alignContent: Alignment.TopStart }) {
      // The Input Field Box
      Row() {
        Text(this.text)
          .fontSize(18)
          .fontWeight(FontWeight.Normal)
          .fontColor('#111827')
          .layoutWeight(1)
      }
      .width('100%')
      .padding({ top: 16, bottom: 16, left: 16, right: 16 })
      .border({ width: 1, color: '#C4B5FD', radius: 12 })
      .margin({ top: 8 })

      // The Floating Label
      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor('#6B7280')
        .padding({ left: 4, right: 4 })
        .backgroundColor('#F5F3FD')
        .offset({ x: 12, y: 0 })
    }
    .width('100%')
    .height(72)
  }
}