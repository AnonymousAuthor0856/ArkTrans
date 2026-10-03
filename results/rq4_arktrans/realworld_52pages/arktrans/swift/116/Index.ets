@Entry
@Component
struct Index {
  @State cities: string[] = ['Chambéry']

  build() {
    Stack() {
      Column() {
        // Header Row (Edit + Add)
        Row() {
          Text('Edit')
            .fontColor('#007AFF')
            .fontSize(17)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              // Edit action placeholder
            })
          
          Blank()
          
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor(Color.White)
          }
          .backgroundColor('#007AFF')
          .borderRadius(20)
          .width(40)
          .height(40)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 16, bottom: 8 })

        // Title
        Text('Weather')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ left: 16, top: 8, bottom: 16 })

        // Section Header
        Text('YOUR CITIES')
          .fontSize(13)
          .fontColor('#8E8E93')
          .letterSpacing(0.5)
          .margin({ left: 16, bottom: 8 })

        // List Container
        Column() {
          ForEach(this.cities, (city: string) => {
            Row() {
              Text(city)
                .fontSize(22)
                .fontColor('#000000')
              
              Blank()
              
              // Placeholder for weather icon/image
              Image($r('app.media.startIcon'))
                .width(40)
                .height(24)
                .borderRadius(4)
                .objectFit(ImageFit.Cover)
                .opacity(0.1) // Simulating the greyed out look from screenshot
              
              Blank().width(10)
              
              // Chevron
              Image($r('app.media.startIcon')) // Reusing startIcon as chevron proxy or using text
                .width(12)
                .height(12)
                .fillColor('#C7C7CC')
                .visibility(Visibility.Hidden) // Hiding image to use text arrow instead for accuracy
                
              Text('>')
                .fontSize(20)
                .fontColor('#C7C7CC')
                .margin({ right: 16 })
            }
            .width('100%')
            .height(60)
            .alignItems(VerticalAlign.Center)
          })
        }
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ left: 16, right: 16 })
        
        Blank()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F2F2F7')
    }.width('100%').height('100%')
  }
}