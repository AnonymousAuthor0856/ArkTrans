// entry/src/main/ets/pages/LeaseWizardPage.ets

@Entry
@Component
struct LeaseWizardPage {
  @State private steps: StepData[] = [
    new StepData("1", "Profile", "Tenant basics", "Edit", true),
    new StepData("2", "Income", "Proof details", "Edit", true),
    new StepData("3", "References", "Upload letters", "Go", false),
    new StepData("4", "Summary", "Confirm submission", "Go", false)
  ];

  build() {
    Column() {
      // Header Section
      Row() {
        Circle().width(44).height(44).fill('#EEE9FC')
        Spacer()
        Column() {
          Text('LeaseWizard').fontColor('#000000').fontWeight(FontWeight.Bold).fontSize(18)
          Text('Guided handoff').fontColor('#6B7280').fontSize(13).margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Center)
        Spacer()
        Circle().width(44).height(44).fill('#EEE9FC')
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })

      // Scrollable Content
      Scroll() {
        Column() {
          // Steps Card
          Column({ space: 20 }) {
            Text('Steps').fontColor('#111827').fontWeight(FontWeight.Bold).fontSize(22).alignSelf(ItemAlign.Start)
            
            Column() {
              ForEach(this.steps, (step: StepData, index: number) => {
                StepRowComponent(step: step, isLast: index === this.steps.length - 1)
              })
            }
          }
          .width('100%')
          .padding(24)
          .backgroundColor('#F5F3FD')
          .borderRadius(24)

          // Form Card
          Column({ space: 25 }) {
            Text('Form').fontColor('#111827').fontWeight(FontWeight.Bold).fontSize(22).alignSelf(ItemAlign.Start)
            
            CustomTextField(label: 'Full name', text: 'Avery Tenant')
            CustomTextField(label: 'Contact', text: 'avery@example.com')
            
            // Bottom spacer for scroll visibility
            Column().height(10)
          }
          .width('100%')
          .padding(24)
          .backgroundColor('#F5F3FD')
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
    .backgroundColor('#FBFBFE')
  }
}

class StepData {
  step: string;
  title: string;
  subtitle: string;
  btnText: string;
  isActive: boolean;

  constructor(step: string, title: string, subtitle: string, btnText: string, isActive: boolean) {
    this.step = step;
    this.title = title;
    this.subtitle = subtitle;
    this.btnText = btnText;
    this.isActive = isActive;
  }
}

@Component
struct StepRowComponent {
  @Prop step: StepData;
  @Prop isLast: boolean;

  build() {
    Row() {
      // Indicator Column
      Column() {
        Stack() {
          Circle()
            .width(32)
            .height(32)
            .fill(this.step.isActive ? '#A07CF0' : '#EBE7F6')
          
          Text(this.step.step)
            .fontColor(this.step.isActive ? '#000000' : '#1F2937')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
        }
        
        if (!this.isLast) {
          Rectangle()
            .width(2)
            .height(40)
            .fill('#EEE9FC')
        }
      }
      .width(32)
      .alignItems(HorizontalAlign.Center)

      // Text Content
      Column({ space: 2 }) {
        Text(this.step.title)
          .fontColor('#111827')
          .fontWeight(FontWeight.SemiBold)
          .fontSize(17)
          .margin({ top: 4 })
        
        Text(this.step.subtitle)
          .fontColor('#6B7280')
          .fontSize(15)
        
        Column().height(24) // Spacer to align with button height roughly
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Action Button
      Button(this.step.btnText) {
        Text(this.step.btnText)
          .fontColor('#2D0D1B')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
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
}

@Component
struct CustomTextField {
  @Prop label: string;
  @Prop text: string;

  build() {
    Stack({ alignRule: Alignment.TopStart }) {
      // Input Box
      Row() {
        Text(this.text)
          .fontColor('#111827')
          .fontSize(18)
        Spacer()
      }
      .width('100%')
      .padding(16)
      .border({ width: 1, color: '#C4B5FD', radius: 12 })

      // Floating Label
      Text(this.label)
        .fontColor('#6B7280')
        .fontSize(14)
        .backgroundColor('#F5F3FD')
        .padding({ left: 4, right: 4 })
        .position({ x: 12, y: -10 })
    }
    .width('100%')
  }
}