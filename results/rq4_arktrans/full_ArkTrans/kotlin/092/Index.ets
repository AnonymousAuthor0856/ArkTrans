import { canvas } from '@kit.ArkGraphics';

@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        // Header Section
        Column() {
          Text('JUNIPER · #04')
            .fontColor('#8A9597')
            .fontSize(12)
            .letterSpacing(2)
            .fontWeight(FontWeight.Medium)
          
          Blank().height(8)
          
          Text('Zen Garden')
            .fontColor('#2C3E50')
            .fontSize(42)
            .fontWeight(FontWeight.Normal)
        }.alignItems(HorizontalAlign.Center)

        Blank().height(32)

        // Bonsai Visual (Canvas Drawing)
        Canvas(this.getContext())
          .width(220)
          .height(220)
          .onReady((context: canvas.CanvasRenderingContext2D, size: canvas.Size) => {
            const centerX = size.width / 2;
            
            // Pot Top Rim
            context.fillStyle = '#8D6E63';
            context.fillRect(centerX - 60, 160, 120, 10);
            
            // Pot Body
            context.fillStyle = '#795548';
            context.beginPath();
            context.moveTo(centerX - 55, 170);
            context.lineTo(centerX + 55, 170);
            context.lineTo(centerX + 45, 210);
            context.lineTo(centerX - 45, 210);
            context.closePath();
            context.fill();

            // Trunk
            context.strokeStyle = '#4E342E';
            context.lineWidth = 12;
            context.lineCap = 'round';
            context.beginPath();
            context.moveTo(centerX, 160);
            context.bezierCurveTo(centerX - 20, 120, centerX + 20, 80, centerX + 10, 40);
            context.stroke();

            // Foliage Clusters (Green Circles)
            context.fillStyle = '#6B8E6B';
            
            // Cluster 1 (Top Right)
            context.beginPath(); context.arc(centerX + 10, 40, 25, 0, Math.PI * 2); context.fill();
            context.beginPath(); context.arc(centerX + 30, 35, 20, 0, Math.PI * 2); context.fill();
            context.beginPath(); context.arc(centerX - 5, 25, 18, 0, Math.PI * 2); context.fill();

            // Cluster 2 (Middle Left)
            context.beginPath(); context.arc(centerX - 15, 80, 22, 0, Math.PI * 2); context.fill();
            context.beginPath(); context.arc(centerX - 35, 75, 18, 0, Math.PI * 2); context.fill();
            context.beginPath(); context.arc(centerX - 5, 95, 15, 0, Math.PI * 2); context.fill();
          })

        Blank().height(32)

        // Status Row
        Row() {
          // Health Item
          Column() {
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon'))
                .width(24).height(24)
                .fillColor('#E57373')
            }
            .width(50).height(50)
            .backgroundColor('#F7F9F9')
            .borderRadius(25)
            .border({ width: 1, color: '#ECEFF1' })

            Blank().height(8)
            Text('98%').fontColor('#2C3E50').fontSize(18).fontWeight(FontWeight.Bold)
            Text('Health').fontColor('#8A9597').fontSize(14)
          }.alignItems(HorizontalAlign.Center)

          // Age Item
          Column() {
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon'))
                .width(24).height(24)
                .fillColor('#8D6E63')
            }
            .width(50).height(50)
            .backgroundColor('#F7F9F9')
            .borderRadius(25)
            .border({ width: 1, color: '#ECEFF1' })

            Blank().height(8)
            Text('4 Yrs').fontColor('#2C3E50').fontSize(18).fontWeight(FontWeight.Bold)
            Text('Age').fontColor('#8A9597').fontSize(14)
          }.alignItems(HorizontalAlign.Center)

          // Water Item
          Column() {
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon'))
                .width(24).height(24)
                .fillColor('#64B5F6')
            }
            .width(50).height(50)
            .backgroundColor('#F7F9F9')
            .borderRadius(25)
            .border({ width: 1, color: '#ECEFF1' })

            Blank().height(8)
            Text('2 Days').fontColor('#2C3E50').fontSize(18).fontWeight(FontWeight.Bold)
            Text('Water').fontColor('#8A9597').fontSize(14)
          }.alignItems(HorizontalAlign.Center)
        }.justifyContent(FlexAlign.SpaceEvenly).width('100%')

        Blank().height(32)

        // Care Schedule Section
        Column() {
          Row() {
            Text('Care Schedule').fontColor('#2C3E50').fontSize(20).fontWeight(FontWeight.Medium)
            Blank()
            Image($r('app.media.startIcon'))
              .width(28).height(28)
              .fillColor('#6A8E6A')
              .margin({ left: 10 })
          }.width('100%')

          Blank().height(16)

          // Log Item 1 (Done)
          Row() {
            Stack({ alignContent: Alignment.Center }) {
              Circle().width(12).height(12).fill('#6A8E6A')
            }.width(12).height(12)
            
            Blank().width(16)
            
            Column() {
              Text('Watering').fontColor('#2C3E50').fontSize(16)
              Text('Today, 8:00 AM').fontColor('#9E9E9E').fontSize(12)
            }.layoutWeight(1)
            
            Image($r('app.media.startIcon')).width(20).height(20).fillColor('#6A8E6A')
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FAFAFA')
          .borderRadius(12)
          .border({ width: 1, color: '#F0F0F0' })

          Blank().height(12)

          // Log Item 2 (Pending)
          Row() {
            Stack({ alignContent: Alignment.Center }) {
              Circle().width(12).height(12).fill('#E0E0E0')
            }.width(12).height(12)
            
            Blank().width(16)
            
            Column() {
              Text('Pruning').fontColor('#8A9597').fontSize(16)
              Text('Tomorrow').fontColor('#9E9E9E').fontSize(12)
            }.layoutWeight(1)
            
            Image($r('app.media.startIcon')).width(20).height(20).fillColor('#6A8E6A')
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FAFAFA')
          .borderRadius(12)
          .border({ width: 1, color: '#F0F0F0' })

          Blank().height(12)

          // Log Item 3 (Pending)
          Row() {
            Stack({ alignContent: Alignment.Center }) {
              Circle().width(12).height(12).fill('#E0E0E0')
            }.width(12).height(12)
            
            Blank().width(16)
            
            Column() {
              Text('Fertilizer').fontColor('#8A9597').fontSize(16)
              Text('In 5 days').fontColor('#9E9E9E').fontSize(12)
            }.layoutWeight(1)
            
            Image($r('app.media.startIcon')).width(20).height(20).fillColor('#6A8E6A')
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FAFAFA')
          .borderRadius(12)
          .border({ width: 1, color: '#F0F0F0' })
        }.width('100%')

        Blank().height(20) // Spacer for bottom nav
      }
      .width('100%')
      .height('100%')
      .padding(24)
      .backgroundColor('#FFFFFF')

      // Bottom Navigation
      Row() {
        // Home Icon (Active)
        Column() {
          Image($r('app.media.startIcon')).width(28).height(28).fillColor('#6A8E6A')
          Blank().height(4)
          Circle().width(4).height(4).fill('#6A8E6A')
        }.alignItems(HorizontalAlign.Center)

        // Info Icon (Inactive)
        Column() {
          Image($r('app.media.startIcon')).width(28).height(28).fillColor('#CFD8DC')
          Blank().height(4)
          Circle().width(4).height(4).fill('transparent')
        }.alignItems(HorizontalAlign.Center)

        // Settings Icon (Inactive)
        Column() {
          Image($r('app.media.startIcon')).width(28).height(28).fillColor('#CFD8DC')
          Blank().height(4)
          Circle().width(4).height(4).fill('transparent')
        }.alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height(80)
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#F5F5F5', style: BorderStyle.Solid })
    }.width('100%').height('100%')
  }

  getContext(): canvas.CanvasRenderingContext2D {
    return new canvas.CanvasRenderingContext2D();
  }
}