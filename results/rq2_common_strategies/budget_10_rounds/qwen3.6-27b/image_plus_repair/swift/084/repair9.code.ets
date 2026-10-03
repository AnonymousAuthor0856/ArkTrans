@Entry
@Component
struct V60GuideApp {
  build() {
    Column() {
      // Header Section
      Row() {
        Column() {
          Text('V60 Guide')
            .fontSize(34)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
          
          Text('Ethiopia Yirgacheffe')
            .fontSize(16)
            .fontColor('#8E8E93')
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ top: 50, left: 24 })
        
        Image($r('app.media.settings'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .margin({ right: 24, top: 50 })
      }
      .width('100%')
      
      // Timer Section
      Column() {
        Text('00:45')
          .fontSize(90)
          .fontColor(Color.Black)
          .lineHeight(90)
          .letterSpacing(-2)
        
        Text('Target: 300g')
          .fontSize(18)
          .fontColor('#8E8E93')
          .margin({ top: 10 })
      }
      .margin({ top: 40 })
      
      // Parameters Grid
      Row() {
        ParameterItem({ icon: $r('app.media.plus'), value: '1:15', label: 'Ratio' })
        ParameterItem({ icon: $r('app.media.heart'), value: '20g', label: 'Beans' })
        ParameterItem({ icon: $r('app.media.refresh'), value: '93°C', label: 'Temp' })
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .width('100%')
      .margin({ top: 40 })
      
      // Divider Line
      Divider()
        .color('#E5E5EA')
        .margin({ top: 30, bottom: 20, left: 24, right: 24 })
      
      // Brewing Steps Section
      Column() {
        Text('Brewing Steps')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ left: 24 })
        
        Row() {
          Image($r('app.media.checkmark'))
            .width(28)
            .height(28)
            .backgroundColor(Color.Black)
            .borderRadius(14)
            .margin({ right: 16 })
          
          Rect()
            .fill('#F2F2F7')
            .borderRadius(10)
            .height(52)
            .width(100)
        }
        .margin({ top: 15, left: 24 })
      }
      
      // Start Button
      Button() {
        Row() {
          Image($r('app.media.play'))
            .width(18)
            .height(18)
            .margin({ right: 8 })
          
          Text('Start Brewing')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .height(60)
        .backgroundColor(Color.Black)
        .borderRadius(18)
      }
      .margin({ top: 30, left: 24, right: 24, bottom: 30 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct ParameterItem {
  @Prop icon: Resource
  @Prop value: string
  @Prop label: string
  
  build() {
    Column() {
      Row() {
        Image(this.icon)
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
      }
      .width(64)
      .height(64)
      .borderRadius(32)
      .border({ width: 1.5, color: '#E5E5EA' })
      
      Text(this.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ top: 12 })
      
      Text(this.label)
        .fontSize(13)
        .fontWeight(FontWeight.Medium)
        .fontColor('#8E8E93')
    }
    .width(80)
  }
}