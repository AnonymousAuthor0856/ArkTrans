import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - Design Tokens (ported from Compose)
interface QuizTypography {
  size: number;
  weight: FontWeight;
}

interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface TypographyTokens {
  display: QuizTypography;
  headline: QuizTypography;
  title: QuizTypography;
  body: QuizTypography;
  label: QuizTypography;
}

interface TokenSet {
  Colors: ColorTokens;
  Shapes: ShapeTokens;
  Spacing: SpacingTokens;
  Typography: TypographyTokens;
}

const QuizTokens: TokenSet = {
  Colors: {
    primary: '#7C3AED',
    secondary: '#22C55E',
    tertiary: '#F97316',
    background: '#FAFAFF',
    surface: '#FFFFFF',
    surfaceVariant: '#F1F5F9',
    outline: '#E2E8F0',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#0F172A',
    onTertiary: '#111827',
    onBackground: '#0B1220',
    onSurface: '#0B1220'
  },
  Shapes: {
    small: 6,
    medium: 8,
    large: 12
  },
  Spacing: {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  },
  Typography: {
    display: { size: 24, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Bold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal },
    label: { size: 10, weight: FontWeight.Medium }
  }
};

@Entry
@Component
struct QuizApp {
  build() {
    Column() {
      QuizRootView()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(QuizTokens.Colors.background)
  }
}

// MARK: - Root Screen
@Component
struct QuizRootView {
  @State selected: number | null = null;
  private options: string[] = ["Earth", "Mars", "Venus", "Jupiter"];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Rect()
          .fillColor(QuizTokens.Colors.primary)
          .width(20)
          .height(20)
          .borderRadius(QuizTokens.Shapes.small)
        
        Text("Quiz")
          .fontSize(QuizTokens.Typography.display.size)
          .fontWeight(QuizTokens.Typography.display.weight)
          .fontColor(QuizTokens.Colors.onSurface)
      }
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .padding({ top: 24, bottom: 16, left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg })
      .margin({ left: QuizTokens.Spacing.sm })

      Scroll() {
        Column() {
          // Card
          Column({ space: QuizTokens.Spacing.lg }) {
            // Placeholder Image/Box
            Column() {
              Text("Question 1/4")
                .fontSize(QuizTokens.Typography.label.size)
                .fontWeight(QuizTokens.Typography.label.weight)
                .fontColor(QuizTokens.Colors.onSurface)
                .position({ x: 16, y: 16 })
            }
            .width('100%')
            .height(120)
            .backgroundColor(QuizTokens.Colors.surfaceVariant)
            .borderRadius(QuizTokens.Shapes.medium)

            Text("Which planet is known as the Red Planet?")
              .fontSize(QuizTokens.Typography.headline.size)
              .fontWeight(QuizTokens.Typography.headline.weight)
              .fontColor(QuizTokens.Colors.onSurface)

            // Options
            Column({ space: QuizTokens.Spacing.sm }) {
              ForEach(this.options.map((opt, index) => ({ text: opt, id: index })), (item: { text: string, id: number }) => {
                OptionButton({ 
                  text: item.text, 
                  isSelected: this.selected === item.id, 
                  onClick: () => {
                    this.selected = item.id;
                  } 
                })
              })
            }
          }
          .padding(QuizTokens.Spacing.lg)
          .backgroundColor(QuizTokens.Colors.surface)
          .borderRadius(QuizTokens.Shapes.large)
          .border({ width: 1, color: QuizTokens.Colors.outline })
          .shadow({ radius: 3, color: 'rgba(0,0,0,0.08)', offsetY: 1 })
          .margin({ left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg })

          // Selected + Skip
          Row() {
            Column({ space: QuizTokens.Spacing.xs }) {
              Text("Selected")
                .fontSize(QuizTokens.Typography.label.size)
                .fontWeight(QuizTokens.Typography.label.weight)
                .fontColor(QuizTokens.Colors.onSurface)
              
              Text(this.selected !== null ? this.options[this.selected] : "None")
                .fontSize(QuizTokens.Typography.title.size)
                .fontWeight(QuizTokens.Typography.title.weight)
                .fontColor(QuizTokens.Colors.onSurface)
            }
            
            Blank()
            
            AssistChip({ label: "Skip", isOn: false, onTap: () => {} })
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .padding({ left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg })
        }
        .padding({ top: QuizTokens.Spacing.md, bottom: 120 })
      }
      .layoutWeight(1)
      
      Divider()
        .color(QuizTokens.Colors.outline)
      
      BottomBar()
    }
  }
}

@Component
struct OptionButton {
  @Prop text: string;
  @Prop isSelected: boolean;
  @Prop onClick: () => void;

  build() {
    Button() {
      Text(this.text)
        .fontSize(this.isSelected ? QuizTokens.Typography.title.size : QuizTokens.Typography.body.size)
        .fontWeight(this.isSelected ? QuizTokens.Typography.title.weight : QuizTokens.Typography.body.weight)
        .fontColor(this.isSelected ? QuizTokens.Colors.onPrimary : QuizTokens.Colors.onSurface)
        .textAlign(TextAlign.Start)
    }
    .type(ButtonType.Normal)
    .backgroundColor(this.isSelected ? QuizTokens.Colors.primary : QuizTokens.Colors.surface)
    .borderRadius(QuizTokens.Shapes.medium)
    .border({ width: 1, color: QuizTokens.Colors.outline })
    .padding({ top: 8, bottom: 8, left: 16, right: 16 })
    .onClick(() => {
      this.onClick();
    })
  }
}

// MARK: - Bottom Bar
@Component
struct BottomBar {
  @State reviewed: boolean = false;
  progress: number = 0.25;

  build() {
    Row() {
      Column({ space: QuizTokens.Spacing.xs }) {
        Text("Progress")
          .fontSize(QuizTokens.Typography.label.size)
          .fontWeight(QuizTokens.Typography.label.weight)
          .fontColor(QuizTokens.Colors.onSurface)
        
        Row() {
          // Background track
          Rect()
            .fillColor(QuizTokens.Colors.surfaceVariant)
            .borderRadius(3)
            .height(6)
          
          // Progress fill
          Rect()
            .fillColor(QuizTokens.Colors.primary)
            .borderRadius(3)
            .height(6)
            .width(`${this.progress * 100}%`)
            
          // Dot marker
          Circle()
            .fillColor(QuizTokens.Colors.primary)
            .width(6)
            .height(6)
            .margin({ left: `${this.progress * 100}%` })
            .offset({ x: -3 })
        }
        .width(140)
        .height(6)
        .clip(true)
      }
      
      Blank()
      
      AssistChip({ label: "Review", isOn: this.reviewed, onTap: () => {
        this.reviewed = !this.reviewed;
      }})
      
      Button() {
        Text("Next")
          .fontSize(QuizTokens.Typography.title.size)
          .fontWeight(QuizTokens.Typography.title.weight)
          .fontColor(QuizTokens.Colors.onPrimary)
      }
      .type(ButtonType.Normal)
      .backgroundColor(QuizTokens.Colors.primary)
      .borderRadius(QuizTokens.Shapes.large)
      .width(140)
      .height(44)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg, top: QuizTokens.Spacing.md, bottom: QuizTokens.Spacing.md })
    .backgroundColor('#FAFAFF') // Using hex directly for opacity simulation if needed, or just solid bg
    .opacity(0.65)
  }
}

// MARK: - Assist Chip
@Component
struct AssistChip {
  @Prop label: string;
  @Prop isOn: boolean;
  @Prop onTap: () => void;

  build() {
    Button() {
      Text(this.label)
        .fontSize(QuizTokens.Typography.label.size)
        .fontWeight(QuizTokens.Typography.label.weight)
        .fontColor(this.isOn ? QuizTokens.Colors.onSecondary : QuizTokens.Colors.onSurface)
    }
    .type(ButtonType.Normal)
    .backgroundColor(this.isOn ? QuizTokens.Colors.secondary : QuizTokens.Colors.surface)
    .borderRadius(QuizTokens.Shapes.small)
    .border({ width: 1, color: QuizTokens.Colors.outline })
    .padding({ top: 10, bottom: 10, left: 14, right: 14 })
    .onClick(() => {
      this.onTap();
    })
  }
}