// entry/src/main/ets/viewpages/AeroSensePage.ets

import { drawing } from '@kit.ArkGraphics';

@Entry
@Component
struct AeroSensePage {
  @State aqiValue: number = 42

  build() {
    Column() {
      // Main Content Area (Scrollable)
      Scroll() {
        Column({ space: 32 }) {
          // 1. Air Quality Circle
          this.AirQualityCircle(this.aqiValue)

          // 2. Metrics Grid
          Column({ space: 16 }) {
            Row({ space: 16 }) {
              this.MetricCard('Temp', '23°C', '#1A1A1A', $r('app.media.ic_info'))
              this.MetricCard('Humidity', '45%', '#4CAF50', $r('app.media.ic_check'))
            }
            Row({ space: 16 }) {
              this.MetricCard('PM 2.5', '12', '#4CAF50', $r('app.media.ic_check'))
              this.MetricCard('CO2', '850', '#FF9800', $r('app.media.ic_warning'))
            }
          }

          // 3. Status Banner
          this.StatusBanner()
        }
        .padding({ top: 16, bottom: 16 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Control Bar
      this.BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .padding({ left: 24, right: 24 })
  }

  // --- Sub-Components ---

  @Builder
  TopHeader() {
    Row() {
      Column({ space: 4 }) {
        Text('Living Room')
          .fontColor('#757575')
          .fontSize(16)
        Text('AeroSense')
          .fontColor('#1A1A1A')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Image($r('app.media.ic_settings'))
          .width(24)
          .height(24)
          .fillColor('#1A1A1A')
      }
      .width(48)
      .height(48)
      .backgroundColor('#FAFAFA')
      .borderRadius(24)
    }
    .width('100%')
    .margin({ top: 24, bottom: 24 })
  }

  @Builder
  AirQualityCircle(aqi: number) {
    Stack() {
      Canvas()
        .width(220)
        .height(220)
        .onReady((context: drawing.DrawingRenderingContext) => {
          const ctx = context as CanvasRenderingContext2D;
          
          // Background Track
          ctx.beginPath();
          ctx.arc(110, 110, 100, degToRad(135), degToRad(405));
          ctx.lineWidth = 40;
          ctx.strokeStyle = '#FAFAFA';
          ctx.stroke();

          // Progress Track (Calculated based on AQI)
          // 270 degrees total sweep. 
          const progressAngle = 135 + (270 * (aqi / 100))
          ctx.beginPath();
          ctx.arc(110, 110, 100, degToRad(135), degToRad(progressAngle));
          ctx.lineWidth = 40;
          ctx.lineCap = drawing.LineCap.Round;
          ctx.strokeStyle = '#4CAF50';
          ctx.stroke();
        })

      // Center Content
      Column({ space: 8 }) {
        Text('AQI')
          .fontColor('#757575')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
        
        Text(`${aqi}`)
          .fontColor('#1A1A1A')
          .fontSize(80)
          .fontWeight(FontWeight.Medium)
          .lineHeight(80)

        Text('Excellent')
          .fontColor('#4CAF50')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor('#4CAF501A') // Hex alpha for 0.1 opacity
          .borderRadius(16)
      }
    }
    .width(220)
    .height(220)
    .alignContent(Alignment.Center)
  }

  @Builder
  MetricCard(label: string, value: string, color: string, iconRes: Resource) {
    Column({ space: 0 }) {
      Row() {
        Image(iconRes)
          .width(24)
          .height(24)
          .fillColor(color)
        Blank()
      }
      .width('100%')

      Blank()

      Column({ space: 4 }) {
        Text(value)
          .fontColor('#1A1A1A')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
        Text(label)
          .fontColor('#757575')
          .fontSize(12)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(110)
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(24)
  }

  @Builder
  StatusBanner() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        Image($r('app.media.ic_home'))
          .width(24)
          .height(24)
          .fillColor('#1A1A1A')
        Text('Room Analysis')
          .fontColor('#1A1A1A')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')

      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontColor('#757575')
        .fontSize(14)
        .lineHeight(22)
    }
    .width('100%')
    .padding(20)
    .borderRadius(20)
    .border({ width: 1, color: '#EEEEEE' })
  }

  @Builder
  BottomControlBar() {
    Column() {
      Divider()
        .color('#EEEEEE')
        .margin({ bottom: 16 })

      Row({ space: 16 }) {
        // Menu Icon
        Button() {
          Image($r('app.media.ic_menu'))
            .width(24)
            .height(24)
            .fillColor('#1A1A1A')
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .border({ width: 1, color: '#EEEEEE' })

        // Refresh Button
        Button() {
          Row({ space: 8 }) {
            Image($r('app.media.ic_refresh'))
              .width(20)
              .height(20)
              .fillColor('#FFFFFF')
            Text('Refresh Data')
              .fontColor('#FFFFFF')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
          }
        }
        .layoutWeight(1)
        .height(56)
        .backgroundColor('#1A1A1A')
        .borderRadius(16)

        // Add Icon
        Button() {
          Image($r('app.media.ic_add'))
            .width(24)
            .height(24)
            .fillColor('#1A1A1A')
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .border({ width: 1, color: '#EEEEEE' })
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
  }
}

function degToRad(deg: number): number {
  return deg * Math.PI / 180;
}