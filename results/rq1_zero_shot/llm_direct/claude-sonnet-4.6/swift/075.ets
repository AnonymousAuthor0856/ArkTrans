import { router } from '@kit.ArkUI';

// App Tokens
const AppColors = {
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
  onSurface: '#2E251D',
};

const AppSpacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32,
  xxxl: 48,
};

const AppShapes = {
  small: 12,
  medium: 16,
  large: 20,
};

interface StudyModule {
  id: number;
  name: string;
  progress: number;
  summary: string;
}

interface TaskItem {
  id: number;
  title: string;
  duration: string;
}

@Component
struct ModuleCard {
  module: StudyModule = { id: 0, name: '', progress: 0, summary: '' };

  build() {
    Column({ space: AppSpacing.sm }) {
      Text(this.module.name)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Text(this.module.summary)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)
        .opacity(0.8)

      Divider()
        .color(AppColors.outline)
        .margin({ top: 4, bottom: 4 })

      Row() {
        Text('Progress')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Blank()
        Text(`${this.module.progress}%`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')

      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width('100%')
          .height(12)
          .borderRadius(AppShapes.small)
          .backgroundColor(AppColors.surfaceVariant)

        Row()
          .width(`${this.module.progress}%`)
          .height(12)
          .borderRadius(AppShapes.small)
          .backgroundColor(AppColors.primary)
      }
      .width('100%')
      .height(12)

      Blank().height(8)

      Button('Review outline')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({ radius: 4, color: '#0D000000', offsetX: 0, offsetY: 2 })
  }
}

@Entry
@Component
struct StudyFocusSplitScreen {
  @State selectedTabIndex: number = 0;
  @State focusNote: string = 'Focus on tone shifts across clay gradients';

  private modules: StudyModule[] = [
    { id: 0, name: 'Clay Resonance', progress: 72, summary: 'Acoustic prototypes' },
    { id: 1, name: 'Material Memory', progress: 54, summary: 'Tactile journaling' },
    { id: 2, name: 'Morph Lab', progress: 83, summary: 'Color blending' },
    { id: 3, name: 'Studio Review', progress: 28, summary: 'Peer critique' },
  ];

  private tasks: TaskItem[] = [
    { id: 0, title: 'Research layering', duration: '45m' },
    { id: 1, title: 'Feedback sync', duration: '30m' },
    { id: 2, title: 'Practice recall', duration: '20m' },
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        // Top Bar
        Row() {
          Button('Back')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .backgroundColor(Color.Transparent)

          Blank()

          Text('Study Focus Split')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Blank()

          Button('Share')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.secondary)
            .backgroundColor(Color.Transparent)
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)

        // Scrollable Content
        Scroll() {
          Column({ space: AppSpacing.lg }) {

            // Tab Row
            Scroll() {
              Row({ space: 0 }) {
                ForEach(this.modules, (module: StudyModule, index: number) => {
                  Column({ space: 8 }) {
                    Text(module.name.replace(' ', '\n'))
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(this.selectedTabIndex === index ? AppColors.primary : AppColors.onSurface)
                      .textAlign(TextAlign.Center)
                      .maxLines(2)
                      .height(40)

                    Row()
                      .width('100%')
                      .height(2)
                      .backgroundColor(this.selectedTabIndex === index ? AppColors.primary : Color.Transparent)
                  }
                  .width(90)
                  .padding({ top: 8, bottom: 8 })
                  .onClick(() => {
                    this.selectedTabIndex = index;
                  })
                })
              }
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .backgroundColor(AppColors.surface)

            // Swiper / Pager
            Swiper() {
              ForEach(this.modules, (module: StudyModule) => {
                ModuleCard({ module: module })
                  .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
              })
            }
            .index(this.selectedTabIndex)
            .onChange((index: number) => {
              this.selectedTabIndex = index;
            })
            .indicator(false)
            .loop(false)
            .height(260)
            .width('100%')

            // Dual Pane
            Row({ space: AppSpacing.md }) {
              // Left Pane: Focus Board
              Column({ space: AppSpacing.sm }) {
                Text('Focus board')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSurface)

                ForEach(this.tasks, (task: TaskItem) => {
                  Row() {
                    Column({ space: AppSpacing.xs }) {
                      Text(task.title)
                        .fontSize(14)
                        .fontWeight(FontWeight.Normal)
                        .fontColor(AppColors.onSurface)
                      Text(task.duration)
                        .fontSize(12)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppColors.secondary)
                    }
                    .alignItems(HorizontalAlign.Start)

                    Blank()
                  }
                  .width('100%')
                  .padding(AppSpacing.sm)
                  .backgroundColor(AppColors.surfaceVariant)
                  .opacity(0.6)
                  .borderRadius(AppShapes.small)
                })
              }
              .alignItems(HorizontalAlign.Start)
              .padding(AppSpacing.md)
              .layoutWeight(1)
              .backgroundColor(AppColors.surface)
              .borderRadius(AppShapes.large)
              .shadow({ radius: 4, color: '#0D000000', offsetX: 0, offsetY: 2 })

              // Right Pane: Reflection
              Column({ space: AppSpacing.sm }) {
                Text('Reflection')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSurface)

                Text(this.focusNote)
                  .fontSize(14)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(AppColors.onSurface)
                  .padding(AppSpacing.md)
                  .width('100%')
                  .backgroundColor(AppColors.surface)
                  .borderRadius(AppShapes.medium)
                  .textAlign(TextAlign.Start)

                Button('Shuffle note')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')
                  .width('100%')
                  .padding({ top: 12, bottom: 12 })
                  .backgroundColor(AppColors.primary)
                  .borderRadius(AppShapes.medium)
                  .onClick(() => {
                    this.focusNote = 'Blend high and low tones before next critique';
                  })
              }
              .alignItems(HorizontalAlign.Start)
              .padding(AppSpacing.md)
              .layoutWeight(1)
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(AppShapes.large)
              .shadow({ radius: 4, color: '#0D000000', offsetX: 0, offsetY: 2 })
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            Blank().height(100)
          }
          .padding({ top: AppSpacing.md })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(AppColors.background)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      // Bottom Bar
      Row() {
        Column({ space: AppSpacing.xs }) {
          Text('Next checkpoint')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text('12:40 Studio')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onSurface)
            .opacity(0.8)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button('Launch session')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(AppColors.surface)
      .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}