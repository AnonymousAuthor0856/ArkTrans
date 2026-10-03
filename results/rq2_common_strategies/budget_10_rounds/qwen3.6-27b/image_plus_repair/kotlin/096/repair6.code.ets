@Entry
@Component
struct AeroSenseApp {
  @State aqi: number = 42;

  build() {
    Column() {
      // Top Header
      Row() {
        Column() {
          Text('Living Room')
            .fontColor('#757575')
            .fontSize(16)
            .fontWeight(FontWeight.Normal)
          
          Text('AeroSense')
            .fontColor('#1A1A1A')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 4 })
        }
        
        Blank()

        Button() {
          Image($r('app.media.settings')) 
            .width(24)
            .height(24)
            .fillColor('#1A1A1A')
        }
        .backgroundColor('#FAFAFA')
        .borderRadius(24)
        .width(48)
        .height(48)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })

      // Main Content Scrollable Area
      Scroll() {
        Column() {
          // Air Quality Circle
          this.AirQualityCircle()

          // Metrics Grid
          Column() {
            Row() {
              this.MetricCard('Temp', '23°C', '#1A1A1A', $r('app.media.info'))
              this.MetricCard('Humidity', '45%', '#4CAF50', $r('app.media.check'))
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            
            Row() {
              this.MetricCard('PM 2.5', '12', '#4CAF50', $r('app.media.check_circle'))
              this.MetricCard('CO2', '850', '#FF9800', $r('app.media.warning'))
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: 16 })
          }
          .margin({ top: 32 })

          // Status Banner
          this.StatusBanner()
            .margin({ top: 32 })
        }
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Control Bar
      Column() {
        Divider().color('#EEEEEE')
        
        Row() {
          Button() {
            Image($r('app.media.menu'))
              .width(24)
              .height(24)
              .fillColor('#1A1A1A')
          }
          .backgroundColor(Color.Transparent)
          .border({ width: 1, color: '#EEEEEE', radius: 24 })
          .width(48)
          .height(48)

          Blank()

          Button('Refresh Data')
            .backgroundColor('#1A1A1A')
            .fontColor('#FFFFFF')
            .borderRadius(16)
            .width('50%')
            .height(56)
            .margin({ left: 16, right: 16 })
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)
            .beforeTextBuilder() {
              Image($r('app.media.refresh'))
                .width(18)
                .height(18)
                .fillColor('#FFFFFF')
            }

          Button() {
            Image($r('app.media.add'))
              .width(24)
              .height(24)
              .fillColor('#1A1A1A')
          }
          .backgroundColor(Color.Transparent)
          .border({ width: 1, color: '#EEEEEE', radius: 24 })
          .width(48)
          .height(48)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 16, bottom: 24 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  AirQualityCircle() {
    Column() {
      Stack() {
        // Background Arc (Simulated with Canvas or Shape)
        // For simplicity in ArkTS without complex canvas math, we use a circular progress approach
        // Note: A real implementation would use Canvas for precise arc drawing like Compose
        Circle()
          .width(220)
          .height(220)
          .fill('none')
          .stroke('#FAFAFA')
          .strokeWidth(40)
          .linearGradient({
            angle: 135,
            colors: [['#FAFAFA', 0], ['#FAFAFA', 1]]
          })
          .rotate({ angle: 135 }) // Rotate to start at top-leftish

        // Foreground Arc (Green)
        // In ArkTS, creating a partial arc usually requires Canvas. 
        // Here we simulate the visual with a rotated circle and clip or just a simple shape for demo
        // To match the screenshot exactly, we'd need a custom DrawTask.
        // Using a simplified representation:
        Circle()
          .width(220)
          .height(220)
          .fill('none')
          .stroke('#4CAF50')
          .strokeWidth(40)
          .lineCap(LineCap.Round)
          .rotate({ angle: 135 })
          .clipPath({
            type: ClipType.Rect,
            rect: new Rect(0, 0, 220, 110) // Roughly half
          })

        Column() {
          Text('AQI')
            .fontColor('#757575')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)
          
          Text(`${this.aqi}`)
            .fontColor('#1A1A1A')
            .fontSize(80)
            .fontWeight(FontWeight.Medium)
            .margin({ top: -10 })
          
          Text('Excellent')
            .fontColor('#4CAF50')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .backgroundColor('#E8F5E9') // Light green bg
            .borderRadius(16)
            .padding({ left: 12, right: 12, top: 6, bottom: 6 })
            .margin({ top: 10 })
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(220)
      .height(220)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .margin({ top: 20 })
  }

  @Builder
  MetricCard(label: string, value: string, statusColor: string, iconRes: Resource) {
    Column() {
      Row() {
        Image(iconRes)
          .width(20)
          .height(20)
          .fillColor(statusColor)
        
        Blank()
      }
      .width('100%')

      Text(value)
        .fontColor('#1A1A1A')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 10 })
      
      Text(label)
        .fontColor('#757575')
        .fontSize(14)
        .margin({ top: 4 })
    }
    .width('48%')
    .height(110)
    .backgroundColor('#FAFAFA')
    .borderRadius(24)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  StatusBanner() {
    Column() {
      Row() {
        Image($r('app.media.home'))
          .width(24)
          .height(24)
          .fillColor('#1A1A1A')
        
        Text('Room Analysis')
          .fontColor('#1A1A1A')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 12 })
      }
      
      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontColor('#757575')
        .fontSize(14)
        .lineHeight(22)
        .margin({ top: 12 })
    }
    .width('100%')
    .border({ width: 1, color: '#EEEEEE', radius: 20 })
    .padding(20)
  }
}