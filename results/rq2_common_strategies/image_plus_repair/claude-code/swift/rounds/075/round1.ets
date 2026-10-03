// App Tokens
class AppColors {
  static primary: ResourceColor = '#C08552';
  static secondary: ResourceColor = '#9BB1C8';
  static tertiary: ResourceColor = '#E6CFAF';
  static background: ResourceColor = '#F3EFE6';
  static surface: ResourceColor = '#FFFFFF';
  static surfaceVariant: ResourceColor = '#E7DDCF';
  static outline: ResourceColor = '#D4C5B6';
  static onPrimary: ResourceColor = '#2A1C13';
  static onSurface: ResourceColor = '#2E251D';
  static onSurfaceVariant: ResourceColor = '#261E19';
}

class AppSpacing {
  static xs: Length = 4;
  static sm: Length = 8;
  static md: Length = 12;
  static lg: Length = 16;
  static xl: Length = 24;
  static xxl: Length = 32;
}

class AppShapes {
  static small: Length = 12;
  static medium: Length = 16;
  static large: Length = 20;
}

// Models
interface StudyModule {
  name: string;
  progress: number;
  summary: string;
}

interface TaskItem {
  title: string;
  duration: string;
}

// ModuleCard Component
@Component
struct ModuleCard {
  @Prop module: StudyModule;

  build() {
    Column() {
      Text(this.module.name)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')

      Text(this.module.summary)
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .opacity(0.8)
        .width('100%')
        .margin({ top: 4 })

      Divider()
        .color(AppColors.outline)
        .strokeWidth(1)
        .margin({ top: 12, bottom: 12 })

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
      .margin({ bottom: 8 })

      Stack({ alignContent: Alignment.Start }) {
        // Background track
        Row()
          .width('100%')
          .height(12)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small)
        // Progress fill
        Row()
          .width(`${this.module.progress}%`)
          .height(12)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.small)
      }
      .width('100%')
      .height(12)

      Button('Review outline')
        .fontSize(12)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        .margin({ top: 16 })
        .onClick(() => {})
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.05)', offsetY: 2 })
  }
}

// Focus Board Card
@Component
struct FocusBoardCard {
  @Prop tasks: TaskItem[];

  build() {
    Column() {
      Text('Focus board')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .margin({ bottom: AppSpacing.sm })

      ForEach(this.tasks, (task: TaskItem) => {
        Row() {
          Column() {
            Text(task.title)
              .fontSize(14)
              .fontColor(AppColors.onSurface)
            Text(task.duration)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.secondary)
              .margin({ top: AppSpacing.xs })
          }
          .alignItems(HorizontalAlign.Start)
          Blank()
        }
        .width('100%')
        .padding(AppSpacing.sm)
        .backgroundColor(AppColors.surfaceVariant)
        .opacity(0.6)
        .borderRadius(AppShapes.small)
        .margin({ bottom: AppSpacing.sm })
      }, (task: TaskItem) => task.title)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.05)', offsetY: 2 })
  }
}

// Reflection Card
@Component
struct ReflectionCard {
  @State focusNote: string = 'Focus on tone shifts across clay gradients';

  build() {
    Column() {
      Text('Reflection')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .margin({ bottom: AppSpacing.sm })

      Text(this.focusNote)
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.medium)
        .margin({ bottom: AppSpacing.sm })

      Button('Shuffle note')
        .fontSize(12)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .width('100%')
        .height(40)
        .onClick(() => {
          this.focusNote = 'Blend high and low tones before next critique';
        })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.large)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.05)', offsetY: 2 })
  }
}

// Tab Bar Item
@Component
struct TabBarItem {
  @Prop name: string;
  @Prop isSelected: boolean;
  @Prop index: number;
  onTabClick?: (index: number) => void;

  build() {
    Column() {
      Text(this.name)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? AppColors.primary : AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .height(40)

      Row()
        .width('100%')
        .height(2)
        .backgroundColor(this.isSelected ? AppColors.primary : Color.Transparent)
    }
    .width(90)
    .padding({ top: 8, bottom: 8 })
    .onClick(() => {
      if (this.onTabClick) {
        this.onTabClick(this.index);
      }
    })
  }
}

// Main Entry
@Entry
@Component
struct StudyFocusSplitScreen {
  @State selectedTabIndex: number = 0;

  private modules: StudyModule[] = [
    { name: 'Clay\nResonance', progress: 72, summary: 'Acoustic prototypes' },
    { name: 'Material\nMemory', progress: 54, summary: 'Tactile journaling' },
    { name: 'Morph\nLab', progress: 83, summary: 'Color blending' },
    { name: 'Studio\nReview', progress: 28, summary: 'Peer critique' }
  ];

  private moduleNames: string[] = [
    'Clay\nResonance',
    'Material\nMemory',
    'Morph\nLab',
    'Studio\nReview'
  ];

  private tasks: TaskItem[] = [
    { title: 'Research layering', duration: '45m' },
    { title: 'Feedback sync', duration: '30m' },
    { title: 'Practice recall', duration: '20m' }
  ];

  aboutToAppear() {
    this.selectedTabIndex = 0;
  }

  build() {
    Stack() {
      Column() {
        // Top Bar
        Row() {
          Button('Back')
            .fontSize(12)
            .fontColor(AppColors.onSurface)
            .backgroundColor(Color.Transparent)
            .onClick(() => {})

          Blank()

          Text('Study Focus Split')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Blank()

          Button('Share')
            .fontSize(12)
            .fontColor(AppColors.secondary)
            .backgroundColor(Color.Transparent)
            .onClick(() => {})
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)

        Scroll() {
          Column() {
            // Tab Row
            Scroll() {
              Row() {
                ForEach(this.moduleNames, (name: string, index: number) => {
                  TabBarItem({
                    name: name,
                    isSelected: this.selectedTabIndex === index,
                    index: index,
                    onTabClick: (idx: number) => {
                      this.selectedTabIndex = idx;
                    }
                  })
                }, (name: string) => name)
              }
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
              .backgroundColor(AppColors.surface)
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .backgroundColor(AppColors.surface)

            // Swiper / Pager for Module Cards
            Swiper() {
              ForEach(this.modules, (module: StudyModule) => {
                ModuleCard({ module: module })
                  .width('100%')
                  .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
              }, (module: StudyModule) => module.name)
            }
            .index(this.selectedTabIndex)
            .onChange((index: number) => {
              this.selectedTabIndex = index;
            })
            .width('100%')
            .height(280)
            .indicator(false)
            .curve(Curve.Linear)
            .margin({ top: AppSpacing.md })

            // Dual Pane
            Row() {
              FocusBoardCard({ tasks: this.tasks })
                .layoutWeight(1)

              ReflectionCard()
                .layoutWeight(1)
            }
            .width('100%')
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            .alignItems(VerticalAlign.Top)

            Blank()
              .height(100)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      // Bottom Bar
      Column() {
        Blank()

        Row() {
          Column() {
            Text('Next checkpoint')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
            Text('12:40 Studio')
              .fontSize(14)
              .fontColor(AppColors.onSurface)
              .opacity(0.8)
              .margin({ top: AppSpacing.xs })
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button('Launch session')
            .fontSize(12)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.medium)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .onClick(() => {})
        }
        .width('100%')
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.sm,
          bottom: AppSpacing.sm
        })
        .backgroundColor(AppColors.surface)
        .shadow({
          radius: 4,
          color: 'rgba(0,0,0,0.1)',
          offsetY: -2
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
