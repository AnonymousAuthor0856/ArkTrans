// QuizPage.ets
// ArkTS (HarmonyOS / ArkUI) port of the SwiftUI Quiz UI.
// UI drawing only — no business logic.
// Full-screen: hide the status bar from EntryAbility, e.g.
//   onWindowStageCreate(windowStage: window.WindowStage): void {
//     windowStage.getMainWindow((err, win) => {
//       win.setWindowLayoutFullScreen(true);
//       win.setWindowSystemBarEnable([]); // status bar hidden
//     });
//     windowStage.loadContent('pages/QuizPage');
//   }

// MARK: - Design Tokens

class QuizColors {
  static readonly primary: string = '#7C3AED';
  static readonly secondary: string = '#22C55E';
  static readonly tertiary: string = '#F97316';
  static readonly background: string = '#FAFAFF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F1F5F9';
  static readonly outline: string = '#E2E8F0';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#0F172A';
  static readonly onTertiary: string = '#111827';
  static readonly onBackground: string = '#0B1220';
  static readonly onSurface: string = '#0B1220';
  // surface @ 8% black shadow, and background @ 65% alpha
  static readonly cardShadow: string = '#14000000';
  static readonly bottomBarTranslucent: string = '#A6FAFAFF';
}

class QuizShapes {
  static readonly small: number = 6;
  static readonly medium: number = 8;
  static readonly large: number = 12;
}

class QuizSpacing {
  static readonly xs: number = 2;
  static readonly sm: number = 4;
  static readonly md: number = 6;
  static readonly lg: number = 8;
  static readonly xl: number = 12;
  static readonly xxl: number = 16;
  static readonly xxxl: number = 24;
}

class QuizTypography {
  static readonly displaySize: number = 24;
  static readonly headlineSize: number = 18;
  static readonly titleSize: number = 14;
  static readonly bodySize: number = 12;
  static readonly labelSize: number = 10;

  static readonly display: FontWeight = FontWeight.Bold;      // .semibold
  static readonly headline: FontWeight = FontWeight.Bold;     // .semibold
  static readonly title: FontWeight = FontWeight.Medium;
  static readonly body: FontWeight = FontWeight.Normal;
  static readonly label: FontWeight = FontWeight.Medium;
}

// MARK: - Root Screen

@Entry
@Component
struct QuizPage {
  @State selected: number = -1; // -1 == nil
  private options: string[] = ['Earth', 'Mars', 'Venus', 'Jupiter'];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row({ space: QuizSpacing.sm }) {
          Row()
            .width(20)
            .height(20)
            .backgroundColor(QuizColors.primary)
            .borderRadius(QuizShapes.small)

          Text('Quiz')
            .fontSize(QuizTypography.displaySize)
            .fontWeight(QuizTypography.display)
            .fontColor(QuizColors.onSurface)
        }
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({
        top: QuizSpacing.xxxl,
        bottom: QuizSpacing.xxl,
        left: QuizSpacing.lg,
        right: QuizSpacing.lg
      })

      // Scrollable content
      Scroll() {
        Column({ space: QuizSpacing.lg }) {
          // Card
          Column({ space: QuizSpacing.lg }) {
            // Question media placeholder
            Stack({ alignContent: Alignment.Center }) {
              Text('Question 1/4')
                .fontSize(QuizTypography.labelSize)
                .fontWeight(QuizTypography.label)
                .fontColor(QuizColors.onSurface)
            }
            .width('100%')
            .height(120)
            .backgroundColor(QuizColors.surfaceVariant)
            .borderRadius(QuizShapes.medium)

            Text('Which planet is known as the Red Planet?')
              .fontSize(QuizTypography.headlineSize)
              .fontWeight(QuizTypography.headline)
              .fontColor(QuizColors.onSurface)
              .width('100%')
              .textAlign(TextAlign.Start)

            // Options
            Column({ space: QuizSpacing.sm }) {
              ForEach(this.options, (item: string, index: number) => {
                Text(item)
                  .fontSize(this.selected === index
                    ? QuizTypography.titleSize
                    : QuizTypography.bodySize)
                  .fontWeight(this.selected === index
                    ? QuizTypography.title
                    : QuizTypography.body)
                  .fontColor(this.selected === index
                    ? QuizColors.onPrimary
                    : QuizColors.onSurface)
                  .padding({
                    top: 8,
                    bottom: 8,
                    left: 16,
                    right: 16
                  })
                  .backgroundColor(this.selected === index
                    ? QuizColors.primary
                    : QuizColors.surface)
                  .borderRadius(QuizShapes.medium)
                  .border({ width: 1, color: QuizColors.outline })
                  .margin({ top: QuizSpacing.md, bottom: QuizSpacing.md })
                  .onClick(() => {
                    this.selected = index;
                  })
              }, (item: string, index: number) => `${item}_${index}`)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding(QuizSpacing.lg)
          .backgroundColor(QuizColors.surface)
          .borderRadius(QuizShapes.large)
          .border({ width: 1, color: QuizColors.outline })
          .shadow({
            radius: 3,
            color: QuizColors.cardShadow,
            offsetX: 0,
            offsetY: 1
          })
          .margin({ left: QuizSpacing.lg, right: QuizSpacing.lg })

          // Selected + Skip
          Row() {
            Column({ space: QuizSpacing.xs }) {
              Text('Selected')
                .fontSize(QuizTypography.labelSize)
                .fontWeight(QuizTypography.label)
                .fontColor(QuizColors.onSurface)
              Text(this.selected >= 0 ? this.options[this.selected] : 'None')
                .fontSize(QuizTypography.titleSize)
                .fontWeight(QuizTypography.title)
                .fontColor(QuizColors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            AssistChip({
              label: 'Skip',
              isOn: false,
              onTap: () => {
              }
            })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .padding({ left: QuizSpacing.lg, right: QuizSpacing.lg })
        }
        .width('100%')
        .padding({ top: QuizSpacing.md, bottom: 120 }) // space for bottom bar
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .width('100%')

      Divider()
        .strokeWidth(1)
        .color(QuizColors.outline)

      BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(QuizColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

// MARK: - Bottom Bar

@Component
struct BottomBar {
  @State reviewed: boolean = false;
  @State progress: number = 0.25;

  private static readonly trackWidth: number = 140;
  private static readonly trackHeight: number = 6;

  build() {
    Row() {
      Column({ space: QuizSpacing.xs }) {
        Text('Progress')
          .fontSize(QuizTypography.labelSize)
          .fontWeight(QuizTypography.label)
          .fontColor(QuizColors.onSurface)

        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(BottomBar.trackHeight)
            .backgroundColor(QuizColors.surfaceVariant)
            .borderRadius(3)

          Row()
            .width(this.clampedProgress() * BottomBar.trackWidth)
            .height(BottomBar.trackHeight)
            .backgroundColor(QuizColors.primary)
            .borderRadius(3)

          Circle()
            .width(BottomBar.trackHeight)
            .height(BottomBar.trackHeight)
            .fill(QuizColors.primary)
            .offset({ x: this.clampedProgress() * BottomBar.trackWidth - 3 })
        }
        .width(BottomBar.trackWidth)
        .height(BottomBar.trackHeight)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      AssistChip({
        label: 'Review',
        isOn: this.reviewed,
        onTap: () => {
          this.reviewed = !this.reviewed;
        }
      })

      Text('Next')
        .fontSize(QuizTypography.titleSize)
        .fontWeight(QuizTypography.title)
        .fontColor(QuizColors.onPrimary)
        .textAlign(TextAlign.Center)
        .width(140)
        .height(44)
        .backgroundColor(QuizColors.primary)
        .borderRadius(QuizShapes.large)
        .margin({ left: QuizSpacing.lg })
        .onClick(() => {
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding({ left: QuizSpacing.lg, right: QuizSpacing.lg, top: QuizSpacing.md, bottom: QuizSpacing.md })
    .backgroundColor(QuizColors.bottomBarTranslucent)
  }

  private clampedProgress(): number {
    return Math.max(0, Math.min(1, this.progress));
  }
}

// MARK: - Assist Chip

@Component
struct AssistChip {
  @Prop label: string = '';
  @Prop isOn: boolean = false;
  onTap: () => void = () => {
  };

  build() {
    Text(this.label)
      .fontSize(QuizTypography.labelSize)
      .fontWeight(QuizTypography.label)
      .fontColor(this.isOn ? QuizColors.onSecondary : QuizColors.onSurface)
      .padding({ top: 10, bottom: 10, left: 14, right: 14 })
      .backgroundColor(this.isOn ? QuizColors.secondary : QuizColors.surface)
      .borderRadius(QuizShapes.small)
      .border({ width: 1, color: QuizColors.outline })
      .onClick(() => {
        this.onTap();
      })
  }
}