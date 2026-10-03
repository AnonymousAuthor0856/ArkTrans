@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Column() {
          Text('Medicine Reminder').fontColor('#111827').fontSize(28)

          Scroll() {
            Column() {
              ForEach([], (item: string) => {
                MedicineItem()
              })
            }.padding({ bottom: 32 })
          }.width('100%').height('100%')

          Blank()

          Button()
            .padding({ bottom: 8 })
            .padding({ left: 16, right: 16 })
        }
        .padding({ bottom: 56 })
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')
      }

      Column() {
        Blank()
        Row() {
          Text('Today').fontColor('#111827').fontSize(16)
          Blank()
          Text('History').fontColor('#1F2937').fontSize(16)
          Blank()
          Text('Profile').fontColor('#1F2937').fontSize(16)
        }
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 4, color: '#1F000000' })
      }

      Button()
        .padding(12)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct MedicineItem {
  build() {
    Column() {
      Text('Medicine Item')
    }
  }
}