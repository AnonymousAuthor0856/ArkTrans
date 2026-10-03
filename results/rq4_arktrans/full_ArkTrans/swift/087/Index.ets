@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        // Header Row
        Row() {
          Column({ space: 2 }) {
            Text('Good Morning,')
              .fontColor('#808080')
              .fontSize(14)
            Text('Tea Master')
              .fontColor('#000000')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
          }
          Blank()
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#000000')
          }
          .backgroundColor('#F5F5F5')
          .borderRadius(24)
          .height(48)
          .width(48)
        }
        .width('100%')
        .margin({ top: 20, bottom: 20 })

        // Tea Card
        Row() {
          Stack() {
            Circle()
              .fill('#F0EBE8')
              .width(60)
              .height(60)
            
            // Simulating the leaf icon with a simple shape since only startIcon is allowed
            // Using a generic placeholder style for the icon inside the circle
            Circle()
              .stroke('#6D4C3F')
              .strokeWidth(2)
              .width(30)
              .height(30)
          }

          Column({ space: 2 }) {
            Text('Earl Grey Reserve')
              .fontColor('#000000')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
            Text('Black Tea • 95°C')
              .fontColor('#8C6D63')
              .fontSize(12)
          }
          
          Blank()
          
          // Heart Icon (Simulated with text or shape as image resource restricted)
          // Using a red heart symbol to match screenshot
          Text('♥') 
            .fontColor('#FFCCD1')
            .fontSize(24)
        }
        .width('100%')
        .padding(20)
        .backgroundColor('#FAFAFA')
        .borderRadius(24)
        .border({ width: 1, color: '#E0E0E0' })
        .margin({ bottom: 30 })

        // Timer Section
        Stack() {
          // Background Track
          Circle()
            .stroke('#F4F4F4')
            .strokeWidth(12)
            .width(220)
            .height(220)
          
          // Progress Arc (Simulated using rotation and stroke-dasharray logic approximation in ArkTS)
          // In real ArkTS, we might use a custom drawing canvas, but here we approximate with a rotated arc if possible
          // or simply a static representation. The skeleton suggests a trim/rotation approach.
          // Since ArkTS Canvas is complex for this snippet, we use a visual approximation.
          // A full circle with a specific color representing the "active" part isn't easily done with just primitives without path drawing.
          // We will stick to the structure provided:
          Circle()
            .stroke('#6D4C3F')
            .strokeWidth(12)
            .width(220)
            .height(220)
            // Note: True trimming requires Path/Circle with dash array or custom draw. 
            // For this UI skeleton conversion, we represent the visual layer.
            .opacity(0.66) // Approximating the fill level visually
            
          Column({ space: 4 }) {
            Text('Steeping')
              .fontColor('#808080')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .letterSpacing(2)
            Text('02:00')
              .fontColor('#000000')
              .fontSize(45)
              .fontWeight(FontWeight.Lighter)
          }
        }
        .width(220)
        .height(220)
        .margin({ bottom: 30 })

        // Controls Row
        Row({ space: 24 }) {
          // Reset Button
          Button() {
            // Simulating refresh icon
            Text('↺')
              .fontSize(24)
              .fontColor('#808080')
          }
          .backgroundColor('#FFFFFF')
          .border({ width: 1, color: '#E0E0E0' })
          .borderRadius(24)
          .width(60)
          .height(60)

          // Start Button
          Button() {
            Row() {
              // Play triangle simulation
              Text('▶')
                .fontSize(16)
                .fontColor('#FFFFFF')
                .margin({ right: 8 })
              Text('Start')
                .fontColor('#FFFFFF')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
            }
          }
          .backgroundColor('#6D4C3F')
          .borderRadius(24)
          .height(60)
          .layoutWeight(1)

          // Add Button
          Button() {
            Text('+')
              .fontSize(32)
              .fontColor('#808080')
          }
          .backgroundColor('#FFFFFF')
          .border({ width: 1, color: '#E0E0E0' })
          .borderRadius(24)
          .width(60)
          .height(60)
        }
        .width('100%')
        .margin({ bottom: 20 })

        // Preparation List
        Column({ space: 0 }) {
          Text('PREPARATION')
            .fontColor('#A0A0A0')
            .fontSize(11)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 12 })
            .textAlign(TextAlign.Start)
            .width('100%')

          // Step 1
          Row() {
            Text('1')
              .backgroundColor('#F0F0F0')
              .borderRadius(12)
              .width(24)
              .height(24)
              .textAlign(TextAlign.Center)
              .fontSize(12)
              .fontColor('#000000')
              .fontWeight(FontWeight.Bold)
            
            Text('Boil fresh water to 95°C')
              .fontColor('#808080')
              .fontSize(14)
              .margin({ left: 12 })
              .layoutWeight(1)
            
            Text('✓')
              .fontColor('#D0D0D0')
              .fontSize(16)
          }
          .width('100%')
          .padding({ top: 10, bottom: 10 })
          .border({ width: { bottom: 1 }, color: '#EEEEEE' })

          // Step 2
          Row() {
            Text('2')
              .backgroundColor('#F0F0F0')
              .borderRadius(12)
              .width(24)
              .height(24)
              .textAlign(TextAlign.Center)
              .fontSize(12)
              .fontColor('#000000')
              .fontWeight(FontWeight.Bold)
            
            Text('Add 1 tsp of loose leaf per cup')
              .fontColor('#808080')
              .fontSize(14)
              .margin({ left: 12 })
              .layoutWeight(1)
            
            Text('✓')
              .fontColor('#D0D0D0')
              .fontSize(16)
          }
          .width('100%')
          .padding({ top: 10, bottom: 10 })
          .border({ width: { bottom: 1 }, color: '#EEEEEE' })

          // Step 3
          Row() {
            Text('3')
              .backgroundColor('#F0F0F0')
              .borderRadius(12)
              .width(24)
              .height(24)
              .textAlign(TextAlign.Center)
              .fontSize(12)
              .fontColor('#000000')
              .fontWeight(FontWeight.Bold)
            
            Text('Pour water and wait for timer')
              .fontColor('#808080')
              .fontSize(14)
              .margin({ left: 12 })
              .layoutWeight(1)
            
            Text('✓')
              .fontColor('#D0D0D0')
              .fontSize(16)
          }
          .width('100%')
          .padding({ top: 10, bottom: 10 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        
        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24 })
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
  }
}