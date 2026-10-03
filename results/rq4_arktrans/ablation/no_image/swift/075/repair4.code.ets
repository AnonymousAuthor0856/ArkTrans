import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct Index {
  @State selectedTabIndex: number = 0

  interface ModuleItem {
    name: string;
    summary: string;
    progress: number;
  }

  interface TaskItem {
    title: string;
    desc: string;
  }

  // Mock data to satisfy ForEach requirements
  private modules: Array<ModuleItem> = [
    { name: 'Color Theory', summary: 'Understanding hues and saturation.', progress: 75 },
    { name: 'Composition', summary: 'Balancing elements in frame.', progress: 40 },
    { name: 'Lighting', summary: 'Mastering natural light.', progress: 90 }
  ]

  private tasks: Array<TaskItem> = [
    { title: 'Review Sketches', desc: 'Check perspective lines.' },
    { title: 'Mix Palette', desc: 'Prepare earth tones.' }
  ]

  build() {
    Stack() {
      // === ZStack (Main Content) ===
      Stack() {
        // === VStack (Scrollable Area) ===
        Column({ space: 0 }) {
          // === HStack (Header) ===
          Row() {
            Button('Menu')
              .backgroundColor('#BF8451')
              .borderRadius(8)
              .width(32)
              .height(32)
              .fontColor('#FFF')
            
            Blank()
            
            Text('Study Focus Split')
              .fontColor('#2D261C')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
            
            Blank()
            
            Button('More')
              .backgroundColor('#BF8451')
              .borderRadius(8)
              .width(32)
              .height(32)
              .fontColor('#FFF')
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FDFCF8')

          // === ScrollView (Vertical) ===
          Scroll() {
            // === VStack (Content Container) ===
            Column({ space: 24 }) {
              .padding({ top: 16 })

              // === ScrollView (Horizontal Tabs) ===
              Scroll() {
                Row({ space: 0 }) {
                  .padding({ left: 24, right: 24 })
                  .backgroundColor('#FDFCF8')
                  
                  ForEach(this.modules.map((_, i) => i), (index: number) => {
                    Column() {
                      Text(this.modules[index].name.replace(' ', '\n'))
                        .fontColor(this.selectedTabIndex === index ? '#BF8451' : '#2D261C')
                        .fontSize(12)
                        .lineHeight(16)
                        .textAlign(TextAlign.Center)
                        .maxLines(2)
                        .height(40)
                      
                      Rect()
                        .fill(this.selectedTabIndex === index ? '#BF8451' : Color.Transparent)
                        .height(2)
                    }
                    .width(90)
                    .padding({ top: 8, bottom: 8 })
                    .onClick(() => {
                      this.selectedTabIndex = index
                    })
                  })
                }
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)

              // === TabView (Cards) ===
              TabContainer() {
                ForEach(this.modules.map((_, i) => i), (index: number) => {
                  TabContent() {
                    CardView() {
                      Column({ space: 8 }) {
                        .padding(24)
                        
                        Text(this.modules[index].name)
                          .fontColor('#2D261C')
                          .fontSize(24)
                          .fontWeight(FontWeight.Bold)
                        
                        Text(this.modules[index].summary)
                          .fontColor('#2D261C')
                          .opacity(0.8)
                          .fontSize(14)
                        
                        Row() {
                          Text('Progress')
                            .fontColor('#2D261C')
                            .fontSize(12)
                          
                          Blank()
                          
                          Text(`${this.modules[index].progress}%`)
                            .fontColor('#BF8451')
                            .fontSize(18)
                            .fontWeight(FontWeight.Bold)
                        }
                        
                        // Progress Bar
                        Stack({ alignContent: Alignment.Start }) {
                          Rect()
                            .fill('#E8DDCE')
                            .borderRadius(6)
                            .height(12)
                          
                          Rect()
                            .fill('#BF8451')
                            .borderRadius(6)
                            .width(`${this.modules[index].progress}%`)
                            .height(12)
                        }
                        .width('100%')
                        
                        Blank().height(8)
                        
                        Button('Continue Learning')
                          .backgroundColor('#BF8451')
                          .borderRadius(8)
                          .fontColor('#FFF')
                      }
                    }
                    .backgroundColor('#FDFCF8')
                    .borderRadius(16)
                    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
                  }
                })
              }
              .index(this.selectedTabIndex)
              .onChange((index: number) => {
                this.selectedTabIndex = index
              })
              .barMode(TabBarMode.None)
              .height(220)

              // === HStack (Bottom Cards) ===
              Row({ space: 16 }) {
                .padding({ left: 24, right: 24 })
                
                // Focus Board Card
                CardView() {
                  Column({ space: 8 }) {
                    .padding(16)
                    
                    Text('Focus board')
                      .fontColor('#2D261C')
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                    
                    ForEach(this.tasks, (task: TaskItem) => {
                      Row() {
                        Column({ space: 2 }) {
                          Text(task.title)
                            .fontColor('#2D261C')
                            .fontSize(14)
                          Text(task.desc)
                            .fontColor('#2D261C')
                            .opacity(0.6)
                            .fontSize(12)
                        }
                        .alignItems(HorizontalAlign.Start)
                        
                        Blank()
                      }
                      .width('100%')
                      .padding(8)
                      .backgroundColor('#E8DDCE')
                      .opacity(0.6)
                      .borderRadius(8)
                    })
                    
                    Blank().height(8)
                    
                    Button('Add Task')
                      .backgroundColor('#BF8451')
                      .borderRadius(8)
                      .fontColor('#FFF')
                  }
                }
                .backgroundColor('#FDFCF8')
                .borderRadius(16)
                .layoutWeight(1)
                .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })

                // Reflection Card
                CardView() {
                  Column({ space: 8 }) {
                    .padding(16)
                    
                    Text('Reflection')
                      .fontColor('#2D261C')
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                    
                    Text('Blend high and low tones before next critique.')
                      .fontColor('#2D261C')
                      .fontSize(14)
                      .width('100%')
                      .padding(12)
                      .backgroundColor('#FDFCF8')
                      .borderRadius(12)
                      .textAlign(TextAlign.Start)
                    
                    Button('Save Note')
                      .backgroundColor('#BF8451')
                      .borderRadius(8)
                      .fontColor('#FFF')
                  }
                }
                .backgroundColor('#E8DDCE')
                .borderRadius(16)
                .layoutWeight(1)
                .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
              }

              Blank().height(100)
            }
          }
          .scrollBar(BarState.Off)
        }

        // === VStack (Floating Bottom Sheet) ===
        Column() {
          Blank()
          
          Row() {
            Column({ space: 2 }) {
              Text('Next checkpoint')
                .fontColor('#2D261C')
                .fontSize(12)
              
              Text('12:40 Studio')
                .fontColor('#2D261C')
                .opacity(0.8)
                .fontSize(14)
            }
            .alignItems(HorizontalAlign.Start)
            
            Blank()
            
            Button('Snooze')
              .backgroundColor('#BF8451')
              .borderRadius(8)
              .fontColor('#FFF')
          }
          .width('100%')
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .backgroundColor('#FDFCF8')
          .shadow({ radius: 4, color: '#1A000000', offsetY: -2 })
        }
      }
    }
    .width('100%')
    .height('100%')
  }
}

// Helper component for consistent card styling
@Component
struct CardView {
  @BuilderParam content: () => void

  build() {
    Column() {
      this.content()
    }
  }
}