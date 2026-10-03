@Entry
@Component
struct Index {
  @State selectedTabIndex: number = 0

  build() {
    Stack() {
      // === ZStack ===
      Stack() {
        // === VStack ===
        Column({ space: 0 }) {
          // === HStack ===
          Row() {
            Button('Back')
              .backgroundColor(Color.Transparent)
              .fontColor('#2D261C')
              .fontSize(16)
            
            Blank()
            
            Text('Study Focus Split')
              .fontColor('#2D261C')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
            
            Blank()
            
            Button('Share')
              .backgroundColor(Color.Transparent)
              .fontColor('#9CA3AF')
              .fontSize(16)
          }
          .width('100%')
          .padding({ left: 24, right: 24, top: 16, bottom: 16 })
          .backgroundColor('#FFFFFF')

          // === ScrollView ===
          Scroll() {
            // === VStack ===
            Column() {
              // === ScrollView (Horizontal Tabs) ===
              Scroll() {
                Row() {
                  ForEach([
                    { name: 'Clay\nResonance' },
                    { name: 'Material\nMemory' },
                    { name: 'Morph\nLab' },
                    { name: 'Studio\nReview' }
                  ], (item: TabItem, index: number) => {
                    Column() {
                      Text(item.name)
                        .fontColor(this.selectedTabIndex === index ? '#BF8451' : '#2D261C')
                        .fontSize(14)
                        .lineHeight(20)
                        .textAlign(TextAlign.Center)
                        .maxLines(2)
                        .width('100%')
                        .height(40)
                      
                      Rect()
                        .fill(this.selectedTabIndex === index ? '#BF8451' : Color.Transparent)
                        .height(2)
                    }
                    .width(90)
                    .onClick(() => {
                      this.selectedTabIndex = index
                    })
                  })
                }
                .padding({ left: 24, right: 24 })
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)

              // === TabView (Main Card) ===
              Column() {
                // Main Content Card
                Column() {
                  Text('Clay Resonance')
                    .fontColor('#2D261C')
                    .fontSize(28)
                    .fontWeight(FontWeight.Bold)
                  
                  Text('Acoustic prototypes')
                    .fontColor('#2D261C')
                    .opacity(0.8)
                    .fontSize(16)
                    .margin({ top: 4 })
                  
                  Divider()
                    .color('#E8DDCE')
                    .margin({ top: 16, bottom: 16 })
                  
                  Row() {
                    Text('Progress')
                      .fontColor('#2D261C')
                      .fontSize(12)
                    
                    Blank()
                    
                    Text('72%')
                      .fontColor('#BF8451')
                      .fontSize(18)
                      .fontWeight(FontWeight.Medium)
                  }
                  .width('100%')
                  
                  Stack({ alignContent: Alignment.Start }) {
                    Rect()
                      .fill('#E8DDCE')
                      .borderRadius(6)
                      .height(12)
                      .width('100%')
                    
                    Rect()
                      .fill('#BF8451')
                      .borderRadius(6)
                      .height(12)
                      .width('72%')
                  }
                  .width('100%')
                  .margin({ top: 12 })
                  
                  Blank().height(24)
                  
                  Button('Review outline')
                    .backgroundColor('#BF8451')
                    .fontColor('#FFFFFF')
                    .borderRadius(20)
                    .height(48)
                    .width('100%')
                    .fontSize(16)
                }
                .width('100%')
                .padding(24)
                .backgroundColor('#FFFFFF')
                .borderRadius(24)
                .shadow({ radius: 4, color: '#00000010', offsetY: 2 })
              }
              .width('100%')
              .padding({ left: 24, right: 24, top: 24 })
              .height(220)

              // === Bottom Grid Section ===
              Row() {
                // Left Column: Focus Board
                Column() {
                  Text('Focus board')
                    .fontColor('#2D261C')
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                  
                  Column() {
                    Row() {
                      Column() {
                        Text('Research layering')
                          .fontColor('#2D261C')
                          .fontSize(14)
                        Text('45m')
                          .fontColor('#9CA3AF')
                          .fontSize(12)
                          .margin({ top: 2 })
                      }.alignItems(HorizontalAlign.Start)
                      Blank()
                    }
                    .width('100%')
                    .padding(12)
                    .backgroundColor('#E8DDCE')
                    .opacity(0.6)
                    .borderRadius(12)
                    .margin({ bottom: 8 })

                    Row() {
                      Column() {
                        Text('Feedback sync')
                          .fontColor('#2D261C')
                          .fontSize(14)
                        Text('30m')
                          .fontColor('#9CA3AF')
                          .fontSize(12)
                          .margin({ top: 2 })
                      }.alignItems(HorizontalAlign.Start)
                      Blank()
                    }
                    .width('100%')
                    .padding(12)
                    .backgroundColor('#E8DDCE')
                    .opacity(0.6)
                    .borderRadius(12)
                    .margin({ bottom: 8 })

                    Row() {
                      Column() {
                        Text('Practice recall')
                          .fontColor('#2D261C')
                          .fontSize(14)
                        Text('20m')
                          .fontColor('#9CA3AF')
                          .fontSize(12)
                          .margin({ top: 2 })
                      }.alignItems(HorizontalAlign.Start)
                      Blank()
                    }
                    .width('100%')
                    .padding(12)
                    .backgroundColor('#E8DDCE')
                    .opacity(0.6)
                    .borderRadius(12)
                  }
                  .layoutWeight(1)
                }
                .layoutWeight(1)
                .padding(16)
                .backgroundColor('#FFFFFF')
                .borderRadius(24)
                .shadow({ radius: 4, color: '#00000010', offsetY: 2 })

                // Right Column: Reflection
                Column() {
                  Text('Reflection')
                    .fontColor('#2D261C')
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                  
                  Text('Focus on tone shifts across clay gradients')
                    .fontColor('#2D261C')
                    .fontSize(14)
                    .lineHeight(22)
                    .margin({ top: 12 })
                    .width('100%')
                    .textAlign(TextAlign.Start)
                  
                  Blank().height(12)
                  
                  Button('Shuffle note')
                    .backgroundColor('#BF8451')
                    .fontColor('#FFFFFF')
                    .borderRadius(20)
                    .height(48)
                    .width('100%')
                    .fontSize(16)
                }
                .layoutWeight(1)
                .padding(16)
                .backgroundColor('#E8DDCE')
                .borderRadius(24)
              }
              .width('100%')
              .padding({ left: 24, right: 24, top: 24 })
              .justifyContent(FlexAlign.SpaceBetween)

              Blank().height(100)
            }
            .padding({ top: 16 })
          }
          .scrollBar(BarState.Off)
          .layoutWeight(1)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F2EB')

        // === Bottom Floating Bar ===
        Column() {
          Blank()
          
          Row() {
            Column() {
              Text('Next checkpoint')
                .fontColor('#2D261C')
                .fontSize(12)
              
              Text('12:40 Studio')
                .fontColor('#2D261C')
                .opacity(0.8)
                .fontSize(14)
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)
            
            Blank()
            
            Button('Launch session')
              .backgroundColor('#BF8451')
              .fontColor('#FFFFFF')
              .borderRadius(20)
              .height(48)
              .width(140)
              .fontSize(16)
          }
          .width('100%')
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .backgroundColor('#FFFFFF')
          .shadow({ radius: 4, color: '#0000001A', offsetY: -2 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.End)
      }
    }
    .width('100%')
    .height('100%')
  }
}

interface TabItem {
  name: string;
}