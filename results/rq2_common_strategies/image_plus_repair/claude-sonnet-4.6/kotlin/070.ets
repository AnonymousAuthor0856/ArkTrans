import { router } from '@kit.ArkUI'

class WizardStep {
  title: string = ''
  description: string = ''
}

class SummaryItem {
  label: string = ''
  value: string = ''
}

class DocumentChecklist {
  label: string = ''
  status: string = ''
}

const primaryColor = '#A07CFF'
const secondaryColor = '#F6B4D7'
const tertiaryColor = '#8DD3C7'
const backgroundColor = '#FDF8FF'
const surfaceColor = '#FFFFFF'
const surfaceVariantColor = '#EFE7FF'
const outlineColor = '#C9B4E6'
const successColor = '#6ED8A0'
const warningColor = '#FCD277'
const errorColor = '#FF8899'
const onPrimaryColor = '#1D0F33'
const onSecondaryColor = '#2B0E1C'
const onTertiaryColor = '#06231C'
const onBackgroundColor = '#1C1126'
const onSurfaceColor = '#24132C'

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
      // Top App Bar
      Row() {
        Stack() {
          Circle({ width: 30, height: 30 })
            .fill(surfaceVariantColor)
        }
        .width(48)
        .height(48)

        Column() {
          Text('LeaseWizard')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(onSurfaceColor)
          Text('Guided handoff')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor('#801C1126')
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)

        Stack() {
          Circle({ width: 30, height: 30 })
            .fill('#4DA07CFF')
        }
        .width(48)
        .height(48)
      }
      .width('100%')
      .height(56)
      .padding({ left: 8, right: 8 })
      .backgroundColor(surfaceColor)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column({ space: 16 }) {
          // Steps Card
          Column({ space: 12 }) {
            Text('Steps')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(onSurfaceColor)

            ForEach(this.steps, (step: WizardStep, index: number) => {
              Row({ space: 16 }) {
                Column() {
                  Stack() {
                    Circle({ width: 28, height: 28 })
                      .fill(index <= this.currentStep ? primaryColor : surfaceVariantColor)
                    Text(`${index + 1}`)
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(index <= this.currentStep ? onPrimaryColor : onSurfaceColor)
                  }
                  .width(28)
                  .height(28)

                  if (index !== this.steps.length - 1) {
                    Column()
                      .width(4)
                      .height(32)
                      .backgroundColor(surfaceVariantColor)
                  }
                }
                .alignItems(HorizontalAlign.Center)

                Column() {
                  Text(step.title)
                    .fontSize(15)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(onSurfaceColor)
                  Text(step.description)
                    .fontSize(13)
                    .fontColor('#801C1126')
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Button(index <= this.currentStep ? 'Edit' : 'Go')
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(onSecondaryColor)
                  .backgroundColor(secondaryColor)
                  .borderRadius(8)
                  .height(40)
                  .onClick(() => {
                    this.currentStep = index
                  })
              }
              .width('100%')
              .alignItems(VerticalAlign.Top)
            })
          }
          .width('100%')
          .padding(16)
          .backgroundColor(surfaceColor)
          .borderRadius(24)
          .shadow({ radius: 8, color: '#29000000', offsetX: 0, offsetY: 4 })
          .alignItems(HorizontalAlign.Start)

          // Form Card
          Column({ space: 12 }) {
            Text('Form')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(onSurfaceColor)

            Column() {
              Text('Full name')
                .fontSize(11)
                .fontColor('#80000000')
                .margin({ bottom: 4 })
              TextInput({ text: this.name, placeholder: 'Full name' })
                .width('100%')
                .height(48)
                .fontSize(13)
                .fontColor(onSurfaceColor)
                .backgroundColor(surfaceColor)
                .border({ width: 1, color: outlineColor, radius: 8 })
                .onChange((value: string) => {
                  this.name = value
                })
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')

            Column() {
              Text('Contact')
                .fontSize(11)
                .fontColor('#80000000')
                .margin({ bottom: 4 })
              TextInput({ text: this.contact, placeholder: 'Contact' })
                .width('100%')
                .height(48)
                .fontSize(13)
                .fontColor(onSurfaceColor)
                .backgroundColor(surfaceColor)
                .border({ width: 1, color: outlineColor, radius: 8 })
                .onChange((value: string) => {
                  this.contact = value
                })
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')

            Column() {
              Text('Income')
                .fontSize(11)
                .fontColor('#80000000')
                .margin({ bottom: 4 })
              TextInput({ text: this.income, placeholder: 'Income' })
                .width('100%')
                .height(48)
                .fontSize(13)
                .fontColor(onSurfaceColor)
                .backgroundColor(surfaceColor)
                .border({ width: 1, color: outlineColor, radius: 8 })
                .onChange((value: string) => {
                  this.income = value
                })
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')

            Row({ space: 12 }) {
              Button('Back')
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(onSurfaceColor)
                .backgroundColor(surfaceVariantColor)
                .borderRadius(14)
                .height(44)
                .layoutWeight(1)
                .onClick(() => {
                  if (this.currentStep > 0) {
                    this.currentStep -= 1
                  }
                })

              Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(onPrimaryColor)
                .backgroundColor(primaryColor)
                .borderRadius(14)
                .height(44)
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
          .padding(16)
          .backgroundColor(surfaceColor)
          .borderRadius(24)
          .shadow({ radius: 8, color: '#29000000', offsetX: 0, offsetY: 4 })
          .alignItems(HorizontalAlign.Start)

          // Summary Card
          Column({ space: 12 }) {
            Text('Summary')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(onSurfaceColor)

            ForEach(this.summaryItems, (item: SummaryItem) => {
              Row() {
                Text(item.label)
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(onSurfaceColor)
                Text(item.value)
                  .fontSize(13)
                  .fontColor(onSurfaceColor)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .padding(12)
              .backgroundColor(surfaceVariantColor)
              .borderRadius(14)
            })

            Column({ space: 8 }) {
              Text('Documents')
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(onSurfaceColor)

              ForEach(this.checklist, (doc: DocumentChecklist) => {
                Row() {
                  Text(doc.label)
                    .fontSize(13)
                    .fontColor(onSurfaceColor)
                  Text(doc.status)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(secondaryColor)
                }
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)
                .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                .backgroundColor('#CCF6B4D7')
                .borderRadius(8)
              })
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
          }
          .width('100%')
          .padding(16)
          .backgroundColor(surfaceColor)
          .borderRadius(24)
          .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
          .alignItems(HorizontalAlign.Start)
        }
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(backgroundColor)
  }
}