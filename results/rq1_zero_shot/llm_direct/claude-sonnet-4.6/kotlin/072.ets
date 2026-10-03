import { router } from '@kit.ArkUI'

// Design Tokens
const Colors = {
  primary: '#B58B5A',
  secondary: '#E5C48F',
  tertiary: '#8BB39B',
  background: '#F6F0E3',
  surface: '#FFFFFF',
  surfaceVariant: '#E7D7C2',
  outline: '#C3B09E',
  success: '#6FB08C',
  warning: '#E6B566',
  error: '#D96C5F',
  onPrimary: '#2D1A0D',
  onSecondary: '#2F230C',
  onTertiary: '#0E1A13',
  onBackground: '#1E130C',
  onSurface: '#2A1C12',
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

interface FormStep {
  title: string
  description: string
}

interface SupportChip {
  label: string
}

interface SummaryItem {
  label: string
  value: string
}

@Entry
@Component
struct RootScreen {
  private steps: FormStep[] = [
    { title: 'Identity', description: 'Applicant basics' },
    { title: 'Impact', description: 'Community reach' },
    { title: 'Needs', description: 'Immediate relief' },
    { title: 'Summary', description: 'Confirm details' },
  ]
  private chips: SupportChip[] = [
    { label: 'Medical' },
    { label: 'Shelter' },
    { label: 'Food' },
    { label: 'Utilities' },
  ]
  private summary: SummaryItem[] = [
    { label: 'Requested', value: '$4,500' },
    { label: 'Households', value: '36' },
    { label: 'Region', value: 'North loop' },
    { label: 'Urgency', value: '48h' },
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
        Button({ type: ButtonType.Circle }) {
          Stack()
            .width(30)
            .height(30)
            .backgroundColor(Colors.surfaceVariant)
            .borderRadius(15)
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.Transparent)

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

        Button({ type: ButtonType.Circle }) {
          Stack()
            .width(30)
            .height(30)
            .backgroundColor(Colors.primary)
            .opacity(0.35)
            .borderRadius(15)
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.Transparent)
      }
      .width('100%')
      .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.sm, bottom: Spacing.sm })
      .backgroundColor(Colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Scrollable Content
      Scroll() {
        Column({ space: Spacing.md }) {

          // Steps Card
          Column({ space: Spacing.sm }) {
            Text('Steps')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)

            ForEach(this.steps, (step: FormStep, index: number) => {
              Row({ space: Spacing.sm }) {
                Column({ space: 0 }) {
                  Stack() {
                    Text(`${index + 1}`)
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(index <= this.currentStep ? Colors.onPrimary : Colors.onSurface)
                  }
                  .width(26)
                  .height(26)
                  .borderRadius(13)
                  .backgroundColor(index <= this.currentStep ? Colors.primary : Colors.surfaceVariant)
                  .alignContent(Alignment.Center)

                  if (index !== this.steps.length - 1) {
                    Stack()
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
                    .fontWeight(FontWeight.Normal)
                    .fontColor(Colors.onSurface)
                    .opacity(0.7)
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)

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
          .padding(Spacing.md)
          .backgroundColor(Colors.surface)
          .borderRadius(24)
          .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 4 })
          .alignItems(HorizontalAlign.Start)

          // Focus / Chips Card
          Column({ space: Spacing.sm }) {
            Text('Focus')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)

            Row({ space: Spacing.sm }) {
              ForEach(this.chips, (chip: SupportChip, index: number) => {
                Text(chip.label)
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                  .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.xs, bottom: Spacing.xs })
                  .backgroundColor(this.selectedChip === index ? Colors.primary + '33' : Colors.surfaceVariant)
                  .borderRadius(8)
                  .border({
                    width: 1,
                    color: this.selectedChip === index ? Colors.primary : Colors.outline,
                    radius: 8
                  })
                  .onClick(() => {
                    this.selectedChip = index
                  })
              })
            }
            .width('100%')
          }
          .width('100%')
          .padding(Spacing.md)
          .backgroundColor(Colors.surface)
          .borderRadius(24)
          .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
          .alignItems(HorizontalAlign.Start)

          // Applicant Details Card
          Column({ space: Spacing.sm }) {
            Text('Applicant details')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)

            TextInput({ placeholder: 'Full name', text: this.name })
              .width('100%')
              .fontSize(13)
              .fontColor(Colors.onSurface)
              .placeholderColor(Colors.onSurface)
              .placeholderFont({ size: 13 })
              .backgroundColor(Colors.surface)
              .border({ width: 1, color: Colors.outline, radius: 8 })
              .onChange((value: string) => {
                this.name = value
              })

            TextInput({ placeholder: 'Organization', text: this.organization })
              .width('100%')
              .fontSize(13)
              .fontColor(Colors.onSurface)
              .placeholderColor(Colors.onSurface)
              .placeholderFont({ size: 13 })
              .backgroundColor(Colors.surface)
              .border({ width: 1, color: Colors.outline, radius: 8 })
              .onChange((value: string) => {
                this.organization = value
              })

            TextInput({ placeholder: 'Contact', text: this.contact })
              .width('100%')
              .fontSize(13)
              .fontColor(Colors.onSurface)
              .placeholderColor(Colors.onSurface)
              .placeholderFont({ size: 13 })
              .backgroundColor(Colors.surface)
              .border({ width: 1, color: Colors.outline, radius: 8 })
              .onChange((value: string) => {
                this.contact = value
              })

            TextArea({ placeholder: 'Relief narrative', text: this.narrative })
              .width('100%')
              .height(90)
              .fontSize(13)
              .fontColor(Colors.onSurface)
              .placeholderColor(Colors.onSurface)
              .placeholderFont({ size: 13 })
              .backgroundColor(Colors.surface)
              .border({ width: 1, color: Colors.outline, radius: 8 })
              .onChange((value: string) => {
                this.narrative = value
              })

            Row({ space: Spacing.sm }) {
              Button('Back')
                .layoutWeight(1)
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
                .backgroundColor(Colors.surfaceVariant)
                .borderRadius(14)
                .height(44)
                .onClick(() => {
                  if (this.currentStep > 0) {
                    this.currentStep -= 1
                  }
                })

              Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
                .layoutWeight(1)
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onPrimary)
                .backgroundColor(Colors.primary)
                .borderRadius(14)
                .height(44)
                .onClick(() => {
                  if (this.currentStep < this.steps.length - 1) {
                    this.currentStep += 1
                  }
                })
            }
            .width('100%')
          }
          .width('100%')
          .padding(Spacing.md)
          .backgroundColor(Colors.surface)
          .borderRadius(24)
          .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 4 })
          .alignItems(HorizontalAlign.Start)

          // Summary Card
          Column({ space: Spacing.xs }) {
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
                  .fontWeight(FontWeight.Normal)
                  .fontColor(Colors.onSurface)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .padding(Spacing.sm)
              .backgroundColor(Colors.surfaceVariant)
              .borderRadius(14)
            })
          }
          .width('100%')
          .padding(Spacing.md)
          .backgroundColor(Colors.surface)
          .borderRadius(24)
          .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
          .alignItems(HorizontalAlign.Start)

        }
        .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.sm, bottom: Spacing.sm })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}