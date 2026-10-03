@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        // Header Section
        Row() {
          Column({ space: 4 }) {
            Text('Hello, Sophie')
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1A1A1A')
            
            Text("Let's start learning!")
              .fontSize(16)
              .fontColor('#757575')
          }

          Blank()

          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor('#1A1A1A')
            .margin({ right: 16 })

          Image($r('app.media.startIcon'))
            .width(48)
            .height(48)
            .borderRadius(24)
            .backgroundColor('#D1C4E9')
            .objectFit(ImageFit.Contain)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 40, bottom: 24 })

        // Search Bar
        Row() {
          Image($r('app.media.startIcon'))
            .width(20)
            .height(20)
            .fillColor('#757575')
            .margin({ right: 12 })
          
          Text('Search for course...')
            .fontSize(16)
            .fontColor('#BDBDBD')
            .layoutWeight(1)
          
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor('#5E35B1')
        }
        .width('100%')
        .height(56)
        .backgroundColor(Color.White)
        .borderRadius(16)
        .padding({ left: 16, right: 16 })
        .margin({ left: 24, right: 24, bottom: 24 })

        // Ongoing Course Title
        Text('Ongoing Course')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1A1A')
          .margin({ left: 24, bottom: 16 })

        // Course Card
        Row() {
          Column({ space: 12 }) {
            Text('3D Modeling')
              .fontSize(16)
              .fontColor('#E8DAEF')
            
            Text('Blender Basic')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
            
            Row({ space: 8 }) {
              Text('75%')
                .fontSize(14)
                .fontColor(Color.White)
              
              Progress({ value: 75, total: 100, type: ProgressType.Linear })
                .width(180)
                .height(8)
                .color('#FFAB40')
                .trackColor('rgba(255,255,255,0.2)')
            }
          }
          .layoutWeight(1)
          
          Circle({ width: 64, height: 64 })
            .fill(Color.White)
            .margin({ left: 16 })
            
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor('#5E35B1')
            .margin({ left: -32 })
        }
        .width('100%')
        .height(160)
        .backgroundColor('#5E35B1')
        .borderRadius(24)
        .padding({ left: 24, right: 24 })
        .margin({ left: 24, right: 24, bottom: 24 })

        // Categories
        Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
          Button('Coding')
            .backgroundColor('#F5F5F5')
            .fontColor('#757575')
            .borderRadius(16)
            .height(56)
            .width('30%')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
          
          Button('Design')
            .backgroundColor('#FF7043')
            .fontColor(Color.White)
            .borderRadius(16)
            .height(56)
            .width('30%')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
          
          Button('Business')
            .backgroundColor('#F5F5F5')
            .fontColor('#757575')
            .borderRadius(16)
            .height(56)
            .width('30%')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
        .margin({ bottom: 24 })

        // Recommended Header
        Row() {
          Text('Recommended')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1A1A1A')
            .layoutWeight(1)
          
          Text('See all')
            .fontSize(16)
            .fontColor('#757575')
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
        .margin({ bottom: 16 })

        // Recommended Item (Partial)
        Row() {
          Column() {
            Image($r('app.media.startIcon'))
              .width(80)
              .height(80)
              .borderRadius(12)
              .backgroundColor('#E3F2FD')
          }
          .width(80)
          .height(80)
          
          Column({ space: 4 }) {
            Text('Android Compose')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#5E35B1')
            
            Text('Mobile Development')
              .fontSize(14)
              .fontColor('#757575')
          }
          .layoutWeight(1)
          .margin({ left: 16 })
        }
        .width('100%')
        .height(100)
        .backgroundColor(Color.White)
        .borderRadius(16)
        .padding({ left: 16, right: 16 })
        .margin({ left: 24, right: 24 })

        Blank()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')

      // Bottom Navigation
      Row() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor(Color.White)
        
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor('#757575')
        
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor('#757575')
        
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor('#757575')
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .width('90%')
      .height(64)
      .backgroundColor('#212121')
      .borderRadius(32)
      .shadow({ radius: 10, color: 'rgba(0,0,0,0.2)' })
      .position({ x: '5%', y: '90%' })
    }
    .width('100%')
    .height('100%')
  }
}