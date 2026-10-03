// App Tokens
const primaryColor: string = '#C08552';
const secondaryColor: string = '#9BB1C8';
const tertiaryColor: string = '#E6CFAF';
const backgroundColor: string = '#F3EFE6';
const surfaceColor: string = '#FFFFFF';
const surfaceVariantColor: string = '#E7DDCF';
const outlineColor: string = '#D4C5B6';
const successColor: string = '#6BB187';
const warningColor: string = '#E2A458';
const errorColor: string = '#D66B5D';
const onPrimaryColor: string = '#2A1C13';
const onSecondaryColor: string = '#15202B';
const onTertiaryColor: string = '#2C1F10';
const onBackgroundColor: string = '#261E19';
const onSurfaceColor: string = '#2E251D';

const spacingXs: number = 4;
const spacingSm: number = 8;
const spacingMd: number = 12;
const spacingLg: number = 16;
const spacingXl: number = 24;
const spacingXxl: number = 32;
const spacingXxxl: number = 48;

const shapeSmall: number = 12;
const shapeMedium: number = 16;
const shapeLarge: number = 20;

class StudyModule {
  id: number = 0;
  name: string = '';
  progress: number = 0;
  summary: string = '';
}

class TaskItem {
  id: number = 0;
  title: string = '';
  duration: string = '';
}

const modulesList: StudyModule[] = [
  { id: 0, name: 'Clay Resonance', progress: 72, summary: 'Acoustic prototypes' },
  { id: 1, name: 'Material Memory', progress: 54, summary: 'Tactile journaling' },
  { id: 2, name: 'Morph Lab', progress: 83, summary: 'Color blending' },
  { id: 3, name: 'Studio Review', progress: 28, summary: 'Peer critique' },
];

const tasksList: TaskItem[] = [
  { id: 0, title: 'Research layering', duration: '45m' },
  { id: 1, title: 'Feedback sync', duration: '30m' },
  { id: 2, title: 'Practice recall', duration: '20m' },
];

@Component
struct ModuleCard {
  module: StudyModule = new StudyModule();

  build() {
    Column({ space: spacingSm }) {
      Text(this.module.name)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(onSurfaceColor)
        .width('100%')

      Text(this.module.summary)
        .fontSize(14)
        .fontColor(onSurfaceColor)
        .opacity(0.8)
        .width('100%')

      Divider()
        .color(outlineColor)
        .margin({ top: 4, bottom: 4 })

      Row() {
        Text('Progress')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(onSurfaceColor)
        Blank()
        Text(`${this.module.progress}%`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(primaryColor)
      }
      .width('100%')

      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width('100%')
          .height(12)
          .borderRadius(shapeSmall)
          .backgroundColor(surfaceVariantColor)

        Row()
          .width(`${this.module.progress}%`)
          .height(12)
          .borderRadius(shapeSmall)
          .backgroundColor(primaryColor)
      }
      .width('100%')
      .height(12)

      Button('Review outline')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(onPrimaryColor)
        .backgroundColor(primaryColor)
        .borderRadius(shapeMedium)
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        .margin({ top: 8 })
    }
    .padding(spacingLg)
    .backgroundColor(surfaceColor)
    .borderRadius(shapeLarge)
    .shadow({ radius: 4, color: '#0D000000', offsetX: 0, offsetY: 2 })
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Entry
@Component
struct StudyFocusSplitScreen {
  @State selectedTabIndex: number = 0;
  @State focusNote: string = 'Focus on tone shifts across clay gradients';
  private swiperController: SwiperController = new SwiperController();

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Bar
        Row() {
          Button('Back')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(onSurfaceColor)
            .backgroundColor(surfaceColor)
            .padding(0)

          Blank()

          Text('Study Focus Split')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(onSurfaceColor)

          Blank()

          Button('Share')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(secondaryColor)
            .backgroundColor(surfaceColor)
            .padding(0)
        }
        .width('100%')
        .padding(spacingLg)
        .backgroundColor(surfaceColor)

        // Scrollable Content
        Scroll() {
          Column({ space: spacingLg }) {

            // Tab Row
            Scroll() {
              Row({ space: 0 }) {
                ForEach(modulesList, (item: StudyModule, index: number) => {
                  Column({ space: 8 }) {
                    Text(item.name.replace(' ', '\n'))
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(this.selectedTabIndex === index ? primaryColor : onSurfaceColor)
                      .textAlign(TextAlign.Center)
                      .maxLines(2)
                      .height(40)

                    Row()
                      .width('100%')
                      .height(2)
                      .backgroundColor(this.selectedTabIndex === index ? primaryColor : 'transparent')
                  }
                  .width(90)
                  .padding({ top: 8, bottom: 8 })
                  .onClick(() => {
                    this.selectedTabIndex = index;
                    this.swiperController.changeIndex(index, true);
                  })
                })
              }
              .padding({ left: spacingLg, right: spacingLg })
              .backgroundColor(surfaceColor)
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            // Swiper / Pager
            Swiper(this.swiperController) {
              ForEach(modulesList, (item: StudyModule) => {
                ModuleCard({ module: item })
                  .padding({ left: spacingLg, right: spacingLg })
              })
            }
            .index(this.selectedTabIndex)
            .indicator(false)
            .loop(false)
            .height(240)
            .onChange((index: number) => {
              this.selectedTabIndex = index;
            })

            // Dual Pane
            Row({ space: spacingMd }) {
              // Left Pane: Focus Board
              Column({ space: spacingSm }) {
                Text('Focus board')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(onSurfaceColor)
                  .width('100%')

                ForEach(tasksList, (task: TaskItem) => {
                  Row() {
                    Column({ space: spacingXs }) {
                      Text(task.title)
                        .fontSize(14)
                        .fontColor(onSurfaceColor)
                        .width('100%')
                      Text(task.duration)
                        .fontSize(12)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(secondaryColor)
                        .width('100%')
                    }
                    .alignItems(HorizontalAlign.Start)

                    Blank()
                  }
                  .width('100%')
                  .padding(spacingSm)
                  .backgroundColor(surfaceVariantColor)
                  .opacity(0.9)
                  .borderRadius(shapeSmall)
                })
              }
              .padding(spacingMd)
              .backgroundColor(surfaceColor)
              .borderRadius(shapeLarge)
              .shadow({ radius: 4, color: '#0D000000', offsetX: 0, offsetY: 2 })
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              // Right Pane: Reflection
              Column({ space: spacingSm }) {
                Text('Reflection')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(onSurfaceColor)
                  .width('100%')

                Text(this.focusNote)
                  .fontSize(14)
                  .fontColor(onSurfaceColor)
                  .padding(spacingMd)
                  .width('100%')
                  .backgroundColor(surfaceColor)
                  .borderRadius(shapeMedium)
                  .textAlign(TextAlign.Start)

                Button('Shuffle note')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(onPrimaryColor)
                  .backgroundColor(primaryColor)
                  .borderRadius(shapeMedium)
                  .width('100%')
                  .padding({ top: 12, bottom: 12 })
                  .onClick(() => {
                    this.focusNote = 'Blend high and low tones before next critique';
                  })
              }
              .padding(spacingMd)
              .backgroundColor(surfaceVariantColor)
              .borderRadius(shapeLarge)
              .shadow({ radius: 4, color: '#0D000000', offsetX: 0, offsetY: 2 })
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
            }
            .padding({ left: spacingLg, right: spacingLg })
            .alignItems(VerticalAlign.Top)
            .width('100%')

            // Bottom spacer
            Row().height(100)
          }
          .padding({ top: spacingMd })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .backgroundColor(backgroundColor)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(backgroundColor)

      // Bottom Bar
      Row() {
        Column({ space: spacingXs }) {
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

        Blank()

        Button('Launch session')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(onPrimaryColor)
          .backgroundColor(primaryColor)
          .borderRadius(shapeMedium)
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      }
      .width('100%')
      .padding({ left: spacingLg, right: spacingLg, top: spacingSm, bottom: spacingSm })
      .backgroundColor(surfaceColor)
      .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
  }
}