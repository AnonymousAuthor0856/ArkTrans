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
          Image($r('app.media.ic_settings')) // Placeholder for settings icon
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
              this.MetricCard('Temp', '23°C', '#1A1A1A', $r('app.media.ic_info'))
              this.MetricCard('Humidity', '45%', '#4CAF50', $r('app.media.ic_check'))
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            
            Row() {
              this.MetricCard('PM 2.5', '12', '#4CAF50', $r('app.media.ic_check_circle'))
              this.MetricCard('CO2', '850', '#FF9800', $r('app.media.ic_warning'))
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
            Image($r('app.media.ic_menu'))
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
            .rowGap(8)
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)
            .beforeTextBuilder() {
              Image($r('app.media.ic_refresh'))
                .width(18)
                .height(18)
                .fillColor('#FFFFFF')
            }

          Button() {
            Image($r('app.media.ic_add'))
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
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  AirQualityCircle() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        // Background Track
        CanvasRenderingContext2D()
          .drawArc(
            new Arc(0, 0, 220, 220, 135, 270, false), 
            { stroke: { width: 40, color: '#FAFAFA' }, cap: LineCap.Round }
          )
        
        // Progress Track (Approximate for AQI 42)
        CanvasRenderingContext2D()
          .drawArc(
            new Arc(0, 0, 220, 220, 135, 110, false), 
            { stroke: { width: 40, color: '#4CAF50' }, cap: LineCap.Round }
          )

        Column() {
          Text('AQI')
            .fontColor('#757575')
            .fontSize(14)
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
            .backgroundColor('#E8F5E9')
            .borderRadius(16)
            .padding({ left: 12, right: 12, top: 6, bottom: 6 })
            .margin({ top: 10 })
        }
      }
      .width(220)
      .height(220)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .aspectRatio(1.2)
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

      Column() {
        Text(value)
          .fontColor('#1A1A1A')
          .fontSize(28)
          .fontWeight(FontWeight.SemiBold)
        
        Text(label)
          .fontColor('#757575')
          .fontSize(14)
          .margin({ top: 4 })
      }
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
        Image($r('app.media.ic_home'))
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