import { Image, Button, Text, Row, Column, Stack, Divider, FlexAlign, GridRow, GridColumn } from '@kit.ArkUI';

@Entry
@Component
struct V60GuideApp {
  build() {
    Column() {
      // Header Section
      Row() {
        Column({ space: 4 }) {
          Text('V60 Guide')
            .fontSize(34)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
          
          Text('Ethiopia Yirgacheffe')
            .fontSize(16)
            .fontColor('#8E8E93') // iOS System Gray
        }
        .alignItems(HorizontalAlign.Start)
        
        Flex({ justifyContent: FlexAlign.End })
        
        Button({ type: ButtonType.Circle }) {
          Image($r('app.media.ic_settings')) // Placeholder for gear icon
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        }
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
      }
      .padding({ left: 24, right: 24, top: 30, bottom: 30 })
      
      Flex({ justifyContent: FlexAlign.Center })
      
      // Timer Section
      Column({ space: 10 }) {
        Text('00:45')
          .fontSize(90)
          .fontWeight(FontWeight.Regular)
          .fontColor(Color.Black)
          .lineHeight(90)
          .textAlign(TextAlign.Center)
        
        Text('Target: 300g')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#8E8E93')
      }
      
      Flex({ justifyContent: FlexAlign.Center })
      
      // Parameters Grid
      Row({ space: 0 }) {
        ParameterItem(icon: 'plus', value: '1:15', label: 'Ratio')
        
        Flex({ justifyContent: FlexAlign.Center })
        
        ParameterItem(icon: 'heart', value: '20g', label: 'Beans')
        
        Flex({ justifyContent: FlexAlign.Center })
        
        ParameterItem(icon: 'clock', value: '93°C', label: 'Temp')
      }
      .padding({ left: 30, right: 30 })
      
      Flex({ justifyContent: FlexAlign.Center })
      
      // Divider Line
      Divider()
        .margin({ left: 24, right: 24, bottom: 20 })
      
      // Brewing Steps Section
      Column({ space: 15 }) {
        Text('Brewing Steps')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ left: 24, right: 24 })
        
        Row({ space: 16 }) {
          // Checkmark Icon
          Stack() {
            Circle()
              .width(28)
              .height(28)
              .fill(Color.White)
            
            Image($r('app.media.ic_check')) // Placeholder for checkmark
              .width(28)
              .height(28)
              .fillColor(Color.Black)
          }
          
          // Step Content Background
          Row() {
            // Empty placeholder row to match height
          }
          .height(52)
          .backgroundColor('#F2F2F7') // iOS System Gray 6
          .borderRadius(10)
        }
        .margin({ left: 24, right: 24 })
      }
      
      Flex({ justifyContent: FlexAlign.Center })
      
      // Start Button
      Button({ type: ButtonType.Capsule }) {
        Row({ space: 8 }) {
          Image($r('app.media.ic_play')) // Placeholder for play icon
            .width(18)
            .height(18)
            .fillColor(Color.White)
          
          Text('Start Brewing')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
      }
      .width('100%')
      .height(60)
      .backgroundColor(Color.Black)
      .borderRadius(18)
      .margin({ left: 24, right: 24, bottom: 30 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct ParameterItem {
  @Prop icon: string;
  @Prop value: string;
  @Prop label: string;

  build() {
    Column({ space: 12 }) {
      // Circular Icon Button
      Stack() {
        Circle()
          .width(64)
          .height(64)
          .stroke('#D1D1D6') // iOS System Gray 5
          .strokeWidth(1.5)
          .fill(Color.Transparent)
        
        Image($r(`app.media.ic_${this.icon}`)) // Dynamic resource loading based on icon name
          .width(24)
          .height(24)
          .fillColor('#8E8E93')
      }
      
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
    }
    .width(80)
  }
}