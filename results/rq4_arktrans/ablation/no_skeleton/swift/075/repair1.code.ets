@Entry
@Component
struct StudyFocusApp {
  @State selectedTabIndex: number = 0
  @State focusNote: string = "Focus on tone shifts across clay gradients"

  // Data Models
  modules: ModuleData[] = [
    { name: "Clay Resonance", progress: 72, summary: "Acoustic prototypes" },
    { name: "Material Memory", progress: 54, summary: "Tactile journaling" },
    { name: "Morph Lab", progress: 83, summary: "Color blending" },
    { name: "Studio Review", progress: 28, summary: "Peer critique" }
  ]

  tasks: TaskData[] = [
    { title: "Research layering", duration: "45m" },
    { title: "Feedback sync", duration: "30m" },
    { title: "Practice recall", duration: "20m" }
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // === Background ===
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F3EFE6')

      // === Main Content ===
      Column() {
        // === Top Bar ===
        Row() {
          Text('Back')
            .font({ size: 12, weight: FontWeight.Medium })
            .fontColor('#2E251D')
          
          Blank()
          
          Text('Study Focus Split')
            .font({ size: 18, weight: FontWeight.Medium })
            .fontColor('#2E251D')
          
          Blank()
          
          Text('Share')
            .font({ size: 12, weight: FontWeight.Medium })
            .fontColor('#9BB1C8')
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFF')

        // === Scrollable Area ===
        Scroll() {
          Column() {
            // === Tab Row ===
            Scroll() {
              Row() {
                ForEach(this.modules.map((_, i) => i), (index: number) => {
                  Column() {
                    Text(this.modules[index].name)
                      .font({ size: 12, weight: FontWeight.Medium })
                      .fontColor(this.selectedTabIndex === index ? '#C08552' : '#2E251D')
                      .textAlign(TextAlign.Center)
                      .maxLines(2)
                      .lineHeight(20)
                      .height(40)
                    
                    Divider()
                      .color(this.selectedTabIndex === index ? '#C08552' : Color.Transparent)
                      .strokeWidth(2)
                  }
                  .width(90)
                  .justifyContent(FlexAlign.Start)
                  .onClick(() => {
                    this.selectedTabIndex = index
                  })
                })
              }
              .padding({ left: 16, right: 16 })
              .backgroundColor('#FFF')
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)

            // === Pager Content (Main Card) ===
            // Using a fixed height container to simulate the page view
            Column() {
              ModuleCard({ module: this.modules[this.selectedTabIndex] })
            }
            .width('100%')
            .height(220)
            .padding({ left: 16, right: 16 })

            // === Dual Pane ===
            Row() {
              // Left Pane: Focus Board
              Column() {
                Text('Focus board')
                  .font({ size: 18, weight: FontWeight.Medium })
                  .fontColor('#2E251D')
                  .alignSelf(ItemAlign.Start)
                
                Column({ space: 8 }) {
                  ForEach(this.tasks, (task: TaskData) => {
                    Row() {
                      Column({ space: 4 }) {
                        Text(task.title)
                          .font({ size: 14, weight: FontWeight.Normal })
                          .fontColor('#2E251D')
                        
                        Text(task.duration)
                          .font({ size: 12, weight: FontWeight.Medium })
                          .fontColor('#9BB1C8')
                      }
                      .alignItems(HorizontalAlign.Start)
                      
                      Blank()
                    }
                    .width('100%')
                    .padding(8)
                    .backgroundColor('#E7DDCF')
                    .borderRadius(12)
                  })
                }
                
                // Button placeholder logic from screenshot (hidden/cut off)
                // Omitted as per visual fidelity to screenshot which shows empty space or cut off
                
              }
              .layoutWeight(1)
              .padding(12)
              .backgroundColor('#FFF')
              .borderRadius(20)
              .shadow({ radius: 4, color: '#0D000000', offsetY: 2 })

              // Right Pane: Reflection
              Column() {
                Text('Reflection')
                  .font({ size: 18, weight: FontWeight.Medium })
                  .fontColor('#2E251D')
                  .alignSelf(ItemAlign.Start)
                
                Text(this.focusNote)
                  .font({ size: 14, weight: FontWeight.Normal })
                  .fontColor('#2E251D')
                  .width('100%')
                  .padding(12)
                  .backgroundColor('#FFF')
                  .borderRadius(16)
                  .textAlign(TextAlign.Start)
                
                Button() {
                  Text('Shuffle note')
                    .font({ size: 12, weight: FontWeight.Medium })
                    .fontColor('#2A1C13')
                }
                .width('100%')
                .height(44)
                .backgroundColor('#C08552')
                .borderRadius(16)
                .onClick(() => {
                  this.focusNote = "Blend high and low tones before next critique"
                })
              }
              .layoutWeight(1)
              .padding(12)
              .backgroundColor('#E7DDCF')
              .borderRadius(20)
              .shadow({ radius: 4, color: '#0D000000', offsetY: 2 })
            }
            .width('100%')
            .padding({ left: 16, right: 16 })
            .margin({ top: 16 })

            // Spacer for bottom bar clearance
            Blank().height(100)
          }
          .padding({ top: 12 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      // === Bottom Bar ===
      Row() {
        Column({ space: 4 }) {
          Text('Next checkpoint')
            .font({ size: 12, weight: FontWeight.Medium })
            .fontColor('#2E251D')
          
          Text('12:40 Studio')
            .font({ size: 14, weight: FontWeight.Normal })
            .fontColor('#2E251D')
            .opacity(0.8)
        }
        .alignItems(HorizontalAlign.Start)
        
        Blank()
        
        Button() {
          Text('Launch session')
            .font({ size: 12, weight: FontWeight.Medium })
            .fontColor('#2A1C13')
        }
        .backgroundColor('#C08552')
        .borderRadius(16)
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor('#FFF')
      .shadow({ radius: 4, color: '#1A000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
  }
}

interface ModuleData {
  name: string;
  progress: number;
  summary: string;
}

interface TaskData {
  title: string;
  duration: string;
}

// Component: ModuleCard
@Component
struct ModuleCard {
  private module: ModuleData

  build() {
    Column() {
      Text(this.module.name)
        .font({ size: 22, weight: FontWeight.Medium })
        .fontColor('#2E251D')
      
      Text(this.module.summary)
        .font({ size: 14, weight: FontWeight.Normal })
        .fontColor('#2E251D')
        .opacity(0.8)
      
      Divider()
        .color('#D4C5B6')
        .margin({ top: 4, bottom: 4 })
      
      Row() {
        Text('Progress')
          .font({ size: 12, weight: FontWeight.Medium })
          .fontColor('#2E251D')
        
        Blank()
        
        Text(`${this.module.progress}%`)
          .font({ size: 18, weight: FontWeight.Medium })
          .fontColor('#C08552')
      }
      
      // Progress Bar
      Row() {
        Row()
          .width(`${this.module.progress}%`)
          .height(12)
          .backgroundColor('#C08552')
          .borderRadius(12)
      }
      .width('100%')
      .height(12)
      .backgroundColor('#E7DDCF')
      .borderRadius(12)
      .margin({ top: 8 })
      
      Button() {
        Text('Review outline')
          .font({ size: 12, weight: FontWeight.Medium })
          .fontColor('#2A1C13')
      }
      .backgroundColor('#C08552')
      .borderRadius(16)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFF')
    .borderRadius(20)
    .shadow({ radius: 4, color: '#0D000000', offsetY: 2 })
  }
}