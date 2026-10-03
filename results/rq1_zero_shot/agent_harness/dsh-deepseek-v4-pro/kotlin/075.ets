const Colors = {
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

const Spacing = { xs: 4, sm: 8, md: 12, lg: 16, xl: 24, xxl: 32, xxxl: 48 };
const Shapes = { small: 12, medium: 16, large: 20 };

interface StudyModule {
  name: string;
  progress: number;
  summary: string;
}

interface TaskItem {
  title: string;
  duration: string;
}

const modules: StudyModule[] = [
  { name: 'Clay Resonance', progress: 72, summary: 'Acoustic prototypes' },
  { name: 'Material Memory', progress: 54, summary: 'Tactile journaling' },
  { name: 'Morph Lab', progress: 83, summary: 'Color blending' },
  { name: 'Studio Review', progress: 28, summary: 'Peer critique' }
];

const tasks: TaskItem[] = [
  { title: 'Research layering', duration: '45m' },
  { title: 'Feedback sync', duration: '30m' },
  { title: 'Practice recall', duration: '20m' }
];

@Entry
@Component
struct Index {
  @State tabIndex: number = 0;
  @State focusNote: string = 'Focus on tone shifts across clay gradients';

  @Builder
  moduleTab(index: number, name: string) {
    Column() {
      Text(name)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.tabIndex === index ? Colors.primary : Colors.onSurface)
    }
    .padding(Spacing.sm)
  }

  build() {
    Column() {
      Row() {
        Text('Back')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        Text('Study Focus Split')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
        Text('Share')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.secondary)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Colors.surface)

      Scroll() {
        Column({ space: Spacing.lg }) {
          Tabs({ barPosition: BarPosition.Start, index: this.tabIndex }) {
            ForEach(modules, (module: StudyModule, index: number) => {
              TabContent() {
                Column({ space: Spacing.sm }) {
                  Text(module.name)
                    .fontSize(22)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                  Text(module.summary)
                    .fontSize(14)
                    .fontColor('#CC2E251D')
                  Divider()
                    .color(Colors.outline)
                    .strokeWidth(1)
                  Row() {
                    Text('Progress')
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(Colors.onSurface)
                    Text(module.progress + '%')
                      .fontSize(18)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(Colors.primary)
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.SpaceBetween)

                  Stack({ alignContent: Alignment.Start }) {
                    Column() {
                    }
                    .width('100%')
                    .height(12)
                    .borderRadius(Shapes.small)
                    .backgroundColor(Colors.surfaceVariant)
                    Column() {
                    }
                    .width(module.progress + '%')
                    .height(12)
                    .borderRadius(Shapes.small)
                    .backgroundColor(Colors.primary)
                  }
                  .width('100%')
                  .height(12)

                  Button('Review outline')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .borderRadius(Shapes.medium)
                }
                .padding(Spacing.lg)
                .borderRadius(Shapes.large)
                .backgroundColor(Colors.surface)
                .width('100%')
                .height(220)
              }
              .tabBar(this.moduleTab(index, module.name))
            }, (module: StudyModule) => module.name)
          }
          .onChange((index: number) => {
            this.tabIndex = index;
          })
          .width('100%')
          .backgroundColor(Colors.surface)

          Row({ space: Spacing.md }) {
            Column({ space: Spacing.sm }) {
              Text('Focus board')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
              ForEach(tasks, (task: TaskItem) => {
                Column({ space: Spacing.xs }) {
                  Text(task.title)
                    .fontSize(14)
                    .fontColor(Colors.onSurface)
                  Text(task.duration)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.secondary)
                }
                .padding(Spacing.sm)
                .borderRadius(Shapes.small)
                .backgroundColor('#99E7DDCF')
              }, (task: TaskItem) => task.title)
              Button('Add checkpoint')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .borderRadius(Shapes.medium)
            }
            .layoutWeight(1)
            .padding(Spacing.md)
            .borderRadius(Shapes.large)
            .backgroundColor(Colors.surface)

            Column({ space: Spacing.sm }) {
              Text('Reflection')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
              Column() {
                Text(this.focusNote)
                  .fontSize(14)
                  .fontColor(Colors.onSurface)
              }
              .width('100%')
              .padding(Spacing.md)
              .borderRadius(Shapes.medium)
              .backgroundColor(Colors.surface)
              Button('Shuffle note')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .borderRadius(Shapes.medium)
                .onClick(() => {
                  this.focusNote = 'Blend high and low tones before next critique';
                })
            }
            .layoutWeight(1)
            .padding(Spacing.md)
            .borderRadius(Shapes.large)
            .backgroundColor(Colors.surfaceVariant)
          }
          .width('100%')
        }
        .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
      }
      .layoutWeight(1)

      Row() {
        Column({ space: Spacing.xs }) {
          Text('Next checkpoint')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text('12:40 Studio')
            .fontSize(14)
            .fontColor('#CC2E251D')
        }
        Button('Launch session')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .borderRadius(Shapes.medium)
      }
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.sm, bottom: Spacing.sm })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Colors.surface)
      .shadow({ radius: 10, color: '#16000000', offsetY: 4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
