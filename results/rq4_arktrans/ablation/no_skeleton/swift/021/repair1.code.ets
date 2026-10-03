@Entry
@Component
struct RootScreen {
  @State notificationsEnabled: boolean = true

  build() {
    // === Stack ===
    // props: {}
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Stack() {
      // === Column ===
      // props: {}
      // modifier: { width: '100%', height: '100%', backgroundColor: '#F3F4F6' }
      // children: 1
      Column() {
        // === Column ===
        // props: {}
        // modifier: { width: '100%' }
        // children: 1
        Column() {
          // === Row ===
          // props: {}
          // modifier: { width: '100%', padding: { left: 16, right: 16, top: 16, bottom: 12 } }
          // children: 3
          Row() {
            // === Blank ===
            Blank().layoutWeight(1)
            // === Text ===
            // props: { text: 'Kanban Board' }
            // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, color: '#1E1E1E' }
            Text('Kanban Board').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#1E1E1E')
            // === Blank ===
            Blank().layoutWeight(1)
          }
        }

        // === Column ===
        // props: { space: 16 }
        // modifier: { width: '100%', layoutWeight: 1, padding: 16, alignItems: ItemAlign.Start }
        // children: 4
        Column({ space: 16 }) {
          // === Row ===
          // props: {}
          // modifier: { width: '100%' }
          // children: 2
          Row() {
            // === Text ===
            // props: { text: 'Notifications' }
            // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#1E1E1E' }
            Text('Notifications').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#1E1E1E')
            // === Blank ===
            Blank().layoutWeight(1)
            // === Toggle ===
            // props: { isOn: this.notificationsEnabled }
            // modifier: { type: ToggleType.Switch }
            Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
              .onChange((value: boolean) => {
                this.notificationsEnabled = value
              })
          }

          // === Scroll ===
          // props: { scrollable: ScrollDirection.Horizontal, barPosition: BarPosition.Outside }
          // modifier: { width: '100%' }
          // children: 1
          Scroll() {
            // === Row ===
            // props: { space: 12 }
            // modifier: { width: '100%', padding: { top: 4, bottom: 4 } }
            // children: 3
            Row({ space: 12 }) {
              // === CardView (To Do) ===
              // props: { title: 'To Do', tasks: ['Write report', 'Design mockup'] }
              // modifier: { width: 220, height: '100%' }
              CardView({ title: 'To Do', tasks: ['Write report', 'Design mockup'] }).width(220).height('100%')
              
              // === CardView (In Progress) ===
              // props: { title: 'In Progress', tasks: ['Implement feature X', 'Fix layout bug'] }
              // modifier: { width: 220, height: '100%' }
              CardView({ title: 'In Progress', tasks: ['Implement feature X', 'Fix layout bug'] }).width(220).height('100%')
              
              // === CardView (Done) ===
              // props: { title: 'Done', tasks: ['Team sync', 'Client feedback'] }
              // modifier: { width: 220, height: '100%' }
              CardView({ title: 'Done', tasks: ['Team sync', 'Client feedback'] }).width(220).height('100%')
            }.width('100%').padding({ top: 4, bottom: 4 })
          }.scrollable(ScrollDirection.Horizontal).scrollBar(BarState.Off)

          // === Text ===
          // props: { text: 'Task Completion' }
          // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#1E1E1E' }
          Text('Task Completion').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#1E1E1E')

          // === Progress ===
          // props: { value: 65, total: 100, type: ProgressType.Linear }
          // modifier: { width: '100%', height: 8, color: '#2563EB', trackColor: '#E5E7EB' }
          Progress({ value: 65, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color('#2563EB')
            .backgroundColor('#E5E7EB')
        }
      }
    }.width('100%').height('100%')
  }
}

@Component
struct CardView {
  private title: string = ''
  private tasks: Array<string> = []

  build() {
    // === Column ===
    // props: { space: 8 }
    // modifier: { width: '100%', height: '100%', padding: 12, backgroundColor: '#FFF', borderRadius: 14, shadow: { radius: 8, color: '#1F000000', offsetY: 4 } }
    // children: 3
    Column({ space: 8 }) {
      // === Text ===
      // props: { text: this.title }
      // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#2563EB' }
      Text(this.title).fontSize(18).fontWeight(FontWeight.Medium).fontColor('#2563EB')

      // === ForEach ===
      // props: { data: this.tasks }
      // children: 1
      ForEach(this.tasks, (task: string) => {
        // === AssistChipView ===
        // props: { task: task }
        AssistChipView({ task: task })
      })

      // === Blank ===
      Blank().layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(12)
    .backgroundColor('#FFF')
    .borderRadius(14)
    .shadow({ radius: 8, color: '#1F000000', offsetY: 4 })
  }
}

@Component
struct AssistChipView {
  private task: string = ''

  build() {
    // === Button ===
    // props: {}
    // modifier: { type: ButtonType.Capsule, stateEffect: false }
    // children: 1
    Button({ type: ButtonType.Capsule, stateEffect: false }) {
      // === Text ===
      // props: { text: this.task }
      // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#1E1E1E' }
      Text(this.task).fontSize(14).fontWeight(FontWeight.Normal).fontColor('#1E1E1E')
    }
    .backgroundColor('#E5E7EB')
    .borderRadius(10)
    .margin({ bottom: 8 })
  }
}