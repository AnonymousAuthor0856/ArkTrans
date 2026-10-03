@Entry
@Component
struct StudyFocusApp {
  @State selectedTabIndex: number = 0
  @State focusNote: string = 'Focus on tone shifts across clay gradients'

  private modules: StudyModule[] = [
    { name: 'Clay Resonance', progress: 72, summary: 'Acoustic prototypes' },
    { name: 'Material Memory', progress: 54, summary: 'Tactile journaling' },
    { name: 'Morph Lab', progress: 83, summary: 'Color blending' },
    { name: 'Studio Review', progress: 28, summary: 'Peer critique' }
  ]

  private tasks: TaskItem[] = [
    { title: 'Research layering', duration: '45m' },
    { title: 'Feedback sync', duration: '30m' },
    { title: 'Practice recall', duration: '20m' }
  ]

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F3EFE6')

      // Main content column
      Column({ space: 0 }) {
        // Top bar
        Row({ space: 0 }) {
          Button() {
            Text('Back')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#2E251D')
          }
          Blank()
          Text('Study Focus Split')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#2E251D')
          Blank()
          Button() {
            Text('Share')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#9BB1C8')
          }
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFF')

        // Content (simulating ScrollView with List)
        List({ space: 16 }) {
          // Tab row (horizontal)
          ListItem() {
            Row({ space: 0 }) {
              ForEach(this.modules, (mod: StudyModule, index: number) => {
                Column({ space: 8 }) {
                  Text(mod.name.replace(/\s+/g, '\n'))
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor(this.selectedTabIndex === index ? '#C08552' : '#2E251D')
                    .textAlign(TextAlign.Center)
                    .height(40)
                    .maxLines(2)
                  Divider()
                    .height(this.selectedTabIndex === index ? 2 : 0)
                    .color('#C08552')
                }
                .width(90)
                .padding({ top: 8, bottom: 8 })
                .onClick(() => {
                  this.selectedTabIndex = index
                })
              })
            }
            .width('100%')
            .padding({ left: 16, right: 16 })
            .backgroundColor('#FFFFFF')
          }

          // Module card (based on selected tab)
          ListItem() {
            this.buildModuleCard(this.modules[this.selectedTabIndex])
          }

          // Dual pane: Focus board and Reflection
          ListItem() {
            Row({ space: 12 }) {
              // Left: Focus board
              Column({ space: 8 }) {
                Text('Focus board')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#2E251D')

                ForEach(this.tasks, (task: TaskItem) => {
                  Row({ space: 0 }) {
                    Column({ space: 4 }) {
                      Text(task.title)
                        .fontSize(14)
                        .foregroundColor('#2E251D')
                      Text(task.duration)
                        .fontSize(12)
                        .fontWeight(FontWeight.Medium)
                        .foregroundColor('#9BB1C8')
                    }
                    .alignItems(HorizontalAlign.Start)
                    Blank()
                  }
                  .padding(8)
                  .backgroundColor('#E7DDCF')
                  .borderRadius(12)
                })
              }
              .padding(12)
              .backgroundColor('#FFFFFF')
              .borderRadius(20)
              .shadow({ radius: 4, color: '#0D000000', offsetY: 2 })
              .layoutWeight(1)

              // Right: Reflection
              Column({ space: 8 }) {
                Text('Reflection')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#2E251D')

                Text(this.focusNote)
                  .fontSize(14)
                  .foregroundColor('#2E251D')
                  .padding(12)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(16)
                  .width('100%')

                Button() {
                  Text('Shuffle note')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#2A1C13')
                    .width('100%')
                    .height(40)
                    .textAlign(TextAlign.Center)
                }
                .width('100%')
                .height(40)
                .backgroundColor('#C08552')
                .borderRadius(16)
                .onClick(() => {
                  this.focusNote = 'Blend high and low tones before next critique'
                })
              }
              .padding(12)
              .backgroundColor('#E7DDCF')
              .borderRadius(20)
              .shadow({ radius: 4, color: '#0D000000', offsetY: 2 })
              .layoutWeight(1)
            }
            .width('100%')
            .padding({ left: 16, right: 16 })
          }

          // Spacer to allow bottom bar
          ListItem() {
            Column()
              .height(100)
              .width('100%')
          }
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ top: 12 })
      }
      .width('100%')
      .height('100%')

      // Bottom bar (overlay using Stack alignment)
      Column() {
        Blank()
        Row({ space: 0 }) {
          Column({ space: 4 }) {
            Text('Next checkpoint')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#2E251D')
            Text('12:40 Studio')
              .fontSize(14)
              .foregroundColor('#2E251D')
              .opacity(0.8)
          }
          .alignItems(HorizontalAlign.Start)
          Blank()
          Button() {
            Text('Launch session')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#2A1C13')
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          }
          .backgroundColor('#C08552')
          .borderRadius(16)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 4, color: '#1A000000', offsetY: -2 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildModuleCard(module: StudyModule) {
    Column({ space: 8 }) {
      Text(module.name)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .foregroundColor('#2E251D')
      Text(module.summary)
        .fontSize(14)
        .foregroundColor('#2E251D')
        .opacity(0.8)

      Divider()
        .color('#D4C5B6')
        .margin({ top: 4, bottom: 4 })

      Row({ space: 0 }) {
        Text('Progress')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#2E251D')
        Blank()
        Text(module.progress + '%')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#C08552')
      }
      .width('100%')

      Progress({ value: module.progress / 100, total: 1, type: ProgressType.Linear })
        .height(12)
        .color('#C08552')
        .backgroundColor('#E7DDCF')
        .borderRadius(12)

      Blank().height(8)

      Button() {
        Text('Review outline')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#2A1C13')
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      }
      .backgroundColor('#C08552')
      .borderRadius(16)
    }
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 4, color: '#0D000000', offsetY: 2 })
    .margin({ left: 16, right: 16 })
  }
}

interface StudyModule {
  name: string
  progress: number
  summary: string
}

interface TaskItem {
  title: string
  duration: string
}