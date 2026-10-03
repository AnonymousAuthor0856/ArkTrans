@Entry
@Component
struct LeaseWizardApp {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#FBFBFE')

      // Main column
      Column({ space: 0 }) {
        // Header
        Row({ space: 0 }) {
          // Left circle
          Column()
            .width(44)
            .height(44)
            .backgroundColor('#EEE9FC')
            .borderRadius(22)
          Blank()
          // Title
          Column({ space: 2 }) {
            Text('LeaseWizard')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .foregroundColor('#000000')
            Text('Guided handoff')
              .fontSize(13)
              .foregroundColor('#6B7280')
          }
          .alignItems(HorizontalAlign.Center)
          Blank()
          // Right circle
          Column()
            .width(44)
            .height(44)
            .backgroundColor('#EEE9FC')
            .borderRadius(22)
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })

        // Scrollable content using List
        List({ space: 24 }) {
          // Section: Steps
          ListItem() {
            Column({ space: 20 }) {
              Text('Steps')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .foregroundColor('#111827')
                .width('100%')

              // Step rows
              Column({ space: 0 }) {
                // Step 1
                this.buildStepRow('1', 'Profile', 'Tenant basics', 'Edit', true, false)
                // Step 2
                this.buildStepRow('2', 'Income', 'Proof details', 'Edit', true, false)
                // Step 3
                this.buildStepRow('3', 'References', 'Upload letters', 'Go', false, false)
                // Step 4
                this.buildStepRow('4', 'Summary', 'Confirm submission', 'Go', false, true)
              }
            }
            .padding(24)
            .backgroundColor('#F5F3FD')
            .borderRadius(24)
            .width('100%')
          }

          // Section: Form
          ListItem() {
            Column({ space: 25 }) {
              Text('Form')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .foregroundColor('#111827')
                .width('100%')

              // Custom TextFields with floating labels
              this.buildFloatingTextInput('Full name', 'Avery Tenant')
              this.buildFloatingTextInput('Contact', 'avery@example.com')

              Blank().height(10)
            }
            .padding(24)
            .backgroundColor('#F5F3FD')
            .borderRadius(24)
            .width('100%')
          }
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, bottom: 40 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildStepRow(step: string, title: string, subtitle: string, btnText: string, isActive: boolean, isLast: boolean) {
    Row({ space: 16 }) {
      // Left indicator column
      Column({ space: 0 }) {
        // Circle indicator
        Stack({ alignContent: Alignment.Center }) {
          Column()
            .width(32)
            .height(32)
            .borderRadius(16)
            .backgroundColor(isActive ? '#A07CFF' : '#EBE7F6')
          Text(step)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .foregroundColor(isActive ? '#000000' : '#1F2937')
        }
        .width(32)
        .height(32)
        // Connecting line (if not last)
        if (!isLast) {
          Divider()
            .width(2)
            .height(40)
            .color('#EEE9FC')
        }
      }
      .width(32)
      .alignItems(HorizontalAlign.Center)

      // Text content
      Column({ space: 2 }) {
        Text(title)
          .fontSize(17)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#111827')
          .margin({ top: 4 })
        Text(subtitle)
          .fontSize(15)
          .foregroundColor('#6B7280')
        // Spacer to match height
        Blank().height(24)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Action button
      Button() {
        Text(btnText)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#2D0D1B')
          .width(60)
          .height(36)
          .textAlign(TextAlign.Center)
      }
      .width(60)
      .height(36)
      .backgroundColor('#F4AECF')
      .borderRadius(8)
      .margin({ top: 2 })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  buildFloatingTextInput(label: string, value: string) {
    Stack({ alignContent: Alignment.TopStart }) {
      // Input field background and border
      Column()
        .width('100%')
        .height(50)
        .borderRadius(12)
        .border({ width: 1, color: '#C4B5FD' })
        .margin({ top: 10 }) // space for floating label

      // Input text
      TextInput({ placeholder: '', text: value })
        .fontSize(18)
        .foregroundColor('#111827')
        .padding({ left: 16, right: 16, top: 16, bottom: 16 })
        .width('100%')
        .backgroundColor('#F5F3FD')
        .borderRadius(12)
        .margin({ top: 10 })
        .enabled(false) // read-only display

      // Floating label
      Text(label)
        .fontSize(14)
        .foregroundColor('#6B7280')
        .padding({ left: 4, right: 4 })
        .backgroundColor('#F5F3FD')
        .position({ x: 12, y: 0 })
    }
    .width('100%')
  }
}