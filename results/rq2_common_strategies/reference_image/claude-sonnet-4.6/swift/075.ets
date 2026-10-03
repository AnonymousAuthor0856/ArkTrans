/**
 * StudyFocusSplit.ets
 * SwiftUI -> ArkTS conversion of the "Study Focus Split" screen.
 */

/* ------------------------- Design tokens ------------------------- */

const C_PRIMARY: string = '#C08552'
const C_SECONDARY: string = '#9BB1C8'
const C_TERTIARY: string = '#E6CFAF'
const C_BACKGROUND: string = '#F3EFE6'
const C_SURFACE: string = '#FFFFFF'
const C_SURFACE_VARIANT: string = '#E7DDCF'
const C_SURFACE_VARIANT_60: string = '#99E7DDCF'
const C_OUTLINE: string = '#D4C5B6'
const C_ON_SURFACE: string = '#2E251D'
const C_ON_SURFACE_80: string = '#CC2E251D'
const C_ON_PRIMARY: string = '#B32A1C13'
const C_BAR_SHADOW: string = '#1A000000'
const C_CARD_SHADOW: string = '#0D000000'
const C_TRANSPARENT: string = '#00000000'

const SP_XS: number = 4
const SP_SM: number = 8
const SP_MD: number = 12
const SP_LG: number = 16
const SP_XL: number = 24

const R_SMALL: number = 12
const R_MEDIUM: number = 16
const R_LARGE: number = 20

/* ---------------------------- Models ----------------------------- */

class StudyModule {
  name: string
  progress: number
  summary: string

  constructor(name: string, progress: number, summary: string) {
    this.name = name
    this.progress = progress
    this.summary = summary
  }
}

class TaskItem {
  title: string
  duration: string

  constructor(title: string, duration: string) {
    this.title = title
    this.duration = duration
  }
}

/* -------------------------- Components --------------------------- */

@Component
struct CardView {
  bgColor: string = C_SURFACE
  @BuilderParam content: () => void

  build() {
    Column() {
      this.content()
    }
    .width('100%')
    .backgroundColor(this.bgColor)
    .borderRadius(R_LARGE)
    .shadow({ radius: 4, color: C_CARD_SHADOW, offsetX: 0, offsetY: 2 })
  }
}

@Component
struct ModuleCard {
  module: StudyModule = new StudyModule('', 0, '')

  build() {
    CardView({ bgColor: C_SURFACE }) {
      Column({ space: SP_SM }) {
        Text(this.module.name)
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)
          .width('100%')

        Text(this.module.summary)
          .fontSize(14)
          .fontColor(C_ON_SURFACE_80)
          .width('100%')

        Divider()
          .strokeWidth(1)
          .color(C_OUTLINE)
          .margin({ top: SP_XS, bottom: SP_XS })

        Row() {
          Text('Progress')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(C_ON_SURFACE)
          Blank()
          Text(`${this.module.progress}%`)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(C_PRIMARY)
        }
        .width('100%')

        Stack({ alignContent: Alignment.Start }) {
          Column()
            .width('100%')
            .height(12)
            .borderRadius(R_SMALL)
            .backgroundColor(C_SURFACE_VARIANT)
          Column()
            .width(`${this.module.progress}%`)
            .height(12)
            .borderRadius(R_SMALL)
            .backgroundColor(C_PRIMARY)
        }
        .width('100%')
        .height(12)

        Text('Review outline')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_PRIMARY)
          .textAlign(TextAlign.Center)
          .padding({ left: SP_XL, right: SP_XL, top: SP_MD, bottom: SP_MD })
          .backgroundColor(C_PRIMARY)
          .borderRadius(R_MEDIUM)
          .margin({ top: SP_SM })
          .onClick(() => {
          })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding(SP_LG)
    }
  }
}

/* -------------------------- Entry page --------------------------- */

@Entry
@Component
struct StudyFocusSplitScreen {
  @State selectedTabIndex: number = 0
  @State focusNote: string = 'Focus on tone shifts across clay gradients'

  private modules: StudyModule[] = [
    new StudyModule('Clay Resonance', 72, 'Acoustic prototypes'),
    new StudyModule('Material Memory', 54, 'Tactile journaling'),
    new StudyModule('Morph Lab', 83, 'Color blending'),
    new StudyModule('Studio Review', 28, 'Peer critique')
  ]

  private tasks: TaskItem[] = [
    new TaskItem('Research layering', '45m'),
    new TaskItem('Feedback sync', '30m'),
    new TaskItem('Practice recall', '20m')
  ]

  @Builder
  TopBar() {
    Row() {
      Text('Back')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(C_ON_SURFACE)
        .textAlign(TextAlign.Start)
        .layoutWeight(1)

      Text('Study Focus Split')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(C_ON_SURFACE)

      Text('Share')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(C_SECONDARY)
        .textAlign(TextAlign.End)
        .layoutWeight(1)
    }
    .width('100%')
    .padding(SP_LG)
    .backgroundColor(C_SURFACE)
  }

  @Builder
  TabRow() {
    Row() {
      ForEach(this.modules, (item: StudyModule, index: number) => {
        Column() {
          Text(item.name.split(' ').join('\n'))
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedTabIndex === index ? C_PRIMARY : C_ON_SURFACE)
            .textAlign(TextAlign.Center)
            .maxLines(2)
            .height(40)
            .width('100%')

          Column()
            .width('100%')
            .height(2)
            .backgroundColor(this.selectedTabIndex === index ? C_PRIMARY : C_TRANSPARENT)
        }
        .justifyContent(FlexAlign.Center)
        .width('25%')
        .padding({ top: SP_SM, bottom: SP_SM })
        .onClick(() => {
          animateTo({ duration: 200, curve: Curve.EaseInOut }, () => {
            this.selectedTabIndex = index
          })
        })
      }, (item: StudyModule) => item.name)
    }
    .width('100%')
    .padding({ left: SP_LG, right: SP_LG })
    .backgroundColor(C_SURFACE)
  }

  @Builder
  FocusBoardCard() {
    CardView({ bgColor: C_SURFACE }) {
      Column({ space: SP_SM }) {
        Text('Focus board')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)

        ForEach(this.tasks, (task: TaskItem) => {
          Column({ space: SP_XS }) {
            Text(task.title)
              .fontSize(14)
              .fontColor(C_ON_SURFACE)
            Text(task.duration)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(C_SECONDARY)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding(SP_SM)
          .backgroundColor(C_SURFACE_VARIANT_60)
          .borderRadius(R_SMALL)
        }, (task: TaskItem) => task.title)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding(SP_MD)
    }
  }

  @Builder
  ReflectionCard() {
    CardView({ bgColor: C_SURFACE_VARIANT }) {
      Column({ space: SP_SM }) {
        Text('Reflection')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)

        Text(this.focusNote)
          .fontSize(14)
          .fontColor(C_ON_SURFACE)
          .textAlign(TextAlign.Start)
          .padding(SP_MD)
          .width('100%')
          .backgroundColor(C_SURFACE)
          .borderRadius(R_MEDIUM)

        Text('Shuffle note')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_PRIMARY)
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: SP_MD, bottom: SP_MD })
          .backgroundColor(C_PRIMARY)
          .borderRadius(R_MEDIUM)
          .onClick(() => {
            this.focusNote = 'Blend high and low tones before next critique'
          })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding(SP_MD)
    }
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: SP_XS }) {
        Text('Next checkpoint')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)
        Text('12:40 Studio')
          .fontSize(14)
          .fontColor(C_ON_SURFACE_80)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('Launch session')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(C_ON_PRIMARY)
        .textAlign(TextAlign.Center)
        .padding({ left: SP_XL, right: SP_XL, top: SP_MD, bottom: SP_MD })
        .backgroundColor(C_PRIMARY)
        .borderRadius(R_MEDIUM)
        .onClick(() => {
        })
    }
    .width('100%')
    .padding({ left: SP_LG, right: SP_LG, top: SP_SM, bottom: SP_SM })
    .backgroundColor(C_SURFACE)
    .shadow({ radius: 4, color: C_BAR_SHADOW, offsetX: 0, offsetY: -2 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()

        Scroll() {
          Column({ space: SP_LG }) {
            // Tab row
            this.TabRow()

            // Pager
            Swiper() {
              ForEach(this.modules, (item: StudyModule) => {
                Column() {
                  ModuleCard({ module: item })
                }
                .width('100%')
                .padding({ left: SP_LG, right: SP_LG })
              }, (item: StudyModule) => item.name)
            }
            .index(this.selectedTabIndex)
            .onChange((index: number) => {
              this.selectedTabIndex = index
            })
            .indicator(false)
            .loop(false)
            .width('100%')
            .height(220)

            // Dual pane
            Row({ space: SP_MD }) {
              Column() {
                this.FocusBoardCard()
              }
              .layoutWeight(1)

              Column() {
                this.ReflectionCard()
              }
              .layoutWeight(1)
            }
            .alignItems(VerticalAlign.Top)
            .width('100%')
            .padding({ left: SP_LG, right: SP_LG })

            Column().height(100)
          }
          .width('100%')
          .padding({ top: SP_MD })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(C_BACKGROUND)
  }
}