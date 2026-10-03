@Entry
@Component
struct Index {
  @State scanning: boolean = false

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        Column() {
          Stack({ alignContent: Alignment.Center }) {
            Canvas().width('100%').height('100%')
          }.width('100%').height('100%')
        }.backgroundColor('#FFFFFF').shadow({ radius: 4, color: '#1A000000' }).width('100%').height(400)

        Row({ space: 0 }) {
          Text('Scanning Active')
          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
        }.alignItems(VerticalAlign.Center).width('100%')

        Button() {
          Text('Add Marker')
        }.height(48)
      }.alignItems(HorizontalAlign.Center).width('100%').height('100%').padding(16)

      CenterAlignedTopAppBar() {
        Text('Invoice Scanner')
      }
    }.width('100%').height('100%')
  }
}