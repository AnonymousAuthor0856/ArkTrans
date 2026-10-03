// StudyFocusApp.ets
import { CardView } from './components/CardView';
import { ModuleCard } from './components/ModuleCard';

// App Tokens
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
    display: { fontSize: 30, fontWeight: FontWeight.SemiBold },
    headline: { fontSize: 22, fontWeight: FontWeight.Medium },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Regular },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
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

  static readonly Shapes = {
    small: 12,
    medium: 16,
    large: 20
  };
}

// Models
interface StudyModule {
  id: string;
  name: string;
  progress: number;
  summary: string;
}

interface TaskItem {
  id: string;
  title: string;
  duration: string;
}

// Main Screen
@Entry
@Component
struct StudyFocusSplitScreen {
  @State selectedTabIndex: number = 0;
  @State focusNote: string = 'Focus on tone shifts across clay gradients';
  @State currentModuleIndex: number = 0;

  private modules: StudyModule[] = [
    { id: '1', name: 'Clay Resonance', progress: 72, summary: 'Acoustic prototypes' },
    { id: '2', name: 'Material Memory', progress: 54, summary: 'Tactile journaling' },
    { id: '3', name: 'Morph Lab', progress: 83, summary: 'Color blending' },
    { id: '4', name: 'Studio Review', progress: 28, summary: 'Peer critique' }
  ];

  private tasks: TaskItem[] = [
    { id: '1', title: 'Research layering', duration: '45m' },
    { id: '2', title: 'Feedback sync', duration: '30m' },
    { id: '3', title: 'Practice recall', duration: '20m' }
  ];

  @Builder
  TabItem(index: number) {
    Column({ space: 8 }) {
      Text(this.modules[index].name.replace(' ', '\n'))
        .fontSize(AppTokens.Typography.label.fontSize)
        .fontWeight(AppTokens.Typography.label.fontWeight)
        .fontColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .height(40)

      Rect()
        .fill(this.selectedTabIndex === index ? AppTokens.Colors.primary : Color.Transparent)
        .height(2)
        .width('100%')
    }
    .width(90)
    .padding({ top: 8, bottom: 8 })
    .onClick(() => {
      this.selectedTabIndex = index;
      this.currentModuleIndex = index;
    })
  }

  @Builder
  TaskRow(task: TaskItem) {
    Row() {
      Column({ space: AppTokens.Spacing.xs }) {
        Text(task.title)
          .fontSize(AppTokens.Typography.body.fontSize)
          .fontWeight(AppTokens.Typography.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
        Text(task.duration)
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(AppTokens.Typography.label.fontWeight)
          .fontColor(AppTokens.Colors.secondary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
    }
    .width('100%')
    .padding(AppTokens.Spacing.sm)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .opacity(0.6)
    .borderRadius(AppTokens.Shapes.small)
  }

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Main Content
      Column({ space: 0 }) {
        // Top Bar
        Row() {
          Text('Back')
            .fontSize(AppTokens.Typography.label.fontSize)
            .fontWeight(AppTokens.Typography.label.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .onClick(() => {})

          Blank()

          Text('Study Focus Split')
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Text('Share')
            .fontSize(AppTokens.Typography.label.fontSize)
            .fontWeight(AppTokens.Typography.label.fontWeight)
            .fontColor(AppTokens.Colors.secondary)
            .onClick(() => {})
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)

        // Scrollable Content
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            // Tab Row
            Scroll() {
              Row({ space: 0 }) {
                ForEach(this.modules, (module: StudyModule, index: number) => {
                  this.TabItem(index)
                })
              }
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
              .backgroundColor(AppTokens.Colors.surface)
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            // Module Card
            ModuleCard({
              module: this.modules[this.currentModuleIndex]
            })
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // Dual Pane
            Row({ space: AppTokens.Spacing.md }) {
              // Left Pane: Focus Board
              CardView({ backgroundColor: AppTokens.Colors.surface }) {
                Column({ space: AppTokens.Spacing.sm }) {
                  Text('Focus board')
                    .fontSize(AppTokens.Typography.title.fontSize)
                    .fontWeight(AppTokens.Typography.title.fontWeight)
                    .fontColor(AppTokens.Colors.onSurface)
                    .width('100%')
                    .textAlign(TextAlign.Start)

                  ForEach(this.tasks, (task: TaskItem) => {
                    this.TaskRow(task)
                  })
                }
                .width('100%')
                .alignItems(HorizontalAlign.Start)
                .padding(AppTokens.Spacing.md)
              }
              .layoutWeight(1)

              // Right Pane: Reflection
              CardView({ backgroundColor: AppTokens.Colors.surfaceVariant }) {
                Column({ space: AppTokens.Spacing.sm }) {
                  Text('Reflection')
                    .fontSize(AppTokens.Typography.title.fontSize)
                    .fontWeight(AppTokens.Typography.title.fontWeight)
                    .fontColor(AppTokens.Colors.onSurface)
                    .width('100%')
                    .textAlign(TextAlign.Start)

                  Text(this.focusNote)
                    .fontSize(AppTokens.Typography.body.fontSize)
                    .fontWeight(AppTokens.Typography.body.fontWeight)
                    .fontColor(AppTokens.Colors.onSurface)
                    .width('100%')
                    .textAlign(TextAlign.Start)
                    .padding(AppTokens.Spacing.md)
                    .backgroundColor(AppTokens.Colors.surface)
                    .borderRadius(AppTokens.Shapes.medium)

                  Button('Shuffle note')
                    .fontSize(AppTokens.Typography.label.fontSize)
                    .fontWeight(AppTokens.Typography.label.fontWeight)
                    .fontColor('#1A1A1A')
                    .width('100%')
                    .padding({ top: 12, bottom: 12 })
                    .backgroundColor(AppTokens.Colors.primary)
                    .borderRadius(AppTokens.Shapes.medium)
                    .onClick(() => {
                      this.focusNote = 'Blend high and low tones before next critique';
                    })
                }
                .width('100%')
                .alignItems(HorizontalAlign.Start)
                .padding(AppTokens.Spacing.md)
              }
              .layoutWeight(1)
            }
            .width('100%')
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .alignItems(VerticalAlign.Top)

            // Spacer
            Blank()
              .height(100)
          }
          .width('100%')
          .padding({ top: AppTokens.Spacing.md })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')

        // Bottom Bar
        Row() {
          Column({ space: AppTokens.Spacing.xs }) {
            Text('Next checkpoint')
              .fontSize(AppTokens.Typography.label.fontSize)
              .fontWeight(AppTokens.Typography.label.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
            Text('12:40 Studio')
              .fontSize(AppTokens.Typography.body.fontSize)
              .fontWeight(AppTokens.Typography.body.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .opacity(0.8)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button('Launch session')
            .fontSize(AppTokens.Typography.label.fontSize)
            .fontWeight(AppTokens.Typography.label.fontWeight)
            .fontColor('#1A1A1A')
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {})
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: -2 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}