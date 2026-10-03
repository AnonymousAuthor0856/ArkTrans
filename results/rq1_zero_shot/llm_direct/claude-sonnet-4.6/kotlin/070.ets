import { router } from '@kit.ArkUI';

// Design Tokens
const Colors = {
  primary: '#A07CFF',
  secondary: '#F6B4D7',
  tertiary: '#8DD3C7',
  background: '#FDF8FF',
  surface: '#FFFFFF',
  surfaceVariant: '#EFE7FF',
  outline: '#C9B4E6',
  success: '#6ED8A0',
  warning: '#FCD277',
  error: '#FF8899',
  onPrimary: '#1D0F33',
  onSecondary: '#2B0E1C',
  onTertiary: '#06231C',
  onBackground: '#1C1126',
  onSurface: '#24132C',
};

const Spacing = {
  xxs: 4,
  xs: 8,
  sm: 12,
  md: 16,
  lg: 20,
  xl: 28,
  xxl: 36,
  xxxl: 48,
};

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

@Component
struct StepperSection {
  @Prop currentStep: number = 1;
  steps: WizardStep[] = [];
  onStepChange: (index: number) => void = () => {};

  build() {
    Column({ space: Spacing.sm }) {
      Text('Steps')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)

      ForEach(this.steps, (step: WizardStep, index: number) => {
        Row({ space: Spacing.md }) {
          Column({ space: 0 }) {
            Stack() {
              Circle()
                .width(28)
                .height(28)
                .fill(index <= this.currentStep ? Colors.primary : Colors.surfaceVariant)
              Text(`${index + 1}`)
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .fontColor(index <= this.currentStep ? Colors.onPrimary : Colors.onSurface)
            }
            .width(28)
            .height(28)

            if (index !== this.steps.length - 1) {
              Column()
                .width(4)
                .height(32)
                .backgroundColor(Colors.surfaceVariant)
            }
          }
          .alignItems(HorizontalAlign.Center)

          Column({ space: 2 }) {
            Text(step.title)
              .fontSize(15)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
            Text(step.description)
              .fontSize(13)
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
            .padding({ left: Spacing.sm, right: Spacing.sm })
            .onClick(() => {
              this.onStepChange(index);
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
    .alignItems(HorizontalAlign.Start)
    .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
  }
}

@Component
struct FormSection {
  @Link currentStep: number;
  @Link name: string;
  @Link contact: string;
  @Link income: string;
  stepsLength: number = 4;

  build() {
    Column({ space: Spacing.sm }) {
      Text('Form')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)

      Column({ space: 4 }) {
        Text('Full name')
          .fontSize(11)
          .fontColor(Colors.onSurface)
          .opacity(0.7)
        TextInput({ text: this.name, placeholder: 'Full name' })
          .width('100%')
          .fontSize(13)
          .fontColor(Colors.onSurface)
          .backgroundColor(Colors.surface)
          .borderWidth(1)
          .borderColor(Colors.outline)
          .borderRadius(8)
          .padding({ left: Spacing.sm, right: Spacing.sm })
          .onChange((value: string) => {
            this.name = value;
          })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Column({ space: 4 }) {
        Text('Contact')
          .fontSize(11)
          .fontColor(Colors.onSurface)
          .opacity(0.7)
        TextInput({ text: this.contact, placeholder: 'Contact' })
          .width('100%')
          .fontSize(13)
          .fontColor(Colors.onSurface)
          .backgroundColor(Colors.surface)
          .borderWidth(1)
          .borderColor(Colors.outline)
          .borderRadius(8)
          .padding({ left: Spacing.sm, right: Spacing.sm })
          .onChange((value: string) => {
            this.contact = value;
          })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Column({ space: 4 }) {
        Text('Income')
          .fontSize(11)
          .fontColor(Colors.onSurface)
          .opacity(0.7)
        TextInput({ text: this.income, placeholder: 'Income' })
          .width('100%')
          .fontSize(13)
          .fontColor(Colors.onSurface)
          .backgroundColor(Colors.surface)
          .borderWidth(1)
          .borderColor(Colors.outline)
          .borderRadius(8)
          .padding({ left: Spacing.sm, right: Spacing.sm })
          .onChange((value: string) => {
            this.income = value;
          })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Row({ space: Spacing.sm }) {
        Button('Back')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(14)
          .layoutWeight(1)
          .onClick(() => {
            if (this.currentStep > 0) {
              this.currentStep -= 1;
            }
          })

        Button(this.currentStep === this.stepsLength - 1 ? 'Submit' : 'Next')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.primary)
          .borderRadius(14)
          .layoutWeight(1)
          .onClick(() => {
            if (this.currentStep < this.stepsLength - 1) {
              this.currentStep += 1;
            }
          })
      }
      .width('100%')
    }
    .width('100%')
    .padding(Spacing.md)
    .backgroundColor(Colors.surface)
    .borderRadius(24)
    .alignItems(HorizontalAlign.Start)
    .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
  }
}

@Component
struct SummarySection {
  summaryItems: SummaryItem[] = [];
  checklist: DocumentChecklist[] = [];

  build() {
    Column({ space: Spacing.sm }) {
      Text('Summary')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)

      ForEach(this.summaryItems, (item: SummaryItem) => {
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
        .padding(Spacing.sm)
        .backgroundColor(Colors.surfaceVariant)
        .borderRadius(14)
      })

      Column({ space: Spacing.xs }) {
        Text('Documents')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)

        ForEach(this.checklist, (doc: DocumentChecklist) => {
          Row() {
            Text(doc.label)
              .fontSize(13)
              .fontColor(Colors.onSurface)
            Text(doc.status)
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.secondary)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xs, bottom: Spacing.xs })
          .backgroundColor(Colors.surfaceVariant)
          .opacity(0.8)
          .borderRadius(8)
        })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(Spacing.md)
    .backgroundColor(Colors.surface)
    .borderRadius(24)
    .alignItems(HorizontalAlign.Start)
    .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
  }
}

@Entry
@Component
struct RootScreen {
  @State currentStep: number = 1;
  @State name: string = 'Avery Tenant';
  @State contact: string = 'avery@example.com';
  @State income: string = '$120k annual';

  private steps: WizardStep[] = [
    { title: 'Profile', description: 'Tenant basics' },
    { title: 'Income', description: 'Proof details' },
    { title: 'References', description: 'Upload letters' },
    { title: 'Summary', description: 'Confirm submission' },
  ];

  private summaryItems: SummaryItem[] = [
    { label: 'Lease start', value: 'Aug 12' },
    { label: 'Monthly', value: '$2,450' },
    { label: 'Deposit', value: '$2,450' },
    { label: 'Pets', value: '2 approved' },
  ];

  private checklist: DocumentChecklist[] = [
    { label: 'ID verification', status: 'Uploaded' },
    { label: 'Employment letter', status: 'Pending' },
    { label: 'Credit report', status: 'Synced' },
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Stack() {
          Circle()
            .width(30)
            .height(30)
            .fill(Colors.surfaceVariant)
        }
        .width(30)
        .height(30)
        .margin({ left: Spacing.md })

        Column({ space: 2 }) {
          Text('LeaseWizard')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text('Guided handoff')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
            .opacity(0.7)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Stack() {
          Circle()
            .width(30)
            .height(30)
            .fill(Colors.primary)
            .opacity(0.3)
        }
        .width(30)
        .height(30)
        .margin({ right: Spacing.md })
      }
      .width('100%')
      .height(56)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor(Colors.background)

      // Scrollable Content
      Scroll() {
        Column({ space: Spacing.md }) {
          StepperSection({
            currentStep: this.currentStep,
            steps: this.steps,
            onStepChange: (index: number) => {
              this.currentStep = index;
            }
          })

          FormSection({
            currentStep: this.currentStep,
            name: this.name,
            contact: this.contact,
            income: this.income,
            stepsLength: this.steps.length,
          })

          SummarySection({
            summaryItems: this.summaryItems,
            checklist: this.checklist,
          })
        }
        .width('100%')
        .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}