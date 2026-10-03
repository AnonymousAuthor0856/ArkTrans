import { Alignment, HorizontalAlign, VerticalAlign } from '@kit.ArkUI'

interface Task {
  title: string;
  duration: string;
}

@Entry
@Component
struct Index {
  @State currentPage: number = 0
  @State focusNote: string = 'Focus on tone shifts across clay gradients'

  private modules: string[] = ['Clay Resonance', 'Material Memory', 'Morph Lab', 'Studio Review']
  
  private tasks: Array<Task> = [
    { title: 'Research layering', duration: '45m' },
    { title: 'Feedback sync', duration: '30m' },
    { title: 'Practice recall', duration: '20m' }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Main Scrollable Content ===
      Column() {
        // === TabRow ===
        Row() {
          ForEach(this.modules, (module: string, index: number) => {
            Text(module)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.currentPage === index ? '#C08552' : '#2E251D')
              .textAlign(TextAlign.Center)
              .layoutWeight(1)
              .onClick(() => {
                this.currentPage = index
              })
          })
        }
        .width('100%')
        .height(70)
        .backgroundColor('#FFFFFF')
        .borderWidth({ bottom: 1 })
        .borderColor({ bottom: '#E0E0E0' })

        // === HorizontalPager Area (Simulated with conditional rendering) ===
        Column() {
          // === Card ===
          Column() {
            Column({ space: 12 }) {
              // Title
              Text(this.modules[this.currentPage])
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .fontColor('#2E251D')

              // Summary
              Text('Acoustic prototypes')
                .fontSize(16)
                .fontColor('#2E251D')
                .opacity(0.7)

              Divider().color('#D4C5B6').margin({ top: 4, bottom: 4 })

              // Progress Header
              Row() {
                Text('Progress')
                  .fontSize(14)
                  .fontColor('#2E251D')
                Blank()
                Text('72%')
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#C08552')
              }.width('100%')

              // Progress Bar
              Stack({ alignContent: Alignment.Start }) {
                // Background track
                Row()
                  .width('100%')
                  .height(12)
                  .backgroundColor('#E7DDCF')
                  .borderRadius(6)
                
                // Foreground fill
                Row()
                  .width('72%')
                  .height(12)
                  .backgroundColor('#C08552')
                  .borderRadius(6)
              }.width('100%')

              // Button
              Button('Review outline')
                .type(ButtonType.Capsule)
                .backgroundColor('#C08552')
                .fontColor('#FFFFFF')
                .width('100%')
                .height(48)
                .margin({ top: 8 })
            }
            .padding(24)
          }
          .width('100%')
          .backgroundColor('#FFFFFF')
          .borderRadius(24)
          .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
          .margin({ top: 24 })

          // === Bottom Grid (Focus Board & Reflection) ===
          Row({ space: 16 }) {
            // Focus Board Card
            Column() {
              Column({ space: 12 }) {
                Text('Focus board')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#2E251D')
                
                Column({ space: 12 }) {
                  ForEach(this.tasks, (task: Task) => {
                    Column({ space: 4 }) {
                      Text(task.title)
                        .fontSize(16)
                        .fontColor('#2E251D')
                      Text(task.duration)
                        .fontSize(14)
                        .fontColor('#9BB1C8')
                    }
                    .alignItems(HorizontalAlign.Start)
                    .padding(12)
                    .backgroundColor('#F3EFE6')
                    .borderRadius(12)
                    .width('100%')
                  })
                }
              }
              .padding(16)
            }
            .layoutWeight(1)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })

            // Reflection Card
            Column() {
              Column({ space: 12 }) {
                Text('Reflection')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#2E251D')
                
                Column() {
                  Text(this.focusNote)
                    .fontSize(16)
                    .fontColor('#2E251D')
                    .lineHeight(24)
                }
                .width('100%')
                .padding(16)
                .backgroundColor('#FFFFFF')
                .borderRadius(16)
                .flexShrink(1)

                Button('Shuffle note')
                  .type(ButtonType.Capsule)
                  .backgroundColor('#C08552')
                  .fontColor('#FFFFFF')
                  .width('100%')
                  .height(48)
                  .onClick(() => {
                    this.focusNote = "Blend high and low tones before next critique"
                  })
              }
              .padding(16)
            }
            .layoutWeight(1)
            .backgroundColor('#E7DDCF')
            .borderRadius(24)
            .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
          }
          .width('100%')
          .margin({ top: 24 })
          
          // Spacer for bottom bar clearance
          Column().height(100)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F3EFE6')
      .scrollBar(BarState.On)

      // === Top App Bar ===
      Row() {
        Button('Back')
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .fontColor('#2E251D')
          .fontSize(16)
        
        Blank()
        
        Text('Study Focus Split')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E251D')
        
        Blank()
        
        Button('Share')
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .fontColor('#9BB1C8')
          .fontSize(16)
      }
      .width('100%')
      .height(56)
      .padding({ left: 24, right: 24 })
      .backgroundColor('#FFFFFF')
      .position({ x: 0, y: 0 })

      // === Bottom Action Bar ===
      Column() {
        Row() {
          Column({ space: 4 }) {
            Text('Next checkpoint')
              .fontSize(14)
              .fontColor('#2E251D')
            Text('12:40 Studio')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2E251D')
          }
          .alignItems(HorizontalAlign.Start)
          
          Blank()
          
          Button('Launch session')
            .type(ButtonType.Capsule)
            .backgroundColor('#C08552')
            .fontColor('#FFFFFF')
            .height(48)
            .padding({ left: 24, right: 24 })
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .backgroundColor('#FAF7F2')
      .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: -2 })
      .position({ x: 0, y: 0 })
      .translate({ y: 600 }) // Approximate positioning to bottom
    }
    .width('100%')
    .height('100%')
  }
}