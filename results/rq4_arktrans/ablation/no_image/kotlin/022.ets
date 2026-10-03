@Entry
@Component
struct Index {
  @State notificationsEnabled: boolean = false
  @State isOn: boolean = false
  @State syncProgress: number = 0.3

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        Row({ space: 0 }) {
          Text('Notifications').fontColor('#1E1E1E')
          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn
            })
        }.alignItems(VerticalAlign.Center).width('100%')

        List({ space: 12 }) {
          ListItem() {
            Column() {
              Column({ space: 8 }) {
                Text('task.name').fontColor('#38BDF8')
                Progress({ value: this.syncProgress, total: 1, type: ProgressType.Linear })
                  .width('100%').height(8).color('#6366F1').backgroundColor('#E2E8F0')
              }.width('100%').padding(12)
            }.shadow({ radius: 4, color: '#1A000000' }).backgroundColor('#FFFFFF').width('100%')
          }
        }.width('100%')

        Button() {
          Text('Add Task')
        }.height(52).width('100%')
      }.width('100%').height('100%').padding(16).backgroundColor('#F1F5F9')

      // Simulating CenterAlignedTopAppBar with a simple Row/Text at the top
      // Since CenterAlignedTopAppBar is not a standard ArkTS component, we approximate its visual structure
      // based on the skeleton's intent (a top bar with title).
      // Note: The skeleton places this inside the Stack but after the main content column in the tree,
      // however, visually it should be at the top. In ArkTS Stack, order matters for z-index if overlapping,
      // but here they are likely distinct areas or the Scaffold handles layout. 
      // Given the "Scaffold" comment in the skeleton, this TopAppBar is likely meant to be at the very top.
      // We will place it in the Stack. To ensure it stays at the top, we rely on Stack alignment or explicit positioning.
      // The skeleton has `Stack({ alignContent: Alignment.Top })`, so children are stacked from top.
      
      // Re-reading the skeleton structure:
      // Stack -> [Column (main content), CenterAlignedTopAppBar]
      // This implies the AppBar might be overlaying or below. Standard Scaffold puts AppBar above content.
      // However, strictly following the provided tree structure where AppBar is a sibling of the main Column:
      
      Row() {
        Text('Project Timeline').fontColor('#1E1E1E')
      }.width('100%').height(56).justifyContent(FlexAlign.Center).backgroundColor('#F1F5F9')
    }.width('100%').height('100%')
  }
}