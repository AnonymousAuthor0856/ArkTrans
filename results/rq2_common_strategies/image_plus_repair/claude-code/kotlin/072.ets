interface FormStep {
  title: string;
  description: string;
}

interface SummaryItem {
  label: string;
  value: string;
}

interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  onPrimary: string;
  onSecondary: string;
  onSurface: string;
  onBackground: string;
}

@Entry
@Component
struct Index {
  @State name: string = ''
  @State organization: string = ''
  @State contact: string = ''
  @State narrative: string = ''
  @State currentStep: number = 1
  @State selectedChip: number = 0

  private colors: ColorTokens = {
    primary: '#B58B5A',
    secondary: '#E5C48F',
    tertiary: '#8BB39B',
    background: '#F6F0E3',
    surface: '#FFFFFF',
    surfaceVariant: '#E7D7C2',
    outline: '#C3B09E',
    onPrimary: '#2D1A0D',
    onSecondary: '#2F230C',
    onSurface: '#2A1C12',
    onBackground: '#1E130C'
  }

  private steps: FormStep[] = [
    { title: 'Identity', description: 'Applicant basics' },
    { title: 'Impact', description: 'Community reach' },
    { title: 'Needs', description: 'Immediate relief' },
    { title: 'Summary', description: 'Confirm details' }
  ]

  private chips: string[] = ['Medical', 'Shelter', 'Food', 'Utilities']

  private summary: SummaryItem[] = [
    { label: 'Requested', value: '$4,500' },
    { label: 'Households', value: '36' },
    { label: 'Region', value: 'North loop' },
    { label: 'Urgency', value: '48h' }
  ]

  build() {
    Column() {
      // Top bar
      Row() {
        // Navigation icon placeholder
        Circle({ width: 56, height: 56 })
          .fill(this.colors.surfaceVariant)

        Column() {
          Text('ReliefFund')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.colors.onSurface)
          Text('Civic support intake')
            .fontSize(16)
            .fontColor(this.colors.onSurface)
            .opacity(0.7)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        // Action icon placeholder
        Circle({ width: 56, height: 56 })
          .fill(this.colors.primary)
          .opacity(0.35)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .backgroundColor(this.colors.surface)

      Scroll() {
        Column({ space: 16 }) {
          // Steps card
          Column({ space: 12 }) {
            Text('Steps')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.colors.onSurface)

            ForEach(this.steps, (step: FormStep, index: number) => {
              Row({ space: 12 }) {
                Column({ space: 0 }) {
                  Circle({ width: 26, height: 26 })
                    .fill(index <= this.currentStep ? this.colors.primary : this.colors.surfaceVariant)
                  Text(`${index + 1}`)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(index <= this.currentStep ? this.colors.onPrimary : this.colors.onSurface)
                    .position({ x: 0, y: 0 })
                    .width(26)
                    .height(26)
                    .textAlign(TextAlign.Center)
                  if (index !== this.steps.length - 1) {
                    Rect({ width: 3, height: 28 })
                      .fill(this.colors.surfaceVariant)
                      .margin({ top: 0, bottom: 0 })
                  }
                }
                .alignItems(HorizontalAlign.Center)
                .width(26)

                Column() {
                  Text(step.title)
                    .fontSize(15)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.colors.onSurface)
                  Text(step.description)
                    .fontSize(13)
                    .fontColor(this.colors.onSurface)
                    .opacity(0.7)
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)
                .justifyContent(FlexAlign.Center)

                Button(index <= this.currentStep ? 'Edit' : 'Go')
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.colors.onSecondary)
                  .backgroundColor(this.colors.secondary)
                  .borderRadius(8)
                  .height(28)
                  .padding({ left: 12, right: 12 })
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
          .backgroundColor(this.colors.surface)
          .borderRadius(24)
          .margin({ top: 12 })

          // Focus card
          Column({ space: 12 }) {
            Text('Focus')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.colors.onSurface)

            Row({ space: 12 }) {
              ForEach(this.chips, (chip: string, index: number) => {
                Text(chip)
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.colors.onSurface)
                  .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                  .backgroundColor(
                    this.selectedChip === index
                      ? this.colors.primary
                      : this.colors.surfaceVariant
                  )
                  .opacity(this.selectedChip === index ? 0.2 : 1)
                  .border({
                    width: 1,
                    color: this.selectedChip === index ? this.colors.primary : this.colors.outline
                  })
                  .borderRadius(8)
                  .onClick(() => {
                    this.selectedChip = index
                  })
              })
            }
          }
          .width('100%')
          .padding(16)
          .backgroundColor(this.colors.surface)
          .borderRadius(24)

          // Applicant details card
          Column({ space: 12 }) {
            Text('Applicant details')
              .fontSize(40)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.colors.onSurface)
              .margin({ bottom: 12 })

            // Full name
            TextInput({ placeholder: 'Full name', text: this.name })
              .width('100%')
              .height(72)
              .fontSize(28)
              .fontColor(this.colors.onSurface)
              .placeholderColor(this.colors.onSurface)
              .placeholderFont({ size: 28 })
              .backgroundColor('rgba(255,255,255,0.5)')
              .borderRadius(16)
              .border({ width: 2, color: this.colors.outline })
              .padding({ left: 24, right: 24 })
              .onChange((val: string) => {
                this.name = val
              })

            // Organization
            TextInput({ placeholder: 'Organization', text: this.organization })
              .width('100%')
              .height(72)
              .fontSize(28)
              .fontColor(this.colors.onSurface)
              .placeholderColor(this.colors.onSurface)
              .placeholderFont({ size: 28 })
              .backgroundColor('rgba(255,255,255,0.5)')
              .borderRadius(16)
              .border({ width: 2, color: this.colors.outline })
              .padding({ left: 24, right: 24 })
              .onChange((val: string) => {
                this.organization = val
              })

            // Contact
            TextInput({ placeholder: 'Contact', text: this.contact })
              .width('100%')
              .height(72)
              .fontSize(28)
              .fontColor(this.colors.onSurface)
              .placeholderColor(this.colors.onSurface)
              .placeholderFont({ size: 28 })
              .backgroundColor('rgba(255,255,255,0.5)')
              .borderRadius(16)
              .border({ width: 2, color: this.colors.outline })
              .padding({ left: 24, right: 24 })
              .onChange((val: string) => {
                this.contact = val
              })

            // Relief narrative (multi-line)
            TextArea({ placeholder: 'Relief narrative', text: this.narrative })
              .width('100%')
              .height(160)
              .fontSize(28)
              .fontColor(this.colors.onSurface)
              .placeholderColor(this.colors.onSurface)
              .placeholderFont({ size: 28 })
              .backgroundColor('rgba(255,255,255,0.5)')
              .borderRadius(16)
              .border({ width: 2, color: this.colors.outline })
              .padding(24)
              .onChange((val: string) => {
                this.narrative = val
              })

            // Buttons row
            Row({ space: 16 }) {
              Button('Back')
                .layoutWeight(1)
                .height(64)
                .fontSize(26)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.onSurface)
                .backgroundColor(this.colors.surfaceVariant)
                .borderRadius(24)
                .onClick(() => {
                  if (this.currentStep > 0) {
                    this.currentStep -= 1
                  }
                })

              Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
                .layoutWeight(1)
                .height(64)
                .fontSize(26)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.onPrimary)
                .backgroundColor(this.colors.primary)
                .borderRadius(24)
                .onClick(() => {
                  if (this.currentStep < this.steps.length - 1) {
                    this.currentStep += 1
                  }
                })
            }
            .width('100%')
            .margin({ top: 8 })
          }
          .width('100%')
          .padding(20)
          .backgroundColor(this.colors.surface)
          .borderRadius(32)
          .opacity(0.95)

          // Summary card
          Column({ space: 8 }) {
            Text('Summary')
              .fontSize(40)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.colors.onSurface)
              .margin({ bottom: 8 })

            ForEach(this.summary, (item: SummaryItem) => {
              Row() {
                Text(item.label)
                  .fontSize(24)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.colors.onSurface)
                Text(item.value)
                  .fontSize(20)
                  .fontColor(this.colors.onSurface)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .padding(16)
              .backgroundColor(this.colors.surfaceVariant)
              .borderRadius(20)
            })
          }
          .width('100%')
          .padding(20)
          .backgroundColor(this.colors.surface)
          .borderRadius(32)
          .margin({ bottom: 12 })
        }
        .width('100%')
        .padding({ left: 20, right: 20 })
      }
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
  }
}
