@Entry
@Component
struct Index {
  @State JUNIPER_04: string = 'JUNIPER · #04'
  @State ZenGarden: string = 'Zen Garden'
  @State potTop: number = 0
  @State potHeight: number = 0
  @State val15f: number = 0
  @State h055: number = 0
  @State h045: number = 0
  @State h025: number = 0
  @State h028: number = 0
  @State h022: number = 0
  @State h05: number = 0
  @State h042: number = 0
  @State value: string = '98%'
  @State label: string = 'Health'
  @State CareSchedule: string = 'Care Schedule'
  @State title: string = 'Watering'
  @State subtitle: string = 'Today, 8:00 AM'
  @State isDoneTrue: boolean = true
  @State isDoneFalse: boolean = false

  build() {
    Stack() {
      // MaterialTheme / Scaffold equivalent
      Stack({ alignContent: Alignment.Top }) {
        // Main Content Column
        Column({ space: 0 }) {
          // HeaderSection
          Column({ space: 0 }) {
            Text(this.JUNIPER_04)
              .fontSize(12)
              .fontColor('#757575')
              .letterSpacing(2)
            
            Blank().height(8)
            
            Text(this.ZenGarden)
              .fontSize(24)
              .fontWeight(FontWeight.Normal)
              .fontColor('#263238')
          }.alignItems(HorizontalAlign.Center)

          Blank().height(32)

          // BonsaiVisual
          Stack({ alignContent: Alignment.Bottom }) {
            Canvas().width('100%').height('100%')
          }.width(220).height(220)

          Blank().height(32)

          // StatusRow
          Row({ space: 0 }) {
            // StatusItem 1: Health
            Column({ space: 0 }) {
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.startIcon'))
                  .width(24).height(24)
                  .objectFit(ImageFit.Contain)
                  .fillColor('#E57373')
              }
              .width(50).height(50)
              .backgroundColor('#F7F9F9')
              .borderRadius(25)
              .border({ width: 1, color: '#ECEFF1', radius: 25 })

              Blank().height(8)
              
              Text('98%')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#263238')
              
              Text('Health')
                .fontSize(12)
                .fontColor('#757575')
            }.alignItems(HorizontalAlign.Center)

            // StatusItem 2: Age
            Column({ space: 0 }) {
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.startIcon'))
                  .width(24).height(24)
                  .objectFit(ImageFit.Contain)
                  .fillColor('#8D6E63') // ZenBrown approx
              }
              .width(50).height(50)
              .backgroundColor('#F7F9F9')
              .borderRadius(25)
              .border({ width: 1, color: '#ECEFF1', radius: 25 })

              Blank().height(8)
              
              Text('4 Yrs')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#263238')
              
              Text('Age')
                .fontSize(12)
                .fontColor('#757575')
            }.alignItems(HorizontalAlign.Center)

            // StatusItem 3: Water
            Column({ space: 0 }) {
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.startIcon'))
                  .width(24).height(24)
                  .objectFit(ImageFit.Contain)
                  .fillColor('#64B5F6')
              }
              .width(50).height(50)
              .backgroundColor('#F7F9F9')
              .borderRadius(25)
              .border({ width: 1, color: '#ECEFF1', radius: 25 })

              Blank().height(8)
              
              Text('2 Days')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#263238')
              
              Text('Water')
                .fontSize(12)
                .fontColor('#757575')
            }.alignItems(HorizontalAlign.Center)
          }.width('100%').justifyContent(FlexAlign.SpaceEvenly)

          Blank().height(32)

          // ActivityLogSection
          Column({ space: 0 }) {
            // Header
            Row({ space: 0 }) {
              Text(this.CareSchedule)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#263238')
              
              Blank() // Spacer for SpaceBetween effect if needed, or just layout weight on text? 
                     // Skeleton says SpaceBetween.
              
              Image($r('app.media.startIcon'))
                .width(28).height(28)
                .objectFit(ImageFit.Contain)
                .fillColor('#6A8E6A') // ZenGreen
                .padding(4)
                .backgroundColor('#C8E6C9') // ZenGreenLight approx
                .borderRadius(14)
            }.alignItems(VerticalAlign.Center).width('100%').justifyContent(FlexAlign.SpaceBetween)

            Blank().height(16)

            // CareLogItem 1 (Done)
            Row({ space: 0 }) {
              Stack({ alignContent: Alignment.Center }) {
                // Dot indicator
              }
              .width(12).height(12)
              .backgroundColor(this.isDoneTrue ? '#6A8E6A' : '#E0E0E0')
              .borderRadius(6)

              Blank().width(16)

              Column({ space: 0 }) {
                Text('Watering')
                  .fontSize(14)
                  .fontColor(this.isDoneTrue ? '#263238' : '#757575')
                
                Text('Today, 8:00 AM')
                  .fontSize(12)
                  .fontColor('#9E9E9E')
              }.layoutWeight(1)

              Image($r('app.media.startIcon'))
                .width(20).height(20)
                .objectFit(ImageFit.Contain)
                .fillColor('#6A8E6A')
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .backgroundColor('#FAFAFA')
            .borderRadius(12)
            .border({ width: 1, color: '#F0F0F0', radius: 12 })
            .padding(16)

            Blank().height(12)

            // CareLogItem 2 (Not Done)
            Row({ space: 0 }) {
              Stack({ alignContent: Alignment.Center }) {
                // Dot indicator
              }
              .width(12).height(12)
              .backgroundColor(this.isDoneFalse ? '#6A8E6A' : '#E0E0E0')
              .borderRadius(6)

              Blank().width(16)

              Column({ space: 0 }) {
                Text('Pruning')
                  .fontSize(14)
                  .fontColor(this.isDoneFalse ? '#263238' : '#757575')
                
                Text('Tomorrow')
                  .fontSize(12)
                  .fontColor('#9E9E9E')
              }.layoutWeight(1)

              Image($r('app.media.startIcon'))
                .width(20).height(20)
                .objectFit(ImageFit.Contain)
                .fillColor('#6A8E6A')
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .backgroundColor('#FAFAFA')
            .borderRadius(12)
            .border({ width: 1, color: '#F0F0F0', radius: 12 })
            .padding(16)

            Blank().height(12)

            // CareLogItem 3 (Not Done)
            Row({ space: 0 }) {
              Stack({ alignContent: Alignment.Center }) {
                // Dot indicator
              }
              .width(12).height(12)
              .backgroundColor(this.isDoneFalse ? '#6A8E6A' : '#E0E0E0')
              .borderRadius(6)

              Blank().width(16)

              Column({ space: 0 }) {
                Text('Fertilizer')
                  .fontSize(14)
                  .fontColor(this.isDoneFalse ? '#263238' : '#757575')
                
                Text('In 5 days')
                  .fontSize(12)
                  .fontColor('#9E9E9E')
              }.layoutWeight(1)

              Image($r('app.media.startIcon'))
                .width(20).height(20)
                .objectFit(ImageFit.Contain)
                .fillColor('#6A8E6A')
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .backgroundColor('#FAFAFA')
            .borderRadius(12)
            .border({ width: 1, color: '#F0F0F0', radius: 12 })
            .padding(16)
          }.width('100%')
        }
        .alignItems(HorizontalAlign.Center)
        .width('100%')
        .height('100%')
        .padding(24)

        // SimpleBottomNav
        Row({ space: 0 }) {
          // NavIcon 1 (Selected)
          Column({ space: 0 }) {
            Image($r('app.media.startIcon'))
              .width(28).height(28)
              .objectFit(ImageFit.Contain)
              .fillColor('#6A8E6A')
            
            Blank().height(4)
            
            Stack({ alignContent: Alignment.Center }) {
              // Indicator dot
            }
            .width(4).height(4)
            .backgroundColor('#6A8E6A')
            .borderRadius(2)
          }.alignItems(HorizontalAlign.Center)

          // NavIcon 2 (Unselected)
          Column({ space: 0 }) {
            Image($r('app.media.startIcon'))
              .width(28).height(28)
              .objectFit(ImageFit.Contain)
              .fillColor('#CFD8DC')
            
            Blank().height(4)
            
            Stack({ alignContent: Alignment.Center }) {
              // Indicator dot (hidden or transparent usually, but skeleton shows it)
            }
            .width(4).height(4)
            .backgroundColor('#6A8E6A')
            .borderRadius(2)
            .opacity(0) // Visually hidden for unselected state typically
          }.alignItems(HorizontalAlign.Center)

          // NavIcon 3 (Unselected)
          Column({ space: 0 }) {
            Image($r('app.media.startIcon'))
              .width(28).height(28)
              .objectFit(ImageFit.Contain)
              .fillColor('#CFD8DC')
            
            Blank().height(4)
            
            Stack({ alignContent: Alignment.Center }) {
              // Indicator dot
            }
            .width(4).height(4)
            .backgroundColor('#6A8E6A')
            .borderRadius(2)
            .opacity(0)
          }.alignItems(HorizontalAlign.Center)
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .height(80)
        .backgroundColor('#FFFFFF')
        .border({ width: 1, color: '#F5F5F5' })
        .position({ x: 0, y: '100%' }) // Position at bottom relative to stack
        .translate({ x: 0, y: -80 }) // Pull up into view
      }
    }.width('100%').height('100%')
  }
}