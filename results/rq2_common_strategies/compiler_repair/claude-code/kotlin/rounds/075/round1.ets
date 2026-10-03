class StudyModule {
  name: string = '';
  progress: number = 0;
  summary: string = '';
  constructor(name: string, progress: number, summary: string) {
    this.name = name;
    this.progress = progress;
    this.summary = summary;
  }
}

class TaskItem {
  title: string = '';
  duration: string = '';
  constructor(title: string, duration: string) {
    this.title = title;
    this.duration = duration;
  }
}

class AppColors {
  static readonly primary: string = '#FFC08552';
  static readonly secondary: string = '#FF9BB1C8';
  static readonly tertiary: string = '#FFE6CFAF';
  static readonly background: string = '#FFF3EFE6';
  static readonly surface: string = '#FFFFFFFF';
  static readonly surfaceVariant: string = '#FFE7DDCF';
  static readonly outline: string = '#FFD4C5B6';
  static readonly success: string = '#FF6BB187';
  static readonly warning: string = '#FFE2A458';
  static readonly error: string = '#FFD66B5D';
  static readonly onPrimary: string = '#FF2A1C13';
  static readonly onSecondary: string = '#FF15202B';
  static readonly onTertiary: string = '#FF2C1F10';
  static readonly onBackground: string = '#FF261E19';
  static readonly onSurface: string = '#FF2E251D';
}

class AppSpacing {
  static readonly xs: Length = '4vp';
  static readonly sm: Length = '8vp';
  static readonly md: Length = '12vp';
  static readonly lg: Length = '16vp';
  static readonly xl: Length = '24vp';
  static readonly xxl: Length = '32vp';
  static readonly xxxl: Length = '48vp';
}

class AppShapes {
  static readonly small: number = 12;
  static readonly medium: number = 16;
  static readonly large: number = 20;
}

@Entry
@Component
struct StudyFocusSplit {
  @State currentIndex: number = 0;
  @State focusNote: string = 'Focus on tone shifts across clay gradients';
  private modules: StudyModule[] = [
    new StudyModule('Clay Resonance', 72, 'Acoustic prototypes'),
    new StudyModule('Material Memory', 54, 'Tactile journaling'),
    new StudyModule('Morph Lab', 83, 'Color blending'),
    new StudyModule('Studio Review', 28, 'Peer critique')
  ];
  private tasks: TaskItem[] = [
    new TaskItem('Research layering', '45m'),
    new TaskItem('Feedback sync', '30m'),
    new TaskItem('Practice recall', '20m')
  ];
  private swiperController: SwiperController = new SwiperController();
  private tabNames: string[] = ['Clay Resonance', 'Material Memory', 'Morph Lab', 'Studio Review'];

  build() {
    Column() {
      this.TopBar()
      Scroll() {
        Column() {
          this.TabSection()
          this.SwiperSection()
          this.SplitCardsSection()
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  TopBar() {
    Row() {
      Text('Back')
        .fontSize(12)
        .fontColor(AppColors.onSurface)
        .fontWeight(FontWeight.Medium)
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })

      Text('Study Focus Split')
        .fontSize(18)
        .fontColor(AppColors.onSurface)
        .fontWeight(FontWeight.Medium)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('Share')
        .fontSize(12)
        .fontColor(AppColors.secondary)
        .fontWeight(FontWeight.Medium)
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  TabSection() {
    Row() {
      ForEach(this.tabNames, (item: string, index: number) => {
        Text(item)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.currentIndex === index ? AppColors.primary : AppColors.onSurface)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.md, bottom: AppSpacing.md })
          .onClick(() => {
            this.currentIndex = index;
            this.swiperController.changeIndex(index);
          })
      }, (item: string) => item)
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.small)
    .justifyContent(FlexAlign.SpaceEvenly)
    .margin({ bottom: parseInt(AppSpacing.lg as string) })
  }

  @Builder
  SwiperSection() {
    Swiper(this.swiperController) {
      ForEach(this.modules, (module: StudyModule, index: number) => {
        this.ModuleCard(module)
      }, (module: StudyModule) => module.name)
    }
    .width('100%')
    .height(220)
    .index(this.currentIndex)
    .onChange((index: number) => {
      this.currentIndex = index;
    })
    .indicator(false)
    .margin({ bottom: parseInt(AppSpacing.lg as string) })
  }

  @Builder
  ModuleCard(module: StudyModule) {
    Column() {
      Text(module.name)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
      Text(module.summary)
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .opacity(0.8)
        .margin({ bottom: parseInt(AppSpacing.sm as string) })
      Divider()
        .color(AppColors.outline)
        .margin({ bottom: parseInt(AppSpacing.sm as string) })
      Row() {
        Text('Progress')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(`${module.progress}%`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ bottom: parseInt(AppSpacing.sm as string) })

      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width('100%')
          .height(12)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small)
        Row()
          .width(`${module.progress}%`)
          .height(12)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.small)
      }
      .width('100%')
      .margin({ bottom: parseInt(AppSpacing.md as string) })

      Button('Review outline')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .borderRadius(AppShapes.medium)
        .backgroundColor(AppColors.primary)
        .fontColor(AppColors.onPrimary)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
  }

  @Builder
  SplitCardsSection() {
    Row() {
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
  }

  @Builder
  FocusBoardCard() {
    Column() {
      Text('Focus board')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .margin({ bottom: parseInt(AppSpacing.sm as string) })

      ForEach(this.tasks, (task: TaskItem) => {
        Column() {
          Text(task.title)
            .fontSize(14)
            .fontColor(AppColors.onSurface)
          Text(task.duration)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.secondary)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(AppSpacing.sm)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.small)
        .margin({ bottom: parseInt(AppSpacing.xs as string) })
      }, (task: TaskItem) => task.title)

      Button('Add checkpoint')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .borderRadius(AppShapes.medium)
        .backgroundColor(AppColors.primary)
        .fontColor(AppColors.onPrimary)
        .margin({ top: parseInt(AppSpacing.sm as string) })
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.md)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .margin({ right: parseInt(AppSpacing.md as string) / 2 })
  }

  @Builder
  ReflectionCard() {
    Column() {
      Text('Reflection')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .margin({ bottom: parseInt(AppSpacing.sm as string) })

      Text(this.focusNote)
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.medium)
        .margin({ bottom: parseInt(AppSpacing.sm as string) })

      Button('Shuffle note')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .borderRadius(AppShapes.medium)
        .backgroundColor(AppColors.primary)
        .fontColor(AppColors.onPrimary)
        .onClick(() => {
          this.focusNote = 'Blend high and low tones before next critique';
        })
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.md)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.large)
    .margin({ left: parseInt(AppSpacing.md as string) / 2 })
  }

  @Builder
  BottomBar() {
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
          .margin({ top: parseInt(AppSpacing.xs as string) })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Launch session')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .borderRadius(AppShapes.medium)
        .backgroundColor(AppColors.primary)
        .fontColor(AppColors.onPrimary)
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .backgroundColor(AppColors.surface)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}
