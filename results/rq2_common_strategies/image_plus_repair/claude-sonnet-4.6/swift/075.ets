class AppColors {
  static primary: string = '#C08552';
  static secondary: string = '#9BB1C8';
  static tertiary: string = '#E6CFAF';
  static background: string = '#F3EFE6';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E7DDCF';
  static outline: string = '#D4C5B6';
  static success: string = '#6BB187';
  static warning: string = '#E2A458';
  static error: string = '#D66B5D';
  static onPrimary: string = '#2A1C13';
  static onSecondary: string = '#15202B';
  static onTertiary: string = '#2C1F10';
  static onBackground: string = '#261E19';
  static onSurface: string = '#2E251D';
}

class StudyModule {
  id: number = 0;
  name: string = '';
  progress: number = 0;
  summary: string = '';

  constructor(id: number, name: string, progress: number, summary: string) {
    this.id = id;
    this.name = name;
    this.progress = progress;
    this.summary = summary;
  }
}

class TaskItem {
  id: number = 0;
  title: string = '';
  duration: string = '';

  constructor(id: number, title: string, duration: string) {
    this.id = id;
    this.title = title;
    this.duration = duration;
  }
}

@Entry
@Component
struct StudyFocusSplitScreen {
  @State selectedTabIndex: number = 0;
  @State focusNote: string = 'Focus on tone shifts across clay gradients';

  modules: StudyModule[] = [
    new StudyModule(0, 'Clay Resonance', 72, 'Acoustic prototypes'),
    new StudyModule(1, 'Material Memory', 54, 'Tactile journaling'),
    new StudyModule(2, 'Morph Lab', 83, 'Color blending'),
    new StudyModule(3, 'Studio Review', 28, 'Peer critique'),
  ];

  tasks: TaskItem[] = [
    new TaskItem(0, 'Research layering', '45m'),
    new TaskItem(1, 'Feedback sync', '30m'),
    new TaskItem(2, 'Practice recall', '20m'),
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {}
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Column() {
        // Top Bar
        Row() {
          Text('Back')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Blank()

          Text('Study Focus Split')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Blank()

          Text('Share')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.secondary)
        }
        .width('100%')
        .padding(16)
        .backgroundColor(AppColors.surface)

        // Scrollable Content
        Scroll() {
          Column({ space: 16 }) {
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

                    Divider()
                      .strokeWidth(2)
                      .color(this.selectedTabIndex === index ? AppColors.primary : 'transparent')
                  }
                  .width(90)
                  .padding({ top: 8, bottom: 8 })
                  .onClick(() => {
                    this.selectedTabIndex = index;
                  })
                })
              }
              .padding({ left: 16, right: 16 })
              .backgroundColor(AppColors.surface)
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            // Module Card (Swiper)
            Swiper() {
              ForEach(this.modules, (module: StudyModule) => {
                this.ModuleCardBuilder(module)
              })
            }
            .index(this.selectedTabIndex)
            .onChange((index: number) => {
              this.selectedTabIndex = index;
            })
            .indicator(false)
            .loop(false)
            .height(240)
            .padding({ left: 16, right: 16 })

            // Dual Pane
            Row({ space: 12 }) {
              // Left Pane: Focus Board
              Column({ space: 8 }) {
                Text('Focus board')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSurface)
                  .alignSelf(ItemAlign.Start)

                ForEach(this.tasks, (task: TaskItem) => {
                  Row() {
                    Column({ space: 4 }) {
                      Text(task.title)
                        .fontSize(14)
                        .fontColor(AppColors.onSurface)
                        .alignSelf(ItemAlign.Start)
                      Text(task.duration)
                        .fontSize(12)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppColors.secondary)
                        .alignSelf(ItemAlign.Start)
                    }
                    .alignItems(HorizontalAlign.Start)

                    Blank()
                  }
                  .width('100%')
                  .padding(8)
                  .backgroundColor(AppColors.surfaceVariant)
                  .borderRadius(12)
                })
              }
              .padding(12)
              .backgroundColor(AppColors.surface)
              .borderRadius(20)
              .shadow({ radius: 4, color: '#0D000000', offsetX: 0, offsetY: 2 })
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              // Right Pane: Reflection
              Column({ space: 8 }) {
                Text('Reflection')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSurface)
                  .alignSelf(ItemAlign.Start)

                Text(this.focusNote)
                  .fontSize(14)
                  .fontColor(AppColors.onSurface)
                  .padding(12)
                  .width('100%')
                  .backgroundColor(AppColors.surface)
                  .borderRadius(16)
                  .textAlign(TextAlign.Start)

                Button('Shuffle note')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onPrimary)
                  .width('100%')
                  .padding({ top: 12, bottom: 12 })
                  .backgroundColor(AppColors.primary)
                  .borderRadius(16)
                  .onClick(() => {
                    this.focusNote = 'Blend high and low tones before next critique';
                  })
              }
              .padding(12)
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(20)
              .shadow({ radius: 4, color: '#0D000000', offsetX: 0, offsetY: 2 })
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
            }
            .padding({ left: 16, right: 16 })
            .alignItems(VerticalAlign.Top)

            Column() {}
            .height(100)
          }
          .padding({ top: 12 })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')

      // Bottom Bar
      Row() {
        Column({ space: 4 }) {
          Text('Next checkpoint')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .alignSelf(ItemAlign.Start)
          Text('12:40 Studio')
            .fontSize(14)
            .fontColor(AppColors.onSurface)
            .alignSelf(ItemAlign.Start)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button('Launch session')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .backgroundColor(AppColors.primary)
          .borderRadius(16)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(AppColors.surface)
      .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  ModuleCardBuilder(module: StudyModule) {
    Column({ space: 8 }) {
      Text(module.name)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .alignSelf(ItemAlign.Start)

      Text(module.summary)
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .opacity(0.8)
        .alignSelf(ItemAlign.Start)

      Divider()
        .strokeWidth(1)
        .color(AppColors.outline)
        .margin({ top: 4, bottom: 4 })

      Row() {
        Text('Progress')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Blank()
        Text(`${module.progress}%`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')

      Stack({ alignContent: Alignment.Start }) {
        Row() {}
        .width('100%')
        .height(12)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(12)

        Row() {}
        .width(`${module.progress}%`)
        .height(12)
        .backgroundColor(AppColors.primary)
        .borderRadius(12)
      }
      .width('100%')
      .height(12)

      Column() {}
      .height(8)

      Button('Review outline')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        .backgroundColor(AppColors.primary)
        .borderRadius(16)
        .alignSelf(ItemAlign.Start)
    }
    .padding(16)
    .backgroundColor(AppColors.surface)
    .borderRadius(20)
    .shadow({ radius: 4, color: '#0D000000', offsetX: 0, offsetY: 2 })
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}