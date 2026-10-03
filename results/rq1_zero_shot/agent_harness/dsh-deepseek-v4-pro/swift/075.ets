// Translated from SwiftUI (075.swift) to ArkTS / ArkUI

// MARK: - App Tokens (Colors)
const ST_PRIMARY = '#C08552';
const ST_SECONDARY = '#9BB1C8';
const ST_TERTIARY = '#E6CFAF';
const ST_BACKGROUND = '#F3EFE6';
const ST_SURFACE = '#FFFFFF';
const ST_SURFACE_VARIANT = '#E7DDCF';
const ST_OUTLINE = '#D4C5B6';
const ST_SUCCESS = '#6BB187';
const ST_WARNING = '#E2A458';
const ST_ERROR = '#D66B5D';
const ST_ON_PRIMARY = '#2A1C13';
const ST_ON_SECONDARY = '#15202B';
const ST_ON_TERTIARY = '#2C1F10';
const ST_ON_BACKGROUND = '#261E19';
const ST_ON_SURFACE = '#2E251D';

// MARK: - Entry Point
@Entry
@Component
struct Index {
  build() {
    ContentView()
  }
}

@Component
struct ContentView {
  build() {
    StudyFocusSplitScreen()
    // .preferredColorScheme(.light)
    // .statusBarHidden(true)
  }
}

// MARK: - Models
class StudyModule {
  id: string;
  name: string;
  progress: number;
  summary: string;

  constructor(id: string, name: string, progress: number, summary: string) {
    this.id = id;
    this.name = name;
    this.progress = progress;
    this.summary = summary;
  }
}

class TaskItem {
  id: string;
  title: string;
  duration: string;

  constructor(id: string, title: string, duration: string) {
    this.id = id;
    this.title = title;
    this.duration = duration;
  }
}

// MARK: - Main Screen
@Component
struct StudyFocusSplitScreen {
  @State selectedTabIndex: number = 0
  @State focusNote: string = 'Focus on tone shifts across clay gradients'

  modules: StudyModule[] = [
    new StudyModule('1', 'Clay Resonance', 72, 'Acoustic prototypes'),
    new StudyModule('2', 'Material Memory', 54, 'Tactile journaling'),
    new StudyModule('3', 'Morph Lab', 83, 'Color blending'),
    new StudyModule('4', 'Studio Review', 28, 'Peer critique')
  ]

  tasks: TaskItem[] = [
    new TaskItem('1', 'Research layering', '45m'),
    new TaskItem('2', 'Feedback sync', '30m'),
    new TaskItem('3', 'Practice recall', '20m')
  ]

  build() {
    Stack() {
      Column({ space: 0 }) {
        // Top Bar
        Row() {
          Button() {
            Text('Back')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(ST_ON_SURFACE)
          }
          .onClick(() => {})
          Blank()
          Text('Study Focus Split')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(ST_ON_SURFACE)
          Blank()
          Button() {
            Text('Share')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(ST_SECONDARY)
          }
          .onClick(() => {})
        }
        .padding(16)
        .backgroundColor(ST_SURFACE)

        // Scrollable Content
        Scroll() {
          Column({ space: 16 }) {
            // Tab Row
            Scroll() {
              Row({ space: 0 }) {
                ForEach(this.modules, (module: StudyModule, index: number) => {
                  Column({ space: 8 }) {
                    Text(module.name.replace(/ /g, '\n'))
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(this.selectedTabIndex === index ? ST_PRIMARY : ST_ON_SURFACE)
                      .textAlign(TextAlign.Center)
                      .maxLines(2)
                      .height(40)

                    Blank()
                      .height(2)
                      .width('100%')
                      .backgroundColor(this.selectedTabIndex === index ? ST_PRIMARY : '#00000000')
                  }
                  .width(90)
                  .padding({ top: 8, bottom: 8 })
                  .onClick(() => { this.selectedTabIndex = index })
                }, (module: StudyModule) => module.id)
              }
              .padding({ left: 16, right: 16 })
              .backgroundColor(ST_SURFACE)
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)

            // Pager Content (Main Card)
            Swiper() {
              ForEach(this.modules, (module: StudyModule) => {
                ModuleCard({ module: module })
                  .padding({ left: 16, right: 16 })
              }, (module: StudyModule) => module.id)
            }
            .index(this.selectedTabIndex)
            .onChange((index: number) => { this.selectedTabIndex = index })
            .height(220)

            // Dual Pane
            Row({ space: 12 }) {
              // Left Pane: Focus Board
              CardView({ backgroundColor: ST_SURFACE }) {
                Column({ space: 8 }) {
                  Text('Focus board')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(ST_ON_SURFACE)

                  ForEach(this.tasks, (task: TaskItem) => {
                    Row() {
                      Column({ space: 4 }) {
                        Text(task.title)
                          .fontSize(14)
                          .fontWeight(FontWeight.Regular)
                          .fontColor(ST_ON_SURFACE)
                        Text(task.duration)
                          .fontSize(12)
                          .fontWeight(FontWeight.Medium)
                          .fontColor(ST_SECONDARY)
                      }
                      .alignItems(HorizontalAlign.Start)
                      Blank()
                    }
                    .padding(8)
                    .backgroundColor('#99E7DDCF') // surfaceVariant.opacity(0.6)
                    .borderRadius(12)
                  }, (task: TaskItem) => task.id)
                }
                .alignItems(HorizontalAlign.Start)
                .padding(12)
              }

              // Right Pane: Reflection
              CardView({ backgroundColor: ST_SURFACE_VARIANT }) {
                Column({ space: 8 }) {
                  Text('Reflection')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(ST_ON_SURFACE)

                  Text(this.focusNote)
                    .fontSize(14)
                    .fontWeight(FontWeight.Regular)
                    .fontColor(ST_ON_SURFACE)
                    .padding(12)
                    .width('100%')
                    .backgroundColor(ST_SURFACE)
                    .borderRadius(16)

                  Button() {
                    Text('Shuffle note')
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#CC000000') // Color.black.opacity(0.8)
                      .width('100%')
                      .padding({ top: 12, bottom: 12 })
                      .backgroundColor(ST_PRIMARY)
                      .borderRadius(16)
                  }
                  .onClick(() => { this.focusNote = 'Blend high and low tones before next critique' })
                }
                .alignItems(HorizontalAlign.Start)
                .padding(12)
              }
            }
            .alignItems(VerticalAlign.Top)
            .padding({ left: 16, right: 16 })

            Blank().height(100)
          }
          .padding({ top: 12 })
        }
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      // Bottom Bar
      Column() {
        Blank()
        Row() {
          Column({ space: 4 }) {
            Text('Next checkpoint')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(ST_ON_SURFACE)
            Text('12:40 Studio')
              .fontSize(14)
              .fontWeight(FontWeight.Regular)
              .fontColor(ST_ON_SURFACE)
              .opacity(0.8)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button() {
            Text('Launch session')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#B3000000') // Color.black.opacity(0.7)
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })
              .backgroundColor(ST_PRIMARY)
              .borderRadius(16)
          }
          .onClick(() => {})
        }
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .backgroundColor(ST_SURFACE)
        .shadow({ radius: 4, color: '#1A000000', offsetY: -2 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ST_BACKGROUND)
  }
}

// MARK: - Components

@Component
struct ModuleCard {
  module: StudyModule = new StudyModule('', '', 0, '')

  build() {
    CardView({ backgroundColor: ST_SURFACE }) {
      Column({ space: 8 }) {
        Text(this.module.name)
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(ST_ON_SURFACE)

        Text(this.module.summary)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(ST_ON_SURFACE)
          .opacity(0.8)

        Divider()
          .color(ST_OUTLINE)
          .margin({ top: 4, bottom: 4 })

        Row() {
          Text('Progress')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(ST_ON_SURFACE)
          Blank()
          Text(this.module.progress.toString() + '%')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(ST_PRIMARY)
        }

        Progress({ value: this.module.progress, total: 100, type: ProgressType.Linear })
          .color(ST_PRIMARY)
          .backgroundColor(ST_SURFACE_VARIANT)
          .height(12)
          .borderRadius(12)

        Blank().height(8)

        Button() {
          Text('Review outline')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B3000000') // Color.black.opacity(0.7)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(ST_PRIMARY)
            .borderRadius(16)
        }
        .onClick(() => {})
      }
      .alignItems(HorizontalAlign.Start)
      .padding(16)
    }
  }
}

@Component
struct CardView {
  @Prop backgroundColor: string = ''
  @BuilderParam content: () => void = this.defaultContent

  @Builder
  defaultContent() {
  }

  build() {
    Column() {
      this.content()
    }
    .backgroundColor(this.backgroundColor)
    .borderRadius(20)
    .shadow({ radius: 4, color: '#0D000000', offsetY: 2 })
  }
}
