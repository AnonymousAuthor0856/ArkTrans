import { UIContext } from '@kit.ArkUI';

// MARK: - 1. Entry Point
@Entry
@Component
struct LeaseWizardApp {
  build() {
    Column() {
      ContentView()
    }
    .backgroundColor('#FBFBFE')
    .width('100%')
    .height('100%')
    .statusBarColor(Color.Transparent)
  }
}

// MARK: - 2. Main Content View
@Component
struct ContentView {
  build() {
    Column() {
      HeaderView()
        .padding({ top: 10, bottom: 10 })

      Scroll() {
        Column({ space: 24 }) {
          // Section 1: Steps Container
          Column({ space: 20 }) {
            Text("Steps")
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#111827')
              .alignSelf(ItemAlign.Start)

            Column() {
              StepRow({
                step: "1",
                title: "Profile",
                subtitle: "Tenant basics",
                btnText: "Edit",
                isActive: true,
                isLast: false
              })

              StepRow({
                step: "2",
                title: "Income",
                subtitle: "Proof details",
                btnText: "Edit",
                isActive: true,
                isLast: false
              })

              StepRow({
                step: "3",
                title: "References",
                subtitle: "Upload letters",
                btnText: "Go",
                isActive: false,
                isLast: false
              })

              StepRow({
                step: "4",
                title: "Summary",
                subtitle: "Confirm submission",
                btnText: "Go",
                isActive: false,
                isLast: true
              })
            }
          }
          .padding(24)
          .backgroundColor('#F5F3FD')
          .borderRadius(24)

          // Section 2: Form Container
          Column({ space: 25 }) {
            Text("Form")
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#111827')
              .alignSelf(ItemAlign.Start)

            CustomTextField({ label: "Full name", text: "Avery Tenant" })
            CustomTextField({ label: "Contact", text: "avery@example.com" })

            // Spacer to ensure bottom padding visible in scroll
            Column().height(10)
          }
          .padding(24)
          .backgroundColor('#F5F3FD')
          .borderRadius(24)
        }
        .padding({ left: 16, right: 16, bottom: 40 })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
    }
    .width('100%')
  }
}

// MARK: - 3. Components

@Component
struct HeaderView {
  build() {
    Row() {
      // Left Circle
      Circle()
        .fill('#EEE9FC')
        .width(44)
        .height(44)

      Flex().layoutWeight(1)

      // Title Block
      Column({ space: 2 }) {
        Text("LeaseWizard")
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text("Guided handoff")
          .fontSize(13)
          .fontWeight(FontWeight.Regular)
          .fontColor('#6B7280')
      }

      Flex().layoutWeight(1)

      // Right Circle
      Circle()
        .fill('#EEE9FC')
        .width(44)
        .height(44)
    }
    .padding({ left: 20, right: 20 })
    .width('100%')
  }
}

@Component
struct StepRow {
  @Prop step: string
  @Prop title: string
  @Prop subtitle: string
  @Prop btnText: string
  @Prop isActive: boolean
  @Prop isLast: boolean

  build() {
    Row({ space: 16 }) {
      // Indicator Column
      Column() {
        Stack() {
          Circle()
            .fill(this.isActive ? '#A07CF6' : '#EBE7F6')
            .width(32)
            .height(32)

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
            .height(40)
        }
      }
      .width(32)

      // Text Content
      Column({ space: 2 }) {
        Text(this.title)
          .fontSize(17)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1F2937')
          .padding({ top: 4 })
          .alignSelf(ItemAlign.Start)

        Text(this.subtitle)
          .fontSize(15)
          .fontWeight(FontWeight.Regular)
          .fontColor('#6B7280')
          .alignSelf(ItemAlign.Start)

        Column().height(24)
      }
      .layoutWeight(1)

      // Action Button
      Button(this.btnText) {
        // Action
      }
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor('#2D0D1B')
      .backgroundColor('#F4AECF')
      .borderRadius(8)
      .width(60)
      .height(36)
      .margin({ top: 2 })
    }
    .width('100%')
  }
}

@Component
struct CustomTextField {
  @Prop label: string
  @Prop text: string

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // The Input Field Box
      Row() {
        Text(this.text)
          .fontSize(18)
          .fontWeight(FontWeight.Regular)
          .fontColor('#111827')
        Flex().layoutWeight(1)
      }
      .padding({ top: 16, bottom: 16, left: 16, right: 16 })
      .border({ width: 1, color: '#C4B5FD', radius: 12 })
      .width('100%')

      // The Floating Label
      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor('#6B7280')
        .backgroundColor('#F5F3FD')
        .padding({ left: 4, right: 4 })
        .position({ x: 12, y: -10 })
    }
    .width('100%')
  }
}