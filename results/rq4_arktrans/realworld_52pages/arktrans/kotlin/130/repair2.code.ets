@Entry
@Component
struct Index {
  @State isSearchMode: boolean = false
  @State showSortMenu: boolean = false
  @State showDeleteDialog: boolean = false

  private todoItems: TodoItem[] = [
    { title: 'Buy groceries', desc: 'Milk, eggs, bread, and vegetables for the week', priorityColor: '#FF5252' },
    { title: 'Finish report', desc: 'Complete the quarterly report for the team meeting', priorityColor: '#FF5252' },
    { title: 'Call dentist', desc: 'Schedule a checkup appointment for next month', priorityColor: '#FFC107' },
    { title: 'Read a book', desc: 'Finish reading Clean Code by Robert C. Martin', priorityColor: '#4CAF50' },
    { title: 'Plan weekend trip', desc: 'Research hotels and activities for the getaway', priorityColor: '#FFC107' },
    { title: 'Organize desk', desc: 'Clean and organize the home office workspace', priorityColor: '#4CAF50' }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      
      // === Main Content (LazyGrid) ===
      Grid() {
        ForEach(this.todoItems, (item: TodoItem) => {
          GridItem() {
            Column() {
              Stack({ alignContent: Alignment.TopStart }) {
                // Card Background
                Column() {
                  Text(item.title)
                    .fontWeight(FontWeight.Bold)
                    .fontSize(20)
                    .fontColor('#191D19')
                    .maxLines(2)
                  
                  Blank().height(8)
                  
                  Text(item.desc)
                    .fontSize(14)
                    .fontColor('#666666')
                    .lineHeight(22)
                    .maxLines(4)
                }
                .width('100%')
                .padding({ left: 16, right: 16, top: 16, bottom: 16 })
                
                // Priority Dot
                Circle({ width: 16, height: 16 })
                  .fill(item.priorityColor)
                  .position({ x: '100%', y: 0 })
                  .margin({ right: 16, top: 16 })
              }
              .width('100%')
            }
            .backgroundColor('#EAE4ED') // Light purple background from screenshot
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
            .width('100%')
            .height(180) // Fixed height for uniformity in grid
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .rowsGap(16)
      .columnsGap(16)
      .padding(16)
      .width('100%')
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)

      // === Top App Bar ===
      Row() {
        if (this.isSearchMode) {
          TextInput({ placeholder: 'Search' })
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .padding(10)
            .layoutWeight(1)
            .margin({ right: 10 })
          
          Button() {
            Image($r('app.media.startIcon')) // Using startIcon as proxy for ArrowBack
              .width(24).height(24).fillColor(Color.White)
          }
          .backgroundColor(Color.Transparent)
          .onClick(() => this.isSearchMode = false)
        } else {
          Text('ToDo List')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
            .layoutWeight(1)
          
          Button() {
            Image($r('app.media.startIcon')) // Proxy for Search Icon
              .width(24).height(24).fillColor(Color.White)
          }
          .backgroundColor(Color.Transparent)
          .onClick(() => this.isSearchMode = true)
          
          Button() {
            // Custom MoreVert Icon using shapes since we only have one image resource
            Column() {
              Circle({ width: 4, height: 4 }).fill(Color.White).margin({ bottom: 3 })
              Circle({ width: 4, height: 4 }).fill(Color.White).margin({ bottom: 3 })
              Circle({ width: 4, height: 4 }).fill(Color.White)
            }
          }
          .backgroundColor(Color.Transparent)
          .onClick(() => this.showSortMenu = !this.showSortMenu)
        }
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#6750A4') // Primary Color

      // === Dropdown Menu (Simulated) ===
      if (this.showSortMenu) {
        Column() {
          Text('Priority High')
            .fontColor('#191D19')
            .padding(16)
            .onClick(() => this.showSortMenu = false)
          
          Text('Priority Low')
            .fontColor('#191D19')
            .padding(16)
            .onClick(() => this.showSortMenu = false)
            
          Divider().color('#E0E0E0').margin({ left: 16 })
          
          Text('Delete All')
            .fontColor('#BA1A1A')
            .padding(16)
            .onClick(() => {
              this.showSortMenu = false
              this.showDeleteDialog = true
            })
        }
        .width(200)
        .backgroundColor('#FFF')
        .borderRadius(8)
        .shadow({ radius: 4, color: '#1F000000' })
        .position({ x: '100%', y: 56 })
        .margin({ right: 16 })
      }

      // === Floating Action Button ===
      Button() {
        // Plus Icon
        Stack() {
          Column().width(20).height(2).backgroundColor(Color.White)
          Column() {
            Row().width(2).height(20).backgroundColor(Color.White)
          }
        }
        .width(24)
        .height(24)
        .alignContent(Alignment.Center)
      }
      .width(56)
      .height(56)
      .backgroundColor('#6750A4')
      .borderRadius(16)
      .shadow({ radius: 6, color: '#3F000000' })
      .position({ x: '100%', y: '100%' })
      .margin({ right: 24, bottom: 24 })

      // === Delete Dialog Overlay ===
      if (this.showDeleteDialog) {
        Column() {
          Column() {
            Text('Delete Everything?')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 12 })
            
            Text('Are you sure you want to remove: Everything?')
              .fontSize(14)
              .fontColor('#666')
              .margin({ bottom: 24 })
            
            Row() {
              Text('YES')
                .fontColor('#BA1A1A')
                .fontWeight(FontWeight.Bold)
                .onClick(() => this.showDeleteDialog = false)
              
              Text('NO')
                .fontColor('#6750A4')
                .fontWeight(FontWeight.Bold)
                .margin({ left: 24 })
                .onClick(() => this.showDeleteDialog = false)
            }
            .justifyContent(FlexAlign.End)
          }
          .width('80%')
          .padding(24)
          .backgroundColor('#FFF')
          .borderRadius(16)
          .shadow({ radius: 8, color: '#3F000000' })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#80000000')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}

interface TodoItem {
  title: string;
  desc: string;
  priorityColor: string;
}