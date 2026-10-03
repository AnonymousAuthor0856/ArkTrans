// MatchaBrewingScreen.ets
import { Image } from '@kit.ArkUI';

@Entry
@Component
struct MatchaBrewingScreen {
  @State private isTimerRunning: boolean = false;

  build() {
    Column() {
      // Top Section: Title
      Column() {
        Text('MATCHA RITUAL')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(4)
          .fontColor('#999999')
        
        Text('Ceremonial Grade')
          .margin({ top: 8 })
          .fontSize(28)
          .fontWeight(FontWeight.Light)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .margin({ top: 48 })

      // Middle Section: Visual Art & Stats
      Column() {
        // Custom Drawn Bowl
        MatchaBowlCanvas()
          .width(160)
          .height(160)
          .margin({ top: 32, bottom: 40 })

        // Info Row
        Row() {
          InfoItem(label: 'TEMP', value: '80°C')
          InfoItem(label: 'WATER', value: '70ml')
          InfoItem(label: 'BAMBOO', value: 'Whisk')
        }
        .justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      // Bottom Section: Instructions & Action
      Column() {
        StepCard(number: '01', text: 'Sift 2g of matcha powder.')
        
        StepCard(number: '02', text: "Add hot water. Whisk in 'M' shape.")
          .margin({ top: 12 })

        Button() {
          Row() {
            // Using a simple SVG path for the play icon to ensure it compiles without external assets
            Image($r('app.media.ic_play')) 
              .width(20)
              .height(20)
              .fillColor(Color.White)
            
            Text('START TIMER')
              .margin({ left: 8 })
              .fontSize(16)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(Color.White)
          }
          .justifyContent(FlexAlign.Center)
          .width('100%')
          .height(56)
        }
        .backgroundColor('#556B2F')
        .borderRadius(28)
        .margin({ top: 32, bottom: 24 })
        .onClick(() => {
          this.isTimerRunning = !this.isTimerRunning;
        })
      }
      .width('100%')
    }
    .padding(24)
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

// MARK: - MatchaBowlCanvas
// Custom drawing component using ArkTS Drawing API
@Component
struct MatchaBowlCanvas {
  build() {
    Drawing() {
      Path()
        .moveTo(160 * 0.15, 160 * 0.4)
        .lineTo(160 * 0.85, 160 * 0.4)
        .quadraticCurveTo(160 * 0.9, 160 * 0.9, 160 * 0.5, 160 * 0.9)
        .quadraticCurveTo(160 * 0.1, 160 * 0.9, 160 * 0.15, 160 * 0.4)
        .close()
        .fill('#333333')

      // Liquid (Matcha)
      Path()
        .addEllipse({ x: 160 * 0.2, y: 160 * 0.42, width: 160 * 0.6, height: 160 * 0.15 })
        .fill('#8BBD52')

      // Steam Lines
      Path()
        .moveTo(160 * 0.4, 160 * 0.3)
        .lineTo(160 * 0.4, 160 * 0.15)
        .strokeWidth(4)
        .strokeLineCap(LineCap.Round)
        .stroke('#808080') // Gray with opacity handled by color hex or alpha

      Path()
        .moveTo(160 * 0.5, 160 * 0.25)
        .lineTo(160 * 0.5, 160 * 0.1)
        .strokeWidth(4)
        .strokeLineCap(LineCap.Round)
        .stroke('#808080')

      Path()
        .moveTo(160 * 0.6, 160 * 0.3)
        .lineTo(160 * 0.6, 160 * 0.15)
        .strokeWidth(4)
        .strokeLineCap(LineCap.Round)
        .stroke('#808080')
    }
  }
}

// MARK: - InfoItem
@Component
struct InfoItem {
  label: string;
  value: string;

  build() {
    Column() {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#808080') // Light gray
        
      Text(this.value)
        .margin({ top: 4 })
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// MARK: - StepCard
@Component
struct StepCard {
  number: string;
  text: string;

  build() {
    Row() {
      Stack() {
        Circle()
          .width(32)
          .height(32)
          .fill('#F5F5F5')
        
        Text(this.number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      
      Text(this.text)
        .margin({ left: 16 })
        .fontSize(14)
        .fontColor('#4D4D4D') // Dark gray equivalent
    }
    .width('100%')
    .padding(16)
    .borderRadius(12)
    .border({ width: 1, color: '#EEEEEE' })
  }
}