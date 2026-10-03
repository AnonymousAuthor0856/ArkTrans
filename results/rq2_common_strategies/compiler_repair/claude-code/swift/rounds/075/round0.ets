// App Tokens
class AppColors {
  static primary: ResourceColor = '#C08552';
  static secondary: ResourceColor = '#9BB1C8';
  static tertiary: ResourceColor = '#E6CFAF';
  static background: ResourceColor = '#F3EFE6';
  static surface: ResourceColor = '#FFFFFF';
  static surfaceVariant: ResourceColor = '#E7DDCF';
  static outline: ResourceColor = '#D4C5B6';
  static success: ResourceColor = '#6BB187';
  static warning: ResourceColor = '#E2A458';
  static error: ResourceColor = '#D66B5D';
  static onPrimary: ResourceColor = '#2A1C13';
  static onSecondary: ResourceColor = '#15202B';
  static onTertiary: ResourceColor = '#2C1F10';
  static onBackground: ResourceColor = '#261E19';
  static onSurface: ResourceColor = '#2E251D';
}

class AppFonts {
  static display: Font = { size: 30, weight: FontWeight.SemiBold };
  static headline: Font = { size: 22, weight: FontWeight.Medium };
  static title: Font = { size: 18, weight: FontWeight.Medium };
  static body: Font = { size: 14, weight: FontWeight.Regular };
  static label: Font = { size: 12, weight: FontWeight.Medium };
}

class AppSpacing {
  static xs: Length = 4;
  static sm: Length = 8;
  static md: Length = 12;
  static lg: Length = 16;
  static xl: Length = 24;
  static xxl: Length = 32;
  static xxxl: Length = 48;
}

class AppShapes {
  static small: number = 12;
  static medium: number = 16;
  static large: number = 20;
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

// CardView component
@Component
struct CardView {
  @Prop backgroundColor: ResourceColor = AppColors.surface;
  @BuilderParam contentBuilder: () => void;

  build() {
    Stack() {
      this.contentBuilder();
    }
    .backgroundColor(this.backgroundColor)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.05)',
      offsetX: 0,
      offsetY: 2
    });
  }
}

// Module Card component
@Component
struct ModuleCard {
  @Prop module: StudyModule = { id: '', name: '', progress: 0, summary: '' };

  build() {
    CardView({ backgroundColor: AppColors.surface }) {
      Column({ space: AppSpacing.sm }) {
        Text(this.module.name)
          .font(AppFonts.headline)
          .fontColor(AppColors.onSurface)
          .width('100%')

        Text(this.module.summary)
          .font(AppFonts.body)
          .fontColor('rgba(46, 37, 29, 0.8)')
          .width('100%')

        Divider()
          .color(AppColors.outline)
          .margin({ top: 4, bottom: 4 })

        Row() {
          Text('Progress')
            .font(AppFonts.label)
            .fontColor(AppColors.onSurface)
          Blank()
          Text(this.module.progress + '%')
            .font(AppFonts.title)
            .fontColor(AppColors.primary)
        }
        .width('100%')

        Stack({ alignContent: Alignment.Start }) {
          RoundedRectangle({
            width: '100%',
            height: 12,
            radius: AppShapes.small,
            fill: AppColors.surfaceVariant
          });
          RoundedRectangle({
            width: this.module.progress + '%',
            height: 12,
            radius: AppShapes.small,
            fill: AppColors.primary
          });
        }
        .width('100%')
        .height(12)

        Blank()
          .height(8)

        Button('Review outline')
          .font(AppFonts.label)
          .fontColor('rgba(0, 0, 0, 0.7)')
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .onClick(() => {});
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding(AppSpacing.lg)
    }
  }
}

// Tab item component
@Component
struct TabItem {
  @Prop name: string = '';
  @Prop isSelected: boolean = false;
  @Prop index: number = 0;
  @Link selectedIndex: number;

  build() {
    Column({ space: 8 }) {
      Text(this.name)
        .font(AppFonts.label)
        .fontColor(this.isSelected ? AppColors.primary : AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .height(40)

      Rectangle()
        .fill(this.isSelected ? AppColors.primary : Color.Transparent)
        .height(2)
        .width('100%')
    }
    .width(90)
    .padding({ top: 8, bottom: 8 })
    .onClick(() => {
      this.selectedIndex = this.index;
    })
  }
}

// Task item row
@Component
struct TaskRow {
  @Prop task: TaskItem = { id: '', title: '', duration: '' };

  build() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text(this.task.title)
          .font(AppFonts.body)
          .fontColor(AppColors.onSurface)
        Text(this.task.duration)
          .font(AppFonts.label)
          .fontColor(AppColors.secondary)
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
    }
    .width('100%')
    .padding(AppSpacing.sm)
    .backgroundColor('rgba(231, 221, 207, 0.6)')
    .borderRadius(AppShapes.small)
  }
}

// Main page
@Entry
@Component
struct StudyFocusSplitScreen {
  @State selectedTabIndex: number = 0;
  @State focusNote: string = 'Focus on tone shifts across clay gradients';

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
  moduleCardBuilder(module: StudyModule) {
    ModuleCard({ module: module })
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg });
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        // Top Bar
        Row() {
          Button('Back')
            .font(AppFonts.label)
            .fontColor(AppColors.onSurface)
            .backgroundColor(Color.Transparent)
            .onClick(() => {});

          Blank();

          Text('Study Focus Split')
            .font(AppFonts.title)
            .fontColor(AppColors.onSurface);

          Blank();

          Button('Share')
            .font(AppFonts.label)
            .fontColor(AppColors.secondary)
            .backgroundColor(Color.Transparent)
            .onClick(() => {});
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)

        // Scrollable Content
        Scroll() {
          Column({ space: AppSpacing.lg }) {

            // Tab Row (horizontal scroll)
            Scroll(this.scroller)
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
              .width('100%')
              .backgroundColor(AppColors.surface) {
              Row({ space: 0 }) {
                ForEach(this.modules, (module: StudyModule, index: number) => {
                  TabItem({
                    name: module.name,
                    isSelected: this.selectedTabIndex === index,
                    index: index,
                    selectedIndex: $selectedTabIndex
                  });
                }, (module: StudyModule) => module.id);
              }
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg });
            }

            // Pager Content (Main Card)
            Swiper(this.swiperController) {
              ForEach(this.modules, (module: StudyModule) => {
                this.moduleCardBuilder(module);
              }, (module: StudyModule) => module.id);
            }
            .index(this.selectedTabIndex)
            .onChange((index: number) => {
              this.selectedTabIndex = index;
            })
            .height(220)
            .indicator(false)
            .loop(false)
            .itemSpace(0)

            // Dual Pane
            Row({ space: AppSpacing.md }) {
              // Left Pane: Focus Board
              Column() {
                CardView({ backgroundColor: AppColors.surface }) {
                  Column({ space: AppSpacing.sm }) {
                    Text('Focus board')
                      .font(AppFonts.title)
                      .fontColor(AppColors.onSurface)
                      .width('100%');

                    ForEach(this.tasks, (task: TaskItem) => {
                      TaskRow({ task: task });
                    }, (task: TaskItem) => task.id);

                    Blank()
                      .height(8);
                  }
                  .width('100%')
                  .alignItems(HorizontalAlign.Start)
                  .padding(AppSpacing.md);
                }
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              // Right Pane: Reflection
              Column() {
                CardView({ backgroundColor: AppColors.surfaceVariant }) {
                  Column({ space: AppSpacing.sm }) {
                    Text('Reflection')
                      .font(AppFonts.title)
                      .fontColor(AppColors.onSurface)
                      .width('100%');

                    Text(this.focusNote)
                      .font(AppFonts.body)
                      .fontColor(AppColors.onSurface)
                      .padding(AppSpacing.md)
                      .width('100%')
                      .textAlign(TextAlign.Start)
                      .backgroundColor(AppColors.surface)
                      .borderRadius(AppShapes.medium);

                    Button('Shuffle note')
                      .font(AppFonts.label)
                      .fontColor('rgba(0, 0, 0, 0.8)')
                      .backgroundColor(AppColors.primary)
                      .borderRadius(AppShapes.medium)
                      .width('100%')
                      .height(40)
                      .onClick(() => {
                        this.focusNote = 'Blend high and low tones before next critique';
                      });
                  }
                  .width('100%')
                  .alignItems(HorizontalAlign.Start)
                  .padding(AppSpacing.md);
                }
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            .alignItems(VerticalAlign.Top)

            Blank()
              .height(100);
          }
          .width('100%')
          .padding({ top: AppSpacing.md });
        }
        .width('100%')
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      // Bottom Bar
      Column() {
        Blank();

        Row() {
          Column({ space: AppSpacing.xs }) {
            Text('Next checkpoint')
              .font(AppFonts.label)
              .fontColor(AppColors.onSurface);
            Text('12:40 Studio')
              .font(AppFonts.body)
              .fontColor('rgba(46, 37, 29, 0.8)');
          }
          .alignItems(HorizontalAlign.Start);

          Blank();

          Button('Launch session')
            .font(AppFonts.label)
            .fontColor('rgba(0, 0, 0, 0.7)')
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.medium)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .onClick(() => {});
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
        .backgroundColor(AppColors.surface)
        .shadow({
          radius: 4,
          color: 'rgba(0, 0, 0, 0.1)',
          offsetX: 0,
          offsetY: -2
        });
      }
      .width('100%')
      .height('100%');
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }

  private scroller: Scroller = new Scroller();
  private swiperController: SwiperController = new SwiperController();
}
