@Entry
@Component
struct Index {
  @State teas: TeaItem[] = [
    { name: 'Sencha Green', origin: 'Japan', temp: '70°C / 158°F', time: '1-2 min', color: '#A4C639' },
    { name: 'Earl Grey', origin: 'Blend', temp: '95°C / 203°F', time: '3-5 min', color: '#B08D7E' },
    { name: 'Silver Needle', origin: 'China', temp: '80°C / 176°F', time: '3-4 min', color: '#D1D5DB' },
    { name: 'Darjeeling', origin: 'India', temp: '90°C / 194°F', time: '3 min', color: '#C4B5AD' }
  ]

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Scroll() {
        Column({ space: 16 }) {
          // Header
          Row() {
            Column() {
              Text('ZenBrew')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#1C1C1E')
                .letterSpacing(-0.5)
              
              Text('Mindful Steeping Guide')
                .fontSize(14)
                .fontColor('#8E8E93')
            }
            
            Blank()
            
            Button() {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .objectFit(ImageFit.Contain)
            }
            .width(44)
            .height(44)
            .backgroundColor(Color.Transparent)
          }
          .width('100%')
          .padding({ top: 10, left: 20, right: 20 })

          // Tip Card
          Row() {
            Column({ space: 4 }) {
              Text('Tip of the day')
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .fontColor('#8E8E93')
              
              Text('Use filtered water for a purer taste profile.')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1C1C1E')
            }
            .layoutWeight(1)
            
            Blank().width(16)
            
            Stack() {
              Circle()
                .width(48)
                .height(48)
                .fill(Color.White)
              
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .objectFit(ImageFit.Contain)
                .opacity(0.5)
            }
          }
          .width('100%')
          .padding(24)
          .backgroundColor('#F2F2F7')
          .borderRadius(20)

          // Collections Title
          Text('Collections')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#1C1C1E')
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: 20, right: 20, top: 8, bottom: 8 })

          // Tea List
          ForEach(this.teas, (tea: TeaItem) => {
            Row() {
              // Avatar
              Stack() {
                Circle()
                  .width(50)
                  .height(50)
                  .fill(Color.White)
                  .border({ width: 2, color: tea.color, radius: 25 })
                
                Text(tea.name.charAt(0))
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(tea.color)
              }
              
              Blank().width(16)
              
              // Info
              Column({ space: 6 }) {
                Text(tea.name)
                  .fontSize(17)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#1C1C1E')
                
                Text(tea.origin)
                  .fontSize(12)
                  .fontColor('#8E8E93')
                
                Row({ space: 8 }) {
                  this.InfoBadge(tea.temp)
                  this.InfoBadge(tea.time)
                }
              }
              .layoutWeight(1)
              
              // Play Button
              Button() {
                Image($r('app.media.startIcon'))
                  .width(20)
                  .height(20)
                  .objectFit(ImageFit.Contain)
                  .fillColor('#1C1C1E')
              }
              .width(40)
              .height(40)
              .backgroundColor(Color.White)
              .border({ width: 1, color: '#E5E5EA', radius: 20 })
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#F9F9FA')
            .borderRadius(16)
            .border({ width: 1, color: '#E5E5EA', radius: 16 })
          })

          Blank().height(80)
        }
        .padding({ top: 10, bottom: 10 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)

      // Custom Brew Button
      Button() {
        Row() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .fillColor(Color.White)
          
          Text('Custom Brew')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
        }
      }
      .backgroundColor('#1C1C1E')
      .borderRadius(16)
      .padding({ left: 20, right: 20, top: 12, bottom: 12 })
      .margin({ right: 20, bottom: 20 })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  InfoBadge(label: string) {
    Text(label)
      .fontSize(12)
      .fontColor('#1C1C1E')
      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      .backgroundColor(Color.White)
      .borderRadius(8)
      .border({ width: 1, color: '#E5E5EA', radius: 8 })
  }
}

interface TeaItem {
  name: string
  origin: string
  temp: string
  time: string
  color: string
}