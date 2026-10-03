@Entry
@Component
struct Index {
  @State scrollOffset: number = 0

  build() {
    Stack() {
      Column() {
        Text('Glass Doc Reader')
          .backgroundColor('#F1F5F9')
          .width('100%')
          .padding({ top: 20, bottom: 12 })
          .fontColor('#1E1E1E')
          .fontSize(28)

        Stack() {
          // Replace Color call with a valid UI component like Div or Column with background color
          Column()
            .backgroundColor('#E2E8F0')
            .opacity(0.8)
            .width('100%')
            .height('100%')

          Column() {
            Text('Document Reader')
              .fontColor('#38BDF8')
              .fontSize(18)

            ForEach(this.generateArray(), (index: number) => {
              Text(`This is a sample line of text content number ${index + 1}.`)
                .fontColor('#1E1E1E')
                .fontSize(14)
            })

            Blank()
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)
          .offset({ y: this.scrollOffset / 5 })
          .shadow({ radius: 6, color: '#33000000' })
          .gesture(
            PanGesture()
              .onActionStart((event: GestureEvent) => {
                // Handle start if needed
              })
              .onActionUpdate((event: GestureEvent) => {
                this.scrollOffset += event.offsetY
              })
              .onActionEnd((event: GestureEvent) => {
                // Handle end if needed
              })
          )
        }.width('100%').height('100%')
      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }

  private generateArray(): number[] {
    const arr: number[] = [];
    for (let i = 0; i < 8; i++) {
      arr.push(i);
    }
    return arr;
  }
}