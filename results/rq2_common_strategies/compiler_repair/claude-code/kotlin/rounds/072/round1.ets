@Entry
@Component
struct ReliefFundPage {
  @State currentStep: number = 1;
  @State name: string = '';
  @State organization: string = '';
  @State contact: string = '';
  @State narrative: string = '';
  @State selectedChip: number = 0;

  private steps: FormStep[] = [
    { title: 'Identity', description: 'Applicant basics' },
    { title: 'Impact', description: 'Community reach' },
    { title: 'Needs', description: 'Immediate relief' },
    { title: 'Summary', description: 'Confirm details' }
  ];

  private chips: string[] = ['Medical', 'Shelter', 'Food', 'Utilities'];

  private summaryItems: SummaryItem[] = [
    { label: 'Requested', value: '$4,500' },
    { label: 'Households', value: '36' },
    { label: 'Region', value: 'North loop' },
    { label: 'Urgency', value: '48h' }
  ];

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column() {
          this.StepperCard()
          this.FocusChipCard()
          this.ApplicantFormCard()
          this.SummaryCard()
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 12, bottom: 12 })
        .justifyContent(FlexAlign.Start)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F6F0E3')
  }

  @Builder
  TopBar() {
    Row() {
      Circle({ width: 30, height: 30 })
        .fill('#E7D7C2')

      Column() {
        Text('ReliefFund')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2A1C12')
        Text('Civic support intake')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2A1C12')
          .opacity(0.7)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      Circle({ width: 30, height: 30 })
        .fill('rgba(181, 139, 90, 0.35)')
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor('#F6F0E3')
  }

  @Builder
  StepBadge(index: number, reached: boolean) {
    Stack() {
      Circle({ width: 26, height: 26 })
        .fill(reached ? '#B58B5A' : '#E7D7C2')
      Text(`${index + 1}`)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(reached ? '#2D1A0D' : '#2A1C12')
    }
    .width(26)
    .height(26)
  }

  @Builder
  StepperCard() {
    Column() {
      Text('Steps')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#2A1C12')
        .margin({ bottom: 12 })

      ForEach(this.steps, (step: FormStep, index: number) => {
        Row() {
          Column() {
            this.StepBadge(index, index <= this.currentStep)

            if (index !== this.steps.length - 1) {
              Rect({ width: 3, height: 28 })
                .fill('#E7D7C2')
                .margin({ top: 2, bottom: 2 })
            }
          }
          .alignItems(HorizontalAlign.Center)
          .margin({ right: 12 })

          Column() {
            Text(step.title)
              .fontSize(15)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2A1C12')
            Text(step.description)
              .fontSize(13)
              .fontColor('#2A1C12')
              .opacity(0.7)
              .margin({ top: 2 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)

          Button(index <= this.currentStep ? 'Edit' : 'Go')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor('#2F230C')
            .backgroundColor('#E5C48F')
            .borderRadius(8)
            .height(28)
            .padding({ left: 12, right: 12 })
            .onClick(() => {
              this.currentStep = index;
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)
      }, (step: FormStep, index: number) => `step-${index}`)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(24)
    .margin({ bottom: 16 })
    .shadow({ radius: 8, color: 'rgba(0,0,0,0.12)', offsetY: 4 })
  }

  @Builder
  FocusChipCard() {
    Column() {
      Text('Focus')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#2A1C12')
        .margin({ bottom: 12 })

      Row() {
        ForEach(this.chips, (chip: string, index: number) => {
          Text(chip)
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor('#2A1C12')
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .backgroundColor(this.selectedChip === index ? 'rgba(181, 139, 90, 0.2)' : '#E7D7C2')
            .border({
              width: 1,
              color: this.selectedChip === index ? '#B58B5A' : '#C3B09E'
            })
            .borderRadius(8)
            .margin({ right: index < this.chips.length - 1 ? 12 : 0 })
            .onClick(() => {
              this.selectedChip = index;
            })
        }, (chip: string, index: number) => `chip-${index}`)
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(24)
    .margin({ bottom: 16 })
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.08)', offsetY: 2 })
  }

  @Builder
  ApplicantFormCard() {
    Column() {
      Text('Applicant details')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#2A1C12')
        .margin({ bottom: 12 })

      this.FormField('Full name', this.name, (val: string) => { this.name = val; })
      this.FormField('Organization', this.organization, (val: string) => { this.organization = val; })
      this.FormField('Contact', this.contact, (val: string) => { this.contact = val; })

      Column() {
        Text('Relief narrative')
          .fontSize(13)
          .fontColor('#2A1C12')
          .opacity(0.7)
          .margin({ bottom: 4 })
        TextArea({ text: this.narrative, placeholder: '' })
          .width('100%')
          .height(80)
          .fontSize(15)
          .fontColor('#2A1C12')
          .backgroundColor('#FFFFFF')
          .border({ width: 1, color: '#C3B09E' })
          .borderRadius(8)
          .padding(10)
          .onChange((val: string) => {
            this.narrative = val;
          })
      }
      .width('100%')
      .margin({ bottom: 12 })

      Row() {
        Button('Back')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2A1C12')
          .backgroundColor('#E7D7C2')
          .borderRadius(14)
          .height(44)
          .layoutWeight(1)
          .margin({ right: 6 })
          .onClick(() => {
            if (this.currentStep > 0) {
              this.currentStep -= 1;
            }
          })

        Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2D1A0D')
          .backgroundColor('#B58B5A')
          .borderRadius(14)
          .height(44)
          .layoutWeight(1)
          .margin({ left: 6 })
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
    .backgroundColor('#FFFFFF')
    .borderRadius(24)
    .margin({ bottom: 16 })
    .shadow({ radius: 8, color: 'rgba(0,0,0,0.12)', offsetY: 4 })
  }

  @Builder
  FormField(label: string, value: string, onChange: (val: string) => void) {
    Column() {
      Text(label)
        .fontSize(13)
        .fontColor('#2A1C12')
        .opacity(0.7)
        .margin({ bottom: 4 })
      TextInput({ text: value, placeholder: '' })
        .width('100%')
        .height(44)
        .fontSize(15)
        .fontColor('#2A1C12')
        .backgroundColor('#FFFFFF')
        .border({ width: 1, color: '#C3B09E' })
        .borderRadius(8)
        .padding({ left: 10, right: 10 })
        .onChange((val: string) => {
          onChange(val);
        })
    }
    .width('100%')
    .margin({ bottom: 12 })
  }

  @Builder
  SummaryCard() {
    Column() {
      Text('Summary')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#2A1C12')
        .margin({ bottom: 8 })

      ForEach(this.summaryItems, (item: SummaryItem, index: number) => {
        Row() {
          Text(item.label)
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor('#2A1C12')
          Text(item.value)
            .fontSize(13)
            .fontColor('#2A1C12')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .padding(12)
        .backgroundColor('#E7D7C2')
        .borderRadius(14)
        .margin({ bottom: index < this.summaryItems.length - 1 ? 4 : 0 })
      }, (item: SummaryItem, index: number) => `summary-${index}`)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(24)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.08)', offsetY: 2 })
  }
}

interface FormStep {
  title: string;
  description: string;
}

interface SummaryItem {
  label: string;
  value: string;
}
