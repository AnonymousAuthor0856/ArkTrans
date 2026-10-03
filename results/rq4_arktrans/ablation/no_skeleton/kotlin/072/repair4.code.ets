@Entry
@Component
struct ReliefFundForm {
  @State currentStep: number = 1
  @State name: string = ''
  @State organization: string = ''
  @State contact: string = ''
  @State narrative: string = ''
  @State selectedChip: number = 0

  // Design Tokens
  private readonly primaryColor: ResourceColor = '#B58B5A' as ResourceColor
  private readonly secondaryColor: ResourceColor = '#E5C48F' as ResourceColor
  private readonly tertiaryColor: ResourceColor = '#8BB39B' as ResourceColor
  private readonly backgroundColor: ResourceColor = '#F6F0E3' as ResourceColor
  private readonly surfaceColor: ResourceColor = '#FFFFFF' as ResourceColor
  private readonly surfaceVariantColor: ResourceColor = '#E7D7C2' as ResourceColor
  private readonly outlineColor: ResourceColor = '#C3B09E' as ResourceColor
  private readonly successColor: ResourceColor = '#6FB08C' as ResourceColor
  private readonly warningColor: ResourceColor = '#E6B566' as ResourceColor
  private readonly errorColor: ResourceColor = '#D96C5F' as ResourceColor
  private readonly onPrimaryColor: ResourceColor = '#2D1A0D' as ResourceColor
  private readonly onSecondaryColor: ResourceColor = '#2F230C' as ResourceColor
  private readonly onTertiaryColor: ResourceColor = '#0E1A13' as ResourceColor
  private readonly onBackgroundColor: ResourceColor = '#1E130C' as ResourceColor
  private readonly onSurfaceColor: ResourceColor = '#2A1C12' as ResourceColor

  interface StepItem {
    title: string;
    description: string;
  }

  private readonly steps: StepItem[] = [
    { title: 'Identity', description: 'Applicant basics' },
    { title: 'Impact', description: 'Community reach' },
    { title: 'Needs', description: 'Immediate relief' },
    { title: 'Summary', description: 'Confirm details' }
  ]

  private readonly chips: string[] = ['Medical', 'Shelter', 'Food', 'Utilities']

  interface SummaryItem {
    label: string;
    value: string;
  }

  private readonly summaryItems: SummaryItem[] = [
    { label: 'Requested', value: '$4,500' },
    { label: 'Households', value: '36' },
    { label: 'Region', value: 'North loop' },
    { label: 'Urgency', value: '48h' }
  ]

  build() {
    Column() {
      // Top Bar
      Row() {
        // Left Icon Placeholder
        Image($r('app.media.startIcon'))
          .width(30)
          .height(30)
          .borderRadius(15)
          .backgroundColor(this.surfaceVariantColor)
          .objectFit(ImageFit.Cover)

        Blank()

        // Center Title
        Column() {
          Text('ReliefFund')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurfaceColor)
          Text('Civic support intake')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Gray) // Approximating alpha 0.7
        }

        Blank()

        // Right Icon Placeholder
        Circle({ width: 30, height: 30 })
          .fill(this.primaryColor)
          .opacity(0.35)
      }
      .width('100%')
      .height(60)
      .padding({ left: 20, right: 20 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Scrollable Content
      Scroll() {
        Column({ space: 16 }) {
          // Steps Card
          this.buildStepsCard()

          // Focus Chips Card
          this.buildFocusChipsCard()

          // Applicant Details Card
          this.buildApplicantDetailsCard()

          // Summary Card
          this.buildSummaryCard()
        }
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }

  @Builder
  buildStepsCard() {
    Column({ space: 12 }) {
      Text('Steps')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onSurfaceColor)

      Column({ space: 12 }) {
        ForEach(this.steps, (step: StepItem, index: number) => {
          const reached = index <= this.currentStep
          Row({ space: 12 }) {
            // Stepper Indicator
            Column({ space: 4 }) {
              Row() {
                Text(`${index + 1}`)
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(reached ? this.onPrimaryColor : this.onSurfaceColor)
                  .textAlign(TextAlign.Center)
              }
              .width(26)
              .height(26)
              .borderRadius(13)
              .backgroundColor(reached ? this.primaryColor : this.surfaceVariantColor)
              .justifyContent(FlexAlign.Center)

              if (index !== this.steps.length - 1) {
                Divider()
                  .width(3)
                  .height(28)
                  .color(this.surfaceVariantColor)
              }
            }

            // Step Info
            Column({ space: 2 }) {
              Text(step.title)
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.onSurfaceColor)
              Text(step.description)
                .fontSize(13)
                .fontColor(Color.Gray)
            }
            .layoutWeight(1)

            // Action Button
            Button(reached ? 'Edit' : 'Go')
              .backgroundColor(this.secondaryColor)
              .fontColor(this.onSecondaryColor)
              .borderRadius(8)
              .height(32)
              .width(60)
              .onClick(() => {
                this.currentStep = index
              })
          }
        })
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor(this.surfaceColor)
    .borderRadius(24)
    .shadow({ radius: 8, color: '#1A000000', offsetY: 4 })
  }

  @Builder
  buildFocusChipsCard() {
    Column({ space: 12 }) {
      Text('Focus')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onSurfaceColor)

      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
        ForEach(this.chips, (chip: string, index: number) => {
          const active = this.selectedChip === index
          Text(chip)
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurfaceColor)
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .margin({ right: 12, bottom: 8 })
            .borderRadius(8)
            .border({ width: 1, color: active ? this.primaryColor : this.outlineColor })
            .backgroundColor(active ? Color.Transparent : this.surfaceVariantColor)
            .onClick(() => {
              this.selectedChip = index
            })
        })
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor(this.surfaceColor)
    .borderRadius(24)
    .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
  }

  @Builder
  buildApplicantDetailsCard() {
    Column({ space: 12 }) {
      Text('Applicant details')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onSurfaceColor)

      TextInput({ placeholder: 'Full name' })
        .width('100%')
        .height(56)
        .backgroundColor(this.backgroundColor)
        .borderRadius(12)
        .border({ width: 1, color: this.outlineColor })
        .onChange((value: string) => { this.name = value })

      TextInput({ placeholder: 'Organization' })
        .width('100%')
        .height(56)
        .backgroundColor(this.backgroundColor)
        .borderRadius(12)
        .border({ width: 1, color: this.outlineColor })
        .onChange((value: string) => { this.organization = value })

      TextInput({ placeholder: 'Contact' })
        .width('100%')
        .height(56)
        .backgroundColor(this.backgroundColor)
        .borderRadius(12)
        .border({ width: 1, color: this.outlineColor })
        .onChange((value: string) => { this.contact = value })

      TextArea({ placeholder: 'Relief narrative' })
        .width('100%')
        .height(100)
        .backgroundColor(this.backgroundColor)
        .borderRadius(12)
        .border({ width: 1, color: this.outlineColor })
        .onChange((value: string) => { this.narrative = value })

      Row({ space: 12 }) {
        Button('Back')
          .layoutWeight(1)
          .height(48)
          .backgroundColor(this.surfaceVariantColor)
          .fontColor(this.onSurfaceColor)
          .borderRadius(14)
          .onClick(() => {
            if (this.currentStep > 0) this.currentStep--
          })

        Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
          .layoutWeight(1)
          .height(48)
          .backgroundColor(this.primaryColor)
          .fontColor(this.onPrimaryColor)
          .borderRadius(14)
          .onClick(() => {
            if (this.currentStep < this.steps.length - 1) this.currentStep++
          })
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor(this.surfaceColor)
    .borderRadius(24)
    .shadow({ radius: 8, color: '#1A000000', offsetY: 4 })
  }

  @Builder
  buildSummaryCard() {
    Column({ space: 8 }) {
      Text('Summary')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onSurfaceColor)

      ForEach(this.summaryItems, (item: SummaryItem) => {
        Row() {
          Text(item.label)
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurfaceColor)
          
          Blank()

          Text(item.value)
            .fontSize(13)
            .fontColor(this.onSurfaceColor)
        }
        .width('100%')
        .padding(12)
        .backgroundColor(this.surfaceVariantColor)
        .borderRadius(14)
      })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(this.surfaceColor)
    .borderRadius(24)
    .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
  }
}