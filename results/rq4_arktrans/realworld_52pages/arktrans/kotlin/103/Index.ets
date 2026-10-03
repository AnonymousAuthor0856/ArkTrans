@Entry
@Component
struct Index {
  @State isGridMode: boolean = true

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Scaffold / Main Content ===
      Column() {
        // === HomeTopBar ===
        Row() {
          // Menu Icon
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .margin({ right: 16 })

          // Title
          Text('Notes')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor('#191D19')
            .layoutWeight(1)

          // Search Icon
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .margin({ right: 16 })

          // Grid/List Toggle Icon
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .margin({ right: 16 })

          // More Vert Icon
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
        }
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16 })
        .alignItems(VerticalAlign.Center)

        // === NotesList (LazyVerticalStaggeredGrid equivalent) ===
        if (this.isGridMode) {
          Grid() {
            // Note 1
            GridItem() {
              Column() {
                Text("Today's first note")
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#191D19')
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                
                Blank().height(4)
                
                Text("Thought of it this morning, jotting it down")
                  .fontSize(14)
                  .fontColor('#424940')
                  .maxLines(4)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .padding(12)
            }

            // Note 2
            GridItem() {
              Column() {
                Text("Weekend shopping list")
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#191D19')
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                
                Blank().height(4)
                
                Text("Milk, eggs, bread, butter, cheese, apples, bananas")
                  .fontSize(14)
                  .fontColor('#424940')
                  .maxLines(4)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .padding(12)
            }

            // Note 3
            GridItem() {
              Column() {
                Text("Meeting minutes — Q3 planning")
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#191D19')
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                
                Blank().height(4)
                
                Text("Discussed roadmap, next quarter focus on search and sync")
                  .fontSize(14)
                  .fontColor('#424940')
                  .maxLines(4)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .padding(12)
            }

            // Note 4
            GridItem() {
              Column() {
                Text("Book notes")
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#191D19')
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                
                Blank().height(4)
                
                Text("Atomic Habits — improve 1% every day, that's 37x in a year")
                  .fontSize(14)
                  .fontColor('#424940')
                  .maxLines(4)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .padding(12)
            }

            // Note 5
            GridItem() {
              Column() {
                Text("Workout plan")
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#191D19')
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                
                Blank().height(4)
                
                Text("Monday chest + triceps, Wednesday back + biceps, Friday l...")
                  .fontSize(14)
                  .fontColor('#424940')
                  .maxLines(4)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .padding(12)
            }
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(8)
          .rowsGap(8)
          .width('100%')
          .layoutWeight(1)
          .padding(8)
        } else {
          // List Mode (Fallback for completeness based on skeleton)
          List({ space: 8 }) {
            ListItem() {
              Column() {
                Text("Today's first note").fontSize(18).fontWeight(FontWeight.Bold).fontColor('#191D19')
                Blank().height(4)
                Text("Thought of it this morning, jotting it down").fontSize(14).fontColor('#424940')
              }.padding(12)
            }
            // ... other items would go here
          }.width('100%').layoutWeight(1).padding(8)
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8FBF1')

      // === FloatingActionButton ===
      Button() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
      }
      .width(56)
      .height(56)
      .borderRadius(16)
      .backgroundColor('#D7F5D9')
      .shadow({ radius: 6, color: '#3F000000' })
      .position({ x: 'calc(100% - 72vp)', y: 'calc(100% - 72vp)' })
    }
    .width('100%')
    .height('100%')
  }
}