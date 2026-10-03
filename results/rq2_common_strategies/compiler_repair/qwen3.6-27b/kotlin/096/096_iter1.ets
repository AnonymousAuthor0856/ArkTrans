import { router } from '@kit.ArkUI'

// --- Theme & Colors ---
const PureWhite: Color = '#FFFFFF' as Color
const OffWhite: Color = '#FAFAFA' as Color
const TextPrimary: Color = '#1A1A1A' as Color
const TextSecondary: Color = '#757575' as Color
const AccentGreen: Color = '#4CAF50' as Color
const AccentWarning: Color = '#FF9800' as Color
const DividerColor: Color = '#EEEEEE' as Color

@Entry
@Component
struct AeroSenseApp {
  @State aqi: number = 42

  build() {
    Column() {
      TopHeader()
      
      MainContent({ padding: { top: 0, bottom: 0, left: 0, right: 0 } })
        .layoutWeight(1)
        .width('100%')

      BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(PureWhite)
  }
}

@Component
struct TopHeader {
  build() {
    Row() {
      Column() {
        Text("Living Room")
          .fontColor(TextSecondary)
          .fontWeight(FontWeight.Normal)
          .fontSize(16) // titleMedium approx
        
        Text("AeroSense")
          .fontColor(TextPrimary)
          .fontWeight(FontWeight.Bold)
          .fontSize(24) // headlineMedium approx
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 24 })

      Blank().layoutWeight(1)

      Button() {
        Image($r('app.media.settings')) // Placeholder for Settings Icon
          .width(24)
          .height(24)
          .fillColor(TextPrimary)
      }
      .type(ButtonType.Circle)
      .backgroundColor(OffWhite)
      .width(48)
      .height(48)
      .margin({ right: 24 })
    }
    .width('100%')
    .padding({ top: 24, bottom: 24 })
  }
}

@Component
struct MainContent {
  @Link padding: Length

  build() {
    Scroll() {
      Column() {
        AirQualityCircle({ aqi: this.aqi })
          .margin({ bottom: 32 })

        // Metrics Grid Row 1
        Row() {
          MetricCard({ label: "Temp", value: "23°C", statusColor: TextPrimary })
            .layoutWeight(1)
          
          MetricCard({ label: "Humidity", value: "45%", statusColor: AccentGreen })
            .layoutWeight(1)
        }
        .width('100%')
        .margin({ bottom: 16 })

        // Metrics Grid Row 2
        Row() {
          MetricCard({ label: "PM 2.5", value: "12", statusColor: AccentGreen })
            .layoutWeight(1)
          
          MetricCard({ label: "CO2", value: "850", statusColor: AccentWarning })
            .layoutWeight(1)
        }
        .width('100%')
        .margin({ bottom: 32 })

        StatusBanner()
      }
      .padding({ left: 24, right: 24, top: 16, bottom: 16 })
    }
    .width('100%')
    .layoutWeight(1)
  }
}

@Component
struct AirQualityCircle {
  @Prop aqi: number

  build() {
    Column() {
      // Custom Drawing for the Indicator Ring
      Canvas()
        .width(220)
        .height(220)
        .onDraw((canvas: CanvasRenderingContext2D, ctx: CanvasRenderingContext2D) => {
          const centerX = 110
          const centerY = 110
          const radius = 90
          const strokeWidth = 40
          
          ctx.lineWidth = strokeWidth
          ctx.lineCap = 'round'

          // Background Track (135deg to 405deg -> 270 sweep)
          // Start angle: -135 deg (or 225 deg). In Canvas arc, 0 is 3 o'clock. 
          // Compose startAngle 135f corresponds to roughly 7:30 position if 0 is 12 o'clock? 
          // Actually Compose 0 is 3 o'clock usually in math, but UI often differs. 
          // Let's approximate visual: Start at bottom-left (-135 deg), sweep 270 deg clockwise.
          
          const startAngleDeg = -135
          const sweepAngleDeg = 270
          
          const startRad = startAngleDeg * Math.PI / 180
          const endRad = (startAngleDeg + sweepAngleDeg) * Math.PI / 180

          // Draw Background Arc
          ctx.beginPath()
          ctx.arc(centerX, centerY, radius, startRad, endRad, false)
          ctx.strokeStyle = OffWhite
          ctx.stroke()

          // Draw Progress Arc
          // AQI 42/100 -> 42% of 270 degrees = ~113 degrees
          const progressSweep = (this.aqi / 100) * sweepAngleDeg
          const progressEndRad = (startAngleDeg + progressSweep) * Math.PI / 180

          ctx.beginPath()
          ctx.arc(centerX, centerY, radius, startRad, progressEndRad, false)
          ctx.strokeStyle = AccentGreen
          ctx.stroke()
        })

      Column() {
        Text("AQI")
          .fontColor(TextSecondary)
          .fontWeight(FontWeight.Bold)
          .fontSize(14)
          .letterSpacing(2)
        
        Text(`${this.aqi}`)
          .fontColor(TextPrimary)
          .fontWeight(FontWeight.Medium)
          .fontSize(80)
          .lineHeight(80)
        
        Text("Excellent")
          .fontColor(AccentGreen)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#E8F5E9' as Color) // AccentGreen with alpha approx
          .borderRadius(16)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .aspectRatio(1.2)
  }
}

@Component
struct MetricCard {
  @Prop label: string
  @Prop value: string
  @Prop statusColor: Color

  build() {
    Column() {
      Row() {
        // Using a simple circle as placeholder for icon since we don't have vector assets
        Circle()
          .width(20)
          .height(20)
          .fill(this.statusColor)
          .opacity(0.8)
      }
      .width('100%')
      .justifyContent(FlexAlign.End)

      Column() {
        Text(this.value)
          .fontColor(TextPrimary)
          .fontWeight(FontWeight.Bold)
          .fontSize(20) // headlineSmall approx
        
        Text(this.label)
          .fontColor(TextSecondary)
          .fontSize(12) // bodySmall approx
      }
    }
    .width('100%')
    .height(110)
    .padding(16)
    .backgroundColor(OffWhite)
    .borderRadius(24)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct StatusBanner {
  build() {
    Column() {
      Row() {
        // Placeholder for Home Icon
        Circle()
          .width(24)
          .height(24)
          .fill(TextPrimary)
        
        Text("Room Analysis")
          .fontColor(TextPrimary)
          .fontWeight(FontWeight.Bold)
          .fontSize(16)
          .margin({ left: 12 })
      }
      .alignItems(VerticalAlign.Center)
      
      Text("Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.")
        .fontColor(TextSecondary)
        .fontSize(14)
        .lineHeight(22)
        .margin({ top: 12 })
    }
    .width('100%')
    .padding(20)
    .borderRadius(20)
    .border({ width: 1, color: DividerColor })
  }
}

@Component
struct BottomControlBar {
  build() {
    Column() {
      Divider()
        .color(DividerColor)
        .margin({ left: 24, right: 24 })

      Row() {
        // Menu Icon Placeholder
        Button() {
           Circle()
             .width(24)
             .height(24)
             .fill(TextPrimary)
        }
        .type(ButtonType.Circle)
        .border({ width: 1, color: DividerColor })
        .width(48)
        .height(48)

        Blank().layoutWeight(1)

        Button() {
          Row() {
            // Refresh Icon Placeholder
            Circle()
              .width(18)
              .height(18)
              .fill(PureWhite)
            
            Text("Refresh Data")
              .fontColor(PureWhite)
              .fontSize(14)
              .margin({ left: 8 })
          }
          .alignItems(VerticalAlign.Center)
        }
        .backgroundColor(TextPrimary)
        .borderRadius(16)
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })

        Blank().layoutWeight(1)

        // Add Icon Placeholder
        Button() {
           Circle()
             .width(24)
             .height(24)
             .fill(TextPrimary)
        }
        .type(ButtonType.Circle)
        .border({ width: 1, color: DividerColor })
        .width(48)
        .height(48)
      }
      .width('100%')
      .padding(24)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor(PureWhite)
  }
}