const Colors = {
  primary: '#A07CFF',
  secondary: '#F6B4D7',
  tertiary: '#8DD3C7',
  background: '#FDF8FF',
  surface: '#FFFFFF',
  surfaceVariant: '#EFE7FF',
  outline: '#C9B4E6',
  success: '#6ED8A0',
  warning: '#FCD277',
  error: '#FF8899',
  onPrimary: '#1D0F33',
  onSecondary: '#2B0E1C',
  onTertiary: '#06231C',
  onBackground: '#1C1126',
  onSurface: '#24132C',
}

const Spacing = {
  xxs: 4,
  xs: 8,
  sm: 12,
  md: 16,
  lg: 20,
  xl: 28,
  xxl: 36,
  xxxl: 48,
}

interface WizardStep {
  title: string
  description: string
}

interface SummaryItem {
  label: string
  value: string
}

interface DocumentChecklist {
  label: string
  status: string
}

@Entry
@Component
struct Index {
  @State currentStep: number = 1
  @State name: string = 'Avery Tenant'
  @State contact: string = 'avery@example.com'
  @State income: string = '$120k annual'
  private steps: WizardStep[] = [
    { title: 'Profile', description: 'Tenant basics' },
    { title: 'Income', description: 'Proof details' },
    { title: 'References', description: 'Upload letters' },
    { title: 'Summary', description: 'Confirm submission' },
  ]
  private summaryItems: SummaryItem[] = [
    { label: 'Lease start', value: 'Aug 12' },
    { label: 'Monthly', value: '$2,450' },
    { label: 'Deposit', value: '$2,450' },
    { label: 'Pets', value: '2 approved' },
  ]
  private checklist: DocumentChecklist[] = [
    { label: 'ID verification', status: 'Uploaded' },
    { label: 'Employment letter', status: 'Pending' },
    { label: 'Credit report', status: 'Synced' },
  ]

  build() {
    Column() {
      Row() {
        Blank()
          .width(30)
          .height(30)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(15)
        Column({ space: Spacing.xxs }) {
          Text('LeaseWizard')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text('Guided handoff')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        Blank()
          .width(30)
          .height(30)
          .backgroundColor('rgba(160,124,255,0.3)')
          .borderRadius(15)
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.lg, right: Spacing.lg })
      .backgroundColor(Colors.surface)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column({ space: Spacing.md }) {
          Column({ space: Spacing.sm }) {
            Text('Steps')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
            ForEach(this.steps, (step: WizardStep, index: number) => {
              Row({ space: Spacing.md }) {
                Column() {
                  Stack({ alignContent: Alignment.Center }) {
                    Text((index + 1).toString())
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(index <= this.currentStep ? Colors.onPrimary : Colors.onSurface)
                  }
                  .width(28)
                  .height(28)
                  .borderRadius(14)
                  .backgroundColor(index <= this.currentStep ? Colors.primary : Colors.surfaceVariant)
                  if (index !== this.steps.length - 1) {
                    Blank()
                      .width(4)
                      .height(32)
                      .backgroundColor(Colors.surfaceVariant)
                  }
                }
                .alignItems(HorizontalAlign.Center)

                Column({ space: Spacing.xs }) {
                  Text(step.title)
                    .fontSize(15)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                  Text(step.description)
                    .fontSize(13)
                    .fontColor(Colors.onSurface)
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)

                Button(index <= this.currentStep ? 'Edit' : 'Go')
                  .type(ButtonType.Normal)
                  .fontSize(11)
                  .fontColor(Colors.onSecondary)
                  .backgroundColor(Colors.secondary)
                  .borderRadius(8)
                  .onClick(() => {
                    this.currentStep = index
                  })
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)
            }, (step: WizardStep, index: number) => step.title)
          }
          .width('100%')
          .padding(Spacing.md)
          .backgroundColor(Colors.surface)
          .borderRadius(24)
          .alignItems(HorizontalAlign.Start)

          Column({ space: Spacing.sm }) {
            Text('Form')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
            TextInput({ text: this.name, placeholder: 'Full name' })
              .width('100%')
              .onChange((value: string) => {
                this.name = value
              })
            TextInput({ text: this.contact, placeholder: 'Contact' })
              .width('100%')
              .onChange((value: string) => {
                this.contact = value
              })
            TextInput({ text: this.income, placeholder: 'Income' })
              .width('100%')
              .onChange((value: string) => {
                this.income = value
              })
            Row({ space: Spacing.sm }) {
              Button('Back')
                .type(ButtonType.Normal)
                .fontSize(15)
                .fontColor(Colors.onSurface)
                .backgroundColor(Colors.surfaceVariant)
                .borderRadius(14)
                .layoutWeight(1)
                .onClick(() => {
                  if (this.currentStep > 0) {
                    this.currentStep -= 1
                  }
                })
              Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
                .type(ButtonType.Normal)
                .fontSize(15)
                .fontColor(Colors.onPrimary)
                .backgroundColor(Colors.primary)
                .borderRadius(14)
                .layoutWeight(1)
                .onClick(() => {
                  if (this.currentStep < this.steps.length - 1) {
                    this.currentStep += 1
                  }
                })
            }
          }
          .width('100%')
          .padding(Spacing.md)
          .backgroundColor(Colors.surface)
          .borderRadius(24)
          .alignItems(HorizontalAlign.Start)

          Column({ space: Spacing.sm }) {
            Text('Summary')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
            ForEach(this.summaryItems, (item: SummaryItem) => {
              Row() {
                Text(item.label)
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                Text(item.value)
                  .fontSize(13)
                  .fontColor(Colors.onSurface)
              }
              .width('100%')
              .padding(Spacing.sm)
              .backgroundColor(Colors.surfaceVariant)
              .borderRadius(14)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }, (item: SummaryItem) => item.label)

            Column({ space: Spacing.xs }) {
              Text('Documents')
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
              ForEach(this.checklist, (doc: DocumentChecklist) => {
                Row() {
                  Text(doc.label)
                    .fontSize(13)
                    .fontColor(Colors.onSurface)
                  Text(doc.status)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.secondary)
                }
                .width('100%')
                .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xs, bottom: Spacing.xs })
                .backgroundColor(Colors.surfaceVariant)
                .borderRadius(8)
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(VerticalAlign.Center)
              }, (doc: DocumentChecklist) => doc.label)
            }
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding(Spacing.md)
          .backgroundColor(Colors.surface)
          .borderRadius(24)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
      }
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
