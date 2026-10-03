@Entry
@Component
struct Index {
  @State query: string = ''
  @State isTextFieldFocused: boolean = false

  build() {
    Stack() {
      Column({ space: 16 }) {
        Text('Retro Filter Search')
          .fontColor('#3E2723')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .textAlign(TextAlign.Start)

        TextInput({ placeholder: 'Search products' })
          .type(InputType.Text)
          .backgroundColor('#FFFFFF')
          .height(56)
          .borderRadius(12)
          .padding({ left: 12, right: 12 })
          .placeholderColor('#3E272399')
          .placeholderFont({ size: 14 })
          .onChange((value: string) => {
            this.query = value
          })
          .onFocus(() => {
            this.isTextFieldFocused = true
          })
          .onBlur(() => {
            this.isTextFieldFocused = false
          })
          .border({
            width: 1,
            color: this.isTextFieldFocused ? '#FF7B00' : '#E0C080',
            radius: 12
          })

        Row({ space: 8 }) {
          Button('Popular').backgroundColor('#FFD166').height(36).borderRadius(8).fontColor('#3E2723')
          Button('New').backgroundColor('#FFD166').height(36).borderRadius(8).fontColor('#3E2723')
          Button('Discount').backgroundColor('#FFD166').height(36).borderRadius(8).fontColor('#3E2723')
          Button('Premium').backgroundColor('#FFD166').height(36).borderRadius(8).fontColor('#3E2723')
        }.width('100%').justifyContent(FlexAlign.Start)

        Stack() {
          Rect().fill('#FFF0C1').width('100%').height('100%')
          Circle().fill('#FF7B00').width(120).height(120).position({ x: '50%', y: '50%' }).margin({ top: -60, left: -60 })
          Circle().fill('#FF7B00').width(40).height(40).position({ x: '50%', y: '60%' }).margin({ top: -20, left: -20 })
        }
        .width('100%')
        .height(180)
        .borderRadius(16)
        .padding(16)

        Grid() {
          ForEach([1, 2, 3, 4], (item: number) => {
            GridItem() {
              Column({ space: 12 }) {
                Rect()
                  .fill('#FFF0C1')
                  .width(96)
                  .height(96)
                  .borderRadius(12)

                Text(`Result ${item}`)
                  .fontColor('#3E2723')
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)

                Button('Add')
                  .backgroundColor('#FF7B00')
                  .borderRadius(12)
                  .height(48)
                  .width('100%')
                  .fontColor('#FFFFFF')
              }
              .width('100%')
              .alignItems(HorizontalAlign.Center)
              .justifyContent(FlexAlign.Center)
              .backgroundColor('#FFFFFF')
              .borderRadius(24)
              .padding(24)
              .shadow({ radius: 10, color: '#0000001A', offsetY: 4 })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(16)
        .rowsGap(16)
        .width('100%')
        .layoutWeight(1)
        .padding({ bottom: 24 })

      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FDF6E3')
    }
    .width('100%')
    .height('100%')
  }
}