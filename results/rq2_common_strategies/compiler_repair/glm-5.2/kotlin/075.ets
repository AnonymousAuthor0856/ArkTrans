// Index.ets

interface StudyModule {
  name: string;
  progress: number;
  summary: string;
}

interface TaskItem {
  title: string;
  duration: string;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokens {
  static Colors = {
    primary: '#FFC08552',
    secondary: '#FF9BB1C8',
    tertiary: '#FFE6CFAF',
    background: '#FFF3EFE6',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE7DDCF',
    outline: '#FFD4C5B6',
    success: '#FF6BB187',
    warning: '#FFE2A458',
    error: '#FFD66B5D',
    onPrimary: '#FF2A1C13',
    onSecondary: '#FF15202B',
    onTertiary: '#FF2C1F10',
    onBackground: '#FF261E19',
    onSurface: '#FF2E251D',
  };
  static TypographyTokens = {
    display: { fontSize: 30, fontWeight: FontWeight.Medium, lineHeight: 36 },
    headline: { fontSize: 22, fontWeight: FontWeight.Medium, lineHeight: 28 },
    title: { fontSize: 18, fontWeight: FontWeight.Medium, lineHeight: 24 },
    body: { fontSize: 14, fontWeight: FontWeight.Normal, lineHeight: 20 },
    label: { fontSize: 12, fontWeight: FontWeight.Medium, lineHeight: 16 },
  };
  static Shapes = {
    small: 12,
    medium: 16,
    large: 20,
  };
  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 48,
  };
  static ElevationMapping: Record<string, ShadowSpec> = {
    level1: { elevation: 2, radius: 6, dy: 2, opacity: 0.12 },
    level2: { elevation: 4, radius: 10, dy: 4, opacity: 0.16 },
    level3: { elevation: 8, radius: 14, dy: 6, opacity: 0.2 },
    level4: { elevation: 12, radius: 18, dy: 8, opacity: 0.24 },
    level5: { elevation: 16, radius: 22, dy: 10, opacity: 0.28 },
  };
}

@Entry
@Component
struct RootScreen {
  @State currentIndex: number = 0;
  @State focusNote: string = 'Focus on tone shifts across clay gradients';

  private modules: StudyModule[] = [
    { name: 'Clay Resonance', progress: 72, summary: 'Acoustic prototypes' },
    { name: 'Material Memory', progress: 54, summary: 'Tactile journaling' },
    { name: 'Morph Lab', progress: 83, summary: 'Color blending' },
    { name: 'Studio Review', progress: 28, summary: 'Peer critique' },
  ];

  private tasks: TaskItem[] = [
    { title: 'Research layering', duration: '45m' },
    { title: 'Feedback sync', duration: '30m' },
    { title: 'Practice recall', duration: '20m' },
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Back')
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.sm })

        Blank()

        Text('Study Focus Split')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Blank()

        Text('Share')
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .fontColor(AppTokens.Colors.secondary)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.lg })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)
      .alignItems(VerticalAlign.Center)

      // Content
      Scroll() {
        Column() {
          // TabRow
          Tabs({ barPosition: BarPosition.Start, index: this.currentIndex }) {
            ForEach(this.modules, (module: StudyModule, index: number) => {
              TabContent() {
                Column() {
                  // Card Content
                  Column() {
                    Text(module.name)
                      .fontSize(AppTokens.TypographyTokens.headline.fontSize)
                      .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
                      .fontColor(AppTokens.Colors.onSurface)
                      .alignSelf(ItemAlign.Start)

                    Text(module.summary)
                      .fontSize(AppTokens.TypographyTokens.body.fontSize)
                      .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
                      .fontColor(AppTokens.Colors.onSurface)
                      .opacity(0.8)
                      .alignSelf(ItemAlign.Start)
                      .margin({ top: AppTokens.Spacing.sm })

                    Divider()
                      .color(AppTokens.Colors.outline)
                      .width('100%')
                      .margin({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })

                    Row() {
                      Text('Progress')
                        .fontSize(AppTokens.TypographyTokens.label.fontSize)
                        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                        .fontColor(AppTokens.Colors.onSurface)

                      Blank()

                      Text(`${module.progress}%`)
                        .fontSize(AppTokens.TypographyTokens.title.fontSize)
                        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                        .fontColor(AppTokens.Colors.primary)
                    }
                    .width('100%')

                    // Progress Bar
                    Stack({ alignContent: Alignment.Start }) {
                      // Background
                      Column()
                        .width('100%')
                        .height(12)
                        .backgroundColor(AppTokens.Colors.surfaceVariant)
                        .borderRadius(AppTokens.Shapes.small)

                      // Foreground
                      Column()
                        .width(`${module.progress}%`)
                        .height(12)
                        .backgroundColor(AppTokens.Colors.primary)
                        .borderRadius(AppTokens.Shapes.small)
                    }
                    .width('100%')
                    .height(12)
                    .margin({ top: AppTokens.Spacing.sm })

                    Button('Review outline')
                      .type(ButtonType.Capsule)
                      .borderRadius(AppTokens.Shapes.medium)
                      .backgroundColor(AppTokens.Colors.primary)
                      .fontColor(AppTokens.Colors.onPrimary)
                      .fontSize(AppTokens.TypographyTokens.label.fontSize)
                      .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                      .margin({ top: AppTokens.Spacing.sm })
                      .alignSelf(ItemAlign.Start)
                  }
                  .padding(AppTokens.Spacing.lg)
                  .backgroundColor(AppTokens.Colors.surface)
                  .borderRadius(AppTokens.Shapes.large)
                  .shadow({
                    radius: AppTokens.ElevationMapping.level1.radius,
                    color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`,
                    offsetX: 0,
                    offsetY: AppTokens.ElevationMapping.level1.dy
                  })
                }
              }
              .tabBar(this.TabBuilder(module.name, index))
            })
          }
          .barMode(BarMode.Scrollable)
          .barWidth('100%')
          .barHeight(48)
          .onChange((index: number) => {
            this.currentIndex = index;
          })
          .height(280)
          .margin({ bottom: AppTokens.Spacing.lg })

          // Dual Focus Panes
          Row() {
            // Focus Board
            Column() {
              Text('Focus board')
                .fontSize(AppTokens.TypographyTokens.title.fontSize)
                .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .alignSelf(ItemAlign.Start)

              ForEach(this.tasks, (task: TaskItem) => {
                Column() {
                  Text(task.title)
                    .fontSize(AppTokens.TypographyTokens.body.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
                    .fontColor(AppTokens.Colors.onSurface)
                    .alignSelf(ItemAlign.Start)

                  Text(task.duration)
                    .fontSize(AppTokens.TypographyTokens.label.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                    .fontColor(AppTokens.Colors.secondary)
                    .alignSelf(ItemAlign.Start)
                    .margin({ top: AppTokens.Spacing.xs })
                }
                .width('100%')
                .padding(AppTokens.Spacing.sm)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .opacity(0.6)
                .borderRadius(AppTokens.Shapes.small)
                .margin({ top: AppTokens.Spacing.sm })
                .alignItems(HorizontalAlign.Start)
              })

              Button('Add checkpoint')
                .type(ButtonType.Capsule)
                .borderRadius(AppTokens.Shapes.medium)
                .backgroundColor(AppTokens.Colors.primary)
                .fontColor(AppTokens.Colors.onPrimary)
                .fontSize(AppTokens.TypographyTokens.label.fontSize)
                .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                .margin({ top: AppTokens.Spacing.sm })
                .alignSelf(ItemAlign.Start)
            }
            .layoutWeight(1)
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .alignItems(HorizontalAlign.Start)

            // Reflection
            Column() {
              Text('Reflection')
                .fontSize(AppTokens.TypographyTokens.title.fontSize)
                .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .alignSelf(ItemAlign.Start)

              Text(this.focusNote)
                .fontSize(AppTokens.TypographyTokens.body.fontSize)
                .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .width('100%')
                .padding(AppTokens.Spacing.md)
                .backgroundColor(AppTokens.Colors.surface)
                .borderRadius(AppTokens.Shapes.medium)
                .margin({ top: AppTokens.Spacing.sm })

              Button('Shuffle note')
                .type(ButtonType.Capsule)
                .borderRadius(AppTokens.Shapes.medium)
                .backgroundColor(AppTokens.Colors.primary)
                .fontColor(AppTokens.Colors.onPrimary)
                .fontSize(AppTokens.TypographyTokens.label.fontSize)
                .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                .margin({ top: AppTokens.Spacing.sm })
                .alignSelf(ItemAlign.Start)
                .onClick(() => {
                  this.focusNote = 'Blend high and low tones before next critique';
                })
            }
            .layoutWeight(1)
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.large)
            .alignItems(HorizontalAlign.Start)
            .margin({ left: AppTokens.Spacing.md })
          }
          .width('100%')
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top)

      // Bottom Bar
      Row() {
        Column() {
          Text('Next checkpoint')
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)

          Text('12:40 Studio')
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .opacity(0.8)
            .margin({ top: AppTokens.Spacing.xs })
        }
        .alignItems(HorizontalAlign.Start)

        Button('Launch session')
          .type(ButtonType.Capsule)
          .borderRadius(AppTokens.Shapes.medium)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      .backgroundColor(AppTokens.Colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .shadow({
        radius: AppTokens.ElevationMapping.level2.radius,
        color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
        offsetX: 0,
        offsetY: AppTokens.ElevationMapping.level2.dy
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  TabBuilder(name: string, index: number) {
    Column() {
      Text(name)
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
        .fontColor(this.currentIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
      Divider()
        .width('100%')
        .height(2)
        .color(this.currentIndex === index ? AppTokens.Colors.primary : 'transparent')
        .margin({ top: AppTokens.Spacing.xs })
    }
    .width('100%')
    .height(48)
    .justifyContent(FlexAlign.Center)
  }
}