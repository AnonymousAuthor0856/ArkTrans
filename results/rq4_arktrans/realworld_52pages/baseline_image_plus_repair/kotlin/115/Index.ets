@Entry
@Component
struct EditNoteView {
  @State noteName: string = 'Sample Note Title'
  @State noteDescription: string = ''

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Easy Notes')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#F0F0F0')

      // Content Area
      Column() {
        // Title Field
        TextInput({ text: this.noteName })
          .placeholderColor(Color.Gray)
          .placeholder('Name')
          .backgroundColor('#F5F5F7')
          .borderRadius({ topLeft: 16, topRight: 16 })
          .height(80)
          .margin({ left: 16, right: 16, top: 16 })
          .onChange((value: string) => {
            this.noteName = value
          })

        // Description Field
        TextArea({ text: this.noteDescription })
          .placeholderColor(Color.Gray)
          .placeholder('Write your note description here...')
          .backgroundColor('#F5F5F7')
          .borderRadius({ bottomLeft: 16, bottomRight: 16 })
          .layoutWeight(1)
          .margin({ left: 16, right: 16, top: 3 })
          .onChange((value: string) => {
            this.noteDescription = value
          })
      }
      .layoutWeight(1)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
  }
}