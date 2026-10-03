@Entry
@Component
struct NoteEditView {
  @State noteTitle: string = ''
  @State noteContent: string = ''
  @State categoryColor: Color = Color.Blue
  @State categoryName: string = 'Thoughts'

  build() {
    Column() {
      // Title TextField
      TextInput({ placeholder: 'Title your note...' })
        .type(InputType.Normal)
        .width('100%')
        .height(40)
        .margin({ top: 20, left: 16 })
        .borderWidth(0)
        .backgroundColor(Color.Transparent)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .onChange((value: string) => {
          this.noteTitle = value
        })

      Divider()
        .color('#E5E5E5')
        .margin({ top: 10, bottom: 10 })

      // TextEditor
      TextArea({ placeholder: '' })
        .width('100%')
        .height('100%')
        .padding({ left: 16, right: 16 })
        .backgroundColor(Color.White)
        .borderWidth(0)
        .onChange((value: string) => {
          this.noteContent = value
        })

      Divider()
        .color('#E5E5E5')
        .margin({ top: 10, bottom: 10 })

      // Category Row
      Row() {
        Circle()
          .width(10)
          .height(10)
          .fill(this.categoryColor)

        Text(this.categoryName)
          .fontWeight(FontWeight.Bold)
          .fontSize(16)
          .margin({ left: 8 })

        Blank()

        Button('Change Category')
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .fontColor('#A67C52')
          .fontSize(16)
          .onClick(() => {
            // Handle category change
          })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 10, bottom: 10 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}