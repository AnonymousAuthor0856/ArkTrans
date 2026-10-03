// ReliefFundForm.ets
import { 
  Component, 
  State, 
  Builder, 
  BuildOptions, 
  ForEach, 
  Item,
  Column,
  Row,
  Text,
  TextInput,
  Button,
  Scroll,
  Stack,
  Divider,
  BorderStyle,
  BorderRadius,
  FlexAlign,
  FlexDirection,
  JustifyContent,
  Alignment,
  FontWeight,
  Color as ColorHelper
} from '@ohos.arkui';

// Design Tokens
class DesignTokens {
  static readonly Colors = {
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
  
  static readonly Typography = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold, lineHeight: 32 },
    headline: { fontSize: 20, fontWeight: FontWeight.SemiBold, lineHeight: 26 },
    title: { fontSize: 15, fontWeight: FontWeight.Medium, lineHeight: 20 },
    body: { fontSize: 13, fontWeight: FontWeight.Normal, lineHeight: 18 },
    label: { fontSize: 11, fontWeight: FontWeight.Medium, lineHeight: 14 }
  };
  
  static readonly Shapes = {
    small: 8,
    medium: 14,
    large: 24
  };
  
  static readonly Spacing = {
    xxs: 4,
    xs: 8,
    sm: 12,
    md: 16,
    lg: 20,
    xl: 28,
    xxl: 36,
    xxxl: 48
  };
  
  static readonly Elevation = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 },
    level3: { elevation: 12, radius: 12, dy: 6, opacity: 0.22 },
    level4: { elevation: 18, radius: 18, dy: 8, opacity: 0.26 },
    level5: { elevation: 24, radius: 24, dy: 10, opacity: 0.3 }
  };
}

// Data Models
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

// Main Component
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

  @Builder
  TopBar() {
    Row() {
      // Navigation Icon
      Stack() {
        Circle({ width: 30, height: 30 })
          .fill(DesignTokens.Colors.surfaceVariant);
      }
      .width(40)
      .height(40)
      .alignContent(Alignment.Center)
      .onClick(() => {});

      // Title
      Column() {
        Text('ReliefFund')
          .fontSize(DesignTokens.Typography.title.fontSize)
          .fontWeight(DesignTokens.Typography.title.fontWeight)
          .fontColor(DesignTokens.Colors.onSurface);
        Text('Civic support intake')
          .fontSize(DesignTokens.Typography.label.fontSize)
          .fontWeight(DesignTokens.Typography.label.fontWeight)
          .fontColor(DesignTokens.Colors.onSurface)
          .opacity(0.7);
      }
      .alignItems(HorizontalAlign.Center)
      .layoutWeight(1);

      // Action Icon
      Stack() {
        Circle({ width: 30, height: 30 })
          .fill(DesignTokens.Colors.primary)
          .opacity(0.35);
      }
      .width(40)
      .height(40)
      .alignContent(Alignment.Center)
      .onClick(() => {});
    }
    .width('100%')
    .height(56)
    .padding({ left: DesignTokens.Spacing.md, right: DesignTokens.Spacing.md })
    .backgroundColor(DesignTokens.Colors.background);
  }

  @Builder
  StepItem(step: FormStep, index: number) {
    Row() {
      // Step indicator
      Column() {
        Stack() {
          if (index <= this.currentStep) {
            Text(`${index + 1}`)
              .fontSize(DesignTokens.Typography.label.fontSize)
              .fontWeight(DesignTokens.Typography.label.fontWeight)
              .fontColor(DesignTokens.Colors.onPrimary);
          } else {
            Text(`${index + 1}`)
              .fontSize(DesignTokens.Typography.label.fontSize)
              .fontWeight(DesignTokens.Typography.label.fontWeight)
              .fontColor(DesignTokens.Colors.onSurface);
          }
        }
        .width(26)
        .height(26)
        .borderRadius(13)
        .backgroundColor(index <= this.currentStep ? DesignTokens.Colors.primary : DesignTokens.Colors.surfaceVariant)
        .alignContent(Alignment.Center);

        if (index !== this.steps.length - 1) {
          Divider()
            .vertical(true)
            .width(3)
            .height(28)
            .color(DesignTokens.Colors.surfaceVariant);
        }
      }
      .alignItems(HorizontalAlign.Center);

      // Step content
      Column() {
        Text(step.title)
          .fontSize(DesignTokens.Typography.title.fontSize)
          .fontWeight(DesignTokens.Typography.title.fontWeight)
          .fontColor(DesignTokens.Colors.onSurface);
        Text(step.description)
          .fontSize(DesignTokens.Typography.body.fontSize)
          .fontWeight(DesignTokens.Typography.body.fontWeight)
          .fontColor(DesignTokens.Colors.onSurface)
          .opacity(0.7);
      }
      .layoutWeight(1)
      .margin({ left: DesignTokens.Spacing.sm });

      // Edit/Go button
      Button(index <= this.currentStep ? 'Edit' : 'Go')
        .fontSize(DesignTokens.Typography.label.fontSize)
        .fontWeight(DesignTokens.Typography.label.fontWeight)
        .fontColor(DesignTokens.Colors.onSecondary)
        .backgroundColor(DesignTokens.Colors.secondary)
        .borderRadius(DesignTokens.Shapes.small)
        .height(32)
        .onClick(() => {
          this.currentStep = index;
        });
    }
    .width('100%')
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  StepsCard() {
    Column() {
      Text('Steps')
        .fontSize(DesignTokens.Typography.headline.fontSize)
        .fontWeight(DesignTokens.Typography.headline.fontWeight)
        .fontColor(DesignTokens.Colors.onSurface)
        .margin({ bottom: DesignTokens.Spacing.sm });

      ForEach(this.steps, (step: FormStep, index: number) => {
        this.StepItem(step, index);
      }, (step: FormStep) => step.title);
    }
    .width('100%')
    .padding(DesignTokens.Spacing.md)
    .backgroundColor(DesignTokens.Colors.surface)
    .borderRadius(DesignTokens.Shapes.large)
    .shadow({
      radius: DesignTokens.Elevation.level2.radius,
      color: `rgba(0,0,0,${DesignTokens.Elevation.level2.opacity})`,
      offsetX: 0,
      offsetY: DesignTokens.Elevation.level2.dy
    });
  }

  @Builder
  ChipItem(chip: SupportChip, index: number) {
    Text(chip.label)
      .fontSize(DesignTokens.Typography.title.fontSize)
      .fontWeight(DesignTokens.Typography.title.fontWeight)
      .fontColor(DesignTokens.Colors.onSurface)
      .padding({
        left: DesignTokens.Spacing.md,
        right: DesignTokens.Spacing.md,
        top: DesignTokens.Spacing.xs,
        bottom: DesignTokens.Spacing.xs
      })
      .backgroundColor(this.selectedChip === index ? 
        `${DesignTokens.Colors.primary}33` : DesignTokens.Colors.surfaceVariant)
      .border({
        width: 1,
        color: this.selectedChip === index ? DesignTokens.Colors.primary : DesignTokens.Colors.outline,
        radius: DesignTokens.Shapes.small,
        style: BorderStyle.Solid
      })
      .borderRadius(DesignTokens.Shapes.small)
      .onClick(() => {
        this.selectedChip = index;
      });
  }

  @Builder
  FocusCard() {
    Column() {
      Text('Focus')
        .fontSize(DesignTokens.Typography.headline.fontSize)
        .fontWeight(DesignTokens.Typography.headline.fontWeight)
        .fontColor(DesignTokens.Colors.onSurface)
        .margin({ bottom: DesignTokens.Spacing.sm });

      Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
        ForEach(this.chips, (chip: SupportChip, index: number) => {
          this.ChipItem(chip, index);
        }, (chip: SupportChip) => chip.label);
      }
      .width('100%');
    }
    .width('100%')
    .padding(DesignTokens.Spacing.md)
    .backgroundColor(DesignTokens.Colors.surface)
    .borderRadius(DesignTokens.Shapes.large)
    .shadow({
      radius: DesignTokens.Elevation.level1.radius,
      color: `rgba(0,0,0,${DesignTokens.Elevation.level1.opacity})`,
      offsetX: 0,
      offsetY: DesignTokens.Elevation.level1.dy
    });
  }

  @Builder
  FormField(label: string, value: string, onChange: (value: string) => void, minLines: number = 1) {
    Column() {
      Text(label)
        .fontSize(DesignTokens.Typography.label.fontSize)
        .fontWeight(DesignTokens.Typography.label.fontWeight)
        .fontColor(DesignTokens.Colors.onSurface)
        .opacity(0.7)
        .margin({ bottom: 4 });
      
      TextInput({ text: value, placeholder: label })
        .fontSize(DesignTokens.Typography.body.fontSize)
        .fontColor(DesignTokens.Colors.onSurface)
        .backgroundColor(DesignTokens.Colors.surface)
        .borderRadius(DesignTokens.Shapes.small)
        .border({
          width: 1,
          color: DesignTokens.Colors.outline,
          radius: DesignTokens.Shapes.small,
          style: BorderStyle.Solid
        })
        .padding(DesignTokens.Spacing.xs)
        .height(minLines > 1 ? 80 : 40)
        .onChange(onChange);
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  DetailsCard() {
    Column() {
      Text('Applicant details')
        .fontSize(DesignTokens.Typography.headline.fontSize)
        .fontWeight(DesignTokens.Typography.headline.fontWeight)
        .fontColor(DesignTokens.Colors.onSurface)
        .margin({ bottom: DesignTokens.Spacing.sm });

      this.FormField('Full name', this.name, (value: string) => {
        this.name = value;
      });

      this.FormField('Organization', this.organization, (value: string) => {
        this.organization = value;
      });

      this.FormField('Contact', this.contact, (value: string) => {
        this.contact = value;
      });

      this.FormField('Relief narrative', this.narrative, (value: string) => {
        this.narrative = value;
      }, 3);

      Row() {
        Button('Back')
          .fontSize(DesignTokens.Typography.title.fontSize)
          .fontWeight(DesignTokens.Typography.title.fontWeight)
          .fontColor(DesignTokens.Colors.onSurface)
          .backgroundColor(DesignTokens.Colors.surfaceVariant)
          .borderRadius(DesignTokens.Shapes.medium)
          .layoutWeight(1)
          .height(44)
          .onClick(() => {
            if (this.currentStep > 0) {
              this.currentStep -= 1;
            }
          });

        Button(this.currentStep === this.steps.length - 1 ? 'Submit' : 'Next')
          .fontSize(DesignTokens.Typography.title.fontSize)
          .fontWeight(DesignTokens.Typography.title.fontWeight)
          .fontColor(DesignTokens.Colors.onPrimary)
          .backgroundColor(DesignTokens.Colors.primary)
          .borderRadius(DesignTokens.Shapes.medium)
          .layoutWeight(1)
          .height(44)
          .margin({ left: DesignTokens.Spacing.sm })
          .onClick(() => {
            if (this.currentStep < this.steps.length - 1) {
              this.currentStep += 1;
            }
          });
      }
      .width('100%')
      .margin({ top: DesignTokens.Spacing.sm });
    }
    .width('100%')
    .padding(DesignTokens.Spacing.md)
    .backgroundColor(DesignTokens.Colors.surface)
    .borderRadius(DesignTokens.Shapes.large)
    .shadow({
      radius: DesignTokens.Elevation.level2.radius,
      color: `rgba(0,0,0,${DesignTokens.Elevation.level2.opacity})`,
      offsetX: 0,
      offsetY: DesignTokens.Elevation.level2.dy
    });
  }

  @Builder
  SummaryRow(item: SummaryItem) {
    Row() {
      Text(item.label)
        .fontSize(DesignTokens.Typography.title.fontSize)
        .fontWeight(DesignTokens.Typography.title.fontWeight)
        .fontColor(DesignTokens.Colors.onSurface);

      Text(item.value)
        .fontSize(DesignTokens.Typography.body.fontSize)
        .fontWeight(DesignTokens.Typography.body.fontWeight)
        .fontColor(DesignTokens.Colors.onSurface);
    }
    .width('100%')
    .padding(DesignTokens.Spacing.sm)
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .borderRadius(DesignTokens.Shapes.medium)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  SummaryCard() {
    Column() {
      Text('Summary')
        .fontSize(DesignTokens.Typography.headline.fontSize)
        .fontWeight(DesignTokens.Typography.headline.fontWeight)
        .fontColor(DesignTokens.Colors.onSurface)
        .margin({ bottom: DesignTokens.Spacing.xs });

      ForEach(this.summary, (item: SummaryItem) => {
        this.SummaryRow(item);
      }, (item: SummaryItem) => item.label);
    }
    .width('100%')
    .padding(DesignTokens.Spacing.md)
    .backgroundColor(DesignTokens.Colors.surface)
    .borderRadius(DesignTokens.Shapes.large)
    .shadow({
      radius: DesignTokens.Elevation.level1.radius,
      color: `rgba(0,0,0,${DesignTokens.Elevation.level1.opacity})`,
      offsetX: 0,
      offsetY: DesignTokens.Elevation.level1.dy
    });
  }

  build() {
    Column() {
      this.TopBar();

      Scroll() {
        Column() {
          this.StepsCard();
          this.FocusCard();
          this.DetailsCard();
          this.SummaryCard();
        }
        .width('100%')
        .padding({
          left: DesignTokens.Spacing.lg,
          right: DesignTokens.Spacing.lg,
          top: DesignTokens.Spacing.sm,
          bottom: DesignTokens.Spacing.sm
        });
      }
      .layoutWeight(1)
      .backgroundColor(DesignTokens.Colors.background);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.Colors.background);
  }
}

@Entry
@Component
struct ReliefFundApp {
  build() {
    ReliefFundForm();
  }
}