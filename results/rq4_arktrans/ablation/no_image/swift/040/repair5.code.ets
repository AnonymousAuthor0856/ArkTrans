@Entry
@Component
struct Index {
  @State query: string = ''
  @State isTextFieldFocused: boolean = false

  build() {
    Stack() {
      Stack() {
        Column({ space: 12 }) {
          Text('Retro Filter Search')
            .width('100%')
            .textAlign(TextAlign.Start)
            .fontColor('#3E2723')
            .fontSize(28)

          TextInput({ placeholder: 'Search products' })
            .enabled(false)
            .contentType(ContentType.NormalText)
            .borderRadius(8)
            .backgroundColor('#FFFFFF')
            .height(56)
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
            .overlay(
              () => {
                Rect()
                  .width('100%')
                  .height('100%')
                  .borderRadius(8)
                  .border({
                    width: 1,
                    color: this.isTextFieldFocused ? '#FF7B00' : '#E0C080'
                  })
              }
            )

          Row({ space: 8 }) {
            ForEach(['Popular', 'New', 'Discount', 'Premium'], (item: string) => {
              Button(item)
                .borderRadius(4)
                .backgroundColor('#FFD166')
                .height(36)
            })
          }.width('100%').justifyContent(FlexAlign.Start)

          Stack() {
            Canvas(this.ctx).width('100%').height(180)
          }.width('100%').height(180)

          Grid() {
            ForEach([1, 2, 3, 4], (item: number) => {
              GridItem() {
                Column({ space: 8 }) {
                  Rect()
                    .width(96)
                    .height(96)
                    .fill('#FFF0C1')
                  
                  Text(`Product ${item}`)
                    .fontColor('#3E2723')
                    .fontSize(16)
                  
                  Button('Add')
                    .borderRadius(8)
                    .backgroundColor('#FF7B00')
                }
                .shadow({ radius: 4, color: '#0000001A' })
                .borderRadius(12)
                .backgroundColor('#FFFFFF')
                .padding(12)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(12)
          .rowsGap(12)
          .padding({ bottom: 24 })
        }
        .padding(12)
      }
    }.width('100%').height('100%')
  }

  private ctx: CanvasRenderingContext2D | null = null
}