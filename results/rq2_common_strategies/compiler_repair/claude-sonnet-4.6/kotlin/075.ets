import { curves } from '@kit.ArkUI'

interface StudyModule {
  name: string
  progress: number
  summary: string
}

interface TaskItem {
  title: string
  duration: string
}

const primaryColor = '#C08552'
const secondaryColor = '#9BB1C8'
const tertiaryColor = '#E6CFAF'
const backgroundColor = '#F3EFE6'
const surfaceColor = '#FFFFFF'
const surfaceVariantColor = '#E7DDCF'
const outlineColor = '#D4C5B6'
const onSurfaceColor = '#2E251D'
const onPrimaryColor = '#2A1C13'

const modules: StudyModule[] = [
  { name: 'Clay Resonance', progress: 72, summary: 'Acoustic prototypes' },
  { name: 'Material Memory', progress: 54, summary: 'Tactile journaling' },
  { name: 'Morph Lab', progress: 83, summary: 'Color blending' },
  { name: 'Studio Review', progress: 28, summary: 'Peer critique' }
]

const tasks: TaskItem[] = [
  { title: 'Research layering', duration: '45m' },
  { title: 'Feedback sync', duration: '30m' },
  { title: 'Practice recall', duration: '20m' }
]

@Entry
@Component
struct RootScreen {
  @State currentPage: number = 0
  @State focusNote: string = 'Focus on tone shifts across clay gradients'

  build() {
    Column() {
      // Top App Bar
      Row() {
        Button('Back')
          .fontSize(12)
          .fontColor(onSurfaceColor)
          .backgroundColor(Color.Transparent)
          .height(40)

        Text('Study Focus Split')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(onSurfaceColor)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button('Share')
          .fontSize(12)
          .fontColor(secondaryColor)
          .backgroundColor(Color.Transparent)
          .height(40)
      }
      .width('100%')
      .height(56)
      .padding({ left: 8, right: 8 })
      .backgroundColor(surfaceColor)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Main scrollable content
      Scroll() {
        Column() {
          // Tab Row
          Row() {
            ForEach(modules, (module: StudyModule, index: number) => {
              Column() {
                Text(module.name)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.currentPage === index ? primaryColor : onSurfaceColor)
                  .padding({ top: 12, bottom: 8 })

                Divider()
                  .strokeWidth(this.currentPage === index ? 2 : 0)
                  .color(primaryColor)
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Center)
              .onClick(() => {
                this.currentPage = index
              })
            })
          }
          .width('100%')
          .backgroundColor(surfaceColor)
          .margin({ bottom: 16 })

          // Pager content (show current page card)
          Column() {
            ForEach(modules, (module: StudyModule, index: number) => {
              if (index === this.currentPage) {
                Column() {
                  Column({ space: 8 }) {
                    Text(module.name)
                      .fontSize(22)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(onSurfaceColor)

                    Text(module.summary)
                      .fontSize(14)
                      .fontColor(onSurfaceColor)
                      .opacity(0.8)

                    Divider()
                      .color(outlineColor)
                      .strokeWidth(1)

                    Row() {
                      Text('Progress')
                        .fontSize(12)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(onSurfaceColor)

                      Text(`${module.progress}%`)
                        .fontSize(18)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(primaryColor)
                    }
                    .width('100%')
                    .justifyContent(FlexAlign.SpaceBetween)

                    // Progress bar
                    Stack({ alignContent: Alignment.Start }) {
                      Row()
                        .width('100%')
                        .height(12)
                        .backgroundColor(surfaceVariantColor)
                        .borderRadius(12)

                      Row()
                        .width(`${module.progress}%`)
                        .height(12)
                        .backgroundColor(primaryColor)
                        .borderRadius(12)
                    }
                    .width('100%')
                    .height(12)

                    Button('Review outline')
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .backgroundColor(primaryColor)
                      .fontColor(onPrimaryColor)
                      .borderRadius(16)
                      .height(40)
                  }
                  .padding(16)
                  .width('100%')
                }
                .width('100%')
                .backgroundColor(surfaceColor)
                .borderRadius(20)
                .shadow({ radius: 6, color: '#1A000000', offsetY: 2 })
              }
            })
          }
          .width('100%')
          .height(220)
          .margin({ bottom: 16 })

          // Split pane row
          Row({ space: 12 }) {
            // Focus board
            Column({ space: 8 }) {
              Text('Focus board')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(onSurfaceColor)

              ForEach(tasks, (task: TaskItem) => {
                Column({ space: 4 }) {
                  Text(task.title)
                    .fontSize(14)
                    .fontColor(onSurfaceColor)

                  Text(task.duration)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(secondaryColor)
                }
                .width('100%')
                .padding(8)
                .backgroundColor(surfaceVariantColor)
                .borderRadius(12)
                .alignItems(HorizontalAlign.Start)
              })

              Button('Add checkpoint')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .backgroundColor(primaryColor)
                .fontColor(onPrimaryColor)
                .borderRadius(16)
                .height(40)
                .width('100%')
            }
            .padding(12)
            .layoutWeight(1)
            .backgroundColor(surfaceColor)
            .borderRadius(20)
            .alignItems(HorizontalAlign.Start)
            .shadow({ radius: 6, color: '#1A000000', offsetY: 2 })

            // Reflection
            Column({ space: 8 }) {
              Text('Reflection')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(onSurfaceColor)

              Column() {
                Text(this.focusNote)
                  .fontSize(14)
                  .fontColor(onSurfaceColor)
                  .padding(12)
                  .width('100%')
              }
              .width('100%')
              .backgroundColor(surfaceColor)
              .borderRadius(16)

              Button('Shuffle note')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .backgroundColor(primaryColor)
                .fontColor(onPrimaryColor)
                .borderRadius(16)
                .height(40)
                .width('100%')
                .onClick(() => {
                  this.focusNote = 'Blend high and low tones before next critique'
                })
            }
            .padding(12)
            .layoutWeight(1)
            .backgroundColor(surfaceVariantColor)
            .borderRadius(20)
            .alignItems(HorizontalAlign.Start)
            .shadow({ radius: 6, color: '#1A000000', offsetY: 2 })
          }
          .width('100%')
          .alignItems(VerticalAlign.Top)
          .margin({ bottom: 16 })
        }
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(backgroundColor)

      // Bottom bar
      Row() {
        Column({ space: 4 }) {
          Text('Next checkpoint')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(onSurfaceColor)

          Text('12:40 Studio')
            .fontSize(14)
            .fontColor(onSurfaceColor)
            .opacity(0.8)
        }
        .alignItems(HorizontalAlign.Start)

        Button('Launch session')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(primaryColor)
          .fontColor(onPrimaryColor)
          .borderRadius(16)
          .height(44)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(surfaceColor)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .shadow({ radius: 10, color: '#29000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(backgroundColor)
  }
}