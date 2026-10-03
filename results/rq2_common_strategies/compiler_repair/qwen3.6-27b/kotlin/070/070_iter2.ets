import { router } from '@kit.ArkUI'

// Design Tokens and Constants
const NAME = "160*LeaseWizard*en"
const UI_TYPE = "Wizard"
const STYLE_THEME = "Soft Pastel"
const LANG = "en"
const BASELINE_SIZE = "720x1280"
const COLOR_PALETTE = "primary:#A07CFF secondary:#F6B4D7 tertiary:#8DD3C7 background:#FDF8FF surface:#FFFFFF surfaceVariant:#EFE7FF outline:#C9B4E6 success:#6ED8A0 warning:#FCD277 error:#FF8899 onPrimary:#1D0F33 onSecondary:#2B0E1C onTertiary:#06231C onBackground:#1C1126 onSurface:#24132C"
const DENSITY_SPACING = "Compact"
const COMPLEXITY = "Stepper,Form,Summary"
const EXTRA = "Soft pastel lease wizard with step chips and summary card"

interface WizardStep {
  title: string;
  description: string;
}

interface SummaryItem {
  label: string;
  value: string;
}

interface DocumentChecklist {
  label: string;
  status: string;
}

@Entry
@Component
struct LeaseWizardApp {
  @State currentStep: number = 1
  @State name: string = "Avery Tenant"
  @State contact: string = "avery@example.com"
  @State income: string = "$120k annual"

  // Data initialization
  private steps: WizardStep[] = [
    { title: "Profile", description: "Tenant basics" },
    { title: "Income", description: "Proof details" },
    { title: "References", description: "Upload letters" },
    { title: "Summary", description: "Confirm submission" }
  ]

  private summaryItems: SummaryItem[] = [
    { label: "Lease start", value: "Aug 12" },
    { label: "Monthly", value: "$2,450" },
    { label: "Deposit", value: "$2,450" },
    { label: "Pets", value: "2 approved" }
  ]

  private checklist: DocumentChecklist[] = [
    { label: "ID verification", status: "Uploaded" },
    { label: "Employment letter", status: "Pending" },
    { label: "Credit report", status: "Synced" }
  ]

  build() {
    Column() {
      // Top Bar
      Row() {
        // Navigation Icon (Left)
        Button() {
          Circle({ width: '30vp', height: '30vp' })
            .fill('#EFE7FF')
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
        .onClick(() => {
          // Placeholder for back action
        })

        Flex().layoutWeight(1)

        // Title Center
        Column() {
          Text("LeaseWizard")
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor('#24132C')
          Text("Guided handoff")
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor('#24132C')
            .opacity(0.7)
        }
        .alignItems(HorizontalAlign.Center)

        Flex().layoutWeight(1)

        // Action Icon (Right)
        Button() {
          Circle({ width: '30vp', height: '30vp' })
            .fill('#A07CFF')
            .opacity(0.3)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
        .onClick(() => {
          // Placeholder for menu action
        })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      .backgroundColor('#FDF8FF')

      // Scrollable Content Area
      Scroll() {
        Column() {
          // Steps Card
          this.StepsCard()

          // Form Card
          this.FormCard()

          // Summary Card
          this.SummaryCard()
          
          // Bottom padding for scroll
          Blank().height(40)
        }
        .padding({ left: 20, right: 20, top: 16 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FDF8FF')
  }

  @Builder
  StepsCard() {
    Column() {
      Text("Steps")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#24132C')
        .margin({ bottom: 12 })

      ForEach(this.steps, (step: WizardStep, index: number) => {
        Row() {
          // Stepper Indicator
          Column() {
            Row() {
              Text(`${index + 1}`)
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .fontColor(index <= this.currentStep ? '#1D0F33' : '#24132C')
                .textAlign(TextAlign.Center)
                .width('28vp')
                .height('28vp')
                .lineHeight(28)
            }
            .justifyContent(FlexAlign.Center)
            .borderRadius(14)
            .backgroundColor(index <= this.currentStep ? '#A07CFF' : '#EFE7FF')

            if (index !== this.steps.length - 1) {
              Divider()
                .width(4)
                .height(32)
                .color('#EFE7FF')
                .margin({ top: 2, bottom: 2 })
            }
          }
          .alignItems(HorizontalAlign.Center)

          Flex().width(16)

          // Step Details
          Column() {
            Text(step.title)
              .fontSize(15)
              .fontWeight(FontWeight.Medium)
              .fontColor('#24132C')
            Text(step.description)
              .fontSize(13)
              .fontWeight(FontWeight.Normal)
              .fontColor('#24132C')
              .opacity(0.7)
              .margin({ top: 2 })
          }
          .layoutWeight(1)

          // Action Button
          Button(index <= this.currentStep ? "Edit" : "Go")
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor('#2B0E1C')
            .backgroundColor('#F6B4D7')
            .borderRadius(8)
            .height(32)
            .width(50)
            .onClick(() => {
              this.currentStep = index
            })
        }
        .width('100%')
        .margin({ bottom: index === this.steps.length - 1 ? 0 : 16 })
      })
    }
    .padding(16)
    .borderRadius(24)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 8, color: 'rgba(0,0,0,0.16)', offsetY: 4 })
    .margin({ bottom: 16 })
  }

  @Builder
  FormCard() {
    Column() {
      Text("Form")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#24132C')
        .margin({ bottom: 12 })

      // Name Field
      TextInput({ placeholder: 'Full name', text: this.name })
        .type(InputType.Normal)
        .width('100%')
        .height(56)
        .borderRadius(8)
        .border({ width: 1, color: '#C9B4E6' })
        .backgroundColor('#FFFFFF')
        .onChange((value: string) => {
          this.name = value
        })
        .margin({ bottom: 12 })

      // Contact Field
      TextInput({ placeholder: 'Contact', text: this.contact })
        .type(InputType.Email)
        .width('100%')
        .height(56)
        .borderRadius(8)
        .border({ width: 1, color: '#C9B4E6' })
        .backgroundColor('#FFFFFF')
        .onChange((value: string) => {
          this.contact = value
        })
        .margin({ bottom: 12 })

      // Income Field
      TextInput({ placeholder: 'Income', text: this.income })
        .type(InputType.Number)
        .width('100%')
        .height(56)
        .borderRadius(8)
        .border({ width: 1, color: '#C9B4E6' })
        .backgroundColor('#FFFFFF')
        .onChange((value: string) => {
          this.income = value
        })
        .margin({ bottom: 16 })

      // Navigation Buttons
      Row() {
        Button("Back")
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor('#24132C')
          .backgroundColor('#EFE7FF')
          .borderRadius(14)
          .height(48)
          .layoutWeight(1)
          .margin({ right: 12 })
          .onClick(() => {
            if (this.currentStep > 0) {
              this.currentStep -= 1
            }
          })

        Button(this.currentStep === this.steps.length - 1 ? "Submit" : "Next")
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1D0F33')
          .backgroundColor('#A07CFF')
          .borderRadius(14)
          .height(48)
          .layoutWeight(1)
          .onClick(() => {
            if (this.currentStep < this.steps.length - 1) {
              this.currentStep += 1
            }
          })
      }
      .width('100%')
    }
    .padding(16)
    .borderRadius(24)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 8, color: 'rgba(0,0,0,0.16)', offsetY: 4 })
    .margin({ bottom: 16 })
  }

  @Builder
  SummaryCard() {
    Column() {
      Text("Summary")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#24132C')
        .margin({ bottom: 12 })

      // Summary Items
      ForEach(this.summaryItems, (item: SummaryItem) => {
        Row() {
          Text(item.label)
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor('#24132C')
            .layoutWeight(1)
          Text(item.value)
            .fontSize(13)
            .fontWeight(FontWeight.Normal)
            .fontColor('#24132C')
        }
        .width('100%')
        .padding(12)
        .borderRadius(14)
        .backgroundColor('#EFE7FF')
        .margin({ bottom: 8 })
      })

      // Documents Section
      Column() {
        Text("Documents")
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor('#24132C')
          .margin({ bottom: 8 })

        ForEach(this.checklist, (doc: DocumentChecklist) => {
          Row() {
            Text(doc.label)
              .fontSize(13)
              .fontWeight(FontWeight.Normal)
              .fontColor('#24132C')
              .layoutWeight(1)
            Text(doc.status)
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor('#F6B4D7')
          }
          .width('100%')
          .padding({ left: 12, right: 12, top: 4, bottom: 4 })
          .borderRadius(8)
          .backgroundColor('#EFE7FF')
          .opacity(0.8)
          .margin({ bottom: 4 })
        })
      }
      .margin({ top: 12 })
    }
    .padding(16)
    .borderRadius(24)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
  }
}