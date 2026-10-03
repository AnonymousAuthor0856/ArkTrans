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

class DesignTokens {
  static readonly primary: string = '#A07CFF';
  static readonly secondary: string = '#F6B4D7';
  static readonly tertiary: string = '#8DD3C7';
  static readonly background: string = '#FDF8FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#EFE7FF';
  static readonly outline: string = '#C9B4E6';
  static readonly success: string = '#6ED8A0';
  static readonly warning: string = '#FCD277';
  static readonly error: string = '#FF8899';
  static readonly onPrimary: string = '#1D0F33';
  static readonly onSecondary: string = '#2B0E1C';
  static readonly onTertiary: string = '#06231C';
  static readonly onBackground: string = '#1C1126';
  static readonly onSurface: string = '#24132C';
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
        Circle({ width: 30, height: 30 })
          .fill(DesignTokens.surfaceVariant);

        Column() {
          Text('LeaseWizard')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.onSurface);
          Text('Guided handoff')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.onSurface)
            .opacity(0.7);
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center);

        Circle({ width: 30, height: 30 })
          .fill(DesignTokens.primary)
          .opacity(0.3);
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center);

      // Scrollable Content
      Scroll() {
        Column({ space: 16 }) {
          // Steps Card
          Column({ space: 12 }) {
            Text('Steps')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(DesignTokens.onSurface);

            ForEach(this.steps, (step: WizardStep, index: number) => {
              Row() {
                Column() {
                  Text(`${index + 1}`)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(index <= this.currentStep ? DesignTokens.onPrimary : DesignTokens.onSurface)
                    .backgroundColor(index <= this.currentStep ? DesignTokens.primary : DesignTokens.surfaceVariant)
                    .borderRadius(14)
                    .width(28)
                    .height(28)
                    .textAlign(TextAlign.Center);

                  if (index !== this.steps.length - 1) {
                    Column()
                      .width(4)
                      .height(32)
                      .backgroundColor(DesignTokens.surfaceVariant)
                      .margin({ top: 4, bottom: 4 });
                  }
                }
                .alignItems(HorizontalAlign.Center);

                Column() {
                  Text(step.title)
                    .fontSize(15)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(DesignTokens.onSurface);
                  Text(step.description)
                    .fontSize(13)
                    .fontColor(DesignTokens.onSurface)
                    .opacity(0.7);
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)
                .margin({ left: 16 });

                Button(index <= this.currentStep ? 'Edit' : 'Go')
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(DesignTokens.onSecondary)
                  .backgroundColor(DesignTokens.secondary)
                  .borderRadius(8)
                  .height(32)
                  .onClick(() => {
                    this.currentStep = index;
                  });
              }
              .width('100%')
              .alignItems(VerticalAlign.Top);
            });
          }
          .width('100%')
          .padding(16)
          .backgroundColor(DesignTokens.surface)
          .borderRadius(24)
          .shadow({ radius: 8, color: '#29000000', offsetX: 0, offsetY: 4 });

          // Form Card
          Column({ space: 12 }) {
            Text('Form')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(DesignTokens.onSurface);

            TextInput({ text: this.name, placeholder: 'Full name' })
              .onChange((value: string) => {
                this.name = value;
              })
              .width('100%')
              .height(48)
              .borderRadius(14)
              .backgroundColor(DesignTokens.surfaceVariant);

            TextInput({ text: this.contact, placeholder: 'Contact' })
              .onChange((value: string) => {
                this.contact = value;
              })
              .width('100%')
              .height(48)
              .borderRadius(14)
              .backgroundColor(DesignTokens.surfaceVariant);

            TextInput({ text: this.income, placeholder: 'Income' })
              .onChange((value: string) => {
                this.income = value;
              })
              .width('100%')
              .height(48)
              .borderRadius(14)
              .backgroundColor(DesignTokens.surfaceVariant);

            Row({ space: 12 }) {
              Button('Back')
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(DesignTokens.onSurface)
                .backgroundColor(DesignTokens.surfaceVariant)
                .borderRadius(14)
                .layoutWeight(1)
                .height(48)
                .onClick(() => {
                  if (this.currentStep > 0) {
                    this.currentStep -= 1;
                  }
                });

              Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(DesignTokens.onPrimary)
                .backgroundColor(DesignTokens.primary)
                .borderRadius(14)
                .layoutWeight(1)
                .height(48)
                .onClick(() => {
                  if (this.currentStep < this.steps.length - 1) {
                    this.currentStep += 1;
                  }
                });
            }
            .width('100%');
          }
          .width('100%')
          .padding(16)
          .backgroundColor(DesignTokens.surface)
          .borderRadius(24)
          .shadow({ radius: 8, color: '#29000000', offsetX: 0, offsetY: 4 });

          // Summary Card
          Column({ space: 12 }) {
            Text('Summary')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(DesignTokens.onSurface);

            ForEach(this.summaryItems, (item: SummaryItem) => {
              Row() {
                Text(item.label)
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(DesignTokens.onSurface);
                Text(item.value)
                  .fontSize(13)
                  .fontColor(DesignTokens.onSurface);
              }
              .width('100%')
              .padding(12)
              .backgroundColor(DesignTokens.surfaceVariant)
              .borderRadius(14)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center);
            });

            Column({ space: 8 }) {
              Text('Documents')
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(DesignTokens.onSurface);

              ForEach(this.checklist, (doc: DocumentChecklist) => {
                Row() {
                  Text(doc.label)
                    .fontSize(13)
                    .fontColor(DesignTokens.onSurface);
                  Text(doc.status)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(DesignTokens.secondary);
                }
                .width('100%')
                .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                .backgroundColor(DesignTokens.surfaceVariant)
                .opacity(0.8)
                .borderRadius(8)
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(VerticalAlign.Center);
              });
            }
          }
          .width('100%')
          .padding(16)
          .backgroundColor(DesignTokens.surface)
          .borderRadius(24)
          .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 });
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 16, bottom: 16 });
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.background);
  }
}