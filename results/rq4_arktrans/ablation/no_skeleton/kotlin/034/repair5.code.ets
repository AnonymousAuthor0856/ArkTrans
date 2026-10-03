// src/main/ets/view/ExploreMap.ets

@Entry
@Component
struct ExploreMap {
  @State query: string = ""

  build() {
    Column() {
      // === Header ===
      Text('Explore Map')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00FF66')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 40, bottom: 32 })

      // === Search Input ===
      TextInput({ placeholder: 'Search destination' })
        .type(InputType.TEXT)
        .backgroundColor('#000000')
        .borderRadius(10)
        .border({ width: 1, color: '#1F1F1F' })
        .padding({ left: 16, right: 16, top: 16, bottom: 16 })
        .height(56)
        .width('100%')
        .margin({ bottom: 16 })
        .onChange((value: string) => {
          this.query = value
        })

      // === List of Markers ===
      Column({ space: 12 }) {
        // Marker 1
        Row() {
          Column() {
            Text('Central Plaza').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#E0E0E0')
            Text('1.2 km').fontSize(13).fontColor('#CCCCCC').margin({ top: 4 })
          }
          Blank()
          Button('View')
            .backgroundColor('#00FF66')
            .fontColor('#000000')
            .borderRadius(6)
            .height(40)
            .width(80)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .padding(12)
        .backgroundColor('#0A0A0A')
        .borderRadius(10)

        // Marker 2
        Row() {
          Column() {
            Text('Museum District').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#E0E0E0')
            Text('3.4 km').fontSize(13).fontColor('#CCCCCC').margin({ top: 4 })
          }
          Blank()
          Button('View')
            .backgroundColor('#00FF66')
            .fontColor('#000000')
            .borderRadius(6)
            .height(40)
            .width(80)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .padding(12)
        .backgroundColor('#0A0A0A')
        .borderRadius(10)

        // Marker 3
        Row() {
          Column() {
            Text('Tech Park').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#E0E0E0')
            Text('5.6 km').fontSize(13).fontColor('#CCCCCC').margin({ top: 4 })
          }
          Blank()
          Button('View')
            .backgroundColor('#00FF66')
            .fontColor('#000000')
            .borderRadius(6)
            .height(40)
            .width(80)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .padding(12)
        .backgroundColor('#0A0A0A')
        .borderRadius(10)

        // Marker 4
        Row() {
          Column() {
            Text('Old Town Gate').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#E0E0E0')
            Text('7.8 km').fontSize(13).fontColor('#CCCCCC').margin({ top: 4 })
          }
          Blank()
          Button('View')
            .backgroundColor('#00FF66')
            .fontColor('#000000')
            .borderRadius(6)
            .height(40)
            .width(80)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .padding(12)
        .backgroundColor('#0A0A0A')
        .borderRadius(10)
      }
      .layoutWeight(1)

      // === Bottom Action ===
      Button('Refresh Map')
        .width('100%')
        .height(48)
        .backgroundColor('#00FF66')
        .fontColor('#000000')
        .borderRadius(14)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .margin({ top: 32, bottom: 32 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#000000')
  }
}