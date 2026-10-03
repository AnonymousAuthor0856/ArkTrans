import { display, window } from '@kit.ArkUI';

// AppTokens
class AppTokens {
  static readonly Colors = {
    primary: '#C08552',
    secondary: '#9BB1C8',
    tertiary: '#E6CFAF',
    background: '#F3EFE6',
    surface: '#FFFFFF',
    surfaceVariant: '#E7DDCF',
    outline: '#D4C5B6',
    success: '#6BB187',
    warning: '#E2A458',
    error: '#D66B5D',
    onPrimary: '#2A1C13',
    onSecondary: '#15202B',
    onTertiary: '#2C1F10',
    onBackground: '#261E19',
    onSurface: '#2E251D'
  };

  static readonly Typography = {
    display: { fontSize: 30, fontWeight: FontWeight.Medium, lineHeight: 36 },
    headline: { fontSize: 22, fontWeight: FontWeight.Medium, lineHeight: 28 },
    title: { fontSize: 18, fontWeight: FontWeight.Medium, lineHeight: 24 },
    body: { fontSize: 14, fontWeight: FontWeight.Normal, lineHeight: 20 },
    label: { fontSize: 12, fontWeight: FontWeight.Medium, lineHeight: 16 }
  };

  static readonly Shapes = {
    small: 12,
    medium: 16,
    large: 20
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 48
  };
}

interface StudyModule {
  name: string;
  progress: number;
  summary: string;
}

interface TaskItem {
  title: string;
  duration: string;
}

@Entry
@Component
struct RootScreen {
  @State private currentPage: number = 0;
  @State private focusNote: string = 'Focus on tone shifts across clay gradients';
  private modules: StudyModule[] = [
    { name: 'Clay Resonance', progress: 72, summary: 'Acoustic prototypes' },
    { name: 'Material Memory', progress: 54, summary: 'Tactile journaling' },
    { name: 'Morph Lab', progress: 83, summary: 'Color blending' },
    { name: 'Studio Review', progress: 28, summary: 'Peer critique' }
  ];
  private tasks: TaskItem[] = [
    { title: 'Research layering', duration: '45m' },
    { title: 'Feedback sync', duration: '30m' },
    { title: 'Practice recall', duration: '20m' }
  ];

  @Builder
  ProgressBar(progress: number) {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(12)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)
      Row()
        .width(`${progress}%`)
        .height(12)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.small)
    }
    .width('100%')
  }

  @Builder
  ModuleCard(module: StudyModule) {
    Column({ space: AppTokens.Spacing.sm }) {
      Text(module.name)
        .fontSize(AppTokens.Typography.headline.fontSize)
        .fontWeight(AppTokens.Typography.headline.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
      Text(module.summary)
        .fontSize(AppTokens.Typography.body.fontSize)
        .fontColor('#CC2E251D')
      Divider()
        .color(AppTokens.Colors.outline)
      Row() {
        Text('Progress')
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontColor(AppTokens.Colors.onSurface)
        Blank()
        Text(`${module.progress}%`)
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .fontColor(AppTokens.Colors.primary)
      }
      .width('100%')

      this.ProgressBar(module.progress)

      Button('Review outline')
        .fontSize(AppTokens.Typography.label.fontSize)
        .borderRadius(AppTokens.Shapes.medium)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .height(40)
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
  }

  @Builder
  FocusBoardCard() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text('Focus board')
        .fontSize(AppTokens.Typography.title.fontSize)
        .fontWeight(AppTokens.Typography.title.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach(this.tasks, (task: TaskItem) => {
        Column({ space: AppTokens.Spacing.xs }) {
          Text(task.title)
            .fontSize(AppTokens.Typography.body.fontSize)
            .fontColor(AppTokens.Colors.onSurface)
          Text(task.duration)
            .fontSize(AppTokens.Typography.label.fontSize)
            .fontColor(AppTokens.Colors.secondary)
        }
        .width('100%')
        .padding(AppTokens.Spacing.sm)
        .backgroundColor('#99E7DDCF')
        .borderRadius(AppTokens.Shapes.small)
      })

      Button('Add checkpoint')
        .fontSize(AppTokens.Typography.label.fontSize)
        .borderRadius(AppTokens.Shapes.medium)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .height(40)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
  }

  @Builder
  ReflectionCard() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text('Reflection')
        .fontSize(AppTokens.Typography.title.fontSize)
        .fontWeight(AppTokens.Typography.title.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)

      Column() {
        Text(this.focusNote)
          .fontSize(AppTokens.Typography.body.fontSize)
          .fontColor(AppTokens.Colors.onSurface)
          .padding(AppTokens.Spacing.md)
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.medium)

      Button('Shuffle note')
        .fontSize(AppTokens.Typography.label.fontSize)
        .borderRadius(AppTokens.Shapes.medium)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .height(40)
        .onClick(() => {
          this.focusNote = 'Blend high and low tones before next critique';
        })
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
  }

  @Builder
  TabBar() {
    Row() {
      ForEach(this.modules, (module: StudyModule, index: number) => {
        Column() {
          Text(module.name)
            .fontSize(AppTokens.Typography.label.fontSize)
            .fontColor(index === this.currentPage ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
            .fontWeight(index === this.currentPage ? FontWeight.Bold : FontWeight.Medium)
            .textAlign(TextAlign.Center)
            .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
          Divider()
            .height(2)
            .color(index === this.currentPage ? AppTokens.Colors.primary : Color.Transparent)
        }
        .layoutWeight(1)
        .onClick(() => {
          this.currentPage = index;
        })
      })
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Back')
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
          .onClick(() => {})
        Blank()
        Text('Study Focus Split')
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
        Blank()
        Text('Share')
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontColor(AppTokens.Colors.secondary)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
          .onClick(() => {})
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)

      // Scrollable content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Tab Row
          this.TabBar()

          // Pager content
          Swiper() {
            ForEach(this.modules, (module: StudyModule) => {
              Column() {
                this.ModuleCard(module)
              }
              .width('100%')
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            })
          }
          .width('100%')
          .height(240)
          .indicator(false)
          .loop(false)
          .onChange((index: number) => {
            this.currentPage = index;
          })
          .index(this.currentPage)

          // Dual focus panes
          Row({ space: AppTokens.Spacing.md }) {
            Column() {
              this.FocusBoardCard()
            }
            .layoutWeight(1)

            Column() {
              this.ReflectionCard()
            }
            .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      // Bottom Bar
      Row() {
        Column({ space: AppTokens.Spacing.xs }) {
          Text('Next checkpoint')
            .fontSize(AppTokens.Typography.label.fontSize)
            .fontColor(AppTokens.Colors.onSurface)
          Text('12:40 Studio')
            .fontSize(AppTokens.Typography.body.fontSize)
            .fontColor('#CC2E251D')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button('Launch session')
          .fontSize(AppTokens.Typography.label.fontSize)
          .borderRadius(AppTokens.Shapes.medium)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .height(40)
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}