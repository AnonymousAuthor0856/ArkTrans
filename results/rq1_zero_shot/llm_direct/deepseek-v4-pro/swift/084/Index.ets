@Entry
@Component
struct V60GuideApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct ContentView {
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
        
        Blank()
        
        Button() {
          // Settings action
        }
        .width(44)
        .height(44)
        .backgroundColor(Color.Transparent)
        .backgroundImage($r('sys.symbol.gearshape_fill'))
        .backgroundImageSize(24)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 30, bottom: 0 })
      .alignItems(VerticalAlign.Top)
      
      Blank()
      
      // Timer Section
      Column({ space: 10 }) {
        Text('00:45')
          .fontSize(90)
          .fontWeight(FontWeight.Regular)
          .fontColor(Color.Black)
          .fontFeature("\"tnum\" 1")
          .maxLines(1)
        
        Text('Target: 300g')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#8E8E93')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      
      Blank()
      
      // Parameters Grid
      Row() {
        ParameterItem({
          icon: 'plus',
          value: '1:15',
          label: 'Ratio'
        })
        
        Blank()
        
        ParameterItem({
          icon: 'heart_fill',
          value: '20g',
          label: 'Beans'
        })
        
        Blank()
        
        ParameterItem({
          icon: 'arrow_clockwise',
          value: '93°C',
          label: 'Temp'
        })
      }
      .width('100%')
      .padding({ left: 30, right: 30 })
      .justifyContent(FlexAlign.SpaceBetween)
      
      Blank()
      
      // Divider Line
      Divider()
        .strokeWidth(0.5)
        .color('#D1D1D6')
        .margin({ left: 24, right: 24, bottom: 20 })
      
      // Brewing Steps Section
      Column({ space: 15 }) {
        Text('Brewing Steps')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .width('100%')
          .padding({ left: 24, right: 24 })
          .textAlign(TextAlign.Start)
        
        // Step Item Row
        Row({ space: 16 }) {
          // Checkmark Icon
          Column() {
            Text('✓')
              .fontSize(28)
              .fontColor(Color.Black)
          }
          .width(28)
          .height(28)
          .borderRadius(14)
          .backgroundColor(Color.White)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          
          // Step Content Background
          Row() {
            // Placeholder for step content
          }
          .width('100%')
          .height(52)
          .borderRadius(10)
          .backgroundColor('#F2F2F7')
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      
      Blank()
      
      // Start Button
      Button() {
        // Start brewing action
      }
      .width('100%')
      .height(60)
      .borderRadius(18)
      .backgroundColor(Color.Black)
      .margin({ left: 24, right: 24, bottom: 30 })
      .type(ButtonType.Normal)
      .borderRadius(18)
      
      Row({ space: 8 }) {
        Text('▶')
          .fontSize(18)
          .fontColor(Color.White)
        
        Text('Start Brewing')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .position({ x: '50%', y: '50%' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct ParameterItem {
  @Prop icon: string = 'plus'
  @Prop value: string = ''
  @Prop label: string = ''
  
  build() {
    Column({ space: 12 }) {
      // Circular Icon Button
      Column() {
        Text(this.getIconSymbol())
          .fontSize(24)
          .fontColor('#8E8E93')
      }
      .width(64)
      .height(64)
      .borderRadius(32)
      .border({ width: 1.5, color: '#E5E5EA' })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      
      // Text Values
      Column({ space: 4 }) {
        Text(this.value)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        
        Text(this.label)
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .fontColor('#8E8E93')
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(80)
    .alignItems(HorizontalAlign.Center)
  }
  
  private getIconSymbol(): string {
    if (this.icon === 'plus') {
      return '+'
    } else if (this.icon === 'heart_fill') {
      return '♥'
    } else if (this.icon === 'arrow_clockwise') {
      return '↻'
    }
    return ''
  }
}