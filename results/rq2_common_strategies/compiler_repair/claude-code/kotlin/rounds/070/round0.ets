@Entry
@Component
struct Index {
  @State currentStep: number = 1;
  @State name: string = "Avery Tenant";
  @State contact: string = "avery@example.com";
  @State income: string = "$120k annual";

  private steps: WizardStep[] = [
    { title: "Profile", description: "Tenant basics" },
    { title: "Income", description: "Proof details" },
    { title: "References", description: "Upload letters" },
    { title: "Summary", description: "Confirm submission" }
  ];
  private summaryItems: SummaryItem[] = [
    { label: "Lease start", value: "Aug 12" },
    { label: "Monthly", value: "$2,450" },
    { label: "Deposit", value: "$2,450" },
    { label: "Pets", value: "2 approved" }
  ];
  private checklist: DocumentChecklist[] = [
    { label: "ID verification", status: "Uploaded" },
    { label: "Employment letter", status: "Pending" },
    { label: "Credit report", status: "Synced" }
  ];

  build() {
    Column() {
      this.TopBar()
      Scroll() {
        Column() {
          this.StepsCard()
          this.FormCard()
          this.SummaryCard()
        }
        .width('100%')
        .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
        .justifyContent(FlexAlign.Start)
        .gap(DesignTokens.Spacing.md)
      }
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .backgroundColor(DesignTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.Colors.background)
  }

  @Builder
  TopBar() {
    Row() {
      Button() {
      }
      .width(30)
      .height(30)
      .backgroundColor(DesignTokens.Colors.surfaceVariant)
      .borderRadius(15)
      .type(ButtonType.Normal)
      .margin({ left: DesignTokens.Spacing.md })

      Column() {
        Text("LeaseWizard")
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
          .lineHeight(20)
        Text("Guided handoff")
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
          .opacity(0.7)
          .lineHeight(14)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      Button() {
      }
      .width(30)
      .height(30)
      .backgroundColor(DesignTokens.Colors.primary)
      .opacity(0.3)
      .borderRadius(15)
      .type(ButtonType.Normal)
      .margin({ right: DesignTokens.Spacing.md })
    }
    .width('100%')
    .height(56)
    .backgroundColor(DesignTokens.Colors.surface)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  StepsCard() {
    Column() {
      Text("Steps")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(DesignTokens.Colors.onSurface)
        .lineHeight(26)
      ForEach(this.steps, (step: WizardStep, index: number) => {
        this.StepRow(step, index)
      }, (step: WizardStep, index: number) => step.title + index.toString())
    }
    .width('100%')
    .padding(DesignTokens.Spacing.md)
    .gap(DesignTokens.Spacing.sm)
    .backgroundColor(DesignTokens.Colors.surface)
    .borderRadius(DesignTokens.Shapes.large)
    .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
  }

  @Builder
  StepRow(step: WizardStep, index: number) {
    Row() {
      Column() {
        Text((index + 1).toString())
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(index <= this.currentStep ? DesignTokens.Colors.onPrimary : DesignTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
          .width(28)
          .height(28)
          .backgroundColor(index <= this.currentStep ? DesignTokens.Colors.primary : DesignTokens.Colors.surfaceVariant)
          .borderRadius(14)
        if (index != this.steps.length - 1) {
          Blank()
            .width(4)
            .height(32)
            .backgroundColor(DesignTokens.Colors.surfaceVariant)
        }
      }
      .alignItems(HorizontalAlign.Center)

      Column() {
        Text(step.title)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
          .lineHeight(20)
        Text(step.description)
          .fontSize(13)
          .fontWeight(FontWeight.Normal)
          .fontColor(DesignTokens.Colors.onSurface)
          .opacity(0.7)
          .lineHeight(18)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button(index <= this.currentStep ? "Edit" : "Go")
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.Colors.onSecondary)
        .backgroundColor(DesignTokens.Colors.secondary)
        .borderRadius(DesignTokens.Shapes.small)
        .height(32)
        .padding({ left: 12, right: 12 })
        .onClick(() => {
          this.currentStep = index;
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .gap(DesignTokens.Spacing.md)
  }

  @Builder
  FormCard() {
    Column() {
      Text("Form")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(DesignTokens.Colors.onSurface)
        .lineHeight(26)
      TextInput({ text: this.name, placeholder: "Full name" })
        .width('100%')
        .height(48)
        .backgroundColor(DesignTokens.Colors.surface)
        .borderRadius(DesignTokens.Shapes.small)
        .border({ width: 1, color: DesignTokens.Colors.outline })
        .padding({ left: DesignTokens.Spacing.sm, right: DesignTokens.Spacing.sm })
        .fontSize(13)
        .fontColor(DesignTokens.Colors.onSurface)
        .onChange((value: string) => {
          this.name = value;
        })
      TextInput({ text: this.contact, placeholder: "Contact" })
        .width('100%')
        .height(48)
        .backgroundColor(DesignTokens.Colors.surface)
        .borderRadius(DesignTokens.Shapes.small)
        .border({ width: 1, color: DesignTokens.Colors.outline })
        .padding({ left: DesignTokens.Spacing.sm, right: DesignTokens.Spacing.sm })
        .fontSize(13)
        .fontColor(DesignTokens.Colors.onSurface)
        .onChange((value: string) => {
          this.contact = value;
        })
      TextInput({ text: this.income, placeholder: "Income" })
        .width('100%')
        .height(48)
        .backgroundColor(DesignTokens.Colors.surface)
        .borderRadius(DesignTokens.Shapes.small)
        .border({ width: 1, color: DesignTokens.Colors.outline })
        .padding({ left: DesignTokens.Spacing.sm, right: DesignTokens.Spacing.sm })
        .fontSize(13)
        .fontColor(DesignTokens.Colors.onSurface)
        .onChange((value: string) => {
          this.income = value;
        })
      Row() {
        Button("Back")
          .layoutWeight(1)
          .height(44)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
          .backgroundColor(DesignTokens.Colors.surfaceVariant)
          .borderRadius(DesignTokens.Shapes.medium)
          .onClick(() => {
            if (this.currentStep > 0) {
              this.currentStep -= 1;
            }
          })
        Button(this.currentStep == this.steps.length - 1 ? "Submit" : "Next")
          .layoutWeight(1)
          .height(44)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onPrimary)
          .backgroundColor(DesignTokens.Colors.primary)
          .borderRadius(DesignTokens.Shapes.medium)
          .onClick(() => {
            if (this.currentStep < this.steps.length - 1) {
              this.currentStep += 1;
            }
          })
      }
      .width('100%')
      .gap(DesignTokens.Spacing.sm)
    }
    .width('100%')
    .padding(DesignTokens.Spacing.md)
    .gap(DesignTokens.Spacing.sm)
    .backgroundColor(DesignTokens.Colors.surface)
    .borderRadius(DesignTokens.Shapes.large)
    .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
  }

  @Builder
  SummaryCard() {
    Column() {
      Text("Summary")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(DesignTokens.Colors.onSurface)
        .lineHeight(26)
      ForEach(this.summaryItems, (item: SummaryItem) => {
        Row() {
          Text(item.label)
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface)
            .lineHeight(20)
          Text(item.value)
            .fontSize(13)
            .fontWeight(FontWeight.Normal)
            .fontColor(DesignTokens.Colors.onSurface)
            .lineHeight(18)
        }
        .width('100%')
        .padding(DesignTokens.Spacing.sm)
        .backgroundColor(DesignTokens.Colors.surfaceVariant)
        .borderRadius(DesignTokens.Shapes.medium)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }, (item: SummaryItem) => item.label)
      Column() {
        Text("Documents")
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
          .lineHeight(20)
        ForEach(this.checklist, (doc: DocumentChecklist) => {
          Row() {
            Text(doc.label)
              .fontSize(13)
              .fontWeight(FontWeight.Normal)
              .fontColor(DesignTokens.Colors.onSurface)
              .lineHeight(18)
            Text(doc.status)
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor(DesignTokens.Colors.secondary)
              .lineHeight(14)
          }
          .width('100%')
          .padding({ left: DesignTokens.Spacing.sm, right: DesignTokens.Spacing.sm, top: DesignTokens.Spacing.xs, bottom: DesignTokens.Spacing.xs })
          .backgroundColor(DesignTokens.Colors.surfaceVariant)
          .opacity(0.8)
          .borderRadius(DesignTokens.Shapes.small)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
        }, (doc: DocumentChecklist) => doc.label)
      }
      .width('100%')
      .gap(DesignTokens.Spacing.xs)
    }
    .width('100%')
    .padding(DesignTokens.Spacing.md)
    .gap(DesignTokens.Spacing.sm)
    .backgroundColor(DesignTokens.Colors.surface)
    .borderRadius(DesignTokens.Shapes.large)
    .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
  }
}

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

namespace DesignTokens {
  export class Colors {
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
  export class Shapes {
    static readonly small: number = 8;
    static readonly medium: number = 14;
    static readonly large: number = 24;
  }
  export class Spacing {
    static readonly xxs: number = 4;
    static readonly xs: number = 8;
    static readonly sm: number = 12;
    static readonly md: number = 16;
    static readonly lg: number = 20;
    static readonly xl: number = 28;
    static readonly xxl: number = 36;
    static readonly xxxl: number = 48;
  }
}
