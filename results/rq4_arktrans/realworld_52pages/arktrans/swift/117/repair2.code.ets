@Entry
@Component
struct Index {
  @State search: string = ''

  build() {
    Stack() {
      Column() {
        // Header Section
        Row() {
          Text('Cancel')
            .fontColor('#007AFF')
            .fontSize(17)
            .onClick(() => {
              // Cancel action
            })
          
          Blank()
          
          Text('Add City')
            .fontSize(34)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
          
          Blank()
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 50, bottom: 16 })
        .backgroundColor('#F2F2F7')

        // Search Input Section
        TextInput({ placeholder: 'Search City' })
          .type(InputType.Text)
          .width('100%')
          .height(50)
          .backgroundColor(Color.White)
          .padding({ left: 16 })
          .borderWidth({ bottom: 1 })
          .borderColor('#C6C6C8')
          .onChange((value: string) => {
            this.search = value
          })

        // List Content Area (Empty in screenshot)
        List() {
          // Empty list as per screenshot
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#F2F2F7')
      }
      .width('100%')
      .height('100%')
    }.width('100%').height('100%')
  }
}