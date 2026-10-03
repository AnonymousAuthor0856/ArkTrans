@Entry
@Component
struct Index {
  @State notificationsEnabled: boolean = false
  @State isOn: boolean = false
  @State syncProgress: number = 0.3

  // Mock data to satisfy the structure requirements without external dependencies
  private colTasks: string[] = ['Task 1', 'Task 2']

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        // Header Row
        Row() {
          Text('Notifications')
            .fontColor('#1E1E1E')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
          
          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // Horizontal List (LazyRow equivalent)
        List({ space: 12 }) {
          ListItem() {
            Column() {
              Column({ space: 8 }) {
                Text('col.title')
                  .fontColor('#2563EB')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)

                // ForEach equivalent using Flex or just iterating in build for static mock
                // Since we can't use dynamic ForEach easily in this specific skeleton conversion without a proper array state,
                // we will render the items directly as per the "Implement every child" rule, 
                // but the skeleton implies a loop. We'll simulate the loop content.
                
                // Simulating the forEach block from the skeleton
                ForEach(this.colTasks, (task: string) => {
                  Button(task) {
                    Text(task)
                      .fontColor('#1E1E1E')
                      .fontSize(14)
                  }
                  .backgroundColor('#F3F4F6') // SurfaceVariant approx
                  .borderRadius(8)
                  .margin({ right: 8 })
                }, (item: string) => item)
              }
              .width('100%')
              .padding(12)
            }
            .width(220)
            .height('100%')
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000' })
          }
        }
        .width('100%')
        .listDirection(Axis.Horizontal)

        // Task Completion Section
        Text('Task Completion')
          .fontColor('#1E1E1E')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)

        Progress({ value: this.syncProgress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color('#2563EB')
          .background('#E5E7EB')
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#F3F4F6')

      // Top App Bar (Overlay)
      Row() {
        Text('Kanban Board')
          .fontColor('#1E1E1E')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#F3F4F6')
    }
    .width('100%')
    .height('100%')
  }
}