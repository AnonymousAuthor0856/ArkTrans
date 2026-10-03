@Entry
@Component
struct Index {
  @State selectedTab: number = 0

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row() {
          Button() {
            Image($r('app.media.startIcon')).width(24).height(24)
          }.backgroundColor('#F5F5F5').borderRadius(16).width(48).height(48)

          Blank()

          Button() {
            Image($r('app.media.startIcon')).width(24).height(24)
          }.backgroundColor('#F5F5F5').borderRadius(16).width(48).height(48)
        }.width('100%').padding({ left: 24, right: 24, top: 16 })

        Scroll() {
          Column() {
            Column() {
              Text('Good Morning,')
                .fontColor('#757575')
                .fontSize(16)
              
              Text('My Jungle')
                .fontColor('#1C1B1F')
                .fontWeight(FontWeight.Bold)
                .fontSize(34)
                .lineHeight(40)
            }.alignItems(HorizontalAlign.Start).padding({ left: 24, right: 24, top: 24, bottom: 16 })

            Text('Pending Tasks')
              .fontColor('#1C1B1F')
              .fontWeight(FontWeight.Bold)
              .fontSize(24)
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })

            Scroll() {
              Row({ space: 16 }) {
                // Task Card 1
                Column() {
                  Row() {
                    Stack() {
                      Circle().fill(Color.White).width(40).height(40)
                      Image($r('app.media.startIcon')).width(20).height(20).objectFit(ImageFit.Contain)
                    }
                    Blank()
                  }.width('100%')
                  
                  Blank()
                  
                  Column() {
                    Text('Watering')
                      .fontColor('#1C1B1F')
                      .fontWeight(FontWeight.Bold)
                      .fontSize(16)
                    
                    Text('Monstera Deliciosa')
                      .fontColor('#757575')
                      .fontSize(12)
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                    
                    Blank().height(8)
                    
                    Text('Today')
                      .fontColor('#1C1B1F')
                      .fontWeight(FontWeight.Bold)
                      .fontSize(12)
                      .backgroundColor('#E0E0E0')
                      .borderRadius(4)
                      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                  }.alignItems(HorizontalAlign.Start)
                }
                .width(160)
                .height(180)
                .backgroundColor('#F9F9F9')
                .borderRadius(24)
                .padding(16)
                .borderWidth(1)
                .borderColor('#EEEEEE')

                // Task Card 2
                Column() {
                  Row() {
                    Stack() {
                      Circle().fill(Color.White).width(40).height(40)
                      Image($r('app.media.startIcon')).width(20).height(20).objectFit(ImageFit.Contain)
                    }
                    Blank()
                  }.width('100%')
                  
                  Blank()
                  
                  Column() {
                    Text('Fertilize')
                      .fontColor('#1C1B1F')
                      .fontWeight(FontWeight.Bold)
                      .fontSize(16)
                    
                    Text('Fiddle Leaf Fig')
                      .fontColor('#757575')
                      .fontSize(12)
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                    
                    Blank().height(8)
                    
                    Text('Tomorrow')
                      .fontColor('#1C1B1F')
                      .fontWeight(FontWeight.Bold)
                      .fontSize(12)
                      .backgroundColor('#E0E0E0')
                      .borderRadius(4)
                      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                  }.alignItems(HorizontalAlign.Start)
                }
                .width(160)
                .height(180)
                .backgroundColor('#F9F9F9')
                .borderRadius(24)
                .padding(16)
                .borderWidth(1)
                .borderColor('#EEEEEE')
              }.padding({ left: 24, right: 24 })
            }.scrollable(ScrollDirection.Horizontal).scrollBar(BarState.Off).padding({ bottom: 32 })

            Text('Your Collection')
              .fontColor('#1C1B1F')
              .fontWeight(FontWeight.Bold)
              .fontSize(24)
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })

            // Plant Item
            Row() {
              Stack() {
                Rect().fill('#EEEEEE').width(56).height(56).borderRadius(12)
                Image($r('app.media.startIcon'))
              }
              
              Blank().width(16)
              
              Column() {
                Text('Monstera')
                  .fontColor('#1C1B1F')
                  .fontWeight(FontWeight.Bold)
                  .fontSize(18)
                
                Text('Monstera deliciosa')
                  .fontColor('#757575')
                  .fontSize(12)
                  .fontStyle(FontStyle.Italic)
                
                Blank().height(8)
                
                Row() {
                  Image($r('app.media.startIcon')).width(12).height(12).objectFit(ImageFit.Contain)
                  Blank().width(4)
                  Text('Living Room')
                    .fontColor('#757575')
                    .fontSize(10)
                }
              }.layoutWeight(1).alignItems(HorizontalAlign.Start)

              Column() {
                Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
                Text('Water')
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#2E5E4E')
                  .fontSize(10)
                Text('2 days')
                  .fontColor('#757575')
                  .fontSize(10)
              }.alignItems(HorizontalAlign.End)
            }
            .width('100%')
            .padding({ left: 24, right: 24, top: 8, bottom: 8 })
            .backgroundColor('#F9F9F9')
            .borderRadius(16)
            
            Blank().height(100) // Spacer for bottom padding
          }.width('100%')
        }.layoutWeight(1).scrollBar(BarState.Off)
      }.width('100%').height('100%')

      // Floating Action Button
      Button() {
        Image($r('app.media.startIcon')).width(24).height(24)
      }
      .width(56)
      .height(56)
      .backgroundColor('#1C1B1F')
      .borderRadius(28)
      .margin({ bottom: 96, right: 24 })
      .shadow({ radius: 8, color: '#1F000000', offsetY: 4 })

      // Bottom Navigation Bar
      Row() {
        // Home
        Column() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
        }
        .onClick(() => { this.selectedTab = 0 })
        
        // Calendar
        Column() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
        }
        .onClick(() => { this.selectedTab = 1 })

        Blank().width(32) // Gap for FAB

        // Bell
        Column() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
        }
        .onClick(() => { this.selectedTab = 2 })

        // Settings
        Column() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
        }
        .onClick(() => { this.selectedTab = 3 })
      }
      .width('100%')
      .height(80)
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.SpaceAround)
      .padding({ left: 24, right: 24 })
      .shadow({ radius: 10, color: '#0A000000', offsetY: -2 })
    }.width('100%').height('100%').backgroundColor(Color.White)
  }
}