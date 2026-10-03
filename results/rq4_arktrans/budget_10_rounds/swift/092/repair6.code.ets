@Entry
@Component
struct Index {
  build() {
    Stack() {
      // === ZStack ===
      Stack({ alignContent: Alignment.Bottom }) {
        // === ScrollView ===
        Scroll() {
          // === VStack ===
          Column() {
            // === VStack ===
            Column() {
              // === Text ===
              Text('JUNIPER · #04').letterSpacing(2).fontColor('#78909C').fontSize(12)
              // === Spacer ===
              Blank().height(8)
              // === Text ===
              Text('Zen Garden').fontColor('#37474F').fontSize(36)
            }
            // === Spacer ===
            Blank().height(32)
            // === Canvas (Tree Illustration) ===
            Column() {
              Row() {
                Circle().width(120).height(120).backgroundColor('#6B8E6B')
                Circle().width(100).height(100).backgroundColor('#5A7D5A').margin({ left: -40, top: 20 })
                Circle().width(90).height(90).backgroundColor('#7BA07B').margin({ left: -20, top: -40 })
              }.alignItems(VerticalAlign.Top)
              
              Capsule().width(20).height(100).backgroundColor('#5D4037').margin({ top: -20 }).rotate({ x: 0, y: 0, z: 1, angle: 15 })
              
              Row() {
                Rect().width(160).height(40).fill('#8D6E63')
              }
            }.width('100%').height(250).justifyContent(FlexAlign.Center)

            // === Spacer ===
            Blank().height(32)
            
            // === HStack (Status Items) ===
            Row() {
              Blank()
              // StatusItem 1
              Column() {
                Row() {
                  Image($r('app.media.startIcon')).width(28).height(28).objectFit(ImageFit.Contain).fillColor('#EF5350')
                }.width(56).height(56).backgroundColor('#F5F5F5').borderRadius(28).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
                
                Text('98%').fontColor('#37474F').fontSize(20).fontWeight(FontWeight.Bold).margin({ top: 8 })
                Text('Health').fontColor('#78909C').fontSize(14).margin({ top: 4 })
              }
              
              Blank()
              // StatusItem 2
              Column() {
                Row() {
                  Image($r('app.media.startIcon')).width(28).height(28).objectFit(ImageFit.Contain).fillColor('#8D6E63')
                }.width(56).height(56).backgroundColor('#F5F5F5').borderRadius(28).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
                
                Text('4 Yrs').fontColor('#37474F').fontSize(20).fontWeight(FontWeight.Bold).margin({ top: 8 })
                Text('Age').fontColor('#78909C').fontSize(14).margin({ top: 4 })
              }
              
              Blank()
              // StatusItem 3
              Column() {
                Row() {
                  Image($r('app.media.startIcon')).width(28).height(28).objectFit(ImageFit.Contain).fillColor('#42A5F5')
                }.width(56).height(56).backgroundColor('#F5F5F5').borderRadius(28).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
                
                Text('2 Days').fontColor('#37474F').fontSize(20).fontWeight(FontWeight.Bold).margin({ top: 8 })
                Text('Water').fontColor('#78909C').fontSize(14).margin({ top: 4 })
              }
              Blank()
            }.width('100%')

            // === Spacer ===
            Blank().height(32)
            
            // === Care Schedule Section ===
            Column() {
              // Header
              Row() {
                Text('Care Schedule').fontColor('#37474F').fontSize(16).fontWeight(FontWeight.Medium)
                Blank()
                // Add Button
                Row() {
                  Image($r('app.media.startIcon')).width(20).height(20).objectFit(ImageFit.Contain).fillColor('#4CAF50')
                }.width(28).height(28).backgroundColor('#E8F5E9').borderRadius(14).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
              }.width('100%')
              
              Blank().height(16)
              
              // CareLogItem 1
              Row() {
                Circle().width(12).height(12).backgroundColor('#4CAF50')
                Column() {
                  Text('Watering').fontColor('#37474F').fontSize(16)
                  Text('Today, 8:00 AM').fontColor('#78909C').fontSize(14).margin({ top: 4 })
                }.margin({ left: 16 }).alignItems(HorizontalAlign.Start)
                Blank()
                Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain).fillColor('#4CAF50')
              }.width('100%').padding(16).backgroundColor('#FAFAFA').borderRadius(16)
              
              Blank().height(12)
              
              // CareLogItem 2
              Row() {
                Circle().width(12).height(12).backgroundColor('#CFD8DC')
                Column() {
                  Text('Pruning').fontColor('#37474F').fontSize(16)
                  Text('Tomorrow').fontColor('#78909C').fontSize(14).margin({ top: 4 })
                }.margin({ left: 16 }).alignItems(HorizontalAlign.Start)
                Blank()
              }.width('100%').padding(16).backgroundColor('#FAFAFA').borderRadius(16)
              
              Blank().height(12)
              
              // CareLogItem 3
              Row() {
                Circle().width(12).height(12).backgroundColor('#CFD8DC')
                Column() {
                  Text('Fertilizer').fontColor('#37474F').fontSize(16)
                  Text('In 5 days').fontColor('#78909C').fontSize(14).margin({ top: 4 })
                }.margin({ left: 16 }).alignItems(HorizontalAlign.Start)
                Blank()
              }.width('100%').padding(16).backgroundColor('#FAFAFA').borderRadius(16)
              
            }.width('100%')
            
          }.width('100%').padding({ left: 24, right: 24, bottom: 80 }).backgroundColor('#FFFFFF')
        }.backgroundColor('#FFFFFF')
        
        // === Bottom Navigation Bar ===
        Column() {
          // Divider
          Rect().width('100%').height(1).fill('#F5F5F5')
          
          // Nav Icons
          Row() {
            // Home Icon (Selected)
            Column() {
              Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain).fillColor('#6B8E6B')
              Circle().width(4).height(4).backgroundColor('#6B8E6B').margin({ top: 4 })
            }.layoutWeight(1).justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)
            
            // Info Icon
            Column() {
              Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain).fillColor('#CFD8DC')
            }.layoutWeight(1).justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)
            
            // Settings Icon
            Column() {
              Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain).fillColor('#CFD8DC')
            }.layoutWeight(1).justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)
          }.width('100%').height(80).backgroundColor('#FFFFFF')
        }
      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }
}