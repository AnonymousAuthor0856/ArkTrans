import { router } from '@kit.ArkUI';

interface StepItem {
  title: string;
  description: string;
}

interface SummaryItem {
  label: string;
  value: string;
}

interface ChecklistItem {
  label: string;
  status: string;
}

interface StepWithIndex {
  step: StepItem;
  index: number;
}

@Entry
@Component
struct Index {
  @State currentStep: number = 0
  @State name: string = ''
  @State contact: string = ''
  @State income: string = ''

  // Mock data for steps
  private steps: Array<StepItem> = [
    { title: 'Personal Info', description: 'Enter your details' },
    { title: 'Financials', description: 'Income and employment' },
    { title: 'Review', description: 'Confirm submission' }
  ]

  // Mock data for documents
  private checklist: Array<ChecklistItem> = [
    { label: 'ID Card', status: 'Uploaded' },
    { label: 'Proof of Income', status: 'Pending' }
  ]

  get summaryItems(): Array<SummaryItem> {
    return [
      { label: 'Full Name', value: this.name || 'N/A' },
      { label: 'Contact', value: this.contact || 'N/A' },
      { label: 'Income', value: this.income || 'N/A' }
    ];
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        // Surface 1: Steps
        Column() {
          Column({ space: 8 }) {
            Text('Steps')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#24132C')

            ForEach(this.steps.map((step, index) => ({ step, index })), (item: StepWithIndex) => {
              const reached = item.index <= this.currentStep
              Row({ space: 16 }) {
                Column({ space: 0 }) {
                  Stack({ alignContent: Alignment.Center }) {
                    Text(`${item.index + 1}`)
                      .fontSize(14)
                      .fontColor(reached ? '#FFFFFF' : '#24132C')
                  }
                  .width(28)
                  .height(28)
                  .borderRadius(14)
                  .backgroundColor(reached ? '#6750A4' : '#E7E0EC')

                  if (item.index < this.steps.length - 1) {
                    Stack()
                      .width(4)
                      .height(32)
                      .backgroundColor('#E7E0EC')
                  }
                }
                .alignItems(HorizontalAlign.Center)

                Column({ space: 0 }) {
                  Text(item.step.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#24132C')
                  Text(item.step.description)
                    .fontSize(14)
                    .fontColor('#24132C')
                }
                .layoutWeight(1)

                Button() {
                  Text(reached ? 'Edit' : 'Go')
                    .fontSize(14)
                    .fontColor('#FFFFFF')
                }
                .backgroundColor('#9C27B0')
                .borderRadius(8)
                .onClick(() => {
                  this.currentStep = item.index
                })
              }
              .alignItems(VerticalAlign.Center)
            })
          }
          .padding(16)
        }
        .borderRadius(16)
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 4, color: '#1A000000' })

        // Surface 2: Form
        Column() {
          Column({ space: 8 }) {
            Text('Form')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#24132C')

            TextInput({ placeholder: 'Full name' })
              .width('100%')
              .height(48)
              .borderRadius(8)
              .borderWidth(1)
              .borderColor('#9C27B0')
              .onChange((value: string) => {
                this.name = value
              })

            TextInput({ placeholder: 'Contact' })
              .width('100%')
              .height(48)
              .borderRadius(8)
              .borderWidth(1)
              .borderColor('#9C27B0')
              .onChange((value: string) => {
                this.contact = value
              })

            TextInput({ placeholder: 'Income' })
              .width('100%')
              .height(48)
              .borderRadius(8)
              .borderWidth(1)
              .borderColor('#9C27B0')
              .onChange((value: string) => {
                this.income = value
              })

            Row({ space: 8 }) {
              Button() {
                Text('Back')
                  .fontSize(16)
                  .fontColor('#24132C')
              }
              .backgroundColor('#E7E0EC')
              .borderRadius(12)
              .layoutWeight(1)
              .onClick(() => {
                if (this.currentStep > 0) this.currentStep -= 1
              })

              Button() {
                Text(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
                  .fontSize(16)
                  .fontColor('#FFFFFF')
              }
              .backgroundColor('#6750A4')
              .borderRadius(12)
              .layoutWeight(1)
              .onClick(() => {
                if (this.currentStep < this.steps.length - 1) this.currentStep += 1
              })
            }
          }
          .padding(16)
        }
        .borderRadius(16)
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 4, color: '#1A000000' })

        // Surface 3: Summary
        Column() {
          Column({ space: 8 }) {
            Text('Summary')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#24132C')

            ForEach(this.summaryItems, (item: SummaryItem) => {
              Row({ space: 0 }) {
                Text(item.label)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#24132C')
                  .layoutWeight(1)
                Text(item.value)
                  .fontSize(14)
                  .fontColor('#24132C')
              }
              .alignItems(VerticalAlign.Center)
              .width('100%')
              .backgroundColor('#E7E0EC')
              .borderRadius(8)
              .padding(12)
            })

            Column({ space: 4 }) {
              Text('Documents')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#24132C')

              ForEach(this.checklist, (doc: ChecklistItem) => {
                Row({ space: 0 }) {
                  Text(doc.label)
                    .fontSize(14)
                    .fontColor('#24132C')
                    .layoutWeight(1)
                  Text(doc.status)
                    .fontSize(12)
                    .fontColor('#F6B4D7')
                }
                .alignItems(VerticalAlign.Center)
                .width('100%')
                .backgroundColor('#E7E0EC')
                .borderRadius(8)
                .padding({ left: 12, right: 12, top: 8, bottom: 8 })
              })
            }
          }
          .padding(16)
        }
        .borderRadius(16)
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 4, color: '#1A000000' })
      }
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .width('100%')
      .layoutWeight(1)
      .scrollable(true)

      // Top App Bar Area
      Row() {
        Column({ space: 0 }) {
          Text('LeaseWizard')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#24132C')
          Text('Guided handoff')
            .fontSize(12)
            .fontColor('#24132C')
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)

        Button() {
          Stack({ alignContent: Alignment.Center }) {
            Image($r('app.media.startIcon'))
              .width(20)
              .height(20)
          }
          .width(30)
          .height(30)
          .borderRadius(15)
          .backgroundColor('#E7E0EC')
        }
        .margin({ right: 8 })

        Button() {
          Stack({ alignContent: Alignment.Center }) {
            Image($r('app.media.startIcon'))
              .width(20)
              .height(20)
          }
          .width(30)
          .height(30)
          .borderRadius(15)
          .backgroundColor('#9C27B0')
        }
      }
      .width('100%')
      .height(60)
      .padding(16)
      .backgroundColor('#FDF8FF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FDF8FF')
  }
}