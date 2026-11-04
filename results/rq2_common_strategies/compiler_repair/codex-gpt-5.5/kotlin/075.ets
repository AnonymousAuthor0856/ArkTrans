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

class StudyColors {
  static readonly primary: string = '#C08552';
  static readonly secondary: string = '#9BB1C8';
  static readonly background: string = '#F3EFE6';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E7DDCF';
  static readonly outline: string = '#D4C5B6';
  static readonly onSurface: string = '#2E251D';
}

@Entry
@Component
struct Index {
  @State currentPage: number = 0;
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

  private currentModule(): StudyModule {
    return this.modules[this.currentPage];
  }

  @Builder
  TopBar() {
    Row() {
      Button('Back')
        .fontSize(12)
        .fontColor(StudyColors.onSurface)
        .backgroundColor(StudyColors.surface)
      Text('Study Focus Split')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(StudyColors.onSurface)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)
      Button('Share')
        .fontSize(12)
        .fontColor(StudyColors.secondary)
        .backgroundColor(StudyColors.surface)
    }
    .width('100%')
    .height(64)
    .padding({ left: 8, right: 8 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(StudyColors.surface)
  }

  @Builder
  TabRow() {
    Row() {
      ForEach(this.modules, (module: StudyModule, index: number) => {
        Button(module.name)
          .height(42)
          .fontSize(12)
          .fontColor(this.currentPage === index ? StudyColors.primary : StudyColors.onSurface)
          .backgroundColor(StudyColors.surface)
          .borderRadius(0)
          .layoutWeight(1)
          .onClick(() => {
            this.currentPage = index;
          })
      }, (module: StudyModule) => module.name)
    }
    .width('100%')
    .backgroundColor(StudyColors.surface)
  }

  @Builder
  ModuleCard() {
    Column() {
      Text(this.currentModule().name)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(StudyColors.onSurface)
        .width('100%')
      Text(this.currentModule().summary)
        .fontSize(14)
        .fontColor('#CC2E251D')
        .width('100%')
        .margin({ top: 8 })
      Divider()
        .color(StudyColors.outline)
        .margin({ top: 12, bottom: 12 })
      Row() {
        Text('Progress')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(StudyColors.onSurface)
          .layoutWeight(1)
        Text(this.currentModule().progress.toString() + '%')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(StudyColors.primary)
      }
      .width('100%')
      Progress({ value: this.currentModule().progress, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(12)
        .color(StudyColors.primary)
        .backgroundColor(StudyColors.surfaceVariant)
        .margin({ top: 8 })
      Button('Review outline')
        .fontSize(12)
        .fontColor(StudyColors.onSurface)
        .backgroundColor(StudyColors.primary)
        .borderRadius(16)
        .margin({ top: 12 })
    }
    .width('100%')
    .height(220)
    .padding(16)
    .backgroundColor(StudyColors.surface)
    .borderRadius(20)
  }

  @Builder
  FocusBoard() {
    Column() {
      Text('Focus board')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(StudyColors.onSurface)
        .width('100%')
      ForEach(this.tasks, (task: TaskItem) => {
        Column() {
          Text(task.title)
            .fontSize(14)
            .fontColor(StudyColors.onSurface)
          Text(task.duration)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(StudyColors.secondary)
            .margin({ top: 4 })
        }
        .width('100%')
        .padding(8)
        .backgroundColor('#99E7DDCF')
        .borderRadius(12)
        .margin({ top: 8 })
      }, (task: TaskItem) => task.title)
      Button('Add checkpoint')
        .fontSize(12)
        .fontColor(StudyColors.onSurface)
        .backgroundColor(StudyColors.primary)
        .borderRadius(16)
        .margin({ top: 8 })
    }
    .layoutWeight(1)
    .padding(12)
    .backgroundColor(StudyColors.surface)
    .borderRadius(20)
  }

  @Builder
  ReflectionCard() {
    Column() {
      Text('Reflection')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(StudyColors.onSurface)
        .width('100%')
      Text(this.focusNote)
        .fontSize(14)
        .fontColor(StudyColors.onSurface)
        .width('100%')
        .padding(12)
        .backgroundColor(StudyColors.surface)
        .borderRadius(16)
        .margin({ top: 8 })
      Button('Shuffle note')
        .fontSize(12)
        .fontColor(StudyColors.onSurface)
        .backgroundColor(StudyColors.primary)
        .borderRadius(16)
        .margin({ top: 8 })
        .onClick(() => {
          this.focusNote = 'Blend high and low tones before next critique';
        })
    }
    .layoutWeight(1)
    .padding(12)
    .backgroundColor(StudyColors.surfaceVariant)
    .borderRadius(20)
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('Next checkpoint')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(StudyColors.onSurface)
        Text('12:40 Studio')
          .fontSize(14)
          .fontColor('#CC2E251D')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      Button('Launch session')
        .fontSize(12)
        .fontColor(StudyColors.onSurface)
        .backgroundColor(StudyColors.primary)
        .borderRadius(16)
    }
    .width('100%')
    .height(68)
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(StudyColors.surface)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()
        Scroll() {
          Column() {
            this.TabRow()
            Column() { this.ModuleCard() }.margin({ top: 16 })
            Row() {
              this.FocusBoard()
              Column() { this.ReflectionCard() }.layoutWeight(1).margin({ left: 12 })
            }
            .width('100%')
            .margin({ top: 16 })
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 12, bottom: 84 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(StudyColors.background)
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(StudyColors.background)
  }
}
