// StudyFocusSplit.ets
// ArkTS / ArkUI port of the Compose "Study Focus Split" screen (Education SplitPane, Clay Morph).

class StudyModule {
  name: string;
  progress: number;
  summary: string;

  constructor(name: string, progress: number, summary: string) {
    this.name = name;
    this.progress = progress;
    this.summary = summary;
  }
}

class TaskItem {
  title: string;
  duration: string;

  constructor(title: string, duration: string) {
    this.title = title;
    this.duration = duration;
  }
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppTokens {
  static readonly primary: string = '#C08552';
  static readonly secondary: string = '#9BB1C8';
  static readonly tertiary: string = '#E6CFAF';
  static readonly background: string = '#F3EFE6';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E7DDCF';
  static readonly outline: string = '#D4C5B6';
  static readonly success: string = '#6BB187';
  static readonly warning: string = '#E2A458';
  static readonly error: string = '#D66B5D';
  static readonly onPrimary: string = '#2A1C13';
  static readonly onSurface: string = '#2E251D';
  static readonly onSurfaceSoft: string = '#CC2E251D';
  static readonly surfaceVariantSoft: string = '#99E7DDCF';

  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
  static readonly xxxl: number = 48;

  static readonly radiusSmall: number = 12;
  static readonly radiusMedium: number = 16;
  static readonly radiusLarge: number = 20;

  static readonly elevation1: ShadowSpec = new ShadowSpec(2, 6, 2, 0.12);
  static readonly elevation2: ShadowSpec = new ShadowSpec(4, 10, 4, 0.16);
  static readonly elevation3: ShadowSpec = new ShadowSpec(8, 14, 6, 0.20);
  static readonly elevation4: ShadowSpec = new ShadowSpec(12, 18, 8, 0.24);
  static readonly elevation5: ShadowSpec = new ShadowSpec(16, 22, 10, 0.28);
}

@Entry
@Component
struct StudyFocusSplit {
  @State currentIndex: number = 0;
  @State focusNote: string = 'Focus on tone shifts across clay gradients';

  private swiperController: SwiperController = new SwiperController();

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

  @Builder
  topBar() {
    Row() {
      Text('Back')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onSurface)
        .onClick(() => {
        })

      Text('Study Focus Split')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onSurface)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)

      Text('Share')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.secondary)
        .onClick(() => {
        })
    }
    .width('100%')
    .height(56)
    .padding({ left: AppTokens.lg, right: AppTokens.lg })
    .backgroundColor(AppTokens.surface)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  tabItem(module: StudyModule, index: number) {
    Column() {
      Text(module.name)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.currentIndex === index ? AppTokens.primary : AppTokens.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .layoutWeight(1)

      Divider()
        .strokeWidth(2)
        .color(this.currentIndex === index ? AppTokens.primary : Color.Transparent)
        .width('100%')
    }
    .layoutWeight(1)
    .height(64)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = index;
      this.swiperController.changeIndex(index, true);
    })
  }

  @Builder
  tabRow() {
    Column() {
      Row() {
        ForEach(this.modules, (module: StudyModule, index: number) => {
          this.tabItem(module, index)
        }, (module: StudyModule, index: number) => module.name + index.toString())
      }
      .width('100%')

      Divider()
        .strokeWidth(1)
        .color(AppTokens.outline)
    }
    .width('100%')
    .backgroundColor(AppTokens.surface)
  }

  @Builder
  moduleCard(module: StudyModule) {
    Column({ space: AppTokens.sm }) {
      Text(module.name)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onSurface)

      Text(module.summary)
        .fontSize(14)
        .fontColor(AppTokens.onSurfaceSoft)

      Divider()
        .strokeWidth(1)
        .color(AppTokens.outline)

      Row() {
        Text('Progress')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.onSurface)

        Blank()

        Text(`${module.progress}%`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.primary)
      }
      .width('100%')

      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width('100%')
          .height(12)
          .backgroundColor(AppTokens.surfaceVariant)
          .borderRadius(AppTokens.radiusSmall)

        Row()
          .width(`${module.progress}%`)
          .height(12)
          .backgroundColor(AppTokens.primary)
          .borderRadius(AppTokens.radiusSmall)
      }
      .width('100%')
      .height(12)

      Button('Review outline', { type: ButtonType.Normal, stateEffect: true })
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onPrimary)
        .backgroundColor(AppTokens.primary)
        .borderRadius(AppTokens.radiusMedium)
        .height(40)
        .width(170)
        .onClick(() => {
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.lg)
    .backgroundColor(AppTokens.surface)
    .borderRadius(AppTokens.radiusLarge)
    .shadow({
      radius: AppTokens.elevation2.radius,
      color: '#29000000',
      offsetX: 0,
      offsetY: AppTokens.elevation2.dy
    })
  }

  @Builder
  pagerSection() {
    Swiper(this.swiperController) {
      ForEach(this.modules, (module: StudyModule) => {
        Column() {
          this.moduleCard(module)
        }
        .width('100%')
        .height('100%')
        .padding({ bottom: AppTokens.md })
      }, (module: StudyModule, index: number) => module.name + index.toString())
    }
    .index(0)
    .loop(false)
    .indicator(false)
    .duration(300)
    .height(268)
    .onChange((index: number) => {
      this.currentIndex = index;
    })
  }

  @Builder
  focusBoardCard() {
    Column({ space: AppTokens.sm }) {
      Text('Focus board')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onSurface)

      ForEach(this.tasks, (task: TaskItem) => {
        Column({ space: AppTokens.xs }) {
          Text(task.title)
            .fontSize(14)
            .fontColor(AppTokens.onSurface)

          Text(task.duration)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.secondary)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(AppTokens.sm)
        .backgroundColor(AppTokens.surfaceVariantSoft)
        .borderRadius(AppTokens.radiusSmall)
      }, (task: TaskItem) => task.title)

      Button('Add checkpoint', { type: ButtonType.Normal, stateEffect: true })
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onPrimary)
        .backgroundColor(AppTokens.primary)
        .borderRadius(AppTokens.radiusMedium)
        .height(40)
        .width('100%')
        .onClick(() => {
        })
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.md)
    .backgroundColor(AppTokens.surface)
    .borderRadius(AppTokens.radiusLarge)
    .shadow({
      radius: AppTokens.elevation1.radius,
      color: '#1F000000',
      offsetX: 0,
      offsetY: AppTokens.elevation1.dy
    })
  }

  @Builder
  reflectionCard() {
    Column({ space: AppTokens.sm }) {
      Text('Reflection')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onSurface)

      Column() {
        Text(this.focusNote)
          .fontSize(14)
          .fontColor(AppTokens.onSurface)
          .width('100%')
          .padding(AppTokens.md)
      }
      .width('100%')
      .backgroundColor(AppTokens.surface)
      .borderRadius(AppTokens.radiusMedium)

      Button('Shuffle note', { type: ButtonType.Normal, stateEffect: true })
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onPrimary)
        .backgroundColor(AppTokens.primary)
        .borderRadius(AppTokens.radiusMedium)
        .height(40)
        .width('100%')
        .onClick(() => {
          this.focusNote = 'Blend high and low tones before next critique';
        })
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.md)
    .backgroundColor(AppTokens.surfaceVariant)
    .borderRadius(AppTokens.radiusLarge)
  }

  @Builder
  splitPanes() {
    Row({ space: AppTokens.md }) {
      this.focusBoardCard()
      this.reflectionCard()
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  bottomBar() {
    Row() {
      Column({ space: AppTokens.xs }) {
        Text('Next checkpoint')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.onSurface)

        Text('12:40 Studio')
          .fontSize(14)
          .fontColor(AppTokens.onSurfaceSoft)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Launch session', { type: ButtonType.Normal, stateEffect: true })
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onPrimary)
        .backgroundColor(AppTokens.primary)
        .borderRadius(AppTokens.radiusMedium)
        .height(40)
        .padding({ left: AppTokens.lg, right: AppTokens.lg })
        .onClick(() => {
        })
    }
    .width('100%')
    .padding({ left: AppTokens.lg, right: AppTokens.lg, top: AppTokens.sm, bottom: AppTokens.sm })
    .backgroundColor(AppTokens.surface)
    .alignItems(VerticalAlign.Center)
    .shadow({
      radius: AppTokens.elevation2.radius,
      color: '#29000000',
      offsetX: 0,
      offsetY: -AppTokens.elevation2.dy
    })
  }

  build() {
    Column() {
      this.topBar()

      Scroll() {
        Column({ space: AppTokens.lg }) {
          this.tabRow()
          this.pagerSection()
          this.splitPanes()
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding({
          left: AppTokens.lg,
          right: AppTokens.lg,
          top: AppTokens.md,
          bottom: AppTokens.md
        })
      }
      .layoutWeight(1)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      this.bottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
  }
}