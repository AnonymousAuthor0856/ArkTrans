@Entry
@Component
struct TeaMasterApp {
  build() {
    Column() {
      // === ZStack (Main Screen) ===
      Stack() {
        // Background
        Column().width('100%').height('100%').backgroundColor('#FFFFFF')

        // Content Column
        Column({ space: 0 }) {
          // === Header Section ===
          Row() {
            Column({ space: 2 }) {
              Text('Good Morning,').fontSize(14).fontColor('#9E9E9E')
              Text('Tea Master').fontSize(22).fontWeight(FontWeight.Bold).fontColor('#000000')
            }
            Blank()
            Button() {
              Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
            }.width(48).height(48).borderRadius(24).backgroundColor('#F5F5F5')
          }.width('100%').padding({ top: 24, bottom: 32 })

          // === Tea Selection Card ===
          Row({ space: 16 }) {
            // Icon Box
            Stack() {
              Circle().width(60).height(60).fill('#EFEBE9')
              // Custom Leaf Icon approximation using SVG path logic or simple shapes
              // Since we can't draw complex paths easily without canvas, we use a simplified representation
              // or the provided icon if it matches. Here we simulate the leaf shape with a circle and line
              // as per the SwiftUI custom drawing logic translated to ArkTS layout primitives where possible,
              // but for exact visual match of "leaf", we rely on the structure.
              // Using a placeholder image for the leaf icon as per rules ($r is only startIcon), 
              // so we construct the leaf visually using basic shapes to match the screenshot.
              Circle().width(30).height(30).strokeWidth(2).stroke('#6D4C41').fill(Color.Transparent)
              // Fix Error 1: LineOptions does not support startX/startY/endX/endY directly in this manner.
              // Use a Path or a simple Rectangle/Line component with width/height instead.
              // Replacing Line with a simple vertical rectangle to represent the stem.
              Column().width(2).height(20).backgroundColor('#6D4C41')
            }.width(60).height(60)

            Column({ space: 2 }) {
              Text('Earl Grey Reserve').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#000000')
              Text('Black Tea • 95°C').fontSize(12).fontColor('#8D6E63')
            }
            Blank()
            // Heart Icon - approximated with text or image. Using text symbol for heart as no specific resource allowed except startIcon
            Text('♥').fontSize(24).fontColor('#FFCDD2')
          }
          .width('100%')
          .padding(20)
          .backgroundColor('#FAFAFA')
          .borderRadius(24)
          .border({ width: 1, color: '#EEEEEE', radius: 24 })
          .margin({ bottom: 32 })

          // === Timer Display ===
          Stack() {
            // Background Circle
            Circle().width(220).height(220).strokeWidth(12).stroke('#F5F5F5').fill(Color.Transparent)
            
            // Progress Arc (Simulated with rotation and trim)
            // Note: ArkTS Circle doesn't have direct trim like SwiftUI. We use a workaround or just the visual result.
            // To strictly follow "compilable" and "visual match", we'll use a rotated circle with stroke-dasharray if needed,
            // but standard Circle in ArkTS is full. We will approximate the visual with a rotated container if necessary,
            // but here we just place the background and foreground circles.
            // For the progress arc specifically:
            // CanvasRenderingContext2D is not available in declarative UI directly.
            // We will use a simple Circle for the track and assume the progress is static for this UI conversion.
            // To mimic the arc:
            Circle().width(220).height(220).strokeWidth(12).stroke('#6D4C41').fill(Color.Transparent)
             // In a real app, we'd use a custom component for the arc. Here we show the full ring or partial via CSS-like properties if supported.
             // ArkTS supports `linearGradient` but not `trim`. We will leave it as a full ring or use a mask if needed.
             // Given the constraints, we render the visual elements.
             
            Column({ space: 4 }) {
              Text('Steeping').fontSize(12).fontWeight(FontWeight.Medium).letterSpacing(2).fontColor('#9E9E9E')
              Text('02:00').fontSize(45).fontWeight(FontWeight.Lighter).fontColor('#000000')
            }
          }.width(220).height(220).margin({ bottom: 40 })

          // === Control Buttons ===
          Row({ space: 24 }) {
            // Reset Button
            Button() {
              // Using startIcon as a proxy for reset icon since no other resources are allowed
              Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
            }.width(60).height(60).borderRadius(30).backgroundColor('#FFFFFF')
             .border({ width: 1, color: '#E0E0E0', radius: 30 })

            // Start Button
            Button() {
              Row({ space: 8 }) {
                // Play icon approximation
                Triangle().width(12).height(12)
                Text('Start').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#FFFFFF')
              }
            }.width(120).height(60).borderRadius(24).backgroundColor('#6D4C41')

            // Add Note Button
            Button() {
              // Plus icon approximation
              Text('+').fontSize(24).fontColor('#9E9E9E')
            }.width(60).height(60).borderRadius(30).backgroundColor('#FFFFFF')
             .border({ width: 1, color: '#E0E0E0', radius: 30 })
          }.width('100%').justifyContent(FlexAlign.Center)

          Blank()

          // === Preparation Steps ===
          Column({ space: 0 }) {
            Text('PREPARATION').fontSize(11).fontWeight(FontWeight.Bold).fontColor('#9E9E9E').opacity(0.8).margin({ bottom: 12 })
            
            // Step 1
            Row({ space: 12 }) {
              Text('1').fontSize(11).fontWeight(FontWeight.Bold).fontColor('#000000').width(24).height(24).textAlign(TextAlign.Center).backgroundColor('#F5F5F5').borderRadius(12)
              Text('Boil fresh water to 95°C').fontSize(14).fontColor('#9E9E9E')
              Blank()
              Text('✓').fontSize(12).fontColor('#EEEEEE')
            }.padding({ top: 8, bottom: 8 })
            
            Divider().color('#F5F5F5')

            // Step 2
            Row({ space: 12 }) {
              Text('2').fontSize(11).fontWeight(FontWeight.Bold).fontColor('#000000').width(24).height(24).textAlign(TextAlign.Center).backgroundColor('#F5F5F5').borderRadius(12)
              Text('Add 1 tsp of loose leaf per cup').fontSize(14).fontColor('#9E9E9E')
              Blank()
              Text('✓').fontSize(12).fontColor('#EEEEEE')
            }.padding({ top: 8, bottom: 8 })

            Divider().color('#F5F5F5')

            // Step 3
            Row({ space: 12 }) {
              Text('3').fontSize(11).fontWeight(FontWeight.Bold).fontColor('#000000').width(24).height(24).textAlign(TextAlign.Center).backgroundColor('#F5F5F5').borderRadius(12)
              Text('Pour water and wait for timer').fontSize(14).fontColor('#9E9E9E')
              Blank()
              Text('✓').fontSize(12).fontColor('#EEEEEE')
            }.padding({ top: 8, bottom: 8 })
          }.width('100%').alignItems(HorizontalAlign.Start).margin({ bottom: 24 })

        }.width('100%').padding({ left: 24, right: 24 })
      }.width('100%').height('100%')
    }.width('100%').height('100%').backgroundColor('#FFFFFF')
  }
}

// Helper component for Triangle (Play Icon)
@Component
struct Triangle {
  build() {
    Path()
      .commands('M 0 0 L 12 6 L 0 12 Z')
      // Fix Error 3: fillColor does not exist on PathAttribute. Use fill() instead.
      .fill('#FFFFFF')
  }
}