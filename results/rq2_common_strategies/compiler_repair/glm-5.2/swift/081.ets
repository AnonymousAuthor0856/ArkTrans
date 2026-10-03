// TaskDashboardApp.ets

@Entry
@Component
struct TaskDashboardApp {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')
        .padding({ top: 48, bottom: 16, left: 24, right: 24 })
        .alignItems(HorizontalAlign.Start) {
          
          // Top Header
          Row() {
            Button() {
              Text('☰')
                .fontSize(24)
                .fontColor(Color.Black)
            }
            .width(48).height(48)
            .backgroundColor('#F5F5F5')
            .borderRadius(24)
            .type(ButtonType.Circle)

            Blank() // Spacer

            Button() {
              Text('🔍')
                .fontSize(20)
                .fontColor(Color.Black)
            }
            .width(48).height(48)
            .backgroundColor('#F5F5F5')
            .borderRadius(24)
            .type(ButtonType.Circle)
          }
          .width('100%')

          // Content ScrollView
          Scroll() {
            Column({ space: 0 }) {
              // Welcome Section
              Column() {
                Text('Hello, Alex')
                  .fontSize(32)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.Black)
                Text('You have 5 incomplete tasks today.')
                  .fontSize(16)
                  .fontColor(Color.Gray)
                  .margin({ top: 8 })
              }
              .alignItems(HorizontalAlign.Start)
              .margin({ top: 16, bottom: 32 })

              // Category Selector
              Scroll() {
                Row({ space: 12 }) {
                  ForEach(['All', 'Work', 'Personal', 'Design'], (category: string) => {
                    Text(category)
                      .fontSize(14)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(category === 'All' ? Color.White : Color.Black)
                      .backgroundColor(category === 'All' ? '#212121' : '#F5F5F5')
                      .borderRadius(16)
                      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
                  })
                }
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
              .margin({ bottom: 24 })

              // Recent Tasks List
              Column({ space: 16 }) {
                Text('Recent Tasks')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.Black)

                // Task Items
                TaskItem({ 
                  title: 'Team Meeting', 
                  time: '10:00 AM - 11:30 AM', 
                  tag: 'Work', 
                  tagColor: '#E3F2FD', 
                  tagTextColor: '#1565C0', 
                  isChecked: true, 
                  icon: '📅'
                })
                TaskItem({ 
                  title: 'Design Review', 
                  time: '02:00 PM - 03:00 PM', 
                  tag: 'Design', 
                  tagColor: '#F3E5F5', 
                  tagTextColor: '#7B1FA2', 
                  isChecked: false, 
                  icon: '📅'
                })
                TaskItem({ 
                  title: 'Grocery Shopping', 
                  time: '05:30 PM', 
                  tag: 'Personal', 
                  tagColor: '#E8F5E9', 
                  tagTextColor: '#2E7D32', 
                  isChecked: false, 
                  icon: '😊'
                })
                TaskItem({ 
                  title: 'Read Documentation', 
                  time: '08:00 PM', 
                  tag: 'Study', 
                  tagColor: '#FFF3E0', 
                  tagTextColor: '#EF6C00', 
                  isChecked: false, 
                  icon: '📅'
                })
              }
              .alignItems(HorizontalAlign.Start)
              .margin({ bottom: 80 })
            }
            .padding({ left: 0, right: 0 })
          }
          .layoutWeight(1)
          .scrollBar(BarState.Off)
          .align(Alignment.TopStart)
        }

      // FAB
      Button() {
        Text('+')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .width(56).height(56)
      .backgroundColor('#212121')
      .borderRadius(28)
      .shadow({ radius: 4, offsetY: 4, color: 'rgba(0,0,0,0.25)' })
      .margin({ right: 24, bottom: 24 })
      .type(ButtonType.Circle)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

// MARK: - Components
@Component
struct TaskItem {
  @Prop title: string = '';
  @Prop time: string = '';
  @Prop tag: string = '';
  @Prop tagColor: string = '';
  @Prop tagTextColor: string = '';
  @State isChecked: boolean = false;
  @Prop icon: string = '';

  build() {
    Row({ space: 16 }) {
      // Icon Box
      Stack() {
        Text(this.icon)
          .fontSize(24)
      }
      .width(48).height(48)
      .backgroundColor(Color.White)
      .borderRadius(14)

      // Text Content
      Column({ space: 4 }) {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? Color.Gray : Color.Black)
          .decoration({ 
            type: this.isChecked ? TextDecorationType.LineThrough : TextDecorationType.None, 
            color: Color.Gray 
          })
        
        Row({ space: 8 }) {
          Text(this.time)
            .fontSize(12)
            .fontColor(Color.Gray)
          
          Text(this.tag)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.tagTextColor)
            .backgroundColor(this.tagColor)
            .borderRadius(4)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
        }
      }
      .alignItems(HorizontalAlign.Start)

      Blank() // Spacer

      // Checkbox Button
      Button() {
        Text(this.isChecked ? '✔' : '▢')
          .fontSize(20)
          .fontColor(this.isChecked ? Color.Black : Color.Gray)
      }
      .backgroundColor(Color.Transparent)
      .onClick(() => {
        this.isChecked = !this.isChecked;
      })
    }
    .padding(20)
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
    .width('100%')
  }
}