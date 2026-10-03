interface Module {
  name: string;
  progress: number;
  summary: string;
}

interface Task {
  title: string;
  duration: string;
}

@Entry
@Component
struct StudyFocusSplit {
  @State currentPage: number = 0
  @State focusNote: string = "Focus on tone shifts across clay gradients"

  private modules: Array<Module> = [
    { name: "Clay Resonance", progress: 72, summary: "Acoustic prototypes" },
    { name: "Material Memory", progress: 54, summary: "Tactile journaling" },
    { name: "Morph Lab", progress: 83, summary: "Color blending" },
    { name: "Studio Review", progress: 28, summary: "Peer critique" }
  ]

  private tasks: Array<Task> = [
    { title: "Research layering", duration: "45m" },
    { title: "Feedback sync", duration: "30m" },
    { title: "Practice recall", duration: "20m" }
  ]

  build() {
    Column() {
      // === Top Bar ===
      Row() {
        Text('Back')
          .fontColor('#2E251D')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {})
        
        Blank()
        
        Text('Study Focus Split')
          .fontColor('#2E251D')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
        
        Blank()
        
        Text('Share')
          .fontColor('#9BB1C8')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {})
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFF')

      // === Tab Row ===
      Row() {
        ForEach(this.modules, (module: Module, index: number) => {
          Column() {
            Text(module.name)
              .fontColor(index === this.currentPage ? '#C08552' : '#2E251D')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .textAlign(TextAlign.Center)
          }
          .layoutWeight(1)
          .height(48)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            this.currentPage = index
          })
          
          if (index === this.currentPage) {
            Divider()
              .width('100%')
              .height(4)
              .color('#C08552')
              .borderRadius(2)
          }
        })
      }
      .width('100%')
      .backgroundColor('#FFF')
      .margin({ top: 12 })

      // === Main Content Scroll ===
      Scroll() {
        Column() {
          // === Module Card ===
          Column() {
            Text(this.modules[this.currentPage].name)
              .fontColor('#2E251D')
              .fontSize(22)
              .fontWeight(FontWeight.Medium)
            
            Text(this.modules[this.currentPage].summary)
              .fontColor('#2E251D')
              .opacity(0.8)
              .fontSize(14)
              .margin({ top: 4 })
            
            Divider()
              .width('100%')
              .height(1)
              .color('#D4C5B6')
              .margin({ top: 12, bottom: 12 })
            
            Row() {
              Text('Progress')
                .fontColor('#2E251D')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
              
              Blank()
              
              Text(`${this.modules[this.currentPage].progress}%`)
                .fontColor('#C08552')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
            }
            .width('100%')
            
            // Progress Bar
            Row() {
              Row() {
                Blank()
                  .width(`${this.modules[this.currentPage].progress}%`)
                  .height(12)
                  .backgroundColor('#C08552')
                  .borderRadius(6)
              }
              .width('100%')
              .height(12)
              .backgroundColor('#E7DDCF')
              .borderRadius(6)
            }
            .width('100%')
            .margin({ top: 12 })
            
            Button('Review outline')
              .width('100%')
              .height(48)
              .backgroundColor('#C08552')
              .fontColor('#FFF')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .borderRadius(16)
              .margin({ top: 16 })
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFF')
          .borderRadius(20)
          .margin({ top: 16 })

          // === Split Pane ===
          Row() {
            // Focus Board
            Column() {
              Text('Focus board')
                .fontColor('#2E251D')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
              
              Column() {
                ForEach(this.tasks, (task: Task) => {
                  Column() {
                    Text(task.title)
                      .fontColor('#2E251D')
                      .fontSize(14)
                    
                    Text(task.duration)
                      .fontColor('#9BB1C8')
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .margin({ top: 4 })
                  }
                  .padding(12)
                  .backgroundColor('#E7DDCF')
                  .borderRadius(12)
                  .margin({ bottom: 8 })
                })
                
                Button('Add checkpoint')
                  .width('100%')
                  .height(40)
                  .backgroundColor('#C08552')
                  .fontColor('#FFF')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .borderRadius(16)
                  .margin({ top: 8 })
              }
              .margin({ top: 12 })
            }
            .layoutWeight(1)
            .padding(16)
            .backgroundColor('#FFF')
            .borderRadius(20)

            // Reflection
            Column() {
              Text('Reflection')
                .fontColor('#2E251D')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
              
              Column() {
                Text(this.focusNote)
                  .fontColor('#2E251D')
                  .fontSize(14)
                  .lineHeight(24)
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#FFF')
              .borderRadius(16)
              .margin({ top: 12 })
              
              Button('Shuffle note')
                .width('100%')
                .height(48)
                .backgroundColor('#C08552')
                .fontColor('#FFF')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .borderRadius(16)
                .margin({ top: 16 })
                .onClick(() => {
                  this.focusNote = "Blend high and low tones before next critique"
                })
            }
            .layoutWeight(1)
            .padding(16)
            .backgroundColor('#E7DDCF')
            .borderRadius(20)
          }
          .width('100%')
          .margin({ top: 16, bottom: 16 })
        }
        .padding({ left: 16, right: 16 })
      }
      .layoutWeight(1)

      // === Bottom Bar ===
      Row() {
        Column() {
          Text('Next checkpoint')
            .fontColor('#2E251D')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
          
          Text('12:40 Studio')
            .fontColor('#2E251D')
            .opacity(0.8)
            .fontSize(14)
            .margin({ top: 4 })
        }
        
        Blank()
        
        Button('Launch session')
          .height(48)
          .backgroundColor('#C08552')
          .fontColor('#FFF')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .borderRadius(16)
          .padding({ left: 24, right: 24 })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor('#FFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F3EFE6')
  }
}