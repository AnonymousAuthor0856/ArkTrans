@Entry
@Component
struct Index {
  @State aqi: number = 42

  build() {
    Stack() {
      Scroll() {
        Column({ space: 32 }) {
          // === ZStack (Main AQI Card) ===
          Stack({ alignContent: Alignment.Center }) {
            // Canvas placeholder - using Image as per rules since Canvas requires complex context setup not in skeleton
            // The skeleton shows Canvas with frame, but no drawing logic. 
            // We use an empty container or image to satisfy structure if needed, 
            // but strictly following "Implement every child", we keep the structure.
            // Since Canvas is a valid ArkTS component, we include it.
            Canvas().width(220).height(220)

            Column({ space: 0 }) {
              Text('AQI')
                .letterSpacing(2)
                .fontColor('#9E9E9E') // Approximation of .textSecondary
                .fontSize(14)
                .fontWeight(FontWeight.Bold)

              Text(`${this.aqi}`)
                .fontColor('#000000') // Approximation of .textPrimary
                .fontSize(80)
                .fontWeight(FontWeight.Medium)

              Text('Excellent')
                .backgroundColor('#E8F5E9') // Approximation of AccentGreen.copy(alpha = 0.1f)
                .borderRadius(16)
                .padding({ top: 6, bottom: 6, left: 12, right: 12 })
                .fontColor('#4CAF50') // Approximation of .accentGreen
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
            }
          }
          .aspectRatio(1.2)
          .width('100%')

          // === VStack (Grid of Cards) ===
          Column({ space: 16 }) {
            // Row 1
            Row({ space: 16 }) {
              this.AirQualityCard('PM2.5', '12', '#4CAF50')
              this.AirQualityCard('Humidity', '45%', '#2196F3')
            }
            // Row 2
            Row({ space: 16 }) {
              this.AirQualityCard('CO2', '400', '#FF9800')
              this.AirQualityCard('Temp', '22°C', '#F44336')
            }
          }

          // === VStack (Room Analysis) ===
          Column({ space: 0 }) {
            Row({ space: 0 }) {
              // Using $r('app.media.startIcon') as per rule 2 for any image resource
              Image($r('app.media.startIcon'))
                .fillColor('#000000')
                .width(24)
                .height(24)
              
              Blank().width(12)
              
              Text('Room Analysis')
                .fontColor('#000000')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
            }

            Blank().height(12)

            Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
              .maxLines(0)
              .lineHeight(22) // Approximation of lineSpacing(8) on size 14
              .fontColor('#9E9E9E')
              .fontSize(14)
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(20)
          .border({ width: 1, color: '#E0E0E0' })
          .padding(20)
          .width('100%')

        }
        .padding({ top: 16, bottom: 16 })
        .width('100%')
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5') // Background for the whole page
  }

  @Builder
  AirQualityCard(label: string, value: string, statusColor: string) {
    Column({ space: 0 }) {
      Row({ space: 0 }) {
        // Using $r('app.media.startIcon') as per rule 2
        Image($r('app.media.startIcon'))
          .fillColor(statusColor)
          .width(20)
          .height(20)
        
        Blank()
      }

      Blank()

      Column({ space: 4 }) {
        Text(value)
          .fontColor('#000000')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
        
        Text(label)
          .fontColor('#9E9E9E')
          .fontSize(12)
      }
    }
    .backgroundColor('#FAFAFA') // Approximation of Color.offWhite
    .borderRadius(24)
    .width('100%')
    .height(110)
    .padding(16)
  }
}