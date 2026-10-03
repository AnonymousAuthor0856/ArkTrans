import { window } from '@kit.ArkUI';

@Entry
@Component
struct LeaseWizardApp {
  build() {
    Column() {
      Stack({ alignContent: Alignment.TopStart }) {
        // Global Background
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('#FBFBFE')

        Column() {
          // Header
          Row() {
            // Left Circle
            Circle()
              .fill('#EEE9FC')
              .width(44)
              .height(44)

            Flex().layoutWeight(1)

            // Title Block
            Column() {
              Text('LeaseWizard')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
              
              Text('Guided handoff')
                .fontSize(13)
                .fontWeight(FontWeight.Regular)
                .fontColor('#6B7280')
            }.alignItems(HorizontalAlign.Center).justifyContent(FlexAlign.Start)

            Flex().layoutWeight(1)

            // Right Circle
            Circle()
              .fill('#EEE9FC')
              .width(44)
              .height(44)
          }
          .padding({ left: 20, right: 20, top: 10, bottom: 10 })
          .width('100%')

          // Scrollable Content
          Scroll() {
            Column({ space: 24 }) {
              
              // Section 1: Steps Container
              Column({ space: 20 }) {
                Text('Steps')
                  .fontSize(22)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#111827')
                  .alignSelf(ItemAlign.Start)

                Column() {
                  StepRowComponent({
                    step: '1',
                    title: 'Profile',
                    subtitle: 'Tenant basics',
                    btnText: 'Edit',
                    isActive: true,
                    isLast: false
                  })
                  
                  StepRowComponent({
                    step: '2',
                    title: 'Income',
                    subtitle: 'Proof details',
                    btnText: 'Edit',
                    isActive: true,
                    isLast: false
                  })
                  
                  StepRowComponent({
                    step: '3',
                    title: 'References',
                    subtitle: 'Upload letters',
                    btnText: 'Go',
                    isActive: false,
                    isLast: false
                  })
                  
                  StepRowComponent({
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

              // Section 2: Form Container
              Column({ space: 25 }) {
                Text('Form')
                  .fontSize(22)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#111827')
                  .alignSelf(ItemAlign.Start)

                CustomTextFieldComponent({ label: 'Full name', text: 'Avery Tenant' })
                
                CustomTextFieldComponent({ label: 'Contact', text: 'avery@example.com' })
                
                // Spacer to ensure bottom padding visible in scroll
                Column().height(10)
              }
              .padding(24)
              .backgroundColor('#F5F3FD')
              .borderRadius(24)
              .width('100%')
            }
            .padding({ left: 16, right: 16, bottom: 40 })
            .width('100%')
          }
          .layoutWeight(1)
          .width('100%')
          .scrollBar(BarState.Off)
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .systemBar({ statusBar: { visibility: window.BarVisibility.Auto, style: window.BarStyle.Light } })
  }
}

@Component
struct StepRowComponent {
  step: string = ''
  title: string = ''
  subtitle: string = ''
  btnText: string = ''
  isActive: boolean = false
  isLast: boolean = false

  build() {
    Row() {
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
            .fontColor(this.isActive ? '#000000' : '#1F2937')
        }
        
        if (!this.isLast) {
          Rect()
            .fill('#EEE9FC')
            .width(2)
            .height(40)
        }
      }
      .width(32)
      .alignItems(HorizontalAlign.Center)

      // Text Content
      Column({ space: 2 }) {
        Text(this.title)
          .fontSize(17)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111827')
          .padding({ top: 4 })
        
        Text(this.subtitle)
          .fontSize(15)
          .fontWeight(FontWeight.Regular)
          .fontColor('#6B7280')
        
        Column().height(24)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Action Button
      Button() {
        Text(this.btnText)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2D0D1B')
      }
      .width(60)
      .height(36)
      .backgroundColor('#F4AECF')
      .borderRadius(8)
      .type(ButtonType.Normal)
      .margin({ top: 2 })
    }
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct CustomTextFieldComponent {
  label: string = ''
  text: string = ''

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
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
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