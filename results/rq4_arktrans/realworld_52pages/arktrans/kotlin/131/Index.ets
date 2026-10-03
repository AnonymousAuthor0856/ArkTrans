@Entry
@Component
struct Index {
  @State title: string = ''
  @State description: string = ''
  @State priority: string = 'Low Priority'

  build() {
    Column() {
      // === TopAppBar ===
      Row() {
        // Back Icon
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor(Color.White)
          .margin({ right: 16 })

        // Title
        Text('Add ToDo')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
          .layoutWeight(1)

        // Check Icon (using startIcon as placeholder for checkmark)
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor(Color.White)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#6750A4')
      .alignItems(VerticalAlign.Center)

      // === Form Content ===
      Column() {
        // Title Input
        TextInput({ placeholder: 'Title' })
          .type(InputType.Normal)
          .width('100%')
          .height(56)
          .backgroundColor(Color.White)
          .borderRadius(8)
          .borderWidth(1)
          .borderColor('#9E9E9E')
          .margin({ top: 24, bottom: 16 })
          .padding({ left: 16 })
          .onChange((value: string) => {
            this.title = value
          })

        // Priority Dropdown Simulation
        Row() {
          Text(this.priority)
            .fontSize(16)
            .fontColor('#1F1F1F')
            .layoutWeight(1)
          
          // Down Arrow Icon (using startIcon rotated or just placed)
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor('#616161')
        }
        .width('100%')
        .height(56)
        .backgroundColor(Color.White)
        .borderRadius(8)
        .borderWidth(1)
        .borderColor('#9E9E9E')
        .padding({ left: 16, right: 16 })
        .alignItems(VerticalAlign.Center)
        .onClick(() => {
          // Toggle logic would go here
          if (this.priority === 'Low Priority') {
            this.priority = 'High Priority'
          } else {
            this.priority = 'Low Priority'
          }
        })

        // Description Input
        TextArea({ placeholder: 'Description' })
          .width('100%')
          .height(300)
          .backgroundColor(Color.White)
          .borderRadius(8)
          .borderWidth(1)
          .borderColor('#9E9E9E')
          .margin({ top: 16 })
          .padding({ left: 16, top: 16 })
          .onChange((value: string) => {
            this.description = value
          })

      }
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 16 })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}