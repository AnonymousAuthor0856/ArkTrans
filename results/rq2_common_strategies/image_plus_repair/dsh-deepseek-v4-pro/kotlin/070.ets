interface WizardStep {
  title: string;
  description: string;
}

interface SummaryItem {
  label: string;
  value: string;
}

interface DocumentItem {
  label: string;
  status: string;
}

const C_PRIMARY: string = '#A07CFF';
const C_SECONDARY: string = '#F6B4D7';
const C_TERTIARY: string = '#8DD3C7';
const C_BACKGROUND: string = '#FDF8FF';
const C_SURFACE: string = '#FFFFFF';
const C_SURFACE_VARIANT: string = '#EFE7FF';
const C_OUTLINE: string = '#C9B4E6';
const C_ON_PRIMARY: string = '#1D0F33';
const C_ON_SECONDARY: string = '#2B0E1C';
const C_ON_TERTIARY: string = '#06231C';
const C_ON_SURFACE: string = '#24132C';

@Entry
@Component
struct LeaseWizardPage {
  @State currentStep: number = 1;
  @State fullName: string = 'Avery Tenant';
  @State contact: string = 'avery@example.com';
  @State income: string = '$120k annual';

  private steps: WizardStep[] = [
    { title: 'Profile', description: 'Tenant basics' },
    { title: 'Income', description: 'Proof details' },
    { title: 'References', description: 'Upload letters' },
    { title: 'Summary', description: 'Confirm submission' }
  ];

  private summaryItems: SummaryItem[] = [
    { label: 'Lease start', value: 'Aug 12' },
    { label: 'Monthly', value: '$2,450' },
    { label: 'Deposit', value: '$2,450' },
    { label: 'Pets', value: '2 approved' }
  ];

  private checklist: DocumentItem[] = [
    { label: 'ID verification', status: 'Uploaded' },
    { label: 'Employment letter', status: 'Pending' },
    { label: 'Credit report', status: 'Synced' }
  ];

  @Builder
  StepCircle(index: number, reached: boolean) {
    Stack() {
      Text((index + 1).toString())
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(reached ? C_ON_PRIMARY : C_ON_SURFACE)
    }
    .width(28)
    .height(28)
    .borderRadius(14)
    .backgroundColor(reached ? C_PRIMARY : C_SURFACE_VARIANT)
    .alignContent(Alignment.Center)
  }

  build() {
    Column() {
      // Top app bar
      Row() {
        Stack() {}
          .width(30)
          .height(30)
          .borderRadius(15)
          .backgroundColor(C_SURFACE_VARIANT)
        Column() {
          Text('LeaseWizard')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(C_ON_SURFACE)
          Text('Guided handoff')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(C_ON_SURFACE)
            .opacity(0.7)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        Stack() {}
          .width(30)
          .height(30)
          .borderRadius(15)
          .backgroundColor(C_PRIMARY)
          .opacity(0.3)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })

      Scroll() {
        Column({ space: 16 }) {
          // Steps surface
          Column({ space: 12 }) {
            Text('Steps')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(C_ON_SURFACE)
            ForEach(this.steps, (step: WizardStep, index: number) => {
              Row({ space: 16 }) {
                Column() {
                  this.StepCircle(index, index <= this.currentStep)
                  if (index !== this.steps.length - 1) {
                    Stack() {}
                      .width(4)
                      .height(32)
                      .backgroundColor(C_SURFACE_VARIANT)
                  }
                }
                .alignItems(HorizontalAlign.Center)

                Column({ space: 2 }) {
                  Text(step.title)
                    .fontSize(15)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(C_ON_SURFACE)
                  Text(step.description)
                    .fontSize(13)
                    .fontWeight(FontWeight.Normal)
                    .fontColor(C_ON_SURFACE)
                    .opacity(0.7)
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)

                Button() {
                  Text(index <= this.currentStep ? 'Edit' : 'Go')
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(C_ON_SECONDARY)
                }
                .height(32)
                .backgroundColor(C_SECONDARY)
                .borderRadius(8)
                .onClick(() => {
                  this.currentStep = index;
                })
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)
            }, (step: WizardStep) => step.title)
          }
          .width('100%')
          .padding(16)
          .borderRadius(24)
          .backgroundColor(C_SURFACE)
          .shadow({ radius: 8, color: '#1A000000', offsetX: 0, offsetY: 4 })

          // Form surface
          Column({ space: 12 }) {
            Text('Form')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(C_ON_SURFACE)

            TextInput({ placeholder: 'Full name', text: this.fullName })
              .width('100%')
              .height(52)
              .borderRadius(8)
              .border({ width: 1, color: C_OUTLINE })
              .backgroundColor(C_SURFACE)
              .placeholderColor('#9A8FA6')
              .onChange((value: string) => {
                this.fullName = value;
              })

            TextInput({ placeholder: 'Contact', text: this.contact })
              .width('100%')
              .height(52)
              .borderRadius(8)
              .border({ width: 1, color: C_OUTLINE })
              .backgroundColor(C_SURFACE)
              .placeholderColor('#9A8FA6')
              .onChange((value: string) => {
                this.contact = value;
              })

            TextInput({ placeholder: 'Income', text: this.income })
              .width('100%')
              .height(52)
              .borderRadius(8)
              .border({ width: 1, color: C_OUTLINE })
              .backgroundColor(C_SURFACE)
              .placeholderColor('#9A8FA6')
              .onChange((value: string) => {
                this.income = value;
              })

            Row({ space: 12 }) {
              Button() {
                Text('Back')
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(C_ON_SURFACE)
              }
              .layoutWeight(1)
              .height(44)
              .backgroundColor(C_SURFACE_VARIANT)
              .borderRadius(14)
              .onClick(() => {
                if (this.currentStep > 0) {
                  this.currentStep -= 1;
                }
              })

              Button() {
                Text(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(C_ON_PRIMARY)
              }
              .layoutWeight(1)
              .height(44)
              .backgroundColor(C_PRIMARY)
              .borderRadius(14)
              .onClick(() => {
                if (this.currentStep < this.steps.length - 1) {
                  this.currentStep += 1;
                }
              })
            }
            .width('100%')
          }
          .width('100%')
          .padding(16)
          .borderRadius(24)
          .backgroundColor(C_SURFACE)
          .shadow({ radius: 8, color: '#1A000000', offsetX: 0, offsetY: 4 })

          // Summary surface
          Column({ space: 12 }) {
            Text('Summary')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(C_ON_SURFACE)

            ForEach(this.summaryItems, (item: SummaryItem) => {
              Row() {
                Text(item.label)
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(C_ON_SURFACE)
                Text(item.value)
                  .fontSize(13)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(C_ON_SURFACE)
              }
              .width('100%')
              .backgroundColor(C_SURFACE_VARIANT)
              .borderRadius(14)
              .padding(12)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }, (item: SummaryItem) => item.label)

            Column({ space: 8 }) {
              Text('Documents')
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(C_ON_SURFACE)

              ForEach(this.checklist, (doc: DocumentItem) => {
                Row() {
                  Text(doc.label)
                    .fontSize(13)
                    .fontWeight(FontWeight.Normal)
                    .fontColor(C_ON_SURFACE)
                  Text(doc.status)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(C_SECONDARY)
                }
                .width('100%')
                .backgroundColor('#CCEFE7FF')
                .borderRadius(8)
                .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(VerticalAlign.Center)
              }, (doc: DocumentItem) => doc.label)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding(16)
          .borderRadius(24)
          .backgroundColor(C_SURFACE)
          .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      }
      .layoutWeight(1)
      .width('100%')
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(C_BACKGROUND)
  }
}
