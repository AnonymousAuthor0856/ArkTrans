import { BusinessError } from '@kit.BasicServicesKit';

interface StepItem {
  title: string;
  description: string;
}

interface ChipItem {
  label: string;
  active: boolean;
}

interface SummaryItem {
  label: string;
  value: string;
}

interface StepMapItem {
  step: StepItem;
  index: number;
}

interface ChipMapItem {
  chip: ChipItem;
  index: number;
}

interface SummaryMapItem {
  item: SummaryItem;
  index: number;
}

@Entry
@Component
struct Index {
  @State currentStep: number = 0
  @State name: string = ''
  @State organization: string = ''
  @State contact: string = ''
  @State narrative: string = ''

  private getSteps(): Array<StepItem> {
    return [
      { title: 'Personal Info', description: 'Enter your details' },
      { title: 'Organization', description: 'Select or add org' },
      { title: 'Review', description: 'Confirm submission' }
    ];
  }

  private getChips(): Array<ChipItem> {
    return [
      { label: 'Food', active: true },
      { label: 'Shelter', active: false },
      { label: 'Medical', active: false }
    ];
  }

  private getSummaryData(): Array<SummaryItem> {
    return [
      { label: 'Name', value: this.name || 'N/A' },
      { label: 'Org', value: this.organization || 'N/A' }
    ];
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        // Surface 1: Steps
        Column() {
          Column({ space: 8 }) {
            Text('Steps')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2A1C12')

            ForEach(this.getSteps().map((step, idx) => ({ step, index: idx })), (item: StepMapItem) => {
              Row({ space: 8 }) {
                Column({ space: 0 }) {
                  Stack({ alignContent: Alignment.Center }) {
                    Text(`${item.index + 1}`)
                      .fontSize(14)
                      .fontColor(item.index <= this.currentStep ? '#FFFFFF' : '#2A1C12')
                  }
                  .width(26)
                  .height(26)
                  .borderRadius(13)
                  .backgroundColor(item.index <= this.currentStep ? '#6750A4' : '#E7E0EC')

                  if (item.index < this.getSteps().length - 1) {
                    Stack()
                      .width(3)
                      .height(28)
                      .backgroundColor('#E7E0EC')
                  }
                }
                .alignItems(HorizontalAlign.Center)

                Column({ space: 0 }) {
                  Text(item.step.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#2A1C12')
                  Text(item.step.description)
                    .fontSize(14)
                    .fontColor('#2A1C12')
                }
                .layoutWeight(1)

                Button() {
                  Text(item.index <= this.currentStep ? 'Edit' : 'Go')
                    .fontSize(14)
                    .fontColor('#FFFFFF')
                }
                .backgroundColor('#9A82F7')
                .borderRadius(8)
                .onClick(() => {
                  this.currentStep = item.index
                })
              }
              .alignItems(VerticalAlign.Center)
            }, (item: StepMapItem) => item.index.toString())
          }
          .padding(16)
        }
        .borderRadius(16)
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 4, color: '#1A000000' })

        // Surface 2: Focus
        Column() {
          Column({ space: 8 }) {
            Text('Focus')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2A1C12')

            Flex({ wrap: FlexWrap.Wrap }) {
              ForEach(this.getChips().map((chip, idx) => ({ chip, index: idx })), (item: ChipMapItem) => {
                Stack({ alignContent: Alignment.Center }) {
                  Text(item.chip.label)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#2A1C12')
                }
                .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                .borderRadius(8)
                .margin({ right: 8, bottom: 8 })
                .backgroundColor(item.chip.active ? '#D0BCFF' : '#E7E0EC')
                .border({ width: 1, color: item.chip.active ? '#6750A4' : '#79747E', radius: 8 })
              }, (item: ChipMapItem) => item.index.toString())
            }
          }
          .padding(16)
        }
        .borderRadius(16)
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 4, color: '#1A000000' })

        // Surface 3: Applicant Details
        Column() {
          Column({ space: 8 }) {
            Text('Applicant details')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2A1C12')

            TextInput({ placeholder: 'Full name' })
              .width('100%')
              .height(48)
              .backgroundColor('#FFFFFF')
              .border({ width: 1, color: '#79747E', radius: 8 })
              .onChange((value: string) => {
                this.name = value
              })

            TextInput({ placeholder: 'Organization' })
              .width('100%')
              .height(48)
              .backgroundColor('#FFFFFF')
              .border({ width: 1, color: '#79747E', radius: 8 })
              .onChange((value: string) => {
                this.organization = value
              })

            TextInput({ placeholder: 'Contact' })
              .width('100%')
              .height(48)
              .backgroundColor('#FFFFFF')
              .border({ width: 1, color: '#79747E', radius: 8 })
              .onChange((value: string) => {
                this.contact = value
              })

            TextArea({ placeholder: 'Relief narrative' })
              .width('100%')
              .height(100)
              .backgroundColor('#FFFFFF')
              .border({ width: 1, color: '#79747E', radius: 8 })
              .onChange((value: string) => {
                this.narrative = value
              })

            Row({ space: 8 }) {
              Button() {
                Text('Back')
                  .fontSize(16)
                  .fontColor('#1C1B1F')
              }
              .layoutWeight(1)
              .backgroundColor('#E7E0EC')
              .borderRadius(12)
              .onClick(() => {
                if (this.currentStep > 0) this.currentStep -= 1
              })

              Button() {
                Text(this.currentStep === this.getSteps().length - 1 ? 'Submit' : 'Next')
                  .fontSize(16)
                  .fontColor('#FFFFFF')
              }
              .layoutWeight(1)
              .backgroundColor('#6750A4')
              .borderRadius(12)
              .onClick(() => {
                if (this.currentStep < this.getSteps().length - 1) this.currentStep += 1
              })
            }
          }
          .padding(16)
        }
        .borderRadius(16)
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 4, color: '#1A000000' })

        // Surface 4: Summary
        Column() {
          Column({ space: 4 }) {
            Text('Summary')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2A1C12')

            ForEach(this.getSummaryData().map((item, idx) => ({ item, index: idx })), (data: SummaryMapItem) => {
              Row({ space: 0 }) {
                Text(data.item.label)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#2A1C12')
                  .layoutWeight(1)
                
                Text(data.item.value)
                  .fontSize(14)
                  .fontColor('#2A1C12')
                  .textAlign(TextAlign.End)
                  .layoutWeight(1)
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)
              .padding(12)
              .borderRadius(12)
              .backgroundColor('#E7E0EC')
            }, (data: SummaryMapItem) => data.index.toString())
          }
          .padding(16)
        }
        .borderRadius(16)
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 4, color: '#1A000000' })
      }
      .padding({ left: 20, right: 20, top: 12, bottom: 12 })
      .width('100%')
      .layoutWeight(1)
      .scrollable(true)

      // Top App Bar Area
      Row() {
        Column({ space: 0 }) {
          Text('ReliefFund')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#2A1C12')
          Text('Civic support intake')
            .fontSize(14)
            .fontColor('#2A1C12')
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)

        Button() {
          Stack()
            .width(30)
            .height(30)
            .borderRadius(15)
            .backgroundColor('#E7E0EC')
        }
        .margin({ right: 8 })
        .onClick(() => {})

        Button() {
          Stack()
            .width(30)
            .height(30)
            .borderRadius(15)
            .backgroundColor('#D0BCFF')
        }
        .onClick(() => {})
      }
      .width('100%')
      .height(60)
      .padding({ left: 16, right: 16 })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F6F0E3')
  }
}