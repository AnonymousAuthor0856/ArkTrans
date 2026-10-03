import { router } from '@kit.ArkUI';

@Entry
@Component
struct ReliefFundForm {
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

  private chips: SupportChip[] = [
    { label: 'Medical' },
    { label: 'Shelter' },
    { label: 'Food' },
    { label: 'Utilities' }
  ];

  private summary: SummaryItem[] = [
    { label: 'Requested', value: '$4,500' },
    { label: 'Households', value: '36' },
    { label: 'Region', value: 'North loop' },
    { label: 'Urgency', value: '48h' }
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Circle({ width: 30, height: 30 })
          .backgroundColor('#E7D7C2')

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
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)

        Circle({ width: 30, height: 30 })
          .backgroundColor('#B58B5A')
          .opacity(0.35)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 20, bottom: 10 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          // Steps Card
          this.StepsCard()

          // Focus Chips Card
          this.FocusChipsCard()

          // Applicant Details Card
          this.ApplicantDetailsCard()

          // Summary Card
          this.SummaryCard()
        }
        .padding({ left: 20, right: 20, bottom: 20 })
        .width('100%')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F6F0E3')
  }

  @Builder
  StepsCard() {
    Column() {
      Text('Steps')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2A1C12')
        .margin({ bottom: 12 })

      ForEach(this.steps, (step: FormStep, index: number) => {
        Row() {
          Column() {
            Stack() {
              Circle({ width: 26, height: 26 })
                .backgroundColor(index <= this.currentStep ? '#B58B5A' : '#E7D7C2')
              Text(`${index + 1}`)
                .textAlign(TextAlign.Center)
                .verticalCenter()
                .horizontalCenter()
                .fontColor('#FFFFFF')
            }
            .width(26)
            .height(26)

            if (index < this.steps.length - 1) {
              Rect()
                .width(3)
                .height(28)
                .backgroundColor('#E7D7C2')
                .margin({ top: 2 })
            }
          }
          .alignItems(HorizontalAlign.Center)

          Column() {
            Text(step.title)
              .fontSize(15)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2A1C12')
            Text(step.description)
              .fontSize(13)
              .fontColor('#2A1C12')
              .opacity(0.7)
          }
          .layoutWeight(1)
          .margin({ left: 12 })

          Button(index <= this.currentStep ? 'Edit' : 'Go')
            .backgroundColor('#E5C48F')
            .fontColor('#2F230C')
            .borderRadius(8)
            .onClick(() => {
              this.currentStep = index;
            })
        }
        .width('100%')
        .margin({ bottom: 12 })
      })
    }
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(24)
    .shadow({ radius: 8, color: '#00000018', offsetY: 4 })
    .margin({ bottom: 16 })
  }

  @Builder
  FocusChipsCard() {
    Column() {
      Text('Focus')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2A1C12')
        .margin({ bottom: 12 })

      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.chips, (chip: SupportChip, index: number) => {
          Button(chip.label)
            .backgroundColor(this.selectedChip === index ? '#B58B5A' : '#E7D7C2')
            .opacity(this.selectedChip === index ? 0.2 : 1)
            .borderWidth(1)
            .borderColor(this.selectedChip === index ? '#B58B5A' : '#C3B09E')
            .borderRadius(8)
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .margin({ right: 12, bottom: 8 })
            .onClick(() => {
              this.selectedChip = index;
            })
        })
      }
    }
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(24)
    .shadow({ radius: 4, color: '#00000012', offsetY: 2 })
    .margin({ bottom: 16 })
  }

  @Builder
  ApplicantDetailsCard() {
    Column() {
      Text('Applicant details')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2A1C12')
        .margin({ bottom: 12 })

      TextInput({ placeholder: 'Full name' })
        .backgroundColor('#F6F0E3')
        .borderRadius(14)
        .borderWidth(1)
        .borderColor('#C3B09E')
        .padding(16)
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.name = value;
        })

      TextInput({ placeholder: 'Organization' })
        .backgroundColor('#F6F0E3')
        .borderRadius(14)
        .borderWidth(1)
        .borderColor('#C3B09E')
        .padding(16)
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.organization = value;
        })

      TextInput({ placeholder: 'Contact' })
        .backgroundColor('#F6F0E3')
        .borderRadius(14)
        .borderWidth(1)
        .borderColor('#C3B09E')
        .padding(16)
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.contact = value;
        })

      TextArea({ placeholder: 'Relief narrative' })
        .backgroundColor('#F6F0E3')
        .borderRadius(14)
        .borderWidth(1)
        .borderColor('#C3B09E')
        .padding(16)
        .height(100)
        .margin({ bottom: 16 })
        .onChange((value: string) => {
          this.narrative = value;
        })

      Row() {
        Button('Back')
          .backgroundColor('#E7D7C2')
          .fontColor('#2A1C12')
          .borderRadius(14)
          .layoutWeight(1)
          .margin({ right: 8 })
          .onClick(() => {
            if (this.currentStep > 0) {
              this.currentStep--;
            }
          })

        Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
          .backgroundColor('#B58B5A')
          .fontColor('#2D1A0D')
          .borderRadius(14)
          .layoutWeight(1)
          .onClick(() => {
            if (this.currentStep < this.steps.length - 1) {
              this.currentStep++;
            }
          })
      }
    }
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(24)
    .shadow({ radius: 8, color: '#00000018', offsetY: 4 })
    .margin({ bottom: 16 })
  }

  @Builder
  SummaryCard() {
    Column() {
      Text('Summary')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2A1C12')
        .margin({ bottom: 12 })

      ForEach(this.summary, (item: SummaryItem) => {
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
        .margin({ bottom: 8 })
      })
    }
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(24)
    .shadow({ radius: 4, color: '#00000012', offsetY: 2 })
  }
}

interface FormStep {
  title: string;
  description: string;
}

interface SupportChip {
  label: string;
}

interface SummaryItem {
  label: string;
  value: string;
}