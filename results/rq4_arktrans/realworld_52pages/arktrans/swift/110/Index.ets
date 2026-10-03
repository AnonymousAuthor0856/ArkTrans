@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        // Header Row
        Row() {
          Text('This is an example note')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .layoutWeight(1)

          Image($r('app.media.startIcon'))
            .width(32)
            .height(32)
            .objectFit(ImageFit.Contain)
            .borderRadius(16)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 50, bottom: 16 })

        Divider().color('#E0E0E0').margin({ left: 24, right: 24 })

        // Body Content
        Column() {
          Text('Hello, world! 🌍\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent volutpat dui eget metus porttitor dapibus. Nunc sed arcu gravida, ornare eros vitae, finibus orci.\nAenean ac augue faucibus, gravida lectus nec, lobortis magna. Mauris eleifend ipsum at faucibus dictum. Phasellus quam nulla, tristique vulputate diam id, ullamcorper hendrerit felis. Vestibulum faucibus tristique rutrum. Vivamus posuere semper orci, sit amet imperdiet nulla. Phasellus ultricies eget odio in posuere.')
            .fontSize(20)
            .lineHeight(30)
            .fontColor('#000000')
            .textAlign(TextAlign.Start)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 16 })
        .layoutWeight(1)

        // Footer Category Bar
        Row() {
          Row() {
            Circle()
              .width(12)
              .height(12)
              .fill('#4DB6AC')
            
            Text('Thoughts')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
              .margin({ left: 10 })
          }
          .layoutWeight(1)

          Text('Change Category')
            .fontSize(20)
            .fontColor('#B08D69')
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 16, bottom: 30 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }.width('100%').height('100%')
  }
}