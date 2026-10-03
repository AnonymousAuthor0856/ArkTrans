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
struct LeaseWizardScreen {
  @State currentStep: number = 1
  @State name: string = 'Avery Tenant'
  @State contact: string = 'avery@example.com'
  @State income: string = '$120k annual'

  private steps: WizardStep[] = [
    { title: 'Profile', description: 'Tenant basics' },
    { title: 'Income', description: 'Proof details' },
    { title: 'References', description: 'Upload letters' },
    { title: 'Summary', description: 'Confirm submission' }
  ]

  private summaryItems: SummaryItem[] = [
    { label: 'Lease start', value: 'Aug 12' },
    { label: 'Monthly', value: '$2,450' },
    { label: 'Deposit', value: '$2,450' },
    { label: 'Pets', value: '2 approved' }
  ]

  private checklist: DocumentChecklist[] = [
    { label: 'ID verification', status: 'Uploaded' },
    { label: 'Employment letter', status: 'Pending' },
    { label: 'Credit report', status: 'Synced' }
  ]

  build() {
    Column() {
      this.TopBar()
      Scroll() {
        Column({ space: 16 }) {
          this.StepsCard()
          this.FormCard()
          this.SummaryCard()
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FDF8FF')
  }

  @Builder
  TopBar() {
    Row() {
      Circle({ width: 60, height: 60 })
        .fill('#EFE7FF')
      Column() {
        Text('LeaseWizard')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#24132C')
        Text('Guided handoff')
          .fontSize(18)
          .fontColor('#24132C')
          .opacity(0.7)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      Circle({ width: 60, height: 60 })
        .fill('#D4C4FF')
    }
    .width('100%')
    .height(88)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FDF8FF')
  }

  @Builder
  StepsCard() {
    Column({ space: 14 }) {
      Text('Steps')
        .fontSize(42)
        .fontWeight(FontWeight.Bold)
        .fontColor('#24132C')

      ForEach(this.steps, (step: WizardStep, index: number) => {
        Row({ space: 16 }) {
          Column({ space: 0 }) {
            Circle({ width: 56, height: 56 })
              .fill(index <= this.currentStep ? '#A07CFF' : '#EFE7FF')
              .overlay(
                Text(`${index + 1}`)
                  .fontSize(22)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(index <= this.currentStep ? '#1D0F33' : '#24132C')
              )
            if (index !== this.steps.length - 1) {
              Rect({ width: 8, height: 64 })
                .fill('#EFE7FF')
            }
          }
          .alignItems(HorizontalAlign.Center)
          .width(56)

          Column({ space: 4 }) {
            Text(step.title)
              .fontSize(32)
              .fontWeight(FontWeight.Medium)
              .fontColor('#24132C')
            Text(step.description)
              .fontSize(26)
              .fontColor('#24132C')
              .opacity(0.7)
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.Center)

          Button(index <= this.currentStep ? 'Edit' : 'Go')
            .fontSize(24)
            .fontColor('#2B0E1C')
            .backgroundColor('#F6B4D7')
            .borderRadius(16)
            .height(56)
            .padding({ left: 28, right: 28 })
            .onClick(() => {
              this.currentStep = index
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)
      }, (item: WizardStep, index: number) => index.toString())
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#F5F0FF')
    .borderRadius(32)
  }

  @Builder
  FormCard() {
    Column({ space: 20 }) {
      Text('Form')
        .fontSize(42)
        .fontWeight(FontWeight.Bold)
        .fontColor('#24132C')

      this.FormField('Full name', this.name, (val: string) => { this.name = val })
      this.FormField('Contact', this.contact, (val: string) => { this.contact = val })
      this.FormField('Income', this.income, (val: string) => { this.income = val })

      Row({ space: 12 }) {
        Button('Back')
          .fontSize(24)
          .fontColor('#24132C')
          .backgroundColor('#EFE7FF')
          .borderRadius(20)
          .height(56)
          .layoutWeight(1)
          .onClick(() => {
            if (this.currentStep > 0) {
              this.currentStep -= 1
            }
          })
        Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
          .fontSize(24)
          .fontColor('#1D0F33')
          .backgroundColor('#A07CFF')
          .borderRadius(20)
          .height(56)
          .layoutWeight(1)
          .onClick(() => {
            if (this.currentStep < this.steps.length - 1) {
              this.currentStep += 1
            }
          })
      }
      .width('100%')
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#F5F0FF')
    .borderRadius(32)
  }

  @Builder
  FormField(label: string, value: string, onChange: (val: string) => void) {
    Column({ space: 0 }) {
      Text(label)
        .fontSize(26)
        .fontColor('#24132C')
        .backgroundColor('#F5F0FF')
        .padding({ left: 8, right: 8 })
        .margin({ left: 16, top: -13 })
        .alignSelf(ItemAlign.Start)
        .zIndex(1)

      TextInput({ text: value })
        .width('100%')
        .height(72)
        .fontSize(30)
        .fontColor('#24132C')
        .backgroundColor(Color.Transparent)
        .border({ width: 2, color: '#C9B4E6' })
        .borderRadius(16)
        .padding({ left: 20, right: 20 })
        .onChange((val: string) => onChange(val))
        .margin({ top: -13 })
    }
    .width('100%')
    .margin({ top: 8 })
  }

  @Builder
  SummaryCard() {
    Column({ space: 14 }) {
      Text('Summary')
        .fontSize(42)
        .fontWeight(FontWeight.Bold)
        .fontColor('#24132C')

      ForEach(this.summaryItems, (item: SummaryItem) => {
        Row() {
          Text(item.label)
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor('#24132C')
          Text(item.value)
            .fontSize(22)
            .fontColor('#24132C')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .padding(14)
        .backgroundColor('#EFE7FF')
        .borderRadius(20)
      }, (item: SummaryItem) => item.label)

      Column({ space: 10 }) {
        Text('Documents')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#24132C')

        ForEach(this.checklist, (doc: DocumentChecklist) => {
          Row() {
            Text(doc.label)
              .fontSize(22)
              .fontColor('#24132C')
            Text(doc.status)
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#A07CFF')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .padding({ left: 14, right: 14, top: 10, bottom: 10 })
          .backgroundColor('#EFE7FF')
          .opacity(0.9)
          .borderRadius(12)
        }, (doc: DocumentChecklist) => doc.label)
      }
      .width('100%')
      .margin({ top: 4 })
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#F5F0FF')
    .borderRadius(32)
  }
}
