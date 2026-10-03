// Index.ets
interface WizardStep {
  title: string;
  description: string;
}

interface SummaryItem {
  label: string;
  value: string;
}

interface DocumentChecklist {
  label: string;
  status: string;
}

@Entry
@Component
struct LeaseWizard {
  @State currentStep: number = 1;
  @State name: string = 'Avery Tenant';
  @State contact: string = 'avery@example.com';
  @State income: string = '$120k annual';

  private steps: WizardStep[] = [
    { title: 'Profile', description: 'Tenant basics' },
    { title: 'Income', description: 'Proof details' },
    { title: 'References', description: 'Upload letters' },
    { title: 'Summary', description: 'Confirm submission' }
  ];

  private summaryItems: SummaryItem[] = [
    { label: 'Lease start', value: 'Aug 12' },
    { label: 'Monthly', value: '$2,450' },
    { label: 'Deposit', value: '$2,450' },
    { label: 'Pets', value: '2 approved' }
  ];

  private checklist: DocumentChecklist[] = [
    { label: 'ID verification', status: 'Uploaded' },
    { label: 'Employment letter', status: 'Pending' },
    { label: 'Credit report', status: 'Synced' }
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        // Navigation Icon
        Circle({ width: 30, height: 30 })
          .fillColor('#EFE7FF')
          .margin({ left: 16 });

        // Title
        Column() {
          Text('LeaseWizard')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor('#24132C');
          Text('Guided handoff')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor('#24132C')
            .opacity(0.7);
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center);

        // Action Icon
        Circle({ width: 30, height: 30 })
          .fillColor('#A07CFF')
          .opacity(0.3)
          .margin({ right: 16 });
      }
      .width('100%')
      .height(56)
      .padding({ top: 8, bottom: 8 });

      // Scrollable Content
      Scroll() {
        Column() {
          // Steps Card
          Column() {
            Text('Steps')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#24132C')
              .margin({ bottom: 12 });

            ForEach(this.steps, (step: WizardStep, index: number) => {
              Row() {
                // Step Indicator
                Column() {
                  Text(`${index + 1}`)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(index <= this.currentStep ? '#1D0F33' : '#24132C')
                    .backgroundColor(index <= this.currentStep ? '#A07CFF' : '#EFE7FF')
                    .borderRadius(14)
                    .width(28)
                    .height(28)
                    .textAlign(TextAlign.Center)
                    .textAlignVertical(TextAlign.Center);

                  if (index !== this.steps.length - 1) {
                    Line()
                      .width(2)
                      .height(32)
                      .backgroundColor('#EFE7FF')
                      .margin({ top: 4, bottom: 4 });
                  }
                }
                .alignItems(HorizontalAlign.Center);

                // Step Text
                Column() {
                  Text(step.title)
                    .fontSize(15)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#24132C');
                  Text(step.description)
                    .fontSize(13)
                    .fontColor('#24132C')
                    .opacity(0.7);
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)
                .margin({ left: 16 });

                // Edit/Go Button
                Button(index <= this.currentStep ? 'Edit' : 'Go')
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#2B0E1C')
                  .backgroundColor('#F6B4D7')
                  .borderRadius(8)
                  .height(32)
                  .onClick(() => {
                    this.currentStep = index;
                  });
              }
              .width('100%')
              .alignItems(VerticalAlign.Center);
            })
          }
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(24)
          .shadow({ radius: 8, color: 'rgba(0,0,0,0.16)', offsetX: 0, offsetY: 4 })
          .margin({ bottom: 16 });

          // Form Card
          Column() {
            Text('Form')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#24132C')
              .margin({ bottom: 12 });

            // Name Input
            Column() {
              Text('Full name')
                .fontSize(11)
                .fontColor('#24132C')
                .opacity(0.7)
                .margin({ bottom: 4 });
              TextInput({ text: this.name })
                .fontSize(13)
                .fontColor('#24132C')
                .backgroundColor('#EFE7FF')
                .borderRadius(8)
                .height(40)
                .onChange((value: string) => {
                  this.name = value;
                });
            }
            .alignItems(HorizontalAlign.Start)
            .margin({ bottom: 8 });

            // Contact Input
            Column() {
              Text('Contact')
                .fontSize(11)
                .fontColor('#24132C')
                .opacity(0.7)
                .margin({ bottom: 4 });
              TextInput({ text: this.contact })
                .fontSize(13)
                .fontColor('#24132C')
                .backgroundColor('#EFE7FF')
                .borderRadius(8)
                .height(40)
                .onChange((value: string) => {
                  this.contact = value;
                });
            }
            .alignItems(HorizontalAlign.Start)
            .margin({ bottom: 8 });

            // Income Input
            Column() {
              Text('Income')
                .fontSize(11)
                .fontColor('#24132C')
                .opacity(0.7)
                .margin({ bottom: 4 });
              TextInput({ text: this.income })
                .fontSize(13)
                .fontColor('#24132C')
                .backgroundColor('#EFE7FF')
                .borderRadius(8)
                .height(40)
                .onChange((value: string) => {
                  this.income = value;
                });
            }
            .alignItems(HorizontalAlign.Start)
            .margin({ bottom: 16 });

            // Navigation Buttons
            Row() {
              Button('Back')
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor('#24132C')
                .backgroundColor('#EFE7FF')
                .borderRadius(14)
                .layoutWeight(1)
                .height(40)
                .onClick(() => {
                  if (this.currentStep > 0) {
                    this.currentStep -= 1;
                  }
                });

              Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1D0F33')
                .backgroundColor('#A07CFF')
                .borderRadius(14)
                .layoutWeight(1)
                .height(40)
                .margin({ left: 12 })
                .onClick(() => {
                  if (this.currentStep < this.steps.length - 1) {
                    this.currentStep += 1;
                  }
                });
            }
            .width('100%');
          }
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(24)
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 2 })
          .margin({ bottom: 16 });

          // Summary Card
          Column() {
            Text('Summary')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#24132C')
              .margin({ bottom: 12 });

            ForEach(this.summaryItems, (item: SummaryItem) => {
              Row() {
                Text(item.label)
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#24132C');
                Text(item.value)
                  .fontSize(13)
                  .fontColor('#24132C');
              }
              .width('100%')
              .padding(12)
              .backgroundColor('#EFE7FF')
              .borderRadius(14)
              .justifyContent(FlexAlign.SpaceBetween)
              .margin({ bottom: 8 });
            });

            // Documents Section
            Text('Documents')
              .fontSize(15)
              .fontWeight(FontWeight.Medium)
              .fontColor('#24132C')
              .margin({ top: 8, bottom: 8 });

            ForEach(this.checklist, (doc: DocumentChecklist) => {
              Row() {
                Text(doc.label)
                  .fontSize(13)
                  .fontColor('#24132C');
                Text(doc.status)
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#F6B4D7');
              }
              .width('100%')
              .padding({ left: 12, right: 12, top: 8, bottom: 8 })
              .backgroundColor('#EFE7FF')
              .opacity(0.8)
              .borderRadius(8)
              .justifyContent(FlexAlign.SpaceBetween)
              .margin({ bottom: 4 });
            });
          }
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(24)
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 2 });
        }
        .padding({ left: 20, right: 20, top: 16, bottom: 16 });
      }
      .layoutWeight(1)
      .backgroundColor('#FDF8FF');
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FDF8FF');
  }
}