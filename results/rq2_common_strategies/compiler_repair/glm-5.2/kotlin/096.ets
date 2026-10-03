// Index.ets
import { LengthMetrics } from '@ohos.arkui.theme';

@Entry
@Component
struct AeroSenseApp {
  build() {
    Column() {
      TopHeader()
      MainContent()
      BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct TopHeader {
  build() {
    Row() {
      Column() {
        Text('Living Room')
          .fontSize(14)
          .fontColor('#FF757575')
        Text('AeroSense')
          .fontSize(24)
          .fontColor('#FF1A1A1A')
          .fontWeight(FontWeight.Bold)
      }
      .alignItems(HorizontalAlign.Start)

      Button() {
        Image($r('sys.media.ohos_ic_public_settings'))
          .width(24)
          .height(24)
          .fillColor('#FF1A1A1A')
      }
      .width(48)
      .height(48)
      .backgroundColor('#FFFAFAFA')
      .borderRadius(24)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MainContent {
  build() {
    Scroll() {
      Column() {
        AirQualityCircle()
        
        Row() {
          MetricCard({ label: 'Temp', value: '23°C', statusColor: '#FF1A1A1A' })
          Blank().width(16)
          MetricCard({ label: 'Humidity', value: '45%', statusColor: '#FF4CAF50' })
        }
        .width('100%')
        .margin({ top: 32 })
        
        Row() {
          MetricCard({ label: 'PM 2.5', value: '12', statusColor: '#FF4CAF50' })
          Blank().width(16)
          MetricCard({ label: 'CO2', value: '850', statusColor: '#FFFF9800' })
        }
        .width('100%')
        .margin({ top: 16 })
        
        StatusBanner()
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 16, bottom: 16 })
    }
    .layoutWeight(1)
    .scrollBar(BarState.Off)
    .align(Alignment.Top)
  }
}

@Component
struct AirQualityCircle {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      // Background Track
      Arc()
        .width(220)
        .height(220)
        .startAngle(135)
        .sweepAngle(270)
        .fill(Color.Transparent)
        .stroke('#FFFAFAFA')
        .strokeWidth(40)
        .strokeLineCap(LineCapStyle.Round)
      
      // Progress Track
      Arc()
        .width(220)
        .height(220)
        .startAngle(135)
        .sweepAngle(110)
        .fill(Color.Transparent)
        .stroke('#FF4CAF50')
        .strokeWidth(40)
        .strokeLineCap(LineCapStyle.Round)
      
      Column() {
        Text('AQI')
          .fontSize(14)
          .fontColor('#FF757575')
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
        Text('42')
          .fontSize(80)
          .fontColor('#FF1A1A1A')
          .fontWeight(FontWeight.Medium)
          .margin({ top: 4, bottom: 8 })
        Text('Excellent')
          .fontSize(14)
          .fontColor('#FF4CAF50')
          .backgroundColor('#1A4CAF50')
          .borderRadius(16)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      }
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .aspectRatio(1.2)
  }
}

@Component
struct MetricCard {
  @Prop label: string = '';
  @Prop value: string = '';
  @Prop statusColor: string = '#FF1A1A1A';

  build() {
    Column() {
      Row() {
        Image($r('sys.media.ohos_ic_public_info'))
          .width(20)
          .height(20)
          .fillColor(this.statusColor)
      }
      .width('100%')
      .justifyContent(FlexAlign.End)

      Column() {
        Text(this.value)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF1A1A1A')
        Text(this.label)
          .fontSize(12)
          .fontColor('#FF757575')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .layoutWeight(1)
    .height(110)
    .padding(16)
    .backgroundColor('#FFFAFAFA')
    .borderRadius(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct StatusBanner {
  build() {
    Column() {
      Row() {
        Image($r('sys.media.ohos_ic_public_home'))
          .width(24)
          .height(24)
          .fillColor('#FF1A1A1A')
        Text('Room Analysis')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF1A1A1A')
          .margin({ left: 12 })
      }
      .alignItems(VerticalAlign.Center)

      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor('#FF757575')
        .lineHeight(22)
        .margin({ top: 12 })
        .textAlign(TextAlign.Start)
    }
    .width('100%')
    .padding(20)
    .borderRadius(20)
    .border({ width: 1, color: '#FFEEEEEE' })
    .alignItems(HorizontalAlign.Start)
    .margin({ top: 32 })
  }
}

@Component
struct BottomControlBar {
  build() {
    Column() {
      Divider().color('#FFEEEEEE').strokeWidth(1)
      Row() {
        Button() {
          Image($r('sys.media.ohos_ic_public_menu'))
            .width(24)
            .height(24)
            .fillColor('#FF1A1A1A')
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .border({ width: 1, color: '#FFEEEEEE' })
        .backgroundColor(Color.Transparent)

        Button() {
          Row() {
            Image($r('sys.media.ohos_ic_public_refresh'))
              .width(18)
              .height(18)
              .fillColor(Color.White)
            Text('Refresh Data')
              .fontSize(16)
              .fontColor(Color.White)
              .margin({ left: 8 })
          }
        }
        .height(52)
        .borderRadius(16)
        .backgroundColor('#FF1A1A1A')
        .padding({ left: 24, right: 24 })

        Button() {
          Image($r('sys.media.ohos_ic_public_add'))
            .width(24)
            .height(24)
            .fillColor('#FF1A1A1A')
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .border({ width: 1, color: '#FFEEEEEE' })
        .backgroundColor(Color.Transparent)
      }
      .width('100%')
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor(Color.White)
  }
}