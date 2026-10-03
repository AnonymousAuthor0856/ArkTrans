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
  onSurface: '#2A1C12'
};

const Spacing = { xxs: 4, xs: 8, sm: 12, md: 16, lg: 20, xl: 28, xxl: 36, xxxl: 48 };
const Shapes = { small: 8, medium: 14, large: 24 };

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

const steps: FormStep[] = [
  { title: 'Identity', description: 'Applicant basics' },
  { title: 'Impact', description: 'Community reach' },
  { title: 'Needs', description: 'Immediate relief' },
  { title: 'Summary', description: 'Confirm details' }
];

const chips: SupportChip[] = [
  { label: 'Medical' },
  { label: 'Shelter' },
  { label: 'Food' },
  { label: 'Utilities' }
];

const summary: SummaryItem[] = [
  { label: 'Requested', value: '$4,500' },
  { label: 'Households', value: '36' },
  { label: 'Region', value: 'North loop' },
  { label: 'Urgency', value: '48h' }
];

@Entry
@Component
struct Index {
  @State currentStep: number = 1;
  @State name: string = '';
  @State organization: string = '';
  @State contact: string = '';
  @State narrative: string = '';
  @State selectedChip: number = 0;

  build() {
    Column() {
      Row() {
        Stack() {
        }
        .width(30)
        .height(30)
        .borderRadius(15)
        .backgroundColor(Colors.surfaceVariant)

        Column() {
          Text('ReliefFund')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text('Civic support intake')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B32A1C12')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Stack() {
        }
        .width(30)
        .height(30)
        .borderRadius(15)
        .backgroundColor('#59B58B5A')
      }
      .width('100%')
      .height(56)
      .padding({ left: 12, right: 12 })

      Scroll() {
        Column({ space: Spacing.md }) {
          Column() {
            Column({ space: Spacing.sm }) {
              Text('Steps')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(Colors.onSurface)

              ForEach(steps, (step: FormStep, index: number) => {
                Row({ space: Spacing.sm }) {
                  Column() {
                    Stack() {
                      Text((index + 1).toString())
                        .fontSize(11)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(index <= this.currentStep ? Colors.onPrimary : Colors.onSurface)
                    }
                    .width(26)
                    .height(26)
                    .borderRadius(13)
                    .backgroundColor(index <= this.currentStep ? Colors.primary : Colors.surfaceVariant)

                    if (index !== steps.length - 1) {
                      Column() {
                      }
                      .width(3)
                      .height(28)
                      .backgroundColor(Colors.surfaceVariant)
                    }
                  }

                  Column() {
                    Text(step.title)
                      .fontSize(15)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(Colors.onSurface)
                    Text(step.description)
                      .fontSize(13)
                      .fontColor('#B32A1C12')
                  }
                  .layoutWeight(1)

                  Button(index <= this.currentStep ? 'Edit' : 'Go')
                    .backgroundColor(Colors.secondary)
                    .fontColor(Colors.onSecondary)
                    .borderRadius(Shapes.small)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .onClick(() => {
                      this.currentStep = index;
                    })
                }
                .alignItems(VerticalAlign.Center)
              }, (step: FormStep) => step.title)
            }
            .padding(Spacing.md)
          }
          .borderRadius(Shapes.large)
          .backgroundColor(Colors.surface)
          .shadow({ radius: 8, color: '#18000000', offsetY: 4 })

          Column() {
            Column({ space: Spacing.sm }) {
              Text('Focus')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(Colors.onSurface)

              Row({ space: Spacing.sm }) {
                ForEach(chips, (chip: SupportChip, index: number) => {
                  Text(chip.label)
                    .fontSize(15)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                    .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.xs, bottom: Spacing.xs })
                    .borderRadius(Shapes.small)
                    .backgroundColor(this.selectedChip === index ? '#33B58B5A' : Colors.surfaceVariant)
                    .border({ width: 1, color: this.selectedChip === index ? Colors.primary : Colors.outline })
                    .onClick(() => {
                      this.selectedChip = index;
                    })
                }, (chip: SupportChip) => chip.label)
              }
            }
            .padding(Spacing.md)
          }
          .borderRadius(Shapes.large)
          .backgroundColor(Colors.surface)
          .shadow({ radius: 4, color: '#12000000', offsetY: 2 })

          Column() {
            Column({ space: Spacing.sm }) {
              Text('Applicant details')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(Colors.onSurface)

              TextInput({ placeholder: 'Full name', text: this.name })
                .width('100%')
                .onChange((v: string) => {
                  this.name = v;
                })

              TextInput({ placeholder: 'Organization', text: this.organization })
                .width('100%')
                .onChange((v: string) => {
                  this.organization = v;
                })

              TextInput({ placeholder: 'Contact', text: this.contact })
                .width('100%')
                .onChange((v: string) => {
                  this.contact = v;
                })

              TextArea({ placeholder: 'Relief narrative', text: this.narrative })
                .width('100%')
                .height(80)
                .onChange((v: string) => {
                  this.narrative = v;
                })

              Row({ space: Spacing.sm }) {
                Button('Back')
                  .layoutWeight(1)
                  .backgroundColor(Colors.surfaceVariant)
                  .fontColor(Colors.onSurface)
                  .borderRadius(Shapes.medium)
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .onClick(() => {
                    if (this.currentStep > 0) {
                      this.currentStep -= 1;
                    }
                  })

                Button(this.currentStep === steps.length - 1 ? 'Submit' : 'Next')
                  .layoutWeight(1)
                  .backgroundColor(Colors.primary)
                  .fontColor(Colors.onPrimary)
                  .borderRadius(Shapes.medium)
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .onClick(() => {
                    if (this.currentStep < steps.length - 1) {
                      this.currentStep += 1;
                    }
                  })
              }
            }
            .padding(Spacing.md)
          }
          .borderRadius(Shapes.large)
          .backgroundColor(Colors.surface)
          .shadow({ radius: 8, color: '#18000000', offsetY: 4 })

          Column() {
            Column({ space: Spacing.xs }) {
              Text('Summary')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(Colors.onSurface)

              ForEach(summary, (item: SummaryItem) => {
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
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(VerticalAlign.Center)
                .borderRadius(Shapes.medium)
                .backgroundColor(Colors.surfaceVariant)
                .padding(Spacing.sm)
              }, (item: SummaryItem) => item.label)
            }
            .padding(Spacing.md)
          }
          .borderRadius(Shapes.large)
          .backgroundColor(Colors.surface)
          .shadow({ radius: 4, color: '#12000000', offsetY: 2 })
        }
        .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.sm, bottom: Spacing.sm })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
