import { router } from '@kit.ArkUI'

interface StudyModule {
  name: string
  progress: number
  summary: string
}

interface TaskItem {
  title: string
  duration: string
}

const colorPrimary = '#C08552'
const colorSecondary = '#9BB1C8'
const colorTertiary = '#E6CFAF'
const colorBackground = '#F3EFE6'
const colorSurface = '#FFFFFF'
const colorSurfaceVariant = '#E7DDCF'
const colorOutline = '#D4C5B6'
const colorOnSurface = '#2E251D'
const colorOnSecondary = '#15202B'

@Entry
@Component
struct Index {
  @State selectedTab: number = 0
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
    Column() {
      // Top App Bar
      Row() {
        Text('Back')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(colorOnSurface)
          .padding({ left: 16, right: 8, top: 8, bottom: 8 })

        Text('Study Focus Split')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(colorOnSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Share')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(colorSecondary)
          .padding({ left: 8, right: 16, top: 8, bottom: 8 })
      }
      .width('100%')
      .height(56)
      .backgroundColor(colorSurface)
      .alignItems(VerticalAlign.Center)

      // Main Content
      Scroll() {
        Column({ space: 16 }) {
          // Tab Row
          Row() {
            ForEach(this.modules, (module: StudyModule, index: number) => {
              Column() {
                Text(module.name)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedTab === index ? colorPrimary : colorOnSurface)
                  .textAlign(TextAlign.Center)
                  .padding({ top: 12, bottom: 8, left: 4, right: 4 })
                  .maxLines(2)

                Divider()
                  .height(2)
                  .backgroundColor(this.selectedTab === index ? colorPrimary : 'transparent')
              }
              .layoutWeight(1)
              .onClick(() => {
                this.selectedTab = index
              })
            })
          }
          .width('100%')
          .backgroundColor(colorSurface)
          .borderRadius(0)

          // Pager Card
          Column() {
            Column({ space: 8 }) {
              Text(this.modules[this.selectedTab].name)
                .fontSize(22)
                .fontWeight(FontWeight.Medium)
                .fontColor(colorOnSurface)

              Text(this.modules[this.selectedTab].summary)
                .fontSize(14)
                .fontColor(colorOnSurface)
                .opacity(0.8)

              Divider()
                .height(1)
                .backgroundColor(colorOutline)

              Row() {
                Text('Progress')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(colorOnSurface)

                Text(`${this.modules[this.selectedTab].progress}%`)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(colorPrimary)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)

              // Progress Bar
              Stack({ alignContent: Alignment.Start }) {
                Row()
                  .width('100%')
                  .height(12)
                  .backgroundColor(colorSurfaceVariant)
                  .borderRadius(12)

                Row()
                  .width(`${this.modules[this.selectedTab].progress}%`)
                  .height(12)
                  .backgroundColor(colorPrimary)
                  .borderRadius(12)
              }
              .width('100%')
              .height(12)

              Button('Review outline')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .backgroundColor(colorPrimary)
                .fontColor(colorOnSurface)
                .borderRadius(16)
                .height(40)
            }
            .padding(16)
            .width('100%')
          }
          .width('100%')
          .backgroundColor(colorSurface)
          .borderRadius(20)
          .shadow({ radius: 6, color: '#1F000000', offsetY: 2 })

          // Split Pane Row
          Row({ space: 12 }) {
            // Focus Board
            Column({ space: 8 }) {
              Text('Focus board')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(colorOnSurface)

              ForEach(this.tasks, (task: TaskItem) => {
                Column({ space: 4 }) {
                  Text(task.title)
                    .fontSize(14)
                    .fontColor(colorOnSurface)

                  Text(task.duration)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(colorSecondary)
                }
                .width('100%')
                .padding(8)
                .backgroundColor(colorSurfaceVariant)
                .borderRadius(12)
                .alignItems(HorizontalAlign.Start)
              })

              Button('Add checkpoint')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .backgroundColor(colorPrimary)
                .fontColor(colorOnSurface)
                .borderRadius(16)
                .height(40)
                .width('100%')
            }
            .padding(12)
            .layoutWeight(1)
            .backgroundColor(colorSurface)
            .borderRadius(20)
            .alignItems(HorizontalAlign.Start)
            .shadow({ radius: 6, color: '#1F000000', offsetY: 2 })

            // Reflection
            Column({ space: 8 }) {
              Text('Reflection')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(colorOnSurface)

              Column() {
                Text(this.focusNote)
                  .fontSize(14)
                  .fontColor(colorOnSurface)
                  .padding(12)
                  .width('100%')
              }
              .width('100%')
              .backgroundColor(colorSurface)
              .borderRadius(16)

              Button('Shuffle note')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .backgroundColor(colorPrimary)
                .fontColor(colorOnSurface)
                .borderRadius(16)
                .height(40)
                .width('100%')
                .onClick(() => {
                  this.focusNote = 'Blend high and low tones before next critique'
                })
            }
            .padding(12)
            .layoutWeight(1)
            .backgroundColor(colorSurfaceVariant)
            .borderRadius(20)
            .alignItems(HorizontalAlign.Start)
            .shadow({ radius: 6, color: '#1F000000', offsetY: 2 })
          }
          .width('100%')
          .alignItems(VerticalAlign.Top)
        }
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor(colorBackground)

      // Bottom Bar
      Row() {
        Column({ space: 4 }) {
          Text('Next checkpoint')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(colorOnSurface)

          Text('12:40 Studio')
            .fontSize(14)
            .fontColor(colorOnSurface)
            .opacity(0.8)
        }
        .alignItems(HorizontalAlign.Start)

        Button('Launch session')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(colorPrimary)
          .fontColor(colorOnSurface)
          .borderRadius(16)
          .height(44)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(colorSurface)
      .shadow({ radius: 10, color: '#29000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(colorBackground)
  }
}