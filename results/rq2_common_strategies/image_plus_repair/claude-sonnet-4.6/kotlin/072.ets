import { LengthMetrics } from '@kit.ArkUI'

class FormStep {
  title: string = ''
  description: string = ''

  constructor(title: string, description: string) {
    this.title = title
    this.description = description
  }
}

class SupportChip {
  label: string = ''

  constructor(label: string) {
    this.label = label
  }
}

class SummaryItem {
  label: string = ''
  value: string = ''

  constructor(label: string, value: string) {
    this.label = label
    this.value = value
  }
}

const Colors = {
  primary: 0xFFB58B5A,
  secondary: 0xFFE5C48F,
  tertiary: 0xFF8BB39B,
  background: 0xFFF6F0E3,
  surface: 0xFFFFFFFF,
  surfaceVariant: 0xFFE7D7C2,
  outline: 0xFFC3B09E,
  success: 0xFF6FB08C,
  warning: 0xFFE6B566,
  error: 0xFFD96C5F,
  onPrimary: 0xFF2D1A0D,
  onSecondary: 0xFF2F230C,
  onTertiary: 0xFF0E1A13,
  onBackground: 0xFF1E130C,
  onSurface: 0xFF2A1C12,
}

@Entry
@Component
struct RootScreen {
  private steps: FormStep[] = [
    new FormStep('Identity', 'Applicant basics'),
    new FormStep('Impact', 'Community reach'),
    new FormStep('Needs', 'Immediate relief'),
    new FormStep('Summary', 'Confirm details'),
  ]
  private chips: SupportChip[] = [
    new SupportChip('Medical'),
    new SupportChip('Shelter'),
    new SupportChip('Food'),
    new SupportChip('Utilities'),
  ]
  private summary: SummaryItem[] = [
    new SummaryItem('Requested', '$4,500'),
    new SummaryItem('Households', '36'),
    new SummaryItem('Region', 'North loop'),
    new SummaryItem('Urgency', '48h'),
  ]
  @State currentStep: number = 1
  @State name: string = ''
  @State organization: string = ''
  @State contact: string = ''
  @State narrative: string = ''
  @State selectedChip: number = 0

  build() {
    Column() {
      // Top App Bar
      Row() {
        Stack() {
          Circle({ width: 30, height: 30 })
            .fill(Colors.surfaceVariant)
        }
        .width(48)
        .height(48)

        Column() {
          Text('ReliefFund')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text('Civic support intake')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
            .opacity(0.7)
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)

        Stack() {
          Circle({ width: 30, height: 30 })
            .fill(Colors.primary)
            .opacity(0.35)
        }
        .width(48)
        .height(48)
      }
      .width('100%')
      .height(56)
      .padding({ left: 4, right: 4 })
      .backgroundColor(Colors.background)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column({ space: 16 }) {
          // Steps Card
          Column({ space: 12 }) {
            Text('Steps')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)

            ForEach(this.steps, (step: FormStep, index: number) => {
              Row({ space: 12 }) {
                Column({ space: 0 }) {
                  Stack() {
                    Circle({ width: 26, height: 26 })
                      .fill(index <= this.currentStep ? Colors.primary : Colors.surfaceVariant)
                    Text(`${index + 1}`)
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(index <= this.currentStep ? Colors.onPrimary : Colors.onSurface)
                  }
                  .width(26)
                  .height(26)

                  if (index !== this.steps.length - 1) {
                    Column()
                      .width(3)
                      .height(28)
                      .backgroundColor(Colors.surfaceVariant)
                  }
                }
                .alignItems(HorizontalAlign.Center)

                Column() {
                  Text(step.title)
                    .fontSize(15)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                  Text(step.description)
                    .fontSize(13)
                    .fontColor(Colors.onSurface)
                    .opacity(0.7)
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Button(index <= this.currentStep ? 'Edit' : 'Go')
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSecondary)
                  .backgroundColor(Colors.secondary)
                  .borderRadius(8)
                  .height(32)
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
          .backgroundColor(Colors.surface)
          .borderRadius(24)
          .alignItems(HorizontalAlign.Start)
          .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })

          // Focus / Chips Card
          Column({ space: 12 }) {
            Text('Focus')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)

            Row({ space: 12 }) {
              ForEach(this.chips, (chip: SupportChip, index: number) => {
                Text(chip.label)
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                  .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                  .backgroundColor(this.selectedChip === index ? 0x33B58B5A : Colors.surfaceVariant)
                  .borderRadius(8)
                  .border({
                    width: 1,
                    color: this.selectedChip === index ? Colors.primary : Colors.outline
                  })
                  .onClick(() => {
                    this.selectedChip = index
                  })
              })
            }
            .width('100%')
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Colors.surface)
          .borderRadius(24)
          .alignItems(HorizontalAlign.Start)
          .shadow({ radius: 4, color: '#1E000000', offsetX: 0, offsetY: 2 })

          // Applicant Details Card
          Column({ space: 12 }) {
            Text('Applicant details')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)

            TextInput({ placeholder: 'Full name', text: this.name })
              .width('100%')
              .height(52)
              .fontSize(13)
              .fontColor(Colors.onSurface)
              .placeholderColor(Colors.onSurface)
              .placeholderFont({ size: 13 })
              .backgroundColor(Colors.background)
              .borderRadius(8)
              .border({ width: 1, color: Colors.outline })
              .onChange((val: string) => {
                this.name = val
              })

            TextInput({ placeholder: 'Organization', text: this.organization })
              .width('100%')
              .height(52)
              .fontSize(13)
              .fontColor(Colors.onSurface)
              .placeholderColor(Colors.onSurface)
              .placeholderFont({ size: 13 })
              .backgroundColor(Colors.background)
              .borderRadius(8)
              .border({ width: 1, color: Colors.outline })
              .onChange((val: string) => {
                this.organization = val
              })

            TextInput({ placeholder: 'Contact', text: this.contact })
              .width('100%')
              .height(52)
              .fontSize(13)
              .fontColor(Colors.onSurface)
              .placeholderColor(Colors.onSurface)
              .placeholderFont({ size: 13 })
              .backgroundColor(Colors.background)
              .borderRadius(8)
              .border({ width: 1, color: Colors.outline })
              .onChange((val: string) => {
                this.contact = val
              })

            TextArea({ placeholder: 'Relief narrative', text: this.narrative })
              .width('100%')
              .height(100)
              .fontSize(13)
              .fontColor(Colors.onSurface)
              .placeholderColor(Colors.onSurface)
              .placeholderFont({ size: 13 })
              .backgroundColor(Colors.background)
              .borderRadius(8)
              .border({ width: 1, color: Colors.outline })
              .onChange((val: string) => {
                this.narrative = val
              })

            Row({ space: 12 }) {
              Button('Back')
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
                .backgroundColor(Colors.surfaceVariant)
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
                .fontColor(Colors.onPrimary)
                .backgroundColor(Colors.primary)
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
          .backgroundColor(Colors.surface)
          .borderRadius(24)
          .alignItems(HorizontalAlign.Start)
          .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })

          // Summary Card
          Column({ space: 8 }) {
            Text('Summary')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)

            ForEach(this.summary, (item: SummaryItem) => {
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
              .padding(12)
              .backgroundColor(Colors.surfaceVariant)
              .borderRadius(14)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            })
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Colors.surface)
          .borderRadius(24)
          .alignItems(HorizontalAlign.Start)
          .shadow({ radius: 4, color: '#1E000000', offsetX: 0, offsetY: 2 })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 12, bottom: 12 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}